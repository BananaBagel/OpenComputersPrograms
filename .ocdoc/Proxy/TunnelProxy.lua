---@meta

--- Proxy interface for the Tunnel component (`tunnel`)
---
--- Provides point-to-point communication between linked cards. Always open, no port configuration.
---@class TunnelProxy
local TunnelProxy = {}

--- Sends data to the linked tunnel card.
--- Emits a `modem_message` signal on the receiving side.
---@param ... any Variable arguments to send
function TunnelProxy.send(...) end

--- Gets the maximum packet size allowed by configuration.
---@return number Maximum packet size in bytes
function TunnelProxy.maxPacketSize() end

--- Gets the tunnel address of the linked card.
--- This is also available via `linkChannel` when inspecting the card item.
---@return string Tunnel channel address
function TunnelProxy.getChannel() end

--- Gets the current wake-up message.
--- If this message is received as the first argument in a network packet, the machine will power on.
---@return string Wake message
function TunnelProxy.getWakeMessage() end

--- Sets the wake-up message.
--- If `fuzzy` is true, trailing arguments in the packet are ignored during match.
---@param message string Wake message to set
---@param fuzzy boolean? Whether to use fuzzy matching (default: false)
---@return string The message that was set
function TunnelProxy.setWakeMessage(message, fuzzy) end

return TunnelProxy