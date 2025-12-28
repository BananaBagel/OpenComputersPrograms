---@meta

--- OpenComputers RC API
---
--- Provides functions for managing rc scripts and the rc controller.
--- rc.lua seems to have been completely emptied after commit c414f7428d67c936f64cc3a61e1fffb3caf24904...
---@class RcLib
local rc = {}

--- Contains the list of every loaded RC module
rc.loaded = {}

return rc
