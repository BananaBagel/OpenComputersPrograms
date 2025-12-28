---@meta

--- Proxy interface for the Sign Upgrade component (`sign`)
---
--- This component allows reading and writing text to signs directly in front of the robot.
--- If no sign is present, operations will return `nil` and an error message.
---@class SignProxy
local SignProxy = {}

--- Gets the text currently displayed on the sign in front of the robot.
--- Returns:
--- - The sign text if successful
--- - `nil` and an error message if no sign is present
---@return string? Sign text or `nil` if failed
---@return string? Error message if failed
function SignProxy.getValue() end

--- Sets the text of the sign in front of the robot.
--- Returns:
--- - The actual text written to the sign (may be truncated)
--- - `nil` and an error message if no sign is present
---@param value string Text to write to the sign
---@return string? Written text or `nil` if failed
---@return string? Error message if failed
function SignProxy.setValue(value) end

return SignProxy