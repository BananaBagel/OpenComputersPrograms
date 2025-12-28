---@meta

--- OpenComputers Filesystem API
---
--- Provides utilities for interacting with file system components and the global directory tree.
---@class FilesystemLib
local filesystem = {}

--- Returns whether autorun is enabled for new filesystems.
---@return boolean True if autorun is enabled
function filesystem.isAutorunEnabled() end

--- Sets whether autorun files should be run on startup.
---@param value boolean Enable or disable autorun
function filesystem.setAutorunEnabled(value) end

--- Returns the canonical form of a path (no . or .. segments).
---@param path string Path to canonicalize
---@return string Canonical path
function filesystem.canonical(path) end

--- Returns a table of canonical path segments.
---@param path string Path to split
---@return table Segments
function filesystem.segments(path) end

--- Concatenates two or more paths, returns canonical result.
---@param pathA string First path
---@param ... string Additional paths
---@return string Concatenated path
function filesystem.concat(pathA, ...) end

--- Returns the directory part of a path.
---@param path string Path
---@return string Directory path
function filesystem.path(path) end

--- Returns the file name part of a path.
---@param path string Path
---@return string File name
function filesystem.name(path) end

--- Gets the proxy for a filesystem by address or label.
---@param filter string Address or label
---@return table|nil Proxy or nil
---@return string? Error message
function filesystem.proxy(filter) end

--- Mounts a filesystem at the specified path.
---@param fs table|string Proxy, address, or label
---@param path string Mount path
---@return boolean|nil True if mounted, nil on error
---@return string? Error message
function filesystem.mount(fs, path) end

--- Returns an iterator over all mounted filesystems and their paths.
---@return function Iterator function
function filesystem.mounts() end

--- Unmounts a filesystem by proxy, address, or path.
---@param fsOrPath table|string Proxy, address, or path
---@return boolean True if unmounted
function filesystem.umount(fsOrPath) end

--- Checks if a path is a symlink. Returns link target if so.
---@param path string Path
---@return boolean True if symlink
---@return string? Link target
function filesystem.isLink(path) end

--- Creates a symbolic link at linkpath to target.
---@param target string Target path
---@param linkpath string Link path
---@return boolean|nil True if link created, nil on error
---@return string? Error message
function filesystem.link(target, linkpath) end

--- Gets the proxy for the filesystem containing the path.
---@param path string Path
---@return table|nil Proxy or nil
---@return string? Mount path or error
function filesystem.get(path) end

--- Checks if a file or folder exists at the path.
---@param path string Path
---@return boolean True if exists
function filesystem.exists(path) end

--- Gets the file size at the path (0 if not a file).
---@param path string Path
---@return number File size
function filesystem.size(path) end

--- Checks if the path is a directory.
---@param path string Path
---@return boolean True if directory
function filesystem.isDirectory(path) end

--- Gets the last modified unix timestamp of the file or directory.
---@param path string Path
---@return number Unix timestamp
function filesystem.lastModified(path) end

--- Returns an iterator over directory contents.
---@param path string Directory path
---@return function Iterator function
---@return string? Error message
function filesystem.list(path) end

--- Creates a new directory (and parents if needed).
---@param path string Directory path
---@return boolean|nil True if created, nil on error
---@return string? Error message
function filesystem.makeDirectory(path) end

--- Removes a file or directory (recursively for directories).
---@param path string Path
---@return boolean|nil True if removed, nil on error
---@return string? Error message
function filesystem.remove(path) end

--- Renames a file or directory.
---@param oldPath string Old path
---@param newPath string New path
---@return boolean|nil True if renamed, nil on error
---@return string? Error message
function filesystem.rename(oldPath, newPath) end

--- Copies a file to a new location.
---@param fromPath string Source file
---@param toPath string Destination file
---@return boolean|nil True if copied, nil on error
---@return string? Error message
function filesystem.copy(fromPath, toPath) end

--- Opens a file for reading or writing. Returns a file stream.
---@param path string File path
---@param mode string? Open mode, follows the same format as the C function fopen
---@return table|nil File stream or nil
---@return string? Error message
function filesystem.open(path, mode) end

return filesystem
