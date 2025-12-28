---@meta

--- Proxy interface for the 3D Printer component (`printer3d`)
---
--- Allows configuration and execution of 3D printed shapes and properties,
--- including labels, tooltips, redstone behavior, and voxel geometry.
---@class Printer3DProxy
local Printer3DProxy = {}

--- Commits the current configuration and begins printing.
---@param count number Number of units to print
---@return boolean success `true` if printing began successfully
function Printer3DProxy.commit(count) end

--- Sets the label that will appear on the printed block.
---@param value string Label text
function Printer3DProxy.setLabel(value) end

--- Gets the label for the block being printed.
---@return string label Label text
function Printer3DProxy.getLabel() end

--- Sets the tooltip that will be shown when hovering over the block.
---@param value string Tooltip text
function Printer3DProxy.setTooltip(value) end

--- Gets the current tooltip of the block being printed.
---@return string tooltip Tooltip text
function Printer3DProxy.getTooltip() end

--- Sets whether the printed block should behave like a button:
--- activating briefly, then returning to its off state.
---@param value boolean Whether button mode is enabled
function Printer3DProxy.setButtonMode(value) end

--- Gets whether the block will behave like a button.
---@return boolean enabled `true` if button mode is enabled
function Printer3DProxy.isButtonMode() end

--- Sets whether the block emits a redstone signal while active.
---@param value boolean Whether redstone emission is enabled
function Printer3DProxy.setRedstoneEmitter(value) end

--- Gets whether the block emits a redstone signal while active.
---@return boolean enabled `true` if redstone emission is enabled
function Printer3DProxy.isRedstoneEmitter() end

--- Adds a shape to the current print configuration.
--- Can define active/inactive state, texture, and optional tint.
---@param minX number Minimum X coordinate
---@param minY number Minimum Y coordinate
---@param minZ number Minimum Z coordinate
---@param maxX number Maximum X coordinate
---@param maxY number Maximum Y coordinate
---@param maxZ number Maximum Z coordinate
---@param texture string Texture name
---@param state boolean? Optional: `true` for active shape, `false` for inactive; default is `false`
---@param tint number? Optional: color tint code
function Printer3DProxy.addShape(minX, minY, minZ, maxX, maxY, maxZ, texture, state, tint) end

--- Gets the number of shapes currently configured.
---@return number count Number of configured shapes
function Printer3DProxy.getShapeCount() end

--- Gets the maximum number of allowed shapes.
---@return number limit Maximum shape count
function Printer3DProxy.getMaxShapeCount() end

--- Gets the printer’s current status.
--- If busy: returns `"busy"`, followed by print progress `number`.
--- If idle: returns `"idle"`, followed by model validity `boolean`.
---@return "busy"|"idle" state Printer state
---@return number|boolean info Progress (if busy) or model validity (if idle)
function Printer3DProxy.status() end

--- Cancels and resets the current job.
--- Printing will continue until the current unit is finished.
function Printer3DProxy.reset() end

return Printer3DProxy