# OpenComputers Type Library (EmmyLua)

This repository provides a complete EmmyLua-based type annotation library for the OpenComputers mod in Minecraft. It enables full IDE support for Lua scripting in OpenComputers, including:

- Autocompletion for all components
- Type-safe function signatures
- Hover documentation and parameter hints
- Jump-to-definition for component APIs

## ✨ Features

- Covers all major components: `robot`, `redstone`, `gpu`, `screen`, `transposer`, `tank_controller`, `thread`, and more
- Structured using EmmyLua annotations (`---@class`, `---@param`, `---@return`, etc.)
- Compatible with [Lua LS](https://github.com/LuaLS/lua-language-server) and VS Code
- Modular layout for easy extension and maintenance

## 📦 Usage

1. Clone this repository into your workspace
2. Add the path to your `.vscode/settings.json`:

```json
{
  "Lua.workspace.library": [
    "./path/to/this/repo"
  ]
}
