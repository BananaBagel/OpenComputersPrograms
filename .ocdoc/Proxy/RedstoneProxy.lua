---@meta

--- Proxy interface for the Redstone Card component (`redstone`)
---
--- Tier 1 supports vanilla analog redstone (single-line).
--- Tier 2 supports bundled and wireless redstone, interoperable with mods like ProjectRed, WR-CBE, SlimeVoid's WR.
---
--- Notes:
--- - `get*` methods are direct and fast (~20,000 calls/sec).
--- - `set*` methods are indirect and limited (~20 calls/sec), with additional delay if output changes.
--- - Overloaded variants allow batch operations with a single API cost.
---@class RedstoneProxy
local RedstoneProxy = {}

--- Gets the redstone input level from a specific side.
---@param side integer The side to query (0–5)
---@return integer Redstone level (0–15 or mod-specific range)
function RedstoneProxy.getInput(side) end

--- Gets redstone input levels from all sides.
--- Returns a zero-based array indexed by side ordinal (e.g. `sides.bottom = 0`)
---@return table<integer, integer> Map of side → redstone level
function RedstoneProxy.getInput() end

--- Gets the redstone output level from a specific side.
---@param side integer The side to query (0–5)
---@return integer Redstone output level
function RedstoneProxy.getOutput(side) end

--- Gets redstone output levels from all sides.
---@return table<integer, integer> Map of side → output level
function RedstoneProxy.getOutput() end

--- Sets the redstone output level on a specific side.
--- Returns the previous output level.
---@param side integer The side to set (0–5)
---@param value integer The redstone strength to emit
---@return integer Previous output level
function RedstoneProxy.setOutput(side, value) end

--- Sets redstone output levels for multiple sides.
--- Keys are side ordinals, values are redstone strengths.
---@param values table<integer, integer> Map of side → output level
---@return table<integer, integer> Previous output levels
function RedstoneProxy.setOutput(values) end

--- Gets bundled redstone input from a specific side and color.
---@param side integer The side to query (0–5)
---@param color integer The color channel (0–15)
---@return integer Bundled input strength
function RedstoneProxy.getBundledInput(side, color) end

--- Gets all bundled input values from a specific side.
--- Returns a map of color → strength.
---@param side integer The side to query (0–5)
---@return table<integer, integer> Map of color → input strength
function RedstoneProxy.getBundledInput(side) end

--- Gets all bundled input values from all sides.
--- Returns a nested map: side → color → strength.
---@return table<integer, table<integer, integer>> Map of side → color → input strength
function RedstoneProxy.getBundledInput() end

--- Gets bundled redstone output from a specific side and color.
---@param side integer The side to query (0–5)
---@param color integer The color channel (0–15)
---@return integer Bundled output strength
function RedstoneProxy.getBundledOutput(side, color) end

--- Gets all bundled output values from a specific side.
---@param side integer The side to query (0–5)
---@return table<integer, integer> Map of color → output strength
function RedstoneProxy.getBundledOutput(side) end

--- Gets all bundled output values from all sides.
---@return table<integer, table<integer, integer>> Map of side → color → output strength
function RedstoneProxy.getBundledOutput() end

--- Sets bundled output on a specific side and color.
--- Returns the previous output value.
---@param side integer The side to set (0–5)
---@param color integer The color channel (0–15)
---@param value integer The redstone strength to emit
---@return integer Previous output strength
function RedstoneProxy.setBundledOutput(side, color, value) end

--- Sets bundled output values on a specific side.
--- Keys are color channels, values are strengths.
---@param side integer The side to set (0–5)
---@param values table<integer, integer> Map of color → output strength
---@return table<integer, integer> Previous output strengths
function RedstoneProxy.setBundledOutput(side, values) end

--- Sets bundled output values for all sides and colors.
--- Keys are sides, values are maps of color → strength.
---@param values table<integer, table<integer, integer>> Map of side → color → output strength
---@return table<integer, table<integer, integer>> Previous output strengths
function RedstoneProxy.setBundledOutput(values) end

--- Gets the comparator input level on a specific side.
---@param side integer The side to query (0–5)
---@return integer Comparator input level
function RedstoneProxy.getComparatorInput(side) end

--- Gets the wireless redstone input.
--- Only available on tier 2 cards.
---@return integer Wireless input level
function RedstoneProxy.getWirelessInput() end

--- Gets the wireless redstone output.
--- Only available on tier 2 cards.
---@return boolean Wireless output state
function RedstoneProxy.getWirelessOutput() end

--- Sets the wireless redstone output.
--- Only available on tier 2 cards.
---@param value boolean Desired output state
---@return boolean Previous output state
function RedstoneProxy.setWirelessOutput(value) end

--- Gets the current wireless redstone frequency.
--- Only available on tier 2 cards.
---@return integer Frequency value
function RedstoneProxy.getWirelessFrequency() end

--- Sets the wireless redstone frequency.
--- Only available on tier 2 cards.
---@param frequency integer Desired frequency
---@return integer Previous frequency
function RedstoneProxy.setWirelessFrequency(frequency) end

--- Gets the current wake-up threshold.
---@return integer Wake threshold value
function RedstoneProxy.getWakeThreshold() end

--- Sets the wake-up threshold.
--- For mods like ProjectRed, higher values (e.g. 255) may be required for binary on/off behavior.
---@param threshold integer Desired threshold
---@return integer Previous threshold
function RedstoneProxy.setWakeThreshold(threshold) end

return RedstoneProxy