---@meta

--- Information about a beacon waypoint detected by the navigation upgrade.
---@class WaypointInfo
---@field position table<number>  -- Relative position `{x, y, z}` from the robot to the beacon
---@field redstone boolean        -- Whether the beacon is emitting a redstone signal
---@field label string            -- User-defined label of the beacon

--- Proxy interface for the Navigation Upgrade component (`navigation`)
--- Provides robot positioning relative to a map, facing direction, map range,
--- and scanning for beacon waypoints.
---@class NavigationProxy
local NavigationProxy = {}

--- Gets the robot's relative position based on the map used to craft the upgrade.
--- Returns `nil` and the message `"out of range"` if the robot is beyond sensing distance.
---@return number? x Relative X coordinate or `nil` if out of range
---@return number? y Relative Y coordinate or `nil` if out of range
---@return number? z Relative Z coordinate or `nil` if out of range
---@return string? message `"out of range"` if not within sensing range
function NavigationProxy.getPosition() end

--- Gets the current facing direction of the robot.
--- Returns one of the six `sides` constants (0–5).
---@return integer side Facing side constant
function NavigationProxy.getFacing() end

--- Gets the maximum sensing range of the navigation upgrade in blocks.
---@return number range Maximum usable range from map center
function NavigationProxy.getRange() end

--- Finds all beacons (waypoints) within the specified range from the robot.
--- Requires OpenComputers version ≥ 1.5.9.
---@param range number Search radius in blocks
---@return WaypointInfo[] beacons List of detected waypoints
function NavigationProxy.findWaypoints(range) end

return NavigationProxy