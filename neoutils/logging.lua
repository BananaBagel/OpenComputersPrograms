-- Logging Utilities
local component = require("component")
local gpu = component.getPrimary("gpu")

local logging = { _VERSION = "0.1.0", }

local function getTick()
    return (os.time() * (1000 / 60 / 60)) - 6000
end

function logging.error(text)
    local timestamp = (math.floor(getTick() / 24000)) .. " " .. os.date("%H:%M.%S")
    local fg = gpu.setForeground(0xF92672)
    print("[" .. timestamp .. "] ERROR / " .. text)
    gpu.setForeground(fg)
end

function logging.info(text)
    local timestamp = (math.floor(getTick() / 24000)) .. " " .. os.date("%H:%M.%S")
    print("[" .. timestamp .. "] INFO  / " .. text)
end

function logging.debug(text)
    local timestamp = (math.floor(getTick() / 24000)) .. " " .. os.date("%H:%M.%S")
    local fg = gpu.setForeground(0x646464)
    print("[" .. timestamp .. "] DEBUG / " .. text)
end

function logging.warn(text)
    local timestamp = (math.floor(getTick() / 24000)) .. " " .. os.date("%H:%M.%S")
    local fg = gpu.setForeground(0xE98D3D)
    print("[" .. timestamp .. "] WARN  / " .. text)
    gpu.setForeground(fg)
end

return logging
