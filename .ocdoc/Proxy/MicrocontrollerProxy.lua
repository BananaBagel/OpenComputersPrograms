---@meta

--- Proxy interface for the Microcontroller component (`microcontroller`)
---
--- Provided by the Microcontroller Case. This component allows a microcontroller to manage its lifecycle
--- and network side visibility. Only the microcontroller itself or directly adjacent devices
--- (sharing a block face) may invoke these methods. Microcontrollers cannot access each other's
--- components directly, but neighboring computers can.
---@class MicrocontrollerProxy
local MicrocontrollerProxy = {}

--- Sets whether the specified side of the microcontroller is open for network communication.
--- Returns `true` if the side state changed.
---@param side number Side index (0–5, corresponding to block faces)
---@param open boolean Whether to open or close the side for messaging
---@return boolean changed Whether the side was successfully updated
function MicrocontrollerProxy.setSideOpen(side, open) end

--- Starts the microcontroller.
--- Returns `true` if it transitioned from stopped to running.
---@return boolean started Whether the microcontroller was started
function MicrocontrollerProxy.start() end

--- Stops the microcontroller.
--- Returns true if it transitioned from running to stopped.
---@return boolean stopped Whether the microcontroller was stopped
function MicrocontrollerProxy.stop() end

--- Checks whether the microcontroller is currently running.
---@return boolean running True if the microcontroller is active
function MicrocontrollerProxy.isRunning() end

--- Gets whether network messages are transmitted via the specified side.
---@param side number Side index
---@return boolean open `true` if the side is currently open
function MicrocontrollerProxy.isSideOpen(side) end

--- Returns the error message from the last crash, if any.
--- Returns `nil` if no crash has occurred.
---@return string|nil reason Crash reason string, or `nil` if clean
function MicrocontrollerProxy.lastError() end

return MicrocontrollerProxy