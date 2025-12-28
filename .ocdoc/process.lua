---@meta

--- OpenComputers Process API
---
--- Provides rudimentary process management utilities.
---@class ProcessLib
local process = {}

--- Loads a Lua script or function as a process with a custom environment.
---@param path string|function Absolute path or function
---@param env table? Custom environment (nil if path is a function)
---@param init function? Initialization function (optional)
---@param name string? Process name (optional)
---@return thread Coroutine for the process
function process.load(path, env, init, name) end

--- Returns a table with info about the current or parent process.
---@param level number? Stack level (1=current, 2=parent, ...)
---@return table Process info
function process.info(level) end

--- (Deprecated) Returns the path, environment, and name of the current or parent process.
---@param level number? Stack level (1=current, 2=parent, ...)
---@return string Path
---@return table Environment
---@return string Name
function process.running(level) end

return process
