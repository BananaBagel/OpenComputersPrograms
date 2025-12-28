---@meta

--- Proxy interface for the Computer component (`computer`)
---
--- Provides control over machine lifecycle, architecture inspection, beep output, and system info.
---@class ComputerProxy
local ComputerProxy = {}

--- Attempts to start the computer.
--- Returns `true` if successful, `false` if already running or if startup failed.
--- If the computer is currently shutting down, this causes a reboot.
---@return boolean success Whether the computer successfully started
function ComputerProxy.start() end

--- Attempts to stop the computer.
--- Returns `true` if the computer was running and is now stopping.
--- Returns `false` if the computer was already stopped.
---@return boolean success Whether the computer was successfully stopped
function ComputerProxy.stop() end

--- Returns whether the computer is currently running.
---@return boolean running `true` if running, `false` otherwise
function ComputerProxy.isRunning() end

--- Emits a beep sound at the specified frequency and duration.
--- Defaults: 500Hz for 0.2 seconds.
--- Frequencies must be between 20–2000Hz. Duration max is 5 seconds.
---@param frequency number? Frequency in Hz (default: 500)
---@param duration number? Duration in seconds (default: 0.2)
function ComputerProxy.beep(frequency, duration) end

--- Returns a table containing architecture-specific device information.
--- May be nil or empty if not implemented by the architecture.
---@return table info Device info fields (architecture-dependent)
function ComputerProxy.getDeviceInfo() end

--- Forces the computer to crash with the specified reason.
---@param reason string Crash message or reason
function ComputerProxy.crash(reason) end

--- Gets the current architecture name of the computer.
--- For example: `"Lua 5.3"` or `"OpenOS"`.
---@return string architecture Architecture identifier string
function ComputerProxy.getArchitecture() end

--- Indicates whether the computer is a robot (mobile computer type).
---@return boolean isRobot `true` if computer is a robot
function ComputerProxy.isRobot() end

return ComputerProxy