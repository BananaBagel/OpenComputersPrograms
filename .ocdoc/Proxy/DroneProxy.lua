---@meta

--- Proxy interface for the Drone component (`drone`)
---
--- Drones are nimble, lightweight robots akin to microcontrollers. This interface provides controls
--- for movement, GUI status, fluid and item interaction, inventory and tank management, and external block manipulation.
---@class DroneProxy
local DroneProxy = {}

-- GUI Status

--- Gets the current GUI status text.
---@return string status Current status text
function DroneProxy.getStatusText() end

--- Sets the GUI status text and returns it.
---@param value string New status text
---@return string status Applied status text
function DroneProxy.setStatusText(value) end

-- Movement and Physics

--- Moves the drone by a relative offset.
---@param dx number X offset
---@param dy number Y offset
---@param dz number Z offset
function DroneProxy.move(dx, dy, dz) end

--- Returns distance to target position.
---@return number offset Distance to target
function DroneProxy.getOffset() end

--- Returns current velocity in meters per second.
---@return number velocity Current velocity
function DroneProxy.getVelocity() end

--- Returns maximum velocity in meters per second.
---@return number maxVelocity Maximum velocity
function DroneProxy.getMaxVelocity() end

--- Gets the currently set acceleration.
---@return number acceleration Current acceleration
function DroneProxy.getAcceleration() end

--- Sets the acceleration value; returns applied value.
---@param value number Desired acceleration
---@return number acceleration Applied acceleration
function DroneProxy.setAcceleration(value) end

--- Returns the name of the drone.
---@return string name Drone name
function DroneProxy.name() end

-- Item Usage and Interaction

--- Uses the equipped tool against the block in front.
---@param side number Side index
---@return boolean success True if action succeeded
---@return string? reason Optional failure reason
function DroneProxy.swing(side) end

--- Simulates a right-click with the equipped item.
---@param side number? Optional target side
---@param sneaky boolean? Sneak-click simulation
---@param duration number? Use duration (e.g. charging)
---@return boolean success True if interacted
---@return string? result Action result: `"block_activated"`, `"item_interacted"`, `"item_placed"`, `"item_used"`, or `"air"`
function DroneProxy.use(side, sneaky, duration) end

--- Attempts to place the item in the selected slot.
---@param side number Placement side
---@param sneaky boolean? Sneak placement
---@return boolean success True if placed
---@return string? reason Optional failure reason
function DroneProxy.place(side, sneaky) end

-- Activity Light Control

--- Gets light color as 0xRRGGBB.
---@return number color Current light color
function DroneProxy.getLightColor() end

--- Sets light color using 0xRRGGBB value.
---@param value number RGB color
---@return number color Applied color
function DroneProxy.setLightColor(value) end

-- Internal Inventory Management

--- Returns internal inventory size.
---@return number size Slot count
function DroneProxy.inventorySize() end

--- Gets or sets the selected slot.
---@param slot number? Slot to select
---@return number selectedSlot Currently selected slot
function DroneProxy.select(slot) end

--- Returns item count in a slot or selected slot.
---@param slot number? Slot index
---@return number count Item quantity
function DroneProxy.count(slot) end

--- Returns remaining space in a slot.
---@param slot number? Slot index
---@return number space Remaining capacity
function DroneProxy.space(slot) end

--- Compares selected slot with another slot.
---@param otherSlot number Other slot index
---@return boolean identical True if matching
function DroneProxy.compareTo(otherSlot) end

--- Transfers items from selected to specified slot.
---@param toSlot number Destination slot
---@param amount number? Optional item count
---@return boolean success True if transferred
function DroneProxy.transferTo(toSlot, amount) end

-- Internal Tank Management

--- Returns number of installed tanks.
---@return number count Tank count
function DroneProxy.tankCount() end

--- Selects a tank for future operations.
---@param tank number Tank index
function DroneProxy.selectTank(tank) end

--- Gets fluid level in specified or selected tank.
---@param tank number? Tank index
---@return number level Fluid level (mB)
function DroneProxy.tankLevel(tank) end

--- Gets fluid capacity in specified or selected tank.
---@param tank number? Tank index
---@return number space Available space (mB)
function DroneProxy.tankSpace(tank) end

--- Compares fluid between selected and target tank.
---@param tank number Target tank index
---@return boolean identical True if fluids match
function DroneProxy.compareFluidTo(tank) end

--- Transfers fluid to a target tank.
---@param tank number Target tank index
---@param count number? Volume (default = 1000mB)
---@return boolean success True if transferred
function DroneProxy.transferFluidTo(tank, count) end

-- External Environment Interaction

--- Detects block or entity in front of specified side.
---@param side number Target side
---@return boolean blocked True if movement blocked
---@return string description `"solid"`, `"air"`, etc.
function DroneProxy.detect(side) end

--- Compares fluid in selected tank to external fluid.
---@param side number Target side
---@return boolean identical True if fluids match
function DroneProxy.compareFluid(side) end

--- Drains fluid from world or tank.
---@param side number Target side
---@param count number? Volume to drain (default = 1000mB)
---@return boolean success True if drained
function DroneProxy.drain(side, count) end

--- Fills fluid into world or tank.
---@param side number Target side
---@param count number? Volume to fill (default = 1000mB)
---@return boolean success True if filled
function DroneProxy.fill(side, count) end

--- Compares block with currently selected item.
---@param side number Target side
---@param fuzzy boolean? Allow fuzzy match (default = false)
---@return boolean match True if block matches item
function DroneProxy.compare(side, fuzzy) end

--- Drops items from selected slot to external inventory.
---@param side number Target side
---@param count number? Quantity to drop
---@return boolean success True if dropped
function DroneProxy.drop(side, count) end

--- Picks up items from external inventory or world.
---@param side number Target side
---@param count number? Quantity to suck
---@return number|boolean result Number of items or false
function DroneProxy.suck(side, count) end

return DroneProxy