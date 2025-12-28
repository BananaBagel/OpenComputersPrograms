-- This program can manage a pneumaticcraft plastic mixer set on choice from signal mode.

local component = require("component")
local sides = require("sides")
local thread = require("thread")
local event = require("event")
local tick = 0.05

local ic = component.getPrimary("transposer")
local rc = component.getPrimary("redstone")

local isReady = false
local isRunning = false

local mio = { input = nil, output = nil, intank = nil, mixer = nil }
local mixerSlots = { input = 1, out = 2, r = 3, g = 4, b = 5 }
local doesOutputExist = false
local gpu = component.getPrimary("gpu")

local colorTable = {
    [0] = "black",
    [1] = "red",
    [2] = "green",
    [3] = "brown",
    [4] = "blue",
    [5] = "purple",
    [6] = "cyan",
    [7] = "lightGray",
    [8] = "gray",
    [9] = "pink",
    [10] = "lime",
    [11] = "yellow",
    [12] = "lightBlue",
    [13] = "magenta",
    [14] = "orange",
    [15] = "white"
}

local function getTick()
    return (os.time() * (1000 / 60 / 60)) - 6000
end

local function perr(text)
    local timestamp = (math.floor(getTick() / 24000)) .. " " .. os.date("%H:%M.%S")
    local fg = gpu.setForeground(0xF92672)
    print("[" .. timestamp .. "] ERR  / " .. text)
    gpu.setForeground(fg)
end
local function pinfo(text)
    local timestamp = (math.floor(getTick() / 24000)) .. " " .. os.date("%H:%M.%S")
    print("[" .. timestamp .. "] INFO / " .. text)
end

for s = 0, #(sides) - 1, 1 do
    local invSize = ic.getInventorySize(s)
    local tankCount = ic.getTankCount(s)

    if invSize == nil and tankCount < 1 then
        goto continue
    end

    local invName = ic.getInventoryName(s)
    local tankFluid = tankCount >= 1 and ic.getFluidInTank(s, 1) or nil
    local tankType = (tankFluid ~= nil and tankFluid >= 1) and tankFluid.name or nil

    if invName == "pneumaticcraft:plastic_mixer" and tankCount >= 1 then
        local tankSize = ic.getTankCapacity(s)
        mio["mixer"] = {
            side = s,
            tankCapacity = tankSize,
            invSize = invSize
        }
        pinfo("Successfully registered plastic mixer on side " ..
            s ..
            " (" ..
            sides[s] .. ") with a capacity of " .. (math.floor(tankSize)) ..
            "mB and an inventory size of " .. (math.floor(invSize)))
    elseif tankCount >= 1 and tankType == "plastic" then
        local tankSize = ic.getTankCapacity(s)
        mio["intank"] = {
            side = s,
            tankCapacity = tankSize
        }
        pinfo("Successfully registered plastic tank on side " ..
            s .. " (" .. sides[s] .. ") with a capacity of " .. (math.floor(tankSize)) .. "mB")
    elseif invSize >= 1 and doesOutputExist == false and s ~= sides.top then
        mio["output"] = {
            side = s,
            invSize = invSize
        }
        pinfo("Successfully registered output on side " ..
            s .. " (" .. sides[s] .. ") with an inventory size of " .. (math.floor(invSize)))
    elseif invSize >= 1 and s == sides.top then
        mio["input"] = {
            side = s,
            invSize = invSize
        }
        pinfo("Successfully registered input on side " ..
            s .. " (" .. sides[s] .. ") with an inventory size of " .. (math.floor(invSize)))
    end

    ::continue::
end

local endScript = false

if mio.output == nil then
    perr(
        "Unable to find valid output inventory       - Make sure an inventory exists on any side (except top) of transposer")
    endScript = true
end
if mio.intank == nil then
    perr(
        "Unable to find valid liquid plastic tank    - Make sure a tank filled with at least 1 mB of liquid plastic exists on any side (except top) of transposer")
    endScript = true
end
if mio.mixer == nil then
    perr(
        "Unable to find pneumaticcraft:plastic_mixer - Make sure to place a plastic mixer on any side (except top) of the transposer")
    endScript = true
end
if mio.input == nil then
    perr(
        "Unable to find valid input inventory        - Make sure an inventory exists on specifically the top side of the transposer")
    endScript = true
