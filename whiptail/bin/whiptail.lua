-- Simple OpenComputers whiptail CLI wrapper
local function join(tbl, sep, i)
    sep = sep or " "
    i = i or 1
    local out = {}
    for k = i, #tbl do out[#out + 1] = tbl[k] end
    return table.concat(out, sep)
end

local whiptail = require("whiptail")

local args = { ... }
local cmd = args[1] or "demo"

local function usage()
    print([[Usage: whiptail <cmd> [args]
Commands:
  demo                         Run a short demo of dialogs
  msgbox <title> <text...>     Show a message box
  yesno <title> <text...>      Show yes/no dialog; prints "yes" or "no"
  input <title> <prompt...>    Prompt for input and print the result
  menu <title> <prompt> <opt1> <opt2> ...  Show menu and print chosen index and value
]])
end

if cmd == "help" or cmd == "-h" or cmd == "--help" then
    usage()
    return
end

if cmd == "demo" then
    whiptail.msgbox("Demo - Message", "This is a demo of simple whiptail dialogs.", { bg = 0x222244, fg = 0xFFFFFF })
    local ok = whiptail.yesno("Demo - Yes/No", "Do you like this demo?", { bg = 0x003366, fg = 0xFFFFFF })
    local inpt = whiptail.inputbox("Demo - Input", "Type something:", { bg = 0x660000, fg = 0xFFFFFF, maxLines = 2 })
    local choices = { "First choice is long to demonstrate truncation because truncation is important", "Second", "Third",
        "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth" }
    local idx, val = whiptail.menu("Demo - Menu", "Pick one:", choices, { bg = 0x004400, fg = 0xFFFFFF })
    -- navmenu demo with distinct selection colors
    local nidx, nval = whiptail.navmenu("Demo - NavMenu", "Use arrow keys to select:", choices,
        { bg = 0x222244, fg = 0xFFFFFF, sel_bg = 0xFFAA00, sel_fg = 0x000000 })

    print("Yes/No result:", ok and "yes" or "no")
    print("You typed:", inpt or "(none)")
    if idx then print("Menu selection:", idx, val) else print("Menu: no selection") end
    if nidx then print("NavMenu selection:", nidx, nval) else print("NavMenu: cancelled") end
    -- now demonstrate forced text-mode versions of each dialog
    print("\n-- Forced text-mode demo --")
    whiptail.msgbox("Text Mode Msg", "This is forced text mode.", { forceTextMode = true })
    local ok2 = whiptail.yesno("Text Mode YesNo", "Proceed in text mode?", { forceTextMode = true })
    local inpt2 = whiptail.inputbox("Text Mode Input", "Enter text:", { forceTextMode = true, maxLines = 2 })
    local idx2, val2 = whiptail.menu("Text Mode Menu", "Pick:", choices, { forceTextMode = true })
    local nidx2, nval2 = whiptail.navmenu("Text Mode Nav", "Select (text mode):", choices, { forceTextMode = true })
    print("Text-mode Yes/No:", ok2 and "yes" or "no")
    print("Text-mode input:", inpt2 or "(none)")
    if idx2 then print("Text-mode menu:", idx2, val2) else print("Text-mode menu: no selection") end
    if nidx2 then print("Text-mode nav:", nidx2, nval2) else print("Text-mode nav: cancelled") end
    return
end

if cmd == "msgbox" then
    local title = args[2] or ""
    local text = join(args, " ", 3)
    whiptail.msgbox(title, text)
    return
end

if cmd == "yesno" then
    local title = args[2] or ""
    local text = join(args, " ", 3)
    local r = whiptail.yesno(title, text)
    print(r and "yes" or "no")
    return
end

if cmd == "input" then
    local title = args[2] or ""
    local prompt = join(args, " ", 3)
    local r = whiptail.inputbox(title, prompt)
    if r then print(r) end
    return
end

if cmd == "menu" then
    local title = args[2] or ""
    local prompt = args[3] or ""
    if #args < 4 then
        io.stderr:write("menu requires at least one option\n")
        usage()
        os.exit(2)
    end
    local choices = {}
    for i = 4, #args do choices[#choices + 1] = args[i] end
    local idx, val = whiptail.menu(title, prompt, choices)
    if idx then print(idx, val) else print("no selection") end
    return
end

usage()
