---@meta

--- Pauses execution for the specified number of seconds. Events are still processed.
---@param seconds number Time to sleep (seconds)
function os.sleep(seconds) end

--- OpenComputers OS Library
---
--- Provides operating system facilities, partially reimplemented for OpenOS.
---@class OsLib
local os = {}

--- Returns the approximate CPU time used by the computer (not wall time).
---@return number CPU time in seconds
function os.clock() end

--- Returns a string or table containing date and time, using in-game time.
---@param format string? Format string (optional)
---@param time number? In-game time (optional)
---@return string|table Date string or table
function os.date(format, time) end

--- Executes a shell command, starting a program from a mounted filesystem.
---@param command string Command to execute
---@return boolean success, ... Results or error message
function os.execute(command) end

--- Terminates the current coroutine (script), optionally with a status code.
---@param code number? Exit code (optional)
function os.exit(code) end

--- Sets a shell environment variable from Lua.
---@param name string Variable name
---@param value string Variable value
function os.setenv(name, value) end

--- Removes a file. Alias for filesystem.remove.
---@param path string File path
---@return boolean|nil True if removed, nil on error
---@return string? Error message
function os.remove(path) end

--- Renames a file. Alias for filesystem.rename.
---@param oldPath string Old file path
---@param newPath string New file path
---@return boolean|nil True if renamed, nil on error
---@return string? Error message
function os.rename(oldPath, newPath) end

--- Returns the in-game time since the world was created (in seconds).
---@return number In-game time in seconds
function os.time() end

--- Generates an unused temporary filename in the /tmp mount.
---@return string Temporary filename
function os.tmpname() end

--- Pauses execution for the specified number of seconds. Events are still processed.
---@param seconds number Time to sleep (seconds)
function os.sleep(seconds) end

return os
