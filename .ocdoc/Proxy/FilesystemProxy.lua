---@meta

--- Proxy interface for the Filesystem component (`filesystem`)
---
--- Provided by Floppy Disks or Hard Disk Drives in **Managed mode**.
--- Enables interaction with a virtual file system for data storage, directory manipulation,
--- file I/O, and metadata inspection. For Unmanaged mode, see the `Drive` component.
---@class FilesystemProxy
local FilesystemProxy = {}

--- Returns the number of bytes currently used on the filesystem.
---@return number usedBytes Used capacity in bytes
function FilesystemProxy.spaceUsed() end

--- Opens a file and returns a file descriptor handle.
--- Files are opened in the specified mode (`r`, `w`, `a`, etc.), default is `'r'`.
---@param path string Absolute file path
---@param mode string? Optional mode (default `'r'`)
---@return number handle File handle
function FilesystemProxy.open(path, mode) end

--- Moves the pointer in the open file descriptor to a new position.
--- Equivalent to POSIX `seek()`.
---@param handle number File handle
---@param whence string `"set"`, `"cur"`, or `"end"` for reference point
---@param offset number Byte offset from reference point
---@return number position New pointer position
function FilesystemProxy.seek(handle, whence, offset) end

--- Creates a directory at the specified path.
--- Also creates necessary parent directories if they don’t exist.
---@param path string Absolute directory path
---@return boolean success True if created successfully
function FilesystemProxy.makeDirectory(path) end

--- Checks if a file or directory exists at the given path.
---@param path string Absolute path
---@return boolean exists True if path exists
function FilesystemProxy.exists(path) end

--- Checks whether the filesystem is mounted as read-only.
---@return boolean readOnly True if read-only
function FilesystemProxy.isReadOnly() end

--- Writes data to an open file descriptor.
---@param handle number File handle
---@param value string Data to write
---@return boolean success True if written successfully
function FilesystemProxy.write(handle, value) end

--- Returns the total capacity of the filesystem in bytes.
---@return number totalBytes Total storage capacity
function FilesystemProxy.spaceTotal() end

--- Determines whether the object at the path is a directory.
---@param path string Absolute path
---@return boolean isDir True if it's a directory
function FilesystemProxy.isDirectory(path) end

--- Renames or moves a file or directory.
---@param from string Source path
---@param to string Destination path
---@return boolean success True if moved successfully
function FilesystemProxy.rename(from, to) end

--- Lists names of objects in the specified directory.
---@param path string Absolute directory path
---@return string[] entries Array of file/directory names
function FilesystemProxy.list(path) end

--- Returns the last modified timestamp of the specified object.
---@param path string Absolute path
---@return number timestamp UNIX epoch time (real-world)
function FilesystemProxy.lastModified(path) end

--- Gets the label (name) assigned to the filesystem.
---@return string label Filesystem label
function FilesystemProxy.getLabel() end

--- Deletes the file or directory at the specified path.
---@param path string Absolute path
---@return boolean success True if deleted successfully
function FilesystemProxy.remove(path) end

--- Closes the open file descriptor.
---@param handle number File handle
function FilesystemProxy.close(handle) end

--- Returns the size of the object (file) at the specified path, in bytes.
---@param path string Absolute path
---@return number size File size
function FilesystemProxy.size(path) end

--- Reads up to `count` bytes from the file descriptor.
--- Returns `nil` when the end of the file is reached.
---@param handle number File handle
---@param count number Max bytes to read
---@return string|nil data Read data or `nil` at EOF
function FilesystemProxy.read(handle, count) end

--- Sets the label (name) of the filesystem.
--- Returns the applied label (may be truncated).
---@param value string New label
---@return string newLabel Final label after truncation
function FilesystemProxy.setLabel(value) end

return FilesystemProxy