---@meta

--- Proxy interface for the Crafting component (`crafting`)
---
--- Provided by the crafting upgrade for robots.
--- Enables automatic crafting operations using the robot's internal crafting grid.
--- The result is placed in the currently selected slot or the next compatible/free slot.
---@class CraftingProxy
local CraftingProxy = {}

--- Attempts to craft items based on the recipe present in the robot’s crafting grid.
--- Will craft up to `count` result items, or as many as possible if `count` is omitted.
--- **!** The robot will never craft more than one **full stack** of results in a single invocation.
---
--- Behavior notes:
--- - If the requested `count` is less than the recipe's result stack size, the method still returns `true` but produces nothing.
--- - Crafted items may be placed into the currently selected slot, or into the next compatible or free slot (even in the crafting grid), which can block subsequent craft calls unless manually cleared.
---@param count number? Number of result items to craft (optional)
---@return boolean success True if at least one item was crafted
function CraftingProxy.craft(count) end

return CraftingProxy