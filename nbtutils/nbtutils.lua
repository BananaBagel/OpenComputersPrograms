-- Created by BananaBagel
-- Licensed under the MIT license

local nbt = require("nbt")

local nbtutils = { _VERSION = "0.1.0" }

--- https://github.com/nessan/lulu/blob/main/lulu/table.lua
---
--- Returns a deep copy of a table. We copy the metatable if it exists.
--- @param obj any The object to copy. Typically a table but handles other types without issuing a warning.
--- @return any obj A deep copy of the input object.
local function deepCopy(obj)
    if type(obj) ~= 'table' then return obj end

    -- Workhorse function to copy a table. This is called recursively.
    local function process(tbl)
        -- Create a new table.
        local retval = {}

        -- Copy the metatable if it exists.
        local mt = getmetatable(tbl)
        if mt then setmetatable(retval, mt) end

        -- Copy all the keys and values from `tbl` to `retval`. May recurse on the values.
        for k, v in pairs(tbl) do
            if type(v) == 'table' then retval[k] = process(v) else retval[k] = v end
        end

        return retval
    end

    -- Kick things off by processing the root table.
    return process(obj)
end

---Parse an array of items' NBTs and add to the items' tables as NBT (item[index].NBT)
---@param itemstacks table[]
---@return table[]
function nbtutils.parseInventoryNBT(itemstacks)
    local items = {}
    for i = 1, #itemstacks do
        items[i] = deepCopy(itemstacks[i])
        items[i].NBT = nbt.parse(itemstacks[i].tag)
    end
    return items
end

---Parse an item's NBT and add to the item's table as NBT (item.NBT)
---@param item table
---@return table
function nbtutils.parseItemNBT(item)
    local newitem = deepCopy(item)
    newitem.NBT = nbt.parse(item.tag)
    return newitem
end

return nbtutils
