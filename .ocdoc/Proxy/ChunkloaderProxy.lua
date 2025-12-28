---@meta

--- Proxy interface for the Chunkloader component (`chunkloader`)
---
--- Provided by the chunkloader upgrade. Allows a robot or computer to force-load the chunk it's in,
--- keeping it active even when no players are nearby. Useful for background processing or automation.
---@class ChunkloaderProxy
local ChunkloaderProxy = {}

--- Returns whether the chunkloader is currently active (i.e. the chunk is being force-loaded).
---@return boolean active True if chunkloader is active
function ChunkloaderProxy.isActive() end

--- Enables or disables the chunkloader.
--- If activation fails (e.g. no ticket available), returns `false`.
---@param enabled boolean Whether to attempt activation
---@return boolean state Final active state (may differ from requested)
function ChunkloaderProxy.setActive(enabled) end

return ChunkloaderProxy