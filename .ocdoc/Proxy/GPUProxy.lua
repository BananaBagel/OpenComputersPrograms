---@meta

--- Hex RGB color value (0xRRGGBB).
---@alias GPUColor integer

--- Palette index for editable 16-color palette (usually 0–15 on tier 2/3).
---@alias PaletteIndex integer

--- Depth string returned by setDepth.
---@alias GPUDepth "OneBit"|"FourBit"|"EightBit"

--- Buffer index. 0 is reserved for the screen; >=1 are VRAM buffers.
---@alias BufferIndex integer

--- Proxy interface for the GPU component (`gpu`).
--- Provides color/palette control, resolution/viewport, text and block I/O,
--- and video RAM buffers (bitblt).
---@class GPUProxy
local GPUProxy = {}

--[[
Palette notes
- Tier 2 screens: 16-color editable palette initialized to Minecraft colors.
- Tier 3 screens: 16-color editable palette (initialized grayscale) + 240 fixed colors.
- Colors passed to setBackground/setForeground are always RGB (0xRRGGBB) unless isPaletteIndex=true.
]]

--------------------------------------------------------------------------------
-- Binding
--------------------------------------------------------------------------------

--- Bind this GPU to a screen.
--- If `reset` is true (default), the screen settings are reset.
--- A GPU can be bound to only one screen at a time.
---@param address string Screen component address
---@param reset boolean? Default: true
---@return boolean success True if bound
---@return string? reason Error message if binding failed
function GPUProxy.bind(address, reset) end

--- Get the address of the currently bound screen (since 1.3.2).
---@return string address Screen address
function GPUProxy.getScreen() end

--------------------------------------------------------------------------------
-- Colors and palette
--------------------------------------------------------------------------------

--- Get the current background color.
--- Returns an RGB color and a flag indicating if it is from the palette.
---@return GPUColor color RGB color (0xRRGGBB) or palette-resolved RGB
---@return boolean isPalette True if color originates from palette
function GPUProxy.getBackground() end

--- Set the background color for subsequent draw operations.
--- If `isPaletteIndex` is true, `color` is interpreted as a palette index (0–15).
--- Returns previous background color as RGB, and previous palette index if it was a palette color.
---@param color GPUColor|PaletteIndex RGB (0xRRGGBB) or palette index
---@param isPaletteIndex boolean? Treat `color` as palette index
---@return GPUColor prevColor Previous color as RGB
---@return PaletteIndex? prevIndex Previous palette index if prior color was from palette
function GPUProxy.setBackground(color, isPaletteIndex) end

--- Get the current foreground color.
---@return GPUColor color RGB color (0xRRGGBB)
---@return boolean isPalette True if color originates from palette
function GPUProxy.getForeground() end

--- Set the foreground color for subsequent draw operations.
--- If `isPaletteIndex` is true, `color` is interpreted as a palette index (0–15).
--- Returns previous foreground color as RGB, and previous palette index if applicable.
---@param color GPUColor|PaletteIndex RGB (0xRRGGBB) or palette index
---@param isPaletteIndex boolean? Treat `color` as palette index
---@return GPUColor prevColor Previous color as RGB
---@return PaletteIndex? prevIndex Previous palette index if prior color was from palette
function GPUProxy.setForeground(color, isPaletteIndex) end

--- Get the RGB value at the given palette index.
---@param index PaletteIndex Palette slot (0–15)
---@return GPUColor color RGB value stored at index
function GPUProxy.getPaletteColor(index) end

--- Set the RGB value at the given palette index; returns the previous RGB value.
---@param index PaletteIndex Palette slot (0–15)
---@param value GPUColor New RGB color (0xRRGGBB)
---@return GPUColor prevColor Previous RGB value
function GPUProxy.setPaletteColor(index, value) end

--------------------------------------------------------------------------------
-- Depth and resolution
--------------------------------------------------------------------------------

--- Get the maximum supported color depth (bits) of the GPU and bound screen (minimum of both).
--- Typical values: 1, 4, 8.
---@return integer bits Max color depth in bits
function GPUProxy.maxDepth() end

--- Get the currently set color depth (bits). One of 1, 4, 8.
---@return integer bits Current color depth in bits
function GPUProxy.getDepth() end

--- Set the color depth to use (up to the maximum).
--- Returns the previous depth as a string.
---@param bit integer Desired color depth (1, 4, or 8)
---@return GPUDepth previousDepth "OneBit" | "FourBit" | "EightBit"
function GPUProxy.setDepth(bit) end

--- Get the maximum supported resolution (width, height) of GPU and bound screen.
---@return integer width
---@return integer height
function GPUProxy.maxResolution() end

--- Get the current resolution (width, height).
---@return integer width
---@return integer height
function GPUProxy.getResolution() end

--- Set the resolution (width, height). Returns true if it changed.
---@param width integer
---@param height integer
---@return boolean changed True if resolution changed
function GPUProxy.setResolution(width, height) end

--- Get the current viewport resolution (width, height).
---@return integer width
---@return integer height
function GPUProxy.getViewport() end

--- Set the viewport resolution (width, height). Returns true if changed.
--- The physical resolution remains; content outside the viewport is hidden.
---@param width integer
---@param height integer
---@return boolean changed True if viewport changed
function GPUProxy.setViewport(width, height) end

--- Get the size in blocks of the bound screen.
--- Deprecated: use `screen.getAspectRatio()` instead.
---@deprecated
---@return integer widthBlocks
---@return integer heightBlocks
function GPUProxy.getSize() end

--------------------------------------------------------------------------------
-- Text and block operations
--------------------------------------------------------------------------------

--- Get the character and colors at (x, y).
--- Returns the character, foreground and background RGB colors, and optional palette indices.
---@param x integer
---@param y integer
---@return string char Single character at position
---@return GPUColor fgColor Foreground color as RGB
---@return GPUColor bgColor Background color as RGB
---@return PaletteIndex? fgIndex Palette index of foreground color if palette-based
---@return PaletteIndex? bgIndex Palette index of background color if palette-based
function GPUProxy.get(x, y) end

--- Write a string starting at (x, y). If `vertical` is true, writes vertically.
---@param x integer
---@param y integer
---@param value string Text to write (no automatic line wrapping)
---@param vertical boolean? If true, render vertically
---@return boolean success True if written to buffer
function GPUProxy.set(x, y, value, vertical) end

--- Copy a rectangle within the screen buffer.
--- Source: (x, y, width, height). Destination: (x + tx, y + ty, width, height).
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param tx integer Delta X to destination
---@param ty integer Delta Y to destination
---@return boolean success
function GPUProxy.copy(x, y, width, height, tx, ty) end

--- Fill a rectangle with a single character.
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param char string Single-character string
---@return boolean success
function GPUProxy.fill(x, y, width, height, char) end

--[[
Budget and energy costs
- Updates to VRAM (set/copy/fill on buffers) are nearly free (no extra GPU energy cost).
- Direct component calls still incur the minimal system budget cost.
- Bitblt to the screen incurs a cost; initial sync of a dirty back buffer is the main overhead.
- Repeated bitblts from a clean back buffer are very cheap.
]]

--------------------------------------------------------------------------------
-- Video RAM buffers (since OC 1.7.5 dev; expected in OC 1.8)
--------------------------------------------------------------------------------

--- Get the index of the currently active buffer.
--- 0 is reserved for the screen and may be returned even when no screen is bound.
---@return BufferIndex index Active buffer index
function GPUProxy.getActiveBuffer() end

--- Set the active buffer by index.
--- 0 is reserved for the screen; can be set