---@meta

--- Proxy interface for the Piston Upgrade component (`piston`)
---
--- This component allows pushing blocks in front of the container it's installed in.
--- It behaves like a basic piston, triggered via API.
---@class PistonProxy
local PistonProxy = {}

--- Attempts to push the block in front of the upgrade container.
--- Returns `true` if the push was successful.
---@param side integer The direction to push (0–5)
---@return boolean `true` if the block was pushed successfully
function PistonProxy.push(side) end

return PistonProxy