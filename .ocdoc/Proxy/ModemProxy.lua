---@meta

--- Proxy interface for the Modem component (`modem`)
---
--- Provides network communication via ports and addresses.
--- Wireless modems support broadcasting and signal range.
---@class ModemProxy
local ModemProxy = {}

--- Checks whether the modem is wireless.
---@return boolean `true` if the modem is wireless
function ModemProxy.isWireless() end

--- Gets the signal strength of the modem.
--- Only applicable to wireless modems.
---@return number Signal strength (range in blocks)
function ModemProxy.getStrength() end

--- Sets the signal strength of the modem.
--- Only applicable to wireless modems.
---@param value number Desired signal strength
---@return number Previous signal strength
function ModemProxy.setStrength(value) end

--- Gets the maximum signal strength supported by the modem.
--- Only applicable to wireless modems.
---@return number Maximum signal strength
function ModemProxy.getMaxStrength() end

--- Opens a network port for receiving messages.
---@param port number Port number (0–65535)
---@return boolean `true` if the port was successfully opened
function ModemProxy.open(port) end

--- Closes a previously opened port.
---@param port number Port number to close
---@return boolean `true` if the port was successfully closed
function ModemProxy.close(port) end

--- Checks whether a port is currently open.
---@param port number Port number to check
---@return boolean `true` if the port is open
function ModemProxy.isOpen(port) end

--- Sends a message to a specific address and port.
--- Emits a `modem_message` signal on the target machine.
---@param address string Target modem address
---@param port number Target port
---@param ... any Message payload
---@return boolean `true` if the message was sent
function ModemProxy.send(address, port, ...) end

--- Broadcasts a message to all modems within range on the specified port.
--- Only applicable to wireless modems.
---@param port number Port to broadcast on
---@param ... any Message payload
---@return boolean `true` if the message was broadcast
function ModemProxy.broadcast(port, ...) end

--- Gets a list of all currently open ports.
---@return number[] Array of open port numbers
function ModemProxy.getOpenPorts() end

--- Gets the local address of this modem.
---@return string Modem address
function ModemProxy.address() end

--- Gets the wake-up message used to power on the machine when received.
---@return string Wake message
function ModemProxy.getWakeMessage() end

--- Sets the wake-up message.
--- If `fuzzy` is true, trailing arguments in the packet are ignored during match.
---@param message string Wake message to set
---@param fuzzy boolean? Whether to use fuzzy matching (default: false)
---@return string The message that was set
function ModemProxy.setWakeMessage(message, fuzzy) end

return ModemProxy