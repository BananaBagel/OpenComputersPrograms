-- This program can sort through EnderIO capacitors and organize them based on their strength

local component = require("component")
local sides = require("sides")
local thread = require("thread")
local event = require("event")
local logging = require("neoutils.logging")
local tick = 0.05

local ic = component.getPrimary("transposer")

local isReady = false
local isRunning = false

local textgui = require("neoutils.textgui")

local doesOutputExist = false

local transposer = {}

for s = 0, #(sides) - 1, 1 do
    local invSize = ic.getInventorySize(s)

    if invSize == nil then
        goto continue
    end

    local invName = ic.getInventoryName(s)
    local invLabel = ic.getInventoryLabel(s)

    transposer[s + 1] = {
        side = sides[s],
        invSize = invSize,
        invName = invName
    }
    ::continue::
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
