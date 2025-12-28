---@meta

--- OpenComputers Buffer API
---
--- Provides buffered stream utilities for file and terminal I/O.
---@class BufferLib
local buffer = {}

--- Creates a new buffered stream wrapping the given stream.
---@param mode string? Buffer mode: "r", "w", or "rw" (optional)
---@param stream table Stream object to wrap
---@return BufferedStream "Buffered stream instance"
function buffer.new(mode, stream) end

--- Instance methods for buffered streams (returned by buffer.new or io.open):
---@class BufferedStream
local BufferedStream = {}

--- Immediately writes any buffered data to the stream.
function BufferedStream:flush() end

--- Flushes the buffer and closes the wrapped stream.
function BufferedStream:close() end

--- Sets the buffering mode and size.
---@param mode string? Buffering mode: "no", "full", or "line" (optional)
---@param size number? Buffer size in bytes (optional)
---@return string mode Buffering mode
---@return number size Buffer size
function BufferedStream:setvbuf(mode, size) end

--- Writes one or more values to the stream.
---@param ... string Values to write
function BufferedStream:write(...) end

--- Returns an iterator function to read lines from the stream.
---@param ... any Line formats (optional)
---@return function Iterator function
function BufferedStream:lines(...) end

--- Reads data from the stream in the specified format(s).
---@param ... any Formats (optional)
---@return ... Read values
function BufferedStream:read(...) end

--- Gets the current timeout for the buffered stream (in seconds).
---@return number Timeout in seconds
function BufferedStream:getTimeout() end

--- Sets the timeout for read operations (in seconds).
---@param timeout number Timeout in seconds
function BufferedStream:setTimeout(timeout) end

--- Moves the stream position by offset from whence.
---@param whence string? Reference point: "cur", "set", or "end" (optional)
---@param offset number? Offset in bytes (optional)
---@return number|nil New position or nil on error
function BufferedStream:seek(whence, offset) end

return buffer
