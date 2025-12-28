---@meta

--- Proxy interface for the Net Splitter component (`net_splitter`)
--- 
--- The net splitter connects networks like a cable, but with controllable faces.
--- Each face can be opened or closed to segment the network.
--- 
--- - A redstone signal toggles face states.
--- - A scrench can manually open/close a face.
--- - This API allows programmatic control of face states.
---@class NetSplitterProxy
local NetSplitterProxy = {}

--- Opens the specified face.
--- Returns `true` if the face was previously closed and is now open.
---@param side integer The face to open (0–5)
---@return boolean `true` if the face was successfully opened
function NetSplitterProxy.open(side) end

--- Closes the specified face.
--- Returns `true` if the face was previously open and is now closed.
---@param side integer The face to close (0–5)
---@return boolean `true` if the face was successfully closed
function NetSplitterProxy.close(side) end

--- Returns the current open/close state of all faces.
--- The result is an array indexed by direction (0–5), with boolean values:
--- - `true` means the face is open
--- - `false` means the face is closed
---@return boolean[] Array of face states indexed by direction
function NetSplitterProxy.getSides() end

--- Sets the open/close state of all faces.
--- Accepts an array indexed by direction (0–5), with boolean values:
--- - `true` to open the face
--- - `false` to close the face
--- Returns the previous states before the change.
---@param settings boolean[] Array of desired face states indexed by direction
---@return boolean[] Array of previous face states
function NetSplitterProxy.setSides(settings) end

return NetSplitterProxy