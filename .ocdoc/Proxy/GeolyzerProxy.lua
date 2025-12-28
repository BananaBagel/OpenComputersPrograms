---@meta

--- Proxy interface for the Geolyzer component (`geolyzer`)
---
--- Provided by the Geolyzer block. Enables block hardness scanning, adjacent block analysis,
--- item stack storage, visibility detection, and sky/sun sensing. Useful for terrain mapping,
--- robot navigation, and structural data extraction.
---@class GeolyzerProxy
local GeolyzerProxy = {}

--- Scans a 3D region for block hardness values.
--- The scan starts from offset `(x, z, y)` relative to the geolyzer.
--- Optional dimensions `(w, d, h)` define width, depth, and height; defaults to 1 block.
--- The scan result is a flat array representing the 3D area: values iterate over `x`, then `z`, then `y`.
--- The result array always has 64 entries; unused entries should be ignored.
--- Noise increases with distance: `distance * 1/33 * geolyzerNoise`.
---@param x number X-axis offset
---@param z number Z-axis offset
---@param y number? Y-axis offset (default = 1)
---@param w number? Width in blocks
---@param d number? Depth in blocks
---@param h number? Height in blocks
---@param ignoreReplaceable boolean|table? Optional flag or settings table
---@return number[] hardness Flat array of hardness values
function GeolyzerProxy.scan(x, z, y, w, d, h, ignoreReplaceable) end

--- Analyzes a directly adjacent block on a given side.
--- Returns information such as block ID (`minecraft:stone`), metadata, hardness, etc.
--- Requires the misc.allowItemStackInspection config setting to be enabled.
--- Consumes the same energy as `scan`.
---@param side number Side index (0–5)
---@param options table? Optional settings
---@return table info Block analysis result
function GeolyzerProxy.analyze(side, options) end

--- Stores the block on the specified side into a database slot.
--- Attempts to create a full item stack representation and store it in
--- the database component at `dbAddress` slot `dbSlot`.
--- May fail for blocks that rely on NBT for uniqueness (e.g. robots).
---@param side number Side index (0–5)
---@param dbAddress string Component address of the database
---@param dbSlot number Target slot in the database
---@return boolean success True if stored successfully
function GeolyzerProxy.store(side, dbAddress, dbSlot) end

--- Detects whether a block or entity is present on the specified side.
--- Returns true if forward movement is blocked. Second return value indicates block type:
--- `entity`, `solid`, `replaceable`, `liquid`, `passable`, or `air`.
--- Note: Drones return true even for passable blocks.
---@param side number Side index (0–5)
---@return boolean blocked Whether movement is blocked
---@return string type General description of detected block
function GeolyzerProxy.detect(side) end

--- Returns true if there is a clear line of sight to the sky directly above.
--- Transparent blocks (e.g. glass) do not obstruct the check.
---@return boolean clearSky Whether the sky is visible
function GeolyzerProxy.canSeeSky() end

--- Returns true if the sun is visible directly above.
--- Depends on both block obstruction and time of day.
---@return boolean visible Whether the sun is directly visible
function GeolyzerProxy.isSunVisible() end

return GeolyzerProxy