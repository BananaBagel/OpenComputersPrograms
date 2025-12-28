---@meta

--- Proxy interface for the Leash Upgrade component (`leash`)
---
--- Enables the device to interact with nearby entities by leashing and unleashing them.
--- Primarily used for entity control within range of the upgrade block (e.g., managing mobs or pets).
---@class LeashProxy
local LeashProxy = {}

--- Attempts to leash an entity on the specified side of the device.
--- Returns true if an entity was successfully leashed.
--- Useful for controlling mob movement or holding entities in place.
---@param side number Side index (0–5) relative to the upgrade
---@return boolean success True if leashing succeeded
function LeashProxy.leash(side) end

--- Releases all currently leashed entities.
--- Effectively undoes previous calls to `leash`.
function LeashProxy.unleash() end

return LeashProxy