---@meta

--- OpenComputers Keyboard API
---
--- Provides key code lookup and keyboard state query utilities.
---@class KeyboardLib
local keyboard = {}

keyboard.keys = {
	c               = 0x2E,
	d               = 0x20,
	q               = 0x10,
	w               = 0x11,
	back            = 0x0E, -- backspace
	delete          = 0xD3,
	down            = 0xD0,
	enter           = 0x1C,
	home            = 0xC7,
	lcontrol        = 0x1D,
	left            = 0xCB,
	lmenu           = 0x38, -- left Alt
	lshift          = 0x2A,
	pageDown        = 0xD1,
	rcontrol        = 0x9D,
	right           = 0xCD,
	rmenu           = 0xB8, -- right Alt
	rshift          = 0x36,
	space           = 0x39,
	tab             = 0x0F,
	up              = 0xC8,
	["end"]         = 0xCF,
	numpadenter     = 0x9C,
}

--- Checks if one of the Alt keys is currently held down.
---@return boolean True if Alt is held
function keyboard.isAltDown() end

--- Checks if the specified character is a control character.
---@param char number Character code
---@return boolean True if control character
function keyboard.isControl(char) end

--- Checks if one of the Control keys is currently held down.
---@return boolean True if Control is held
function keyboard.isControlDown() end

--- Checks if a specific key is currently held down.
---@param charOrCode string|number Character or key code
---@return boolean True if key is held
function keyboard.isKeyDown(charOrCode) end

--- Checks if one of the Shift keys is currently held down.
---@return boolean True if Shift is held
function keyboard.isShiftDown() end

return keyboard
