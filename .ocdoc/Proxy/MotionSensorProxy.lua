---@meta

--- Proxy interface for the Motion Sensor component (`motion_sensor`)
---
--- Monitors motion events triggered by entities moving within line of sight
--- and above a configured speed threshold. Updates every 0.5 seconds.
--- Range limited to 8 blocks. Emits motion events when triggered.
---@class MotionSensorProxy
local MotionSensorProxy = {}

--- Gets the current sensitivity value.
--- Sensitivity determines the movement speed threshold (distance/second)
--- above which motion events are queued.
---@return number sensitivity The current speed threshold value
function MotionSensorProxy.getSensitivity() end

--- Sets the sensitivity value to a new threshold.
--- Higher sensitivity triggers on slower movement.
--- Returns the previous sensitivity before this change.
---@param value number The new speed threshold value
---@return number oldValue The previous sensitivity setting
function MotionSensorProxy.setSensitivity(value) end

return MotionSensorProxy