--- @meta

-- Things that are in OpenComputers' os library but not in standard Lua's os library.
-- This file is here to help the Lua language server vscode extension find these functions correctly


--- Sleeps for the given number of seconds. Does not block other threads or event listeners.
---@param seconds number
os.sleep = function(seconds) end

os.setenv = function() end

os.setlocale = nil
