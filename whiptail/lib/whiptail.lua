local component = require("component")
local term = require("term")
local unicode = require("unicode")

local gpu = component.gpu

---@class Whiptail
---@field _VERSION string
local whiptail = {}

---Get current GPU resolution.
---@return number w
---@return number h
local function getResolution()
    local w, h = gpu.getResolution()
    return w, h
end

---Clear whole screen to black.
local function clear()
    local sw, sh = getResolution()
    gpu.setBackground(0x000000)
    gpu.fill(1, 1, sw, sh, " ")
end


---Draw a dialog box. When GPU depth>1 fills background; otherwise draws ASCII border.
---@param x number
---@param y number
---@param w number
---@param h number
---@param title string|nil
---@param bg number|nil
---@param fg number|nil
local function drawBox(x, y, w, h, title, bg, fg)
    local depth = 1
    if gpu.getDepth then depth = gpu.getDepth() end
    if depth and depth > 1 then
        bg = bg or 0x222222
        fg = fg or 0xFFFFFF
        -- draw full border area
        gpu.setBackground(bg)
        gpu.fill(x, y, w, h, " ")
        -- draw title on top border
        gpu.setForeground(fg)
        if title and unicode.len(title) > 0 then
            local tlen = unicode.len(title)
            local tx = x + math.floor((w - tlen) / 2)
            local ty = y - 1
            if ty < 1 then
                -- if we're at the top line, draw the title inside the top border
                ty = y
            end
            gpu.setForeground(0xFFFFFF)
            gpu.setBackground(0x000000)
            gpu.set(tx, ty, title)
            gpu.setForeground(fg)
            gpu.setBackground(bg)
        end
    else
        local horiz = string.rep("-", w - 2)
        gpu.set(x, y, "+" .. horiz .. "+")
        for i = 1, h - 2 do
            gpu.set(x, y + i, "|" .. string.rep(" ", w - 2) .. "|")
        end
        gpu.set(x, y + h - 1, "+" .. horiz .. "+")
        if title and unicode.len(title) > 0 then
            local tlen = unicode.len(title)
            local tx = x + math.floor((w - tlen) / 2)
            local ty = y - 1
            if ty < 1 then ty = y end
            gpu.set(tx, ty, title)
        end
    end
end

---Wrap a string into lines not exceeding `width` characters.
---@param text string
---@param width number
---@return string[]
local function wrapText(text, width)
    local words = {}
    for w in text:gmatch("%S+") do table.insert(words, w) end
    local lines = {}
    local cur = ""
    for _, w in ipairs(words) do
        if unicode.len(cur) + unicode.len(w) + 1 > width then
            table.insert(lines, cur)
            cur = w
        else
            if cur == "" then cur = w else cur = cur .. " " .. w end
        end
    end
    if cur ~= "" then table.insert(lines, cur) end
    return lines
end

---Return top-left coordinates to center a rectangle of size windowW/windowH.
---@param windowW number
---@param windowH number
---@return number x
---@return number y
local function center(windowW, windowH)
    local sw, sh = getResolution()
    local x = math.floor((sw - windowW) / 2) + 1
    local y = math.floor((sh - windowH) / 2) + 1
    return x, y
end

