---@meta

--- Represents an item stack in an inventory.
---@class ItemStack
---@field damage number Current damage value of the item
---@field maxDamage number Maximum damage before the item breaks
---@field size number Current stack size
---@field maxSize number Maximum stack size
---@field id number? Minecraft item id (optional)
---@field name string Untranslated item name (e.g. "oc:item.FloppyDisk")
---@field label string Translated item name
---@field hasTag boolean Whether the item has an NBT tag

--- Proxy for the OpenComputers Inventory Controller component.
---@class InventoryControllerProxy
local InventoryControllerProxy = {}

--- Returns the size of the inventory at the specified side.
---@param side integer Side to check (see Sides API)
---@return number|nil size Size of the inventory, or nil if not found
---@return string? error Error message if failed
function InventoryControllerProxy.getInventorySize(side) end

--- Returns the item stack in the specified slot of the inventory at the given side.
---@param side integer Side to check (see Sides API)
---@param slot integer Slot number
---@return ItemStack|nil item Item stack info, or nil if empty
function InventoryControllerProxy.getStackInSlot(side, slot) end

--- Returns the item stack in the specified or selected slot of the robot's own inventory.
---@param slot integer Slot number
---@return ItemStack|nil item Item stack info, or nil if empty
function InventoryControllerProxy.getStackInInternalSlot(slot) end

--- Drops up to count items from the selected slot into the specified slot of the inventory at the given side.
---@param side integer Side to drop into (see Sides API)
---@param slot integer Slot number to drop into
---@param count integer? Number of items to drop (optional)
---@return boolean success `true` if at least one item was moved
---@return string? error Error message if failed
function InventoryControllerProxy.dropIntoSlot(side, slot, count) end

--- Takes up to count items from the specified slot of the inventory at the given side and puts them into the selected slot.
---@param side integer Side to take from (see Sides API)
---@param slot integer Slot number to take from
---@param count integer? Number of items to take (optional)
---@return boolean success True if at least one item was moved
function InventoryControllerProxy.suckFromSlot(side, slot, count) end

--- Swaps the content of the robot's tool slot with the selected inventory slot.
---@return boolean success True if items were swapped
function InventoryControllerProxy.equip() end

--- Stores the item stack description from the specified slot in an inventory into a database slot.
---@param side integer Side of the inventory (see Sides API)
---@param slot integer Slot number
---@param dbAddress string Database component address
---@param dbSlot integer Database slot number
---@return boolean success True if stored
function InventoryControllerProxy.store(side, slot, dbAddress, dbSlot) end

--- Stores the item stack description from the specified robot inventory slot into a database slot.
---@param slot integer Robot inventory slot
---@param dbAddress string Database component address
---@param dbSlot integer Database slot number
---@return boolean success True if stored
function InventoryControllerProxy.storeInternal(slot, dbAddress, dbSlot) end

--- Compares the item stack in the specified slot with one in a database slot.
---@param slot integer Robot inventory slot
---@param dbAddress string Database component address
---@param dbSlot integer Database slot number
---@return boolean match True if items match
function InventoryControllerProxy.compareToDatabase(slot, dbAddress, dbSlot) end

--- Compares item stacks in two slots of an inventory on the specified side.
---@param side integer Side of the inventory (see Sides API)
---@param slotA integer First slot number
---@param slotB integer Second slot number
---@return boolean match True if stacks are identical
function InventoryControllerProxy.compareStacks(side, slotA, slotB) end

--- Gets the maximum number of items in the specified slot of an inventory on the given side.
---@param side integer Side of the inventory (see Sides API)
---@param slot integer Slot number
---@return integer maxSize Maximum stack size for the slot
function InventoryControllerProxy.getSlotMaxStackSize(side, slot) end

--- Gets the number of items in the specified slot of an inventory on the given side.
---@param side integer Side of the inventory (see Sides API)
---@param slot integer Slot number
---@return integer size Number of items in the slot
function InventoryControllerProxy.getSlotStackSize(side, slot) end

return InventoryControllerProxy