-- Text-based GUI library for OpenComputers by BananaBagel


local textgui = { _VERSION = "0.1.0", _gui = {}, available = false }

local logging = require("neoutils.logging")
local term = require("term")

if term.isAvailable() then
    textgui._gpu = term.gpu()
    textgui._capabilities = {
        colorDepth = textgui._gpu.getDepth(),
        maxWidth = textgui._width,
        maxHeight = textgui._height
    }
    textgui.available = true
else
    logging.error("No terminal available for textgui")
    textgui.available = false
end




return textgui
