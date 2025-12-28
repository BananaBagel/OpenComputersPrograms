---@meta

--- OpenComputers Shell API
---
--- Provides shell-related utilities such as working directory, path, aliases, and command execution.
---@class ShellLib
local shell = {}

--- Gets the value of a specified alias, or nil if not set.
---@param alias string Alias name
---@return string|nil Alias value
function shell.getAlias(alias) end

--- Sets or removes an alias. Pass nil as value to remove.
---@param alias string Alias name
---@param value string|nil Alias value or nil to remove
function shell.setAlias(alias, value) end

--- Returns an iterator over all known aliases.
---@return function Iterator function
function shell.aliases() end

--- Gets the current working directory.
---@return string Working directory path
function shell.getWorkingDirectory() end

--- Sets the current working directory.
---@param dir string Directory path
function shell.setWorkingDirectory(dir) end

--- Gets the search path used by shell.resolve.
---@return string Search path
function shell.getPath() end

--- Sets the search path (replaces previous paths).
---@param value string New search path
function shell.setPath(value) end

--- Resolves a path, optionally checking for a file extension.
---@param path string Path to resolve
---@param ext string? Optional extension
---@return string Resolved path
function shell.resolve(path, ext) end

--- Executes a command in the shell environment.
---@param command string Command to execute
---@param env table Environment table
---@param ... any Additional arguments
---@return boolean Success
---@return ... Results or error message
function shell.execute(command, env, ...) end

--- Parses command-line arguments into parameters and options tables.
---@param ... string Arguments
---@return table Parameters
---@return table Options
function shell.parse(...) end

return shell
