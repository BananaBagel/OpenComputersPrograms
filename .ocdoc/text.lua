---@meta

--- OpenComputers Text API
---
--- Provides general string operations and data serialization utilities.
---@class TextLib
local text = {}

--- Converts tabs in a string to spaces, aligning to tabWidth.
---@param value string Input string
---@param tabWidth number Tab width
---@return string String with tabs replaced by spaces
function text.detab(value, tabWidth) end

--- Pads a string with whitespace on the right up to the specified length.
---@param value string Input string
---@param length number Target length
---@return string Right-padded string
function text.padRight(value, length) end

--- Pads a string with whitespace on the left up to the specified length.
---@param value string Input string
---@param length number Target length
---@return string Left-padded string
function text.padLeft(value, length) end

--- Removes whitespace from the start and end of a string.
---@param value string Input string
---@return string Trimmed string
function text.trim(value) end

--- Wraps the provided string to the specified width.
---@param value string Input string
---@param width number Wrap width
---@param maxWidth number Maximum width
---@return string[] Wrapped lines
function text.wrap(value, width, maxWidth) end

--- Returns a wrapper function around text.wrap.
---@param value string Input string
---@param width number Wrap width
---@param maxWidth number Maximum width
---@return function Wrapper function
function text.wrappedLines(value, width, maxWidth) end

--- Splits the input string into a table using space as the delimiter.
---@param value string Input string
---@return table Tokens
function text.tokenize(value) end

return text