---Draw `lines` within a rectangular area limited by width/height.
---@param x number
---@param y number
---@param w number
---@param h number
---@param lines string[]
local function drawTextBlock(x, y, w, h, lines)
    for i = 1, math.min(#lines, h) do
        gpu.set(x, y + i - 1, lines[i])
    end
end

---Prepare screen and draw box; returns a table with geometry and wrapped lines.
---@param title string
---@param text string
---@param opts table|nil
---@param defaultW number
---@param defaultH number
---@return table info
local function prep(title, text, opts, defaultW, defaultH)
    opts = opts or {}
    local w = opts.width or defaultW
    local h = opts.height or defaultH
    local bg = opts.bg or 0x222222
    local fg = opts.fg or 0xFFFFFF
    local x, y = center(w, h)
    local sw, sh = getResolution()
    clear()
    drawBox(x, y, w, h, title, bg, fg)
    local innerX = x + 2
    local innerY = y + 1
    local innerW = w - 4
    local innerH = h - 4
    local lines = wrapText(text or "", innerW)
    gpu.setForeground(fg)
    return {
        w = w,
        h = h,
        bg = bg,
        fg = fg,
        x = x,
        y = y,
        sw = sw,
        sh = sh,
        innerX = innerX,
        innerY = innerY,
        innerW = innerW,
        innerH = innerH,
        lines = lines,
    }
end

---Cleanup screen: clear and set cursor to 1,1
local function cleanup()
    clear()
    term.setCursor(1, 1)
end

---Show a message box and wait for Enter.
---@param title string
---@param text string
---@param opts table|nil {width:number, height:number, bg:number, fg:number}
function whiptail.msgbox(title, text, opts)
    local info = prep(title, text, opts, 50, 10)
    drawTextBlock(info.innerX, info.innerY, info.innerW, info.innerH, info.lines)
    gpu.set(info.innerX, info.y + info.h - 3, "[ Press Enter to continue ]")
    local _ = io.read()
    cleanup()
end

---Show a yes/no dialog; returns true for yes, false for no.
---@param title string
---@param text string
---@param opts table|nil {width:number, height:number, bg:number, fg:number}
---@return boolean
function whiptail.yesno(title, text, opts)
    local info = prep(title, text, opts, 50, 10)
    drawTextBlock(info.innerX, info.innerY, info.innerW, info.innerH, info.lines)
    gpu.set(info.innerX, info.y + info.h - 3, "[Y]es / [N]o : ")
    term.setCursor(info.innerX + 16, math.min(info.sh - 1, info.y + info.h - 3))
    local ans = io.read()
    local ok = false
    if ans and #ans > 0 then
        local c = ans:sub(1, 1):lower()
        ok = (c == "y")
    end
    cleanup()
    return ok
end

---Prompt for text input; returns the entered string or nil.
---@param title string
---@param prompt string
---@param opts table|nil {width:number, height:number, bg:number, fg:number, default:string}
---@return string|nil
function whiptail.inputbox(title, prompt, opts)
    local info = prep(title, prompt, opts, 60, 10)
    drawTextBlock(info.innerX, info.innerY, info.innerW, info.innerH, info.lines)
    gpu.set(info.innerX, info.y + info.h - 3, "Input: ")
    term.setCursor(info.innerX + 8, math.min(info.sh - 1, info.y + info.h - 3))
    local res = io.read()
    cleanup()
    return res
end

---Show a numbered menu; returns selected index and value or nil.
---@param title string
---@param prompt string
---@param choices string[]
---@param opts table|nil {width:number, height:number, bg:number, fg:number}
---@return number?|nil idx
---@return string?|nil value
function whiptail.menu(title, prompt, choices, opts)
    -- choices: array of strings
    opts = opts or {}
    local info = prep(title, prompt, opts, 60, (6 + #choices))
    for i, v in ipairs(choices) do
        gpu.set(info.innerX, info.innerY + #info.lines + i, string.format("%d) %s", i, v))
    end
    gpu.set(info.innerX, info.y + info.h - 3, "Enter number: ")
    term.setCursor(info.innerX + 14, math.min(info.sh - 1, info.y + info.h - 3))
    local ans = io.read()
    local idx = tonumber(ans)
    cleanup()
    if idx and choices[idx] then return idx, choices[idx] end
    return nil
end

---Interactive menu navigable with arrow keys; returns (index, value) or nil if cancelled.
---@param title string
---@param prompt string
---@param choices string[]
---@param opts table|nil {width:number, height:number, bg:number, fg:number, sel_bg:number, sel_fg:number, selected:number}
---@return number?|nil idx
---@return string?|nil value
function whiptail.navmenu(title, prompt, choices, opts)
    opts = opts or {}
    local w = opts.width or 60
    local h = opts.height or (6 + #choices)
    local info = prep(title, prompt, opts, w, h)
    local bg = info.bg or 0x000000
    local fg = info.fg or 0xFFFFFF
    local sel_bg = opts.sel_bg or 0x444444
    local sel_fg = opts.sel_fg or info.fg or 0xFFFFFF
    local innerX = info.innerX
    local innerY = info.innerY
    local innerW = info.innerW
    local innerH = info.innerH
    local lines = info.lines

    local event = require("event")
    local keyboard_mod_ok, keyboard_mod = pcall(require, "keyboard")
    local keys = keyboard_mod_ok and keyboard_mod.keys or { up = 0xC8, down = 0xD0, enter = 0x1C, esc = 0x01 }

    local selected = math.max(1, opts.selected or 1)
    local depth = 1
    if gpu.getDepth then depth = gpu.getDepth() end

    local function render()
        for i, v in ipairs(choices) do
            local ly = innerY + #lines + i
            local idxStr = tostring(i)
            local idxLen = unicode.len(idxStr)
            local nameMax = math.max(0, innerW - idxLen - 1)
            local name = v
            if unicode.len(name) > nameMax then
                name = unicode.sub(name, 1, math.max(0, nameMax - 1)) .. "…"
            end
            if i == selected then
                if depth and depth > 1 then
                    gpu.setBackground(sel_bg)
                    gpu.fill(innerX, ly, innerW, 1, " ")
                    gpu.setForeground(sel_fg)
                    gpu.set(innerX, ly, name)
                    gpu.set(innerX + innerW - idxLen, ly, idxStr)
                    gpu.setBackground(bg)
                else
                    local s = "> " .. name
                    s = s .. string.rep(" ", math.max(0, innerW - unicode.len(s) - idxLen - 1))
                    gpu.set(innerX, ly, s)
                    gpu.set(innerX + innerW - idxLen, ly, idxStr)
                end
            else
                local s = "  " .. name
                s = s .. string.rep(" ", math.max(0, innerW - unicode.len(s) - idxLen - 1))
                gpu.set(innerX, ly, s)
                gpu.set(innerX + innerW - idxLen, ly, idxStr)
            end
        end
    end

    render()

    while true do
        local name, a1, a2, a3 = event.pullFiltered(nil,
            function(n, ...) return n == "key_down" or n == "key" or n == "key_up" end)
        local code
        if type(a3) == "number" then code = a3 end
        if not code and type(a2) == "number" then code = a2 end
        if not code and type(a1) == "number" then code = a1 end

        if code then
            if keyboard_mod_ok then
                if code == keys.up then
                    selected = math.max(1, selected - 1)
                    render()
                elseif code == keys.down then
                    selected = math.min(#choices, selected + 1)
                    render()
                elseif code == keys.enter then
                    cleanup()
                    return selected, choices[selected]
                elseif code == (keys.esc or 0x01) then
                    cleanup()
                    return nil
                end
            else
                if code == 0xC8 then
                    selected = math.max(1, selected - 1)
                    render()
                elseif code == 0xD0 then
                    selected = math.min(#choices, selected + 1)
                    render()
                elseif code == 0x1C then
                    cleanup()
                    return selected, choices[selected]
                elseif code == 0x01 then
                    cleanup()
                    return nil
                end
            end
        else
            if a2 == 13 or a3 == 13 then
                cleanup()
                return selected, choices[selected]
            end
        end
    end
end

whiptail._VERSION = "neoutils.whiptail 0.1"

return whiptail
