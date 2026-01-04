local component = require("component")
local event = require("event")
local serialization = require("serialization")

local args = { ... }
local mode = args[1] or "send" -- "send" or "watch"

local redstone = component.redstone
local tunnel = component.tunnel

if not redstone then
    io.stderr:write("No redstone card found.\n"); return
end
if not tunnel then
    io.stderr:write("No linked (tunnel) card found.\n"); return
end

local sides = require("sides")

if mode == "send" then
    local last = {}
    local last_count = 0
    while true do
        local values = redstone.getInput()
        if table.concat(values) ~= table.concat(last) or values[0] ~= last[0] then
            last = values
            tunnel.send(serialization.serialize(values))
            print("Sent redstone state:", serialization.serialize(values))
            last_count = 0
        else
            last_count = last_count + 1
            if last_count >= 600 then
                -- resend every 30 seconds in case of lost packets
                tunnel.send(values)
                last_count = 0
            end
        end
        os.sleep(0.05)
    end
elseif mode == "watch" then
    -- listen for messages (modem_message used by linked cards in many setups)
    while true do
        local _, _, _, _, _, payload = event.pull("modem_message")
        redstone.setOutput(serialization.unserialize(payload))
        print("Received redstone state:", payload)
    end
else
    io.stderr:write("Unknown mode. Use: send (default) or watch\n")
end
