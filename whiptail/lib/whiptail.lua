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

---Read a single-line input at given coordinates using event loop (avoids io.read scrolling).
---@param x number
---@param y number
---@param maxlen number
---@param bg number
---@param fg number
---@param default string|nil
---@return string
local function readLineAt(x, y, maxlen, bg, fg, default)
    default = default or ""
    local event = require("event")
    local keyboard_mod = require("keyboard")
    local keys = keyboard_mod.keys
    local backspace_code = keys.backspace or 0x0E
    local enter_code = keys.enter or 0x1C
    local left_code = keys.left or 0xCB
    local right_code = keys.right or 0xCD

    local buf = {}
    for i = 1, unicode.len(default) do table.insert(buf, unicode.sub(default, i, i)) end
    local pos = #buf + 1

    local function draw()
        gpu.setBackground(bg)
        gpu.fill(x, y, maxlen, 1, " ")
        gpu.setForeground(fg)
        local s = table.concat(buf)
        if unicode.len(s) > maxlen then
            s = unicode.sub(s, 1, maxlen)
        end
        -- write visible text
        gpu.set(x, y, s)
        -- compute cursor cell (1-based within field)
        local cursorCell = math.min(pos, maxlen)
        local cx = x + cursorCell - 1
        local ch = " "
        if unicode.len(s) >= cursorCell then
            ch = unicode.sub(s, cursorCell, cursorCell)
        end
        -- draw simple block cursor by inverting colors at cursor position
        gpu.setBackground(fg)
        gpu.setForeground(bg)
        gpu.set(cx, y, ch)
        gpu.setForeground(fg)
        gpu.setBackground(bg)
    end

    -- flush any pending events so previous key presses don't immediately trigger actions
    while true do
        local n = event.pull(0)
        if not n then break end
    end

    draw()
    while true do
        local ev, a1, a2, a3 = event.pullFiltered(nil, function(n, ...) return n == "key_down" end)
        local charCode = a2
        local code = a3

        if code == enter_code then
            break
        elseif code == backspace_code then
            if pos > 1 then
                table.remove(buf, pos - 1)
                pos = pos - 1
            end
            draw()
        elseif code == left_code then
            pos = math.max(1, pos - 1)
            draw()
        elseif code == right_code then
            pos = math.min(#buf + 1, pos + 1)
            draw()
        else
            if type(charCode) == "number" and charCode >= 32 then
                local ch = unicode.char(charCode)
                if unicode.len(table.concat(buf)) < maxlen then
                    table.insert(buf, pos, ch)
                    pos = pos + 1
                end
                draw()
            end
        end
    end

    -- restore normal colors for the input line
    gpu.setBackground(bg)
    gpu.setForeground(fg)
    gpu.set(x, y, unicode.sub(table.concat(buf), 1, maxlen))
    return table.concat(buf)
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
    local readX = info.innerX + 16
    local readY = math.min(info.sh - 1, info.y + info.h - 3)
    gpu.setBackground(info.bg)
    gpu.setForeground(info.fg)
    local ans = readLineAt(readX, readY, 1, info.bg, info.fg, "")
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
    local readX = info.innerX + 8
    local readY = math.min(info.sh - 1, info.y + info.h - 3)
    gpu.setBackground(info.bg)
    gpu.setForeground(info.fg)
    local maxlen = math.max(1, info.innerW - 8)
    local res = readLineAt(readX, readY, maxlen, info.bg, info.fg, opts and opts.default)
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
    local readX = info.innerX + 14
    local readY = math.min(info.sh - 1, info.y + info.h - 3)
    gpu.setBackground(info.bg)
    gpu.setForeground(info.fg)
    local ans = readLineAt(readX, readY, 6, info.bg, info.fg, "")
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
    local keyboard_mod = require("keyboard")
    local keys = keyboard_mod.keys

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

            if depth and depth > 1 then
                if i == selected then
                    gpu.setBackground(sel_bg)
                    gpu.fill(innerX, ly, innerW, 1, " ")
                    gpu.setForeground(sel_fg)
                    gpu.set(innerX, ly, name)
                    gpu.set(innerX + innerW - idxLen, ly, idxStr)
                    -- restore defaults for next lines
                    gpu.setForeground(fg)
                    gpu.setBackground(bg)
                else
                    gpu.setBackground(bg)
                    gpu.fill(innerX, ly, innerW, 1, " ")
                    gpu.setForeground(fg)
                    gpu.set(innerX, ly, name)
                    gpu.set(innerX + innerW - idxLen, ly, idxStr)
                end
            else
                if i == selected then
                    local s = "> " .. name
                    s = s .. string.rep(" ", math.max(0, innerW - unicode.len(s) - idxLen - 1))
                    gpu.set(innerX, ly, s)
                    gpu.set(innerX + innerW - idxLen, ly, idxStr)
                else
                    local s = "  " .. name
                    s = s .. string.rep(" ", math.max(0, innerW - unicode.len(s) - idxLen - 1))
                    gpu.set(innerX, ly, s)
                    gpu.set(innerX + innerW - idxLen, ly, idxStr)
                end
            end
        end
    end

    -- small drain loop to discard any leftover key events (helps when keys are held)
    for i = 1, 5 do
        local _ = event.pull(0.02)
    end

    render()

    while true do
        local name, a1, a2, a3 = event.pullFiltered(nil,
            function(n, ...) return n == "key_down" end)
        local code
        if type(a3) == "number" then code = a3 end
        if not code and type(a2) == "number" then code = a2 end
        if not code and type(a1) == "number" then code = a1 end

        if code then
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
        end
    end
end

whiptail._VERSION = "neoutils.whiptail 0.1"

return whiptail
