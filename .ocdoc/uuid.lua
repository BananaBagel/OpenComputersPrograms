---@meta

--- OpenComputers UUID API
---
--- Provides utilities for generating 128-bit random identifiers (UUIDs).
---@class UuidLib
local uuid = {}

--- Generates a new 128-bit random UUID string.
--- The UUID generated is version 4 (based on randomness).
--- UUIDs V4 variant 1 are used by Minecraft, and no other UUID variant is possible to generate using this API.
---@return string UUID string (e.g. "34eb7b28-14d3-4767-b326-dd1609ba92e")
function uuid.next() end

return uuid