end
if endScript then
    os.exit()
end


local function getInvComponents(s)
    local stacks = {}
    local slot = 1
    for k in ic.getAllStacks(s) do
        if k.name == nil then goto continue end
        k["slot"] = slot
        table.insert(stacks, k)

        ::continue::
        slot = slot + 1
    end
    return stacks
end


local function getTankLevel(s)
    return ic.getTankLevel(s, 1)
end
local function getTankFluid(s)
    return ic.getFluidInTank(s, 1)
end

local function getInvItem(s, slot)
    return ic.getStackInSlot(s, slot)
end
local x = getInvComponents(mio.input.side)


local function moveToOut(s, slot, count)
    local done = 0
    local iter = 0
    local has_errored = false
    while (done < count) do
        iter = iter + 1
        done = done + ic.transferItem(s, mio.output.side, count, slot)
        if (iter > mio.output.invSize) then
            if not has_errored then
                perr(
                    "Unable to move items to output storage. Is it full and/or unable to be emptied?")
            end
            has_errored = true
            os.sleep(1)
        end
    end
end

local function moveToMixer(a)
    local done = 0
    local iter = 0
    local has_errored = false
    while (done < a) do
        iter = iter + 1
        local result, tmpdone = ic.transferFluid(mio.intank.side, mio.mixer.side, a)
        if result == true then done = done + tmpdone end
        if (iter > 8) then
            if not has_errored then
                perr(
                    "Unable to move plastic to mixer. Is the input tank empty or have the incorrect fluid?")
            end
            has_errored = true
            os.sleep(1)
        elseif (done < a) then
            os.sleep(tick * 1)
        end
    end
end

local function setColor(c)
    rc.setOutput({ c, c, c, c, c, c })
end

local state = 0

local function doLoop()
    ::call::
    if not isRunning then
        pinfo("Starting up main loop")
    end
    if not isReady and isRunning then
        pinfo("Script is no longer ready & has completed running task -- exiting...")
        return
    elseif (not isReady) and (not isRunning) then
        perr("Script not ready -- exiting")
        return
    end

    isRunning = true
    ::loop::
    while (isReady) do
        local mixerTankLevel = getTankLevel(mio.mixer.side)
        if (mixerTankLevel >= 999) then
            if state == 0 then
                state = 1
            elseif state == 1 then
                perr("Plastic mixer has " .. mixerTankLevel .. "mB of liquid plastic but is not producing plastic")
                state = 2
            end
            os.sleep(1)
            goto call
        elseif state ~= 0 then
            state = 0
        end
        local inputInv = getInvComponents(mio.input.side)
        if #inputInv < 1 then
            os.sleep(1)
            goto loop
        end
        local si = inputInv[1]

        local item = getInvItem(mio.input.side, si.slot)

        if item.name ~= "minecraft:dye" then
            moveToOut(mio.input.side, si.slot, item.size)
            goto loop
        end

        local outItem = getInvItem(mio.mixer.side, mixerSlots.out)
        if outItem ~= nil then
            pinfo("Moving leftover plastic sheets to output storage")
            moveToOut(mio.mixer.side, mixerSlots.out, outItem.size)
        end

        local color = item.damage
        local quantity = math.floor(math.min(math.min(item.size, (math.floor(mio.mixer.tankCapacity / 1000))),
            mio.intank.tankCapacity / 1000))
        pinfo("Creating " ..
        math.floor(quantity) .. " Plastics of color " .. colorTable[color] .. " (" .. math.floor(color) .. ")")
        setColor(color)
        moveToMixer((quantity * 1000) - mixerTankLevel)
        moveToOut(mio.input.side, si.slot, quantity)
        local done = 0
        local first = true
        while (done < quantity) do
            if first then os.sleep(quantity * tick) end
            first = false
            done = ic.getSlotStackSize(mio.mixer.side, mixerSlots.out)
            if (done < quantity) and not first then os.sleep(1 * tick) end
        end
        moveToOut(mio.mixer.side, mixerSlots.out, quantity)

        os.sleep(1 * tick)
    end
    goto call
end

isReady = true
local interruptThread = thread.create(function()
    event.pull("interrupted")
    pinfo("Interrupted, Safely Exiting")
    isReady = false
end)
local loopThread = thread.create(doLoop)

thread.waitForAll({ loopThread })
