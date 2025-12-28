---@meta

--- Proxy interface for the Experience component (`experience`)
---
--- Provided by the experience upgrade. Enables retrieval of stored XP level within the robot.
--- Useful for automation workflows involving entity interaction, enchantment, or XP transfer mechanics.
---@class ExperienceProxy
local ExperienceProxy = {}

--- Retrieves the current experience level stored in the upgrade.
--- Represents the effective XP level, similar to player-level XP.
---@return number level Stored experience level
function ExperienceProxy.level() end

return ExperienceProxy