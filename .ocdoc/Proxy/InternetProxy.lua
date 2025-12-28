---@meta

--- TCP socket handle returned by InternetProxy.connect.
--- Provides byte-stream I/O, connection finalization, and a unique socket id.
--- After calling finishConnect() or read(), this socket may emit an "internet_ready" signal
--- with one argument: the socket id string, indicating new data is available to read.
---@class TCPSocket
local TCPSocket = {}

--- Read data from the socket stream.
--- If n is provided, reads up to n bytes; otherwise reads what is currently available.
--- Returns the bytes read as a string (may be empty if no data was available at the time).
---@param n number?
---@return string
function TCPSocket.read(n) end

--- Close the open socket stream. Further reads/writes will fail after closing.
function TCPSocket.close() end

--- Write data to the socket stream.
--- Returns the number of bytes successfully written (may be less than the input length).
---@param data string
---@return number
function TCPSocket.write(data) end

--- Ensure the socket is connected.
--- Returns true if the connection was established; may raise an error if it failed.
---@return boolean
function TCPSocket.finishConnect() end

--- Get the unique identifier for this socket.
--- Useful for correlating "internet_ready" signals with this specific socket.
---@return string
function TCPSocket.id() end

--- HTTP request handle returned by InternetProxy.request.
--- Supports streaming response body reads, response metadata inspection, and completion.
---@class HTTPRequest
local HTTPRequest = {}

--- Read data from the HTTP response body.
--- If n is provided, reads up to n bytes; otherwise reads what is currently available.
--- Returns the bytes read as a string (may be empty if no data was available at the time).
---@param n number?
---@return string
function HTTPRequest.read(n) end

--- Get the HTTP response status code, status message, and headers table.
--- Typically available after finishConnect() succeeds.
---@return number, string, table
function HTTPRequest.response() end

--- Close the HTTP connection/stream. Further reads will fail after closing.
function HTTPRequest.close() end

--- Ensure a response is available.
--- Returns true if the request completed successfully; may raise an error if it failed.
---@return boolean
function HTTPRequest.finishConnect() end

--- Proxy interface for the Internet component (component name: "internet").
--- Provided by the Internet Card. Supports TCP sockets and HTTP requests.
---@class InternetProxy
local InternetProxy = {}

--- Check if TCP connections are enabled in the configuration.
---@return boolean
function InternetProxy.isTcpEnabled() end

--- Check if HTTP requests are enabled in the configuration.
---@return boolean
function InternetProxy.isHttpEnabled() end

--- Open a new TCP connection to the given address and optional port.
--- Returns a TCPSocket handle for reading/writing and connection management.
---@param address string
---@param port integer?
---@return TCPSocket
function InternetProxy.connect(address, port) end

--- Send an HTTP request to the given URL with optional POST data and headers.
--- Returns an HTTPRequest handle for reading the response and querying metadata.
---@param url string
---@param postData string?
---@param headers table?
---@return HTTPRequest
function InternetProxy.request(url, postData, headers) end

return InternetProxy