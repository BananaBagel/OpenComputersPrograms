---@meta

--- Proxy interface for the Transposer component (`transposer`)
---
--- Enables fluid and item transfer between inventories and tanks, as well as database comparisons and inventory inspection.
---@class TransposerProxy
local TransposerProxy = {}

--- Transfers fluid between two sides.
--- Defaults to 1000 mB if `count` is not specified.
---@param sourceSide integer Side to pull fluid from
---@param sinkSide integer Side to push fluid to
---@param count integer Amount in millibuckets
---@return boolean Success
---@return number|nil Amount transferred or error message
function TransposerProxy.transferFluid(sourceSide, sinkSide, count) end

--- Transfers items between two inventories.
---@param sourceSide integer Side to pull from
---@param sinkSide integer Side to push to
---@param count integer Number of items to transfer
---@param sourceSlot integer Source slot index
---@param sinkSlot integer Target slot index
---@return number Number of items transferred
function TransposerProxy.transferItem(sourceSide, sinkSide, count, sourceSlot, sinkSlot) end

--- Stores an item stack description into a database slot.
---@param side integer Inventory side
---@param slot integer Inventory slot
---@param dbAddress string Database component address
---@param dbSlot integer Database slot index
---@return boolean Success
function TransposerProxy.store(side, slot, dbAddress, dbSlot) end

--- Compares an item stack to a database entry.
---@param side integer Inventory side
---@param slot integer Inventory slot
---@param dbAddress string Database component address
---@param dbSlot integer Database slot index
---@param checkNBT boolean? Whether to compare NBT data
---@return boolean Match result
function TransposerProxy.compareStackToDatabase(side, slot, dbAddress, dbSlot, checkNBT) end

--- Compares two item stacks in the same inventory.
---@param side integer Inventory side
---@param slotA integer First slot
---@param slotB integer Second slot
---@param checkNBT boolean? Whether to compare NBT data
---@return boolean Match result
function TransposerProxy.compareStacks(side, slotA, slotB, checkNBT) end

--- Checks whether two stacks are equivalent via OreDictionary.
---@param side integer Inventory side
---@param slotA integer First slot
---@param slotB integer Second slot
---@return boolean Equivalence result
function TransposerProxy.areStacksEquivalent(side, slotA, slotB) end

--- Gets the number of items in a specific slot.
---@param side integer Inventory side
---@param slot integer Slot index
---@return number Item count
function TransposerProxy.getSlotStackSize(side, slot) end

--- Gets the max stack size of a specific slot.
---@param side integer Inventory side
---@param slot integer Slot index
---@return number Max stack size
function TransposerProxy.getSlotMaxStackSize(side, slot) end

--- Gets the name of the inventory on the specified side.
---@param side integer Inventory side
---@return string Inventory name
function TransposerProxy.getInventoryName(side) end

--- Gets the number of slots in the inventory on the specified side.
---@param side integer Inventory side
---@return number Slot count
function TransposerProxy.getInventorySize(side) end

--- Gets a description of the fluid in a specific tank.
---@param side integer Tank side
---@param tank integer Tank index
---@return table Fluid description
function TransposerProxy.getFluidInTank(side, tank) end

--- Gets the fluid level in a specific tank.
---@param side integer Tank side
---@param tank integer Tank index
---@return number Fluid level in millibuckets
function TransposerProxy.getTankLevel(side, tank) end

--- Gets the capacity of a specific tank.
---@param side integer Tank side
---@param tank integer Tank index
---@return number Tank capacity in millibuckets
function TransposerProxy.getTankCapacity(side, tank) end

--- Gets the number of tanks available on the specified side.
---@param side integer Tank side
---@return number Tank count
function TransposerProxy.getTankCount(side) end

--- Gets a description of the item stack in a specific slot.
---@param side integer Inventory side
---@param slot integer Slot index
---@return table Stack description
function TransposerProxy.getStackInSlot(side, slot) end

--- Gets a callable iterator over all stacks in the inventory.
--- The returned object supports:
--- - `getAll(): table`
--- - `count(): number`
--- - `reset(): void`
---@param side integer Inventory side
---@return userdata Stack iterator object
function TransposerProxy.getAllStacks(side) end

return TransposerProxy