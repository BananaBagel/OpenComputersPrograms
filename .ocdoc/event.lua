---@meta

--- OpenComputers Event API
---
--- Provides event handling, timers, and signal management for OpenComputers programs.
---@class EventLib
local event = {}

--- Registers a new event listener for the specified event name.
---@param eventName string Name of the event to listen for
---@param callback fun(...):any Callback function to invoke when the event is received
---@return number|boolean Listener ID (number) if successful, false if already registered
function event.listen(eventName, callback) end

--- Unregisters a previously registered event listener.
---@param eventName string Name of the event to stop listening for
---@param callback fun(...):any The callback function to remove
---@return boolean True if successfully unregistered, false otherwise
function event.ignore(eventName, callback) end

--- Starts a new timer that calls the callback after the given interval.
---@param interval number Time in seconds between each callback invocation
---@param callback fun():any Function to call when the timer fires
---@param times number? Number of times to call the function (default: 1, math.huge for infinite)
---@return number Timer ID
function event.timer(interval, callback, times) end

--- Cancels a timer previously created with event.timer.
---@param timerId number Timer ID as returned by event.timer
---@return boolean True if the timer was stopped, false otherwise
function event.cancel(timerId) end

--- Waits for and returns the next available event from the queue, or waits until one becomes available.
---@param timeout number? Maximum time to wait in seconds (optional)
---@param name string? Event name pattern to filter for (optional)
---@param ... any Additional argument filters (optional)
---@return string|nil Event name, or nil if timed out
---@return ... Additional event arguments
function event.pull(timeout, name, ...) end

--- Waits for and returns the next available event from the queue, or waits until one becomes available.
---@param name string? Event name pattern to filter for (optional)
---@param ... any Additional argument filters (optional)
---@return string|nil Event name, or nil if timed out
---@return ... Additional event arguments
function event.pull(name, ...) end

--- Waits for and returns the next available event matching a filter function.
---@param timeout number? Maximum time to wait in seconds (optional)
---@param filter fun(name:string, ...):boolean? Filter function to determine if the event should be returned (optional)
---@return string|nil Event name, or nil if timed out
---@return ... Additional event arguments
function event.pullFiltered(timeout, filter) end

--- Waits for and returns the next event matching any of the given event names.
---@param ... string Event names to filter for
---@return ... Event arguments
function event.pullMultiple(...) end

--- Global event callback error handler. Override to customize error handling for event listeners.
---@param message any Error message or object
function event.onError(message) end

--- Pushes a new event into the event queue (alias for computer.pushSignal).
---@param name string Event name
---@param ... any Event arguments
function event.push(name, ...) end

return event
