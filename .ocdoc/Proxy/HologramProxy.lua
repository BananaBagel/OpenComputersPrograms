---@meta

--- Proxy interface for the Hologram component (`hologram`)
---
--- Projects a 3D grid of voxels at 48x32x48 resolution. Tier 1 holograms support one color;
--- Tier 2 supports up to three simultaneous colors. The projection size and color depth vary by tier and scale.
--- The maximum effective volume is 9×6×9 blocks, and updates occur on a timed interval.
---@class HologramProxy
local HologramProxy = {}

--- Clears all voxel data from the current hologram.
function HologramProxy.clear() end

--- Gets the value of the voxel at the specified 3D coordinate.
---@param x number X-axis position (1 to 48)
---@param y number Y-axis position (1 to 32)
---@param z number Z-axis position (1 to 48)
---@return number value Voxel value at the coordinate
function HologramProxy.get(x, y, z) end

--- Sets the voxel at the specified position to the given value.
--- If value is `true`, sets to 1; if `false`, sets to 0.
---@param x number X-axis position
---@param y number Y-axis position
---@param z number Z-axis position
---@param value number|boolean Value to assign (integer or boolean)
function HologramProxy.set(x, y, z, value) end

--- Fills a vertical column of voxels with the specified value.
--- Interval is inclusive; if `minY` is omitted, defaults to 1.
---@param x number X-axis coordinate of the column
---@param z number Z-axis coordinate of the column
---@param minY number? Starting Y-coordinate (defaults to 1)
---@param maxY number Ending Y-coordinate
---@param value number Value to assign to each voxel
function HologramProxy.fill(x, z, minY, maxY, value) end

--- Copies a rectangular block of columns from one region to another.
--- Source origin `(x,z)` with size `(sx,sz)` is translated by `(tx,tz)`.
---@param x number Source X origin
---@param z number Source Z origin
---@param sx number Width of source region
---@param sz number Depth of source region
---@param tx number X offset to apply
---@param tz number Z offset to apply
function HologramProxy.copy(x, z, sx, sz, tx, tz) end

--- Returns the current render scale of the hologram.
--- Range: 0.33 to 3. Larger scales require more energy.
---@return number scale Current hologram scale
function HologramProxy.getScale() end

--- Sets the render scale of the hologram.
--- At scale 0.33 the hologram fits in one block; at 3 it spans 9×6×9 blocks.
---@param value number New scale value (0.33 to 3)
function HologramProxy.setScale(value) end

--- Gets the translation vector applied to the hologram's origin.
--- Units are hologram-relative, and scale-dependent.
---@return number x
---@return number y
---@return number z
function HologramProxy.getTranslation() end

--- Sets the translation vector that offsets the hologram’s base location.
---@param x number X offset (relative to scale)
---@param y number Y offset
---@param z number Z offset
function HologramProxy.setTranslation(x, y, z) end

--- Returns the number of simultaneous color values supported by the hologram.
--- Tier 1 returns 1; Tier 2 supports up to 3.
---@return number depth Color depth
function HologramProxy.maxDepth() end

--- Gets the hex color value defined for the specified voxel value.
---@param index number Voxel value index (e.g., 1, 2, 3)
---@return number color RGB hex code
function HologramProxy.getPaletteColor(index) end

--- Sets the hex color associated with a specific voxel value index.
---@param index number Voxel value index to configure
---@param value number Hex RGB color (e.g., 0xFF00FF)
---@return number previous Previous color value
function HologramProxy.setPaletteColor(index, value) end