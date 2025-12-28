---@meta

--- Proxy interface for the Tractor Beam Upgrade (`tractor_beam`)
---
--- Allows the robot to attempt to pull in nearby items from a 9×9 area centered on itself.
---@class TractorBeamProxy
local TractorBeamProxy = {}

--- Attempts to pick up a random item within a 9×9 area centered on the robot.
--- Returns `true` if an item was successfully picked up, `false` otherwise.
---@return boolean Success status
function TractorBeamProxy.suck() end

return TractorBeamProxy