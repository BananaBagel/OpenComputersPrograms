---@meta

--- Proxy interface for the Generator component (`generator`)
---
--- Provided by the generator upgrade for robots. Allows managing fuel items for energy generation.
--- The generator has an internal inventory capable of storing one stack of burnable fuel items.
--- These methods enable querying, inserting, and removing fuel within the generator.
---@class GeneratorProxy
local GeneratorProxy = {}

--- Returns the number of fuel items currently stored in the generator's internal inventory.
---@return number count Number of fuel items
function GeneratorProxy.count() end

--- Attempts to insert fuel items from the currently selected inventory slot.
--- Moves up to the specified `count` of items if possible.
--- Returns `true` if at least one item was inserted, or `false` and an error message otherwise.
--- Possible errors:
--- - `"selected slot does not contain fuel"`: item is not burnable
--- - `"different fuel type already queued"`: conflicting fuel types
--- - `"queue is full"`: maximum 64 items already stored
---@param count number? Number of fuel items to insert
---@return boolean success Whether insertion succeeded
---@return string? errorMsg Optional error message on failure
function GeneratorProxy.insert(count) end

--- Attempts to remove up to the specified number of fuel items from the generator.
--- Items are placed into the currently selected inventory slot or the next available slot.
--- Returns `true` if removal succeeded, `false` otherwise.
---@param count number? Number of fuel items to remove
---@return boolean success Whether removal succeeded
function GeneratorProxy.remove(count) end

return GeneratorProxy