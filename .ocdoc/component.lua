---@meta
---@class Component
---@field printer3d Printer3DProxy
---@field chunkloader ChunkloaderProxy
---@field computer ComputerProxy
---@field crafting CraftingProxy
---@field database DatabaseProxy
---@field data DataProxy
---@field debug DebugProxy
---@field drive DriveProxy
---@field eeprom EEPROMProxy
---@field experience ExperienceProxy
---@field filesystem FilesystemProxy
---@field generator GeneratorProxy
---@field geolyzer GeolyzerProxy
---@field gpu GPUProxy
---@field hologram HologramProxy
---@field internet InternetProxy
---@field inventory_controller InventoryControllerProxy
---@field leash LeashProxy
---@field microcontroller MicrocontrollerProxy
---@field modem ModemProxy
---@field motion_sensor MotionSensorProxy
---@field navigation NavigationProxy
---@field net_splitter NetSplitterProxy
---@field piston PistonProxy
---@field redstone RedstoneProxy
---@field screen ScreenProxy
---@field tank_controller TankControllerProxy
---@field sign SignProxy
---@field tractor_beam TractorBeamProxy
---@field robot RobotProxy
---@field transposer TransposerProxy
---@field tunnel TunnelProxy
local component = {}

--- Returns the documentation string for the specified method of the component at the given address.
---@param address string Component address
---@param method string Method name
---@return string Documentation string
function component.doc(address, method) end

--- Calls the specified method on the component at the given address, passing any additional arguments.
---@param address string Component address
---@param method string Method name
---@param ... any Arguments to pass to the method
---@return any Results returned by the method
function component.invoke(address, method, ...) end

--- Returns an iterator over all components attached to the computer.
--- If filter is set, only components whose type contains the filter string are returned.
--- If exact is true, only exact matches are returned.
---@param filter? string Filter string (optional)
---@param exact? boolean Exact match (optional)
---@return fun(): (string, string) Iterator yielding address and type
function component.list(filter, exact) end

--- Returns a table of all method names provided by the component at the given address.
--- The table keys are method names, values indicate if the method is called directly.
---@param address string Component address
---@return table<string, boolean> Table of method names to direct-call flags
function component.methods(address) end

--- Gets a proxy object for the component at the given address, providing all its methods as fields.
---@param address string Component address
---@return table Proxy object for the component
function component.proxy(address) end

--- Gets the component type of the component at the given address.
---@param address string Component address
---@return string Component type
function component.type(address) end

--- Returns the slot number where the component is installed, or -1 if not applicable.
---@param address string Component address
---@return integer Slot number or -1
function component.slot(address) end

--- (Undocumented) Returns fields for the component at the given address.
---@param address string Component address
---@return string Fields (undocumented)
function component.fields(address) end -- undocumented

--- Tries to resolve an abbreviated address to a full address, optionally filtering by component type.
---@param address string Abbreviated or full address
---@param componentType? string Component type to filter (optional)
---@return string|nil Full address or nil
---@return string? Error message if any error occurs
function component.get(address, componentType) end

--- Checks if there is a primary component of the specified type.
---@param componentType string Component type
---@return boolean `True` if available
function component.isAvailable(componentType) end

--- Gets the proxy for the primary component of the specified type.
--- Throws an error if there is no primary component of that type.
---@overload fun(componentType: "printer3d"): Printer3DProxy
---@overload fun(componentType: "chunkloader"): ChunkloaderProxy
---@overload fun(componentType: "computer"): ComputerProxy
---@overload fun(componentType: "crafting"): CraftingProxy
---@overload fun(componentType: "database"): DatabaseProxy
---@overload fun(componentType: "data"): DataProxy
---@overload fun(componentType: "debug"): DebugProxy
---@overload fun(componentType: "drive"): DriveProxy
---@overload fun(componentType: "eeprom"): EEPROMProxy
---@overload fun(componentType: "experience"): ExperienceProxy
---@overload fun(componentType: "filesystem"): FilesystemProxy
---@overload fun(componentType: "generator"): GeneratorProxy
---@overload fun(componentType: "geolyzer"): GeolyzerProxy
---@overload fun(componentType: "gpu"): GPUProxy
---@overload fun(componentType: "hologram"): HologramProxy
---@overload fun(componentType: "internet"): InternetProxy
---@overload fun(componentType: "inventory_controller"): InventoryControllerProxy
---@overload fun(componentType: "leash"): LeashProxy
---@overload fun(componentType: "microcontroller"): MicrocontrollerProxy
---@overload fun(componentType: "modem"): ModemProxy
---@overload fun(componentType: "motion_sensor"): MotionSensorProxy
---@overload fun(componentType: "navigation"): NavigationProxy
---@overload fun(componentType: "net_splitter"): NetSplitterProxy
---@overload fun(componentType: "piston"): PistonProxy
---@overload fun(componentType: "redstone"): RedstoneProxy
---@overload fun(componentType: "screen"): ScreenProxy
---@overload fun(componentType: "tank_controller"): TankControllerProxy
---@overload fun(componentType: "sign"): SignProxy
---@overload fun(componentType: "tractor_beam"): TractorBeamProxy
---@overload fun(componentType: "robot"): RobotProxy
---@overload fun(componentType: "transposer"): TransposerProxy
---@overload fun(componentType: "tunnel"): TunnelProxy
---@param componentType string Component type
---@return table Proxy object for the primary component
function component.getPrimary(componentType) end

--- Sets a new primary component for the specified type. Triggers signals if changed.
---@param componentType string Component type
---@param address string Component address (can be abbreviated)
function component.setPrimary(componentType, address) end

return component
