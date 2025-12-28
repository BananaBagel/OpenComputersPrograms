---@meta

--- OpenComputers Computer API
---
--- Provides information and control over the running computer, including memory, energy, users, and signals.
---@class ComputerLib
local computer = {}

--- Returns the component address of this computer.
---@return string Component address
function computer.address() end

--- Returns the component address of the temporary file system (if any).
---@return string Temporary filesystem address
function computer.tmpAddress() end

--- Returns the amount of free memory in bytes. If too low, means the computer may crash due to having not enough memory.
---@return number Free memory (bytes)
function computer.freeMemory() end

--- Returns the total installed memory in bytes.
---@return number Total memory (bytes)
function computer.totalMemory() end

--- Returns the current available energy.
---@return number Energy (EU)
function computer.energy() end

--- Returns the maximum storable energy.
---@return number Max energy (EU)
function computer.maxEnergy() end

--- Returns the computer's uptime in seconds.
---@return number Uptime (seconds)
function computer.uptime() end

--- Shuts down or reboots the computer.
---@param reboot boolean? If true, reboots instead of shutting down
function computer.shutdown(reboot) end

--- Gets the boot address of the filesystem to boot from.
---@return string Filesystem address
function computer.getBootAddress() end

--- Sets the boot address of the filesystem to boot from.
---@param address string? Filesystem address (nil to clear)
function computer.setBootAddress(address) end

--- Returns the current runlevel ("S" for single user mode while booting, "1" for single user mode after boot).
---@return string|number Runlevel
function computer.runlevel() end

--- Returns a list of all registered users.
---@return string,... Usernames
function computer.users() end

--- Registers a new user.
---@param name string Username
---@return boolean|nil "Success or nil and error message" 
---@return string? Error message
function computer.addUser(name) end

--- Removes a registered user.
---@param name string Username
---@return boolean Success
function computer.removeUser(name) end

--- Pushes a new signal into the event queue.
--- Using the computer library for events is not recommended, use the event library instead.
---@param name string Signal name
---@param ... any Signal arguments
function computer.pushSignal(name, ...) end

--- Pulls a signal from the event queue, waiting up to timeout seconds.
--- Using the computer library for events is not recommended, use the event library instead.
---@param timeout number? Maximum time to wait (optional)
---@return string|nil Signal name, or nil if timed out
---@return ... Signal arguments
function computer.pullSignal(timeout) end

--- Produces a beep sound at the given frequency and duration, or plays a pattern.
---@param frequency string|number? Frequency in Hz or pattern string (optional)
---@param duration number? Duration in seconds (optional)
function computer.beep(frequency, duration) end

--- Returns a table of information about installed devices.
---@return table Device info
function computer.getDeviceInfo() end

return computer
