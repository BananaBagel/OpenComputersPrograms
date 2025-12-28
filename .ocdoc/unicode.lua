---@meta

--- OpenComputers Unicode API
---
--- Provides UTF-8 aware string manipulation utilities.
---@class UnicodeLib
local unicode = {}

--- UTF-8 aware version of string.char.
---@param value number Codepoint
---@param ... number Additional codepoints
---@return string UTF-8 string
function unicode.char(value, ...) end

--- Returns the width of the first character in the string.
---@param value string Input string
---@return number Character width
function unicode.charWidth(value, ...) end

--- Returns true if the first character is wide (width > 1).
---@param value string Input string
---@return boolean True if wide
function unicode.isWide(value, ...) end

--- UTF-8 aware version of string.len.
---@param value string Input string
---@return number Character count
function unicode.len(value) end

--- UTF-8 aware version of string.lower.
---@param value string Input string
---@return string Lowercase string
function unicode.lower(value) end

--- UTF-8 aware version of string.reverse.
---@param value string Input string
---@return string Reversed string
function unicode.reverse(value) end

--- UTF-8 aware version of string.sub.
---@param value string Input string
---@param i number Start index
---@param j number? End index (optional)
---@return string Substring
function unicode.sub(value, i, j) end

--- UTF-8 aware version of string.upper.
---@param value string Input string
---@return string Uppercase string
function unicode.upper(value) end

--- Returns the width of the entire string.
---@param value string Input string
---@return number String width
function unicode.wlen(value) end

--- Truncates the string to the specified width.
---@param value string Input string
---@param count number Width to truncate to
---@return string Truncated string
function unicode.wtrunc(value, count) end

return unicode
