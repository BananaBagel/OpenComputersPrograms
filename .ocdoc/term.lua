---@meta

--- OpenComputers Term API
---
--- Provides terminal text output, input, and cursor control utilities.
---@class TermLib
local term = {}

--- Returns whether the term API is available (primary GPU and screen present).
---@return boolean True if available
function term.isAvailable() end

--- Gets the viewport dimensions and offsets.
---@return number width
---@return number height
---@return number xOffset
---@return number yOffset
---@return number relX
---@return number relY
function term.getViewport() end

--- Gets the GPU proxy used by the term API.
---@return GPUProxy GPU proxy
function term.gpu() end

--- Waits for an event, like event.pull.
---@param ... any Event filter arguments
---@return ... Event arguments
function term.pull(...) end

--- Gets the current cursor position.
---@return number col
---@return number row
function term.getCursor() end

--- Sets the cursor position.
---@param col number Column
---@param row number Row
function term.setCursor(col, row) end

--- Gets whether cursor blink is enabled.
---@return boolean True if blinking
function term.getCursorBlink() end

--- Sets whether cursor blink is enabled.
---@param enabled boolean Enable blinking
function term.setCursorBlink(enabled) end

--- Clears the screen and resets the cursor to (1, 1).
function term.clear() end

--- Clears the current line and resets the cursor's column to 1.
function term.clearLine() end

--- Reads text input from the terminal.
---@param history table? Command history (optional)
---@param dobreak boolean? Whether to break on enter (optional)
---@param hint table|function? Tab completion hints (optional)
---@param pwchar string? Password mask character (optional)
---@return string|nil|false Input string, nil if closed, false if interrupted
function term.read(history, dobreak, hint, pwchar) end

--- Writes text to the terminal at the current cursor position.
---@param value string Text to write
---@param wrap boolean? Whether to word-wrap (optional)
function term.write(value, wrap) end

--- Binds a GPU proxy to the terminal.
---@param gpu table GPU proxy
function term.bind(gpu) end

--- Gets the address of the bound screen.
---@return string Screen address
function term.screen() end

--- Gets the address of the keyboard used by the terminal.
---@return string Keyboard address
function term.keyboard() end

return term
