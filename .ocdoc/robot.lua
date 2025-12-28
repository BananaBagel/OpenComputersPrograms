---@meta

--- OpenComputers Robot API
---
--- High-level robot operations: movement, inventory, fluid, and block interaction.
---@class RobotAPI
local robot = {}

--- Returns the robot's name.
---@return string Robot name
function robot.name() end

--- Detects if there is a block or entity in front of the robot.
---@return boolean True if something is in front of the robot.
---@return string Type description (entity/solid/replaceable/liquid/passable/air)
function robot.detect() end

--- Detects if there is a block or entity above the robot.
---@return boolean True if something is above the robot
---@return string Type description
function robot.detectUp() end

--- Detects if there is a block or entity below the robot.
---@return boolean True if something is below the robot
---@return string Type description
function robot.detectDown() end

--- Selects the given inventory slot.
---@param slot number? Slot to select (optional)
---@return number Currently selected slot
function robot.select(slot) end

--- Returns the number of main inventory slots.
---@return number Slot count
function robot.inventorySize() end

--- Returns the item count in the given or current slot.
---@param slot number? Slot number (optional, defaults to current)
---@return number Item count
function robot.count(slot) end

--- Returns the remaining space in the given or current slot.
---@param slot number? Slot number (optional, defaults to current)
---@return number Remaining stack space
function robot.space(slot) end

--- Moves items from the selected slot to the target slot.
---@param slot number Target slot
---@param count number? Number of items to move (optional, default all)
---@return boolean Success
function robot.transferTo(slot, count) end

--- Compares the item in the selected slot to the target slot.
---@param slot number Target slot
---@return boolean True if items are equal
function robot.compareTo(slot) end

--- Compares the block in front with the item in the selected slot.
---@return boolean True if equal
function robot.compare() end

--- Compares the block above with the item in the selected slot.
---@return boolean True if equal
function robot.compareUp() end

--- Compares the block below with the item in the selected slot.
---@return boolean True if equal
function robot.compareDown() end

--- Drops items from the selected slot in front of the robot.
---@param count number? Number of items to drop (optional, default all)
---@return boolean Success
function robot.drop(count) end

--- Drops items from the selected slot above the robot.
---@param count number? Number of items to drop (optional, default all)
---@return boolean Success
function robot.dropUp(count) end

--- Drops items from the selected slot below the robot.
---@param count number? Number of items to drop (optional, default all)
---@return boolean Success
function robot.dropDown(count) end

--- Picks up items in front of the robot.
---@param count number? Number of items to pick up (optional, default one stack)
---@return boolean Success
function robot.suck(count) end

--- Picks up items above the robot.
---@param count number? Number of items to pick up (optional, default one stack)
---@return boolean Success
function robot.suckUp(count) end

--- Picks up items below the robot.
---@param count number? Number of items to pick up (optional, default one stack)
---@return boolean Success
function robot.suckDown(count) end

--- Places the selected item in front of the robot.
---@param side number? Side to place on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@return boolean Success
---@return string? Failure reason
function robot.place(side, sneaky) end

--- Places the selected item above the robot.
---@param side number? Side to place on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@return boolean Success
---@return string? Failure reason
function robot.placeUp(side, sneaky) end

--- Places the selected item below the robot.
---@param side number? Side to place on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@return boolean Success
---@return string? Failure reason
function robot.placeDown(side, sneaky) end

--- Returns the durability of the tool in the tool slot.
---@return number? Current durability
---@return number? Max durability
---@return number? Percentage
---@return string? Error message
function robot.durability() end

--- Uses the tool in the tool slot in front of the robot (left-click).
---@param side number? Side to use on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@return boolean Success
---@return string? Interaction type (entity/block/fire)
function robot.swing(side, sneaky) end

--- Uses the tool in the tool slot above the robot.
---@param side number? Side to use on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@return boolean Success
---@return string? Interaction type
function robot.swingUp(side, sneaky) end

--- Uses the tool in the tool slot below the robot.
---@param side number? Side to use on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@return boolean Success
---@return string? Interaction type
function robot.swingDown(side, sneaky) end

--- Uses the item in the tool slot (right-click).
---@param side number? Side to use on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@param duration number? Use duration (optional)
---@return boolean Success
---@return string? Interaction result
function robot.use(side, sneaky, duration) end

--- Uses the item in the tool slot above the robot.
---@param side number? Side to use on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@param duration number? Use duration (optional)
---@return boolean Success
---@return string? Interaction result
function robot.useUp(side, sneaky, duration) end

--- Uses the item in the tool slot below the robot.
---@param side number? Side to use on (optional)
---@param sneaky boolean? Simulate sneaking (optional)
---@param duration number? Use duration (optional)
---@return boolean Success
---@return string? Interaction result
function robot.useDown(side, sneaky, duration) end

--- Moves the robot forward.
---@return boolean Success
---@return string? Failure reason
function robot.forward() end

--- Moves the robot backward.
---@return boolean Success
---@return string? Failure reason
function robot.back() end

--- Moves the robot upward.
---@return boolean Success
---@return string? Failure reason
function robot.up() end

--- Moves the robot downward.
---@return boolean Success
---@return string? Failure reason
function robot.down() end

--- Turns the robot 90° left.
function robot.turnLeft() end

--- Turns the robot 90° right.
function robot.turnRight() end

--- Turns the robot 180°.
function robot.turnAround() end

--- Returns the robot's experience level (deprecated).
---@return number Level
function robot.level() end

--- Returns the number of installed fluid tanks.
---@return number Tank count
function robot.tankCount() end

--- Selects the specified tank.
---@param tank number Tank index
function robot.selectTank(tank) end

--- Returns the fluid level in the specified or current tank.
---@param tank number? Tank index (optional)
---@return number Fluid level
function robot.tankLevel(tank) end

--- Returns the remaining capacity in the specified or current tank.
---@param tank number? Tank index (optional)
---@return number Remaining capacity
function robot.tankSpace(tank) end

--- Compares the fluid in the selected tank to another tank.
---@param tank number Target tank index
---@return boolean True if fluids are equal
function robot.compareFluidTo(tank) end

--- Transfers fluid from the selected tank to another tank.
---@param tank number Target tank index
---@param count number? Amount to transfer (optional, default 1000mB)
---@return boolean Success
function robot.transferFluidTo(tank, count) end

--- Compares the fluid in the selected tank to the world or tank in front.
---@return boolean True if fluids are equal
function robot.compareFluid() end

--- Compares the fluid in the selected tank to the block above.
---@return boolean True if fluids are equal
function robot.compareFluidUp() end

--- Compares the fluid in the selected tank to the block below.
---@return boolean True if fluids are equal
function robot.compareFluidDown() end

--- Drains fluid from the world or tank in front.
---@param count number? Amount to drain (optional, default 1000mB)
---@return boolean Success
function robot.drain(count) end

--- Drains fluid from the block above.
---@param count number? Amount to drain (optional, default 1000mB)
---@return boolean Success
function robot.drainUp(count) end

--- Drains fluid from the block below.
---@param count number? Amount to drain (optional, default 1000mB)
---@return boolean Success
function robot.drainDown(count) end

--- Fills the world or tank in front with fluid from the selected tank.
---@param count number? Amount to fill (optional, default 1000mB)
---@return boolean Success
function robot.fill(count) end

--- Fills the block above with fluid from the selected tank.
---@param count number? Amount to fill (optional, default 1000mB)
---@return boolean Success
function robot.fillUp(count) end

--- Fills the block below with fluid from the selected tank.
---@param count number? Amount to fill (optional, default 1000mB)
---@return boolean Success
function robot.fillDown(count) end

return robot
