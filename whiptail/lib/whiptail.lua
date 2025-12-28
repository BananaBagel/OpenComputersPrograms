local component = require("component")
local term = require("term")
local unicode = require("unicode")

local gpu = component.gpu

---@class opts
---@field width number?
---@field height number?
---@field bg number?
---@field fg number?
---@field sel_bg number?
---@field sel_fg number?
---@field default string?
---@field selected number?
---@field prefix string?
---@field maxLines number?

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

---Read an input at given coordinates using event loop (avoids io.read scrolling).
---Supports multi-line visual wrapping and clipped view with ellipses.
---@param x number
---@param y number
---@param maxlen number  -- width in characters for each visual line
---@param bg number
---@param fg number
---@param default string|nil
---@param maxLines number? -- number of visual lines to use before truncating (default 1)
---@return string
local function readLineAt(x, y, maxlen, bg, fg, default, maxLines)
    default = default or ""
    local event = require("event")
    local keyboard_mod = require("keyboard")
    local keys = keyboard_mod.keys

    local buf = {}
    for i = 1, unicode.len(default) do table.insert(buf, unicode.sub(default, i, i)) end
    local pos = #buf + 1

    maxLines = maxLines or 1
    local function draw()
        local s = table.concat(buf)
        local total = unicode.len(s)
        -- build wrapped lines (simple fixed-width wrap)
        local lines = {}
        if maxlen <= 0 then maxlen = 1 end
        for i = 1, math.max(1, math.ceil(total / maxlen)) do
            local st = (i - 1) * maxlen + 1
            local en = math.min(total, i * maxlen)
            table.insert(lines, unicode.sub(s, st, en))
        end
        if #lines == 0 then lines = { "" } end

        -- determine which block of lines to display so cursor is visible
        local cursorIdx = math.max(0, pos - 1) -- 0-based index into chars
        local cursorLine = math.floor(cursorIdx / maxlen) + 1
        local totalLines = #lines
        local topLine = 1
        if totalLines <= maxLines then
            topLine = 1
        else
            -- try to center cursor line within visible block when possible
            topLine = math.max(1, math.min(cursorLine - math.floor(maxLines / 2), totalLines - maxLines + 1))
        end

        -- draw the visual area (maxLines rows)
        for li = 1, maxLines do
            local drawY = y + li - 1
            gpu.setBackground(bg)
            gpu.fill(x, drawY, maxlen, 1, " ")
            gpu.setForeground(fg)
            local sourceLine = topLine + li - 1
            local textLine = ""
            if sourceLine <= totalLines then textLine = lines[sourceLine] end
            -- add ellipsis markers if clipped
            if sourceLine == topLine and sourceLine > 1 then
                -- indicate there's content above
                if unicode.len(textLine) > 0 then
                    textLine = "…" .. unicode.sub(textLine, 2)
                else
                    textLine = "…"
                end
            end
            if sourceLine == topLine + maxLines - 1 and (topLine + maxLines - 1) < totalLines then
                -- indicate there's content below
                if unicode.len(textLine) > 0 then
                    textLine = unicode.sub(textLine, 1, math.max(1, unicode.len(textLine) - 1)) .. "…"
                else
                    textLine = "…"
                end
            end
            gpu.set(x, drawY, textLine)
        end

        -- draw cursor (invert colors at cursor position)
        local cpos = math.max(0, pos - 1)
        local cLine = math.floor(cpos / maxlen) + 1
        local cCol = (cpos % maxlen) + 1
        if cLine >= topLine and cLine < topLine + maxLines then
            local cx = x + cCol - 1
            local cy = y + (cLine - topLine)
            local ch = " "
            local lineIndex = cLine
            local lineText = ""
            if lineIndex <= #lines then lineText = lines[lineIndex] end
            if unicode.len(lineText) >= cCol then
                ch = unicode.sub(lineText, cCol, cCol)
            end
            gpu.setBackground(fg)
            gpu.setForeground(bg)
            gpu.set(cx, cy, ch)
            gpu.setForeground(fg)
            gpu.setBackground(bg)
        end
    end

    -- flush any pending events so previous key presses don't immediately trigger actions
    while true do
        local n = event.pull(0)
        if not n then break end
    end

    -- keep only true non-text control/navigation/modifier keys; allow punctuation and numpad operators
    local _nonText = {
        0xC8, 0xD0, 0xCB, 0xCD, 0xC7, 0xCF, 0xC9, 0xD1, 0xD2, 0xD3, -- arrows/navigation
        0x1C, 0x0E, 0x0F,                                           -- enter/backspace/tab
        0x3A, 0x45, 0x46,                                           -- locks
        0x2A, 0x36, 0x1D, 0x9D, 0x38, 0xB8,                         -- modifiers
        0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x41, 0x42, 0x43, 0x44, -- function keys
        0x57, 0x58, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x71,       -- function keys
    }
    local _nonTextSet = {}
    for _, v in ipairs(_nonText) do if v then _nonTextSet[v] = true end end
    local function isTextKey(code)
        return not _nonTextSet[code]
    end

    draw()
    while true do
        local ev, a1, a2, a3 = event.pullFiltered(nil, function(n, ...) return n == "key_down" end)
        local charCode = a2
        local code = a3

        if code == keys.enter or code == keys.numpadenter then
            break
        elseif code == keys.backspace or code == keys.back then
            if pos > 1 then
                table.remove(buf, pos - 1)
                pos = pos - 1
            end
            draw()
        elseif code == keys.delete then
            if pos <= #buf then
                table.remove(buf, pos)
            end
            draw()
        elseif code == keys.left then
            pos = math.max(1, pos - 1)
            draw()
        elseif code == keys.right then
            pos = math.min(#buf + 1, pos + 1)
            draw()
        elseif code == keys.home then
            pos = 1
            draw()
        elseif code == keys["end"] then
            pos = #buf + 1
            draw()
        else
            if type(charCode) == "number" and charCode >= 32 and isTextKey(code) then
                local ch = unicode.char(charCode)
                table.insert(buf, pos, ch)
                pos = pos + 1
                draw()
            end
        end
    end

    -- finalize: render full visible area then return buffer
    draw()
    return table.concat(buf)
end

---Prepare screen and draw box; returns a table with geometry and wrapped lines.
---@param title string
---@param text string
---@param opts opts?
---@param defaultW number
---@param defaultH number
---@return table info
local function prep(title, text, opts, defaultW, defaultH)
    opts = opts or {}
    local w = opts.width or defaultW
    local h = opts.height or defaultH
    local bg = opts.bg or 0x222222
    local fg = opts.fg or 0xFFFFFF
    local prefix = opts.prefix or "Input: "
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
        prefix = prefix,
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
---@param opts opts?
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
---@param opts opts?
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
---@param opts opts?
---@return string|nil
function whiptail.inputbox(title, prompt, opts)
    opts = opts or {}
    local info = prep(title, prompt, opts, 60, 10)
    drawTextBlock(info.innerX, info.innerY, info.innerW, info.innerH, info.lines)
    gpu.set(info.innerX, info.y + info.h - 3, info.prefix or "Input: ")
    local readX = info.innerX + 8
    local readY = math.min(info.sh - 1, info.y + info.h - 3)
    gpu.setBackground(info.bg)
    gpu.setForeground(info.fg)
    local maxlen = math.max(1, info.innerW - 8)
    local maxLines = opts.maxLines or 1
    local res = readLineAt(readX, readY, maxlen, info.bg, info.fg, opts.default, maxLines)
    cleanup()
    return res
end

---Show a numbered menu; returns selected index and value or nil.
---@param title string
---@param prompt string
---@param choices string[]
---@param opts opts?
---@return number?|nil idx
---@return string?|nil value
function whiptail.menu(title, prompt, choices, opts)
    -- choices: array of strings
    opts = opts or {}
    local desiredH = opts.height or (6 + #choices)
    local sw, sh = getResolution()
    if desiredH > sh then error("menu: too many options for screen height") end
    local info = prep(title, prompt, opts, 60, desiredH)
    -- render choices with wrapping so long entries don't overflow
    local curY = info.innerY + #info.lines
    local maxY = info.innerY + info.innerH - 1
    for i, v in ipairs(choices) do
        if curY > maxY then break end
        local idxStr = tostring(i)
        local idxLen = unicode.len(idxStr)
        local nameMax = math.max(0, info.innerW - idxLen - 3) -- space for ") " and padding
        local lines = wrapText(v, nameMax)
        for li, line in ipairs(lines) do
            if curY > maxY then break end
            local prefix = (li == 1) and (idxStr .. ") ") or "   "
            gpu.set(info.innerX, curY, prefix .. line)
            curY = curY + 1
        end
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
---@param opts opts?
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
    -- determine visible window size (at most innerH, minimum 6 or half of dialog height)
    local visible = math.min(innerH, math.max(6, math.floor(info.h / 2)))
    visible = math.max(1, visible)
    local top = 1

    local function render()
        local promptLines = #lines
        local displayRow = 0
        local maxRow = visible
        local stop = false
        for i = top, #choices do
            if stop then break end
            local idxStr = tostring(i)
            local idxLen = unicode.len(idxStr)
            local nameMax = math.max(0, innerW - idxLen - 1)
            local whole = choices[i]
            local renderLines = {}
            if i == selected then
                renderLines = wrapText(whole, nameMax)
            else
                local name = whole
                if unicode.len(name) > nameMax then
                    name = unicode.sub(name, 1, math.max(0, nameMax - 1)) .. "…"
                end
                renderLines = { name }
            end

            for li, textLine in ipairs(renderLines) do
                if displayRow >= maxRow then
                    stop = true
                    break
                end
                displayRow = displayRow + 1
                local ly = innerY + promptLines + displayRow
                if depth and depth > 1 then
                    if i == selected then
                        gpu.setBackground(sel_bg)
                        gpu.fill(innerX, ly, innerW, 1, " ")
                        gpu.setForeground(sel_fg)
                        gpu.set(innerX, ly, textLine)
                        if li == 1 then gpu.set(innerX + innerW - idxLen, ly, idxStr) end
                        gpu.setForeground(fg)
                        gpu.setBackground(bg)
                    else
                        gpu.setBackground(bg)
                        gpu.fill(innerX, ly, innerW, 1, " ")
                        gpu.setForeground(fg)
                        gpu.set(innerX, ly, textLine)
                        if li == 1 then gpu.set(innerX + innerW - idxLen, ly, idxStr) end
                    end
                else
                    if i == selected then
                        local s = "> " .. textLine
                        s = s .. string.rep(" ", math.max(0, innerW - unicode.len(s) - (li == 1 and idxLen or 0) - 1))
                        gpu.set(innerX, ly, s)
                        if li == 1 then gpu.set(innerX + innerW - idxLen, ly, idxStr) end
                    else
                        local s = "  " .. textLine
                        s = s .. string.rep(" ", math.max(0, innerW - unicode.len(s) - idxLen - 1))
                        gpu.set(innerX, ly, s)
                        if li == 1 then gpu.set(innerX + innerW - idxLen, ly, idxStr) end
                    end
                end
            end
        end
    end

    -- helper: compute number of visual rows an item consumes (selected may expand)
    local function rowsForItem(i)
        local idxLen = unicode.len(tostring(i))
        local nameMax = math.max(0, innerW - idxLen - 1)
        if i == selected then
            local parts = wrapText(choices[i], nameMax)
            return math.max(1, #parts)
        else
            return 1
        end
    end

    -- advance top downwards by upToRows visual rows (based on current selected expansion)
    local function advanceTopByRowsDown(upToRows)
        local acc = 0
        local i = top
        while i <= #choices and acc < upToRows do
            acc = acc + rowsForItem(i)
            i = i + 1
        end
        if i > #choices then
            return #choices
        end
        return i
    end

    -- move top upwards by upToRows visual rows
    local function advanceTopByRowsUp(upToRows)
        local acc = 0
        local i = top - 1
        while i >= 1 and acc < upToRows do
            acc = acc + rowsForItem(i)
            i = i - 1
        end
        return math.max(1, i + 1)
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
                if selected < top then top = selected end
                render()
            elseif code == keys.down then
                selected = math.min(#choices, selected + 1)
                if selected > top + visible - 1 then top = selected - visible + 1 end
                render()
            elseif code == keys.pageUp then
                local newTop = advanceTopByRowsUp(visible)
                top = math.max(1, math.min(newTop, #choices))
                selected = top
                render()
            elseif code == keys.pageDown then
                local newTop = advanceTopByRowsDown(visible)
                top = math.max(1, math.min(newTop, #choices))
                selected = top
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

whiptail._VERSION = "0.1.0"

return whiptail
