---@meta

--- Proxy interface for the EEPROM component (`eeprom`)
---
--- Provided by the EEPROM upgrade. Supports storage and retrieval of firmware code and boot metadata.
--- EEPROMs store byte arrays and labels and can be made permanently read-only.
---@class EEPROMProxy
local EEPROMProxy = {}

--- Retrieves the currently stored byte array, typically representing the Lua firmware code.
---@return string data Stored byte array contents
function EEPROMProxy.get() end

--- Overwrites the currently stored byte array.
--- Use with caution: overwriting may affect boot behavior.
---@param data string New byte array data
function EEPROMProxy.set(data) end

--- Gets the label (name) assigned to this EEPROM.
---@return string label EEPROM label
function EEPROMProxy.getLabel() end

--- Sets the label for this EEPROM.
--- The label is a human-readable identifier, not related to data contents.
---@param data string Label to assign
function EEPROMProxy.setLabel(data) end

--- Returns the maximum capacity of this EEPROM in bytes.
--- This includes both firmware and metadata storage regions.
---@return number size Maximum capacity (bytes)
function EEPROMProxy.getSize() end

--- Gets the maximum capacity of the data section on the EEPROM.
--- Usually used to store metadata such as boot device information.
---@return number dataSize Metadata section capacity (bytes)
function EEPROMProxy.getDataSize() end

--- Retrieves the stored metadata byte array (e.g., boot device address).
---@return string data EEPROM metadata contents
function EEPROMProxy.getData() end

--- Sets the metadata section of the EEPROM to the specified byte array.
---@param data string Metadata contents to store
function EEPROMProxy.setData(data) end

--- Returns the checksum of the EEPROM's byte array.
--- Useful for integrity verification and read-only locking.
---@return string checksum Hexadecimal checksum string
function EEPROMProxy.getChecksum() end

--- Makes the EEPROM permanently read-only using the checksum.
--- This action is irreversible; use with care.
---@param checksum string Checksum of current EEPROM contents
---@return boolean success `true` if EEPROM was successfully locked
function EEPROMProxy.makeReadonly(checksum) end

return EEPROMProxy