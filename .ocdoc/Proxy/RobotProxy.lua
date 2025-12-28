---@meta

--- Proxy interface for the Robot component (`robot`)
---
--- This component is provided by the Robot upgrade.
--- Functions can be called directly via `component.robot.function()`, or through the Robot API wrapper for extended behavior.
---@class RobotProxy
local RobotProxy = {}

-- Base Methods --

--- Gets the durability of the currently equipped tool.
---@return number Tool durability
function RobotProxy.durability() end

--- Moves the robot in the specified direction.
--- Valid directions: front, back, top, bottom (see `sides` API).
---@param direction integer Direction to move (0–5)
---@return boolean `true` if movement succeeded
function RobotProxy.move(direction) end

--- Rotates the robot clockwise or counter-clockwise.
---@param clockwise boolean `true` for clockwise, `false` for counter-clockwise
---@return boolean `true` if rotation succeeded
function RobotProxy.turn(clockwise) end

--- Gets the robot's name.
---@return string Robot name
function RobotProxy.name() end

--- Uses the equipped tool against the block or space in front.
--- Returns `true` if successful, or `false` with a reason string.
---@param side integer Direction to swing (0–5)
---@return boolean Success
---@return string? Failure reason or interaction result
function RobotProxy.swing(side) end

--- Uses the equipped item like a player right-click.
--- Can simulate sneaky use and specify duration.
---@param side integer? Target side (optional)
---@param sneaky boolean? Simulate sneak-right-click
---@param duration number? Use duration (e.g. charging a bow)
---@return boolean Success
---@return string? Interaction result: `'block_activated'`, `'item_placed'`, `'item_interacted'`, `'item_used'`, `'air'`
function RobotProxy.use(side, sneaky, duration) end

--- Places the item in the selected slot on the specified side.
---@param side integer Target side (0–5)
---@param sneaky boolean? Simulate sneak-placement
---@return boolean Success
---@return string? Failure reason
function RobotProxy.place(side, sneaky) end

--- Gets the current light color (RGB encoded as 0xRRGGBB).
---@return number RGB color
function RobotProxy.getLightColor() end

--- Sets the light color (RGB encoded as 0xRRGGBB).
---@param value number RGB color
---@return number Previous color
function RobotProxy.setLightColor(value) end

-- Internal Inventory Methods --

--- Gets the size of the robot's internal inventory.
---@return number Inventory size
function RobotProxy.inventorySize() end

--- Gets or sets the currently selected inventory slot.
---@param slot number? Slot to select
---@return number Currently selected slot
function RobotProxy.select(slot) end

--- Gets the item count in the specified or selected slot.
---@param slot number? Slot to query
---@return number Item count
function RobotProxy.count(slot) end

--- Gets the remaining space in the specified or selected slot.
---@param slot number? Slot to query
---@return number Remaining space
function RobotProxy.space(slot) end

--- Compares the selected slot with another slot.
---@param otherSlot number Slot to compare with
---@return boolean `true` if contents match
function RobotProxy.compareTo(otherSlot) end

--- Transfers items from the selected slot to another slot.
---@param toSlot number Target slot
---@param amount number? Amount to transfer
---@return boolean `true` if transfer succeeded
function RobotProxy.transferTo(toSlot, amount) end

-- Fluid Tank Methods --

--- Gets the number of installed tanks.
---@return number Tank count
function RobotProxy.tankCount() end

--- Selects the active tank for fluid operations.
---@param tank number Tank index
function RobotProxy.selectTank(tank) end

--- Gets the fluid level in the specified or selected tank.
---@param tank number? Tank index
---@return number Fluid level
function RobotProxy.tankLevel(tank) end

--- Gets the remaining fluid capacity in the specified or selected tank.
---@param tank number? Tank index
---@return number Remaining capacity
function RobotProxy.tankSpace(tank) end

--- Compares fluid in the selected tank with another tank.
---@param tank number Tank index to compare
---@return boolean `true` if fluids match
function RobotProxy.compareFluidTo(tank) end

--- Transfers fluid from the selected tank to another tank.
---@param tank number Target tank index
---@param count number? Amount to transfer (default: 1000 mB)
---@return boolean `true` if transfer succeeded
function RobotProxy.transferFluidTo(tank, count) end

-- External Inventory & World Interaction --

--- Detects the block on the specified side.
--- Returns `true` if the block prevents movement.
---@param side integer Side to detect (0–5)
---@return boolean `true` if blocked
function RobotProxy.detect(side) end

--- Compares fluid in the selected tank with fluid on the specified side.
---@param side integer Side to compare (0–5)
---@return boolean `true` if fluids match
function RobotProxy.compareFluid(side) end

--- Drains fluid from the world or external tank on the specified side.
---@param side integer Side to drain from (0–5)
---@param count number? Amount to drain (default: 1000 mB)
---@return boolean `true` if drain succeeded
function RobotProxy.drain(side, count) end

--- Fills fluid into the world or external tank on the specified side.
---@param side integer Side to fill into (0–5)
---@param count number? Amount to fill (default: 1000 mB)
---@return boolean `true` if fill succeeded
function RobotProxy.fill(side, count) end

--- Compares the block on the specified side with the selected inventory item.
---@param side integer Side to compare (0–5)
---@param fuzzy boolean? Allow fuzzy comparison (default: false)
---@return boolean `true` if blocks match
function RobotProxy.compare(side, fuzzy) end

--- Drops items from the selected slot to the specified side.
---@param side integer Side to drop toward (0–5)
---@param count number? Number of items to drop
---@return boolean `true` if items were dropped
function RobotProxy.drop(side, count) end

--- Picks up items from the specified side into the selected slot.
---@param side integer Side to suck from (0–5)
---@param count number? Number of items to pick up
---@return number|boolean Number of items picked up or `false` if failed
function RobotProxy.suck(side, count) end

return RobotProxy