---@meta

--- Proxy interface for the Drive component (`drive`)
---
--- Provided by Floppy Disks or Hard Disk Drives operating in **Unmanaged mode**.
--- Offers low-level read/write access to individual bytes and sectors, useful for raw data manipulation,
--- custom filesystems, boot loaders, or disk-level utilities. ⚠️ Switching from Managed to Unmanaged mode
--- will wipe all data on the drive.
---@class DriveProxy
local DriveProxy = {}

--- Reads a single byte from the drive at the specified offset.
---@param offset number Byte offset
---@return number value Byte value at offset
function DriveProxy.readByte(offset) end

--- Writes a single byte to the drive at the specified offset.
---@param offset number Byte offset
---@param value number Byte value to write
function DriveProxy.writeByte(offset, value) end

--- Retrieves the size of one sector on the drive, in bytes.
---@return number sectorSize Size of each sector
function DriveProxy.getSectorSize() end

--- Gets the label (name/identifier) of the drive.
---@return string label Drive label
function DriveProxy.getLabel() end

--- Sets the label for the drive. May be truncated depending on limitations.
---@param value string New label string
---@return string label Applied label (possibly truncated)
function DriveProxy.setLabel(value) end

--- Reads the entire contents of the specified sector.
---@param sector number Sector index
---@return string contents Sector data as byte string
function DriveProxy.readSector(sector) end

--- Writes the provided data to the specified sector.
---@param sector number Sector index
---@param value string Data to write (must match sector size)
function DriveProxy.writeSector(sector, value) end

--- Returns the number of physical platters in the drive.
--- May be useful for diagnostics or data geometry calculations.
---@return number count Number of platters
function DriveProxy.getPlatterCount() end

--- Gets the total capacity of the drive, in bytes.
---@return number capacity Total drive storage
function DriveProxy.getCapacity() end

return DriveProxy