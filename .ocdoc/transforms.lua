---@meta

--- OpenComputers Transforms API
---
--- Provides utilities for working with indexed tables (sequences).
---@class TransformsLib
local transforms = {}

--- Returns a sub-table from first to last (inclusive).
---@param tbl table Source table
---@param first number Start index
---@param last number? End index (optional)
---@return table Sub-table
function transforms.sub(tbl, first, last) end

--- Returns the first index where predicate is satisfied.
---@param tbl table Source table
---@param predicate function|table Predicate function or table
---@param first number? Start index (optional)
---@param last number? End index (optional)
---@return number startIndex
---@return number endIndex
function transforms.first(tbl, predicate, first, last) end

--- Partitions the table into sublists using the partitioner predicate.
---@param tbl table Source table
---@param partitioner function Predicate function
---@param first number? Start index (optional)
---@param last number? End index (optional)
---@return table[] List of sub-tables
function transforms.partition(tbl, partitioner, first, last) end

--- Returns true if the sub-table matches at the start of tbl.
---@param tbl table Source table
---@param sub table Sub-table to match
---@param first number? Start index (optional)
---@param last number? End index (optional)
---@return boolean True if begins with sub
function transforms.begins(tbl, sub, first, last) end

--- Applies adapter to each element, returns adapted table.
---@param tbl table Source table
---@param adapter function Adapter function
---@param first number? Start index (optional)
---@param last number? End index (optional)
---@return table Adapted table
function transforms.foreach(tbl, adapter, first, last) end

return transforms
