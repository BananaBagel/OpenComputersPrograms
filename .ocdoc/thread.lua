---@meta

--- Static thread API from `require("thread")`
---@class ThreadLib
local ThreadLib = {}

--- Starts a new thread executing the given function.
--- The thread runs autonomously and returns a thread handle.
---@param thread_proc fun(...): any Function to run in the thread
---@param ... any Optional arguments passed to thread_proc
---@return ThreadHandle Thread handle object
function ThreadLib.create(thread_proc, ...) end

--- Waits for all threads in the array to complete.
--- Optionally times out after `timeout` seconds.
---@param threads ThreadHandle[] Array of thread handles
---@param timeout number? Optional timeout in seconds
---@return boolean Success
---@return string|nil Error message on failure
function ThreadLib.waitForAll(threads, timeout) end

--- Waits for any one thread in the array to complete.
--- Optionally times out after `timeout` seconds.
---@param threads ThreadHandle[] Array of thread handles
---@param timeout number? Optional timeout in seconds
---@return boolean Success
---@return string|nil Error message on failure
function ThreadLib.waitForAny(threads, timeout) end

--- Returns the current thread handle.
--- Returns nil if called from the init process.
---@return ThreadHandle|nil Current thread handle
function ThreadLib.current() end

--- Thread handle object returned by `thread.create`
---@class ThreadHandle
local ThreadHandle = {}

--- Suspends the thread.
--- Suspended threads ignore events and do not resume until explicitly resumed.
---@return boolean Success
---@return string|nil Error message on failure
function ThreadHandle:suspend() end

--- Resumes a suspended thread.
--- Exceptions inside the thread are not propagated.
---@return boolean Success
---@return string|nil Error message on failure
function ThreadHandle:resume() end

--- Terminates the thread immediately.
--- All event listeners and child threads are also terminated.
---@return boolean Success
---@return string|nil Error message on failure
function ThreadHandle:kill() end

--- Returns the current status of the thread.
--- One of: `"running"`, `"suspended"`, `"dead"`
---@return string Thread status
function ThreadHandle:status() end

--- Attaches the thread to a parent process.
--- Prevents the parent from closing until this thread dies.
---@param level number? Optional process level (default: current process)
---@return boolean Success
---@return string|nil Error message on failure
function ThreadHandle:attach(level) end

--- Detaches the thread from its parent.
--- Allows the parent process to close independently.
---@return ThreadHandle|nil Self on success
---@return string|nil Error message on failure
function ThreadHandle:detach() end

--- Blocks until the thread is no longer running.
--- Optionally times out after `timeout` seconds.
---@param timeout number? Optional timeout in seconds
---@return boolean Success
---@return string|nil Error message on failure
function ThreadHandle:join(timeout) end

return ThreadLib