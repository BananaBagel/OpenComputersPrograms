---@meta

--- OpenComputers Sides API
---
--- Provides a global table for referring to block sides by name or number.
---@class SidesLib
local sides = {}

--- Bottom side (number: 0, aliases: "down", "negy")
sides.bottom = 0
sides.down = 0
sides.negy = 0

--- Top side (number: 1, aliases: "up", "posy")
sides.top = 1
sides.up = 1
sides.posy = 1

--- Back side (number: 2, aliases: "north", "negz")
sides.back = 2
sides.north = 2
sides.negz = 2

--- Front side (number: 3, aliases: "south", "posz", "forward")
sides.front = 3
sides.south = 3
sides.posz = 3
sides.forward = 3

--- Right side (number: 4, aliases: "west", "negx")
sides.right = 4
sides.west = 4
sides.negx = 4

--- Left side (number: 5, aliases: "east", "posx")
sides.left = 5
sides.east = 5
sides.posx = 5

return sides
