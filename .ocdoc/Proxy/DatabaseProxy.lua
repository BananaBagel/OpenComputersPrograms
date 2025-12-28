---@meta

--- Proxy interface for the Database component (`database`)
---
--- Allows access to full item stacks, including NBT data.
--- Enables item identity via hash comparison and cross-database operations.
---@class DatabaseProxy
local DatabaseProxy = {}

--- Retrieves the item stack stored in the specified slot.
--- The returned table includes metadata such as NBT tags, if available.
---@param slot number The slot index to read from
---@return table stack The item stack representation (architecture-specific)
function DatabaseProxy.get(slot) end

--- Computes a stable hash for the item stack in the given slot.
--- Identical stacks yield the same hash, useful for cross-network equality checks.
---@param slot number The slot index to hash
---@return string hash A string identifying the item stack
function DatabaseProxy.computeHash(slot) end

--- Returns the index of the item stack that matches the provided hash.
--- Returns a negative value if no match is found.
---@param hash string The hash value to search for
---@return number index The slot index of the matching item, or a negative value
function DatabaseProxy.indexOf(hash) end

--- Clears the specified slot in the database.
--- Returns true if the slot previously held data.
---@param slot number The slot index to clear
---@return boolean cleared Whether an entry was removed
function DatabaseProxy.clear(slot) end

--- Copies the item stack from one slot to another.
--- If `address` is specified, copies to a slot in another database.
--- Returns true if something was overwritten in the destination.
---@param fromSlot number Source slot index
---@param toSlot number Target slot index
---@param address string|nil Optional target database address
---@return boolean overwritten Whether the target slot was overwritten
function DatabaseProxy.copy(fromSlot, toSlot, address) end

--- Clones the entire database to another database at the specified address.
--- Copies all item stack data.
---@param address string Destination database address
---@return number result Clone operation result (implementation-defined)
function DatabaseProxy.clone(address) end

return DatabaseProxy