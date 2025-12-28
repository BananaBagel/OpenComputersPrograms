---@meta

--- Proxy interface for the Screen component (`screen`)
---
--- This component is provided by screen blocks, either placed in the world or installed in a robot.
--- Tier 3 screens support high-precision input and inverted touch mode.
---@class ScreenProxy
local ScreenProxy = {}

--- Checks whether the screen is currently powered on.
---@return boolean `true` if the screen is on
function ScreenProxy.isOn() end

--- Turns the screen on.
--- Returns two values:
--- - `true` if the screen was previously off
--- - `true` if the screen is now on
---@return boolean Was previously off
---@return boolean Current power state
function ScreenProxy.turnOn() end

--- Turns the screen off.
--- Returns two values:
--- - `true` if the screen was previously on
--- - `false` if the screen is now off
---@return boolean Was previously on
---@return boolean Current power state
function ScreenProxy.turnOff() end

--- Gets the aspect ratio of the screen.
--- For multi-block screens, returns the number of blocks horizontally and vertically.
---@return number Horizontal block count
---@return number Vertical block count
function ScreenProxy.getAspectRatio() end

--- Gets the list of keyboards attached to the screen.
---@return table List of attached keyboard addresses
function ScreenProxy.getKeyboards() end

--- Enables or disables high-precision mode (sub-pixel mouse event position).
--- Requires a Tier 3 screen.
---@param enabled boolean `true` to enable precise mode
---@return boolean Previous precise mode state
function ScreenProxy.setPrecise(enabled) end

--- Checks whether high-precision mode is enabled.
--- Requires a Tier 3 screen.
---@return boolean `true` if precise mode is enabled
function ScreenProxy.isPrecise() end

--- Enables or disables inverted touch mode.
--- If enabled, sneak-activate opens GUI.
---@param enabled boolean `true` to enable inverted touch mode
---@return boolean Previous inverted mode state
function ScreenProxy.setTouchModeInverted(enabled) end

--- Checks whether inverted touch mode is enabled.
--- If enabled, sneak-activate opens GUI.
---@return boolean `true` if inverted touch mode is enabled
function ScreenProxy.isTouchModeInverted() end

return ScreenProxy