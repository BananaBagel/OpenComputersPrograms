---@meta

--- Proxy interface for the Tank Controller upgrade (`tank_controller`)
---
--- Enables fluid storage, transfer, and inspection between the robot, the world, and inventory tank items.
---@class TankControllerProxy
local TankControllerProxy = {}

--- Gets the capacity of the tank on the specified side of the robot.
--- `side` refers to the direction (0–5), with `sides.back` deprecated.
---@param side integer
---@return number? Capacity in millibuckets, or `nil` if unavailable
---@return string? Error message if failed
function TankControllerProxy.getTankCapacity(side) end

--- Gets the current fluid level in the tank on the specified side.
---@param side integer
---@return number? Fluid level in millibuckets, or `nil` if unavailable
---@return string? Error message if failed
function TankControllerProxy.getTankLevel(side) end

--- Gets a description of the fluid in the tank on the specified side.
--- Returns a table with fluid metadata (e.g., name, amount).
---@param side integer
---@return table Fluid description table (may be empty)
function TankControllerProxy.getFluidInTank(side) end

--- Gets a description of the fluid in the robot's internal tank item slot.
--- If `slot` is omitted, uses the currently selected slot.
---@param slot? integer
---@return table Fluid description table (may be empty)
function TankControllerProxy.getFluidInInternalTank(slot) end

--- Transfers fluid from the tank item in the selected inventory slot to the robot's internal tank.
--- If the fluid amount exceeds tank capacity, no fluid is transferred.
---@param amount? integer Amount in millibuckets (optional)
---@return boolean Success status
function TankControllerProxy.drain(amount) end

--- Transfers fluid from the robot's internal tank to the tank item in the selected inventory slot.
--- If the amount is below the minimum required (e.g., 1000 for buckets), no fluid is transferred.
---@param amount? integer Amount in millibuckets (optional)
---@return boolean Success status
function TankControllerProxy.fill(amount) end

--- Gets the capacity of the tank item in the specified or selected inventory slot.
---@param slot integer
---@return number Capacity in millibuckets
function TankControllerProxy.getTankCapacityInSlot(slot) end

--- Gets the fluid level of the tank item in the specified or selected inventory slot.
---@param slot integer
---@return number Fluid level in millibuckets
function TankControllerProxy.getTankLevelInSlot(slot) end

--- Gets a description of the fluid in the tank item in the specified or selected inventory slot.
---@param slot integer
---@return table Fluid description table (may be empty)
function TankControllerProxy.getFluidInTankInSlot(slot) end

return TankControllerProxy