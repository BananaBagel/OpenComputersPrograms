---@meta

--- OpenComputers Serialization API
---
--- Provides functions to serialize and unserialize Lua values.
---@class SerializationLib
local serialization = {}

--- Serializes a value to a string of Lua code.
--- Supports basic types and tables without cycles. Use pretty for human-readable output.
---@param value any Value to serialize (functions not supported)
---@param pretty boolean|number? Pretty print mode or entry count (optional)
---@return string Serialized string
function serialization.serialize(value, pretty) end

--- Unserializes a string produced by serialization.serialize.
---@param value string String to unserialize
---@return any The deserialized value
function serialization.unserialize(value) end

return serialization
