---@meta

--- Proxy interface for the Debug component (`debug`)
---
--- Only available in creative mode. Grants powerful low-level access for debugging purposes:
--- altering energy buffers, executing commands, inspecting worlds, modifying blocks, manipulating players, etc.
--- **Warning** Use with extreme caution: changes are immediate and irreversible.
---@class DebugProxy
local DebugProxy = {}

-- Core methods

--- Adjust the component network's energy buffer.
---@param value number Amount to add or subtract (delta)
---@return number newBuffer Updated buffer value
function DebugProxy.changeBuffer(value) end

--- Connects the debug card to a compatible block at the given coordinates.
---@param x number
---@param y number
---@param z number
---@return boolean success True if connection succeeded
function DebugProxy.connectToBlock(x, y, z) end

--- Retrieves a player entity by name.
---@param name string Player name
---@return DebugPlayer player Player entity object
function DebugProxy.getPlayer(name) end

--- Lists all currently logged-in players.
---@return string[] players Array of player names
function DebugProxy.getPlayers() end

--- Gets the world object for the specified dimension ID or the container's current world.
---@param id number? Optional dimension ID
---@return DebugWorld world World object
function DebugProxy.getWorld(id) end

--- Lists all loaded and unloaded world IDs.
---@return number[] worldIds Dimension identifiers
function DebugProxy.getWorlds() end

--- Get the container's X position.
---@return number x
function DebugProxy.getX() end

--- Get the container's Y position.
---@return number y
function DebugProxy.getY() end

--- Get the container's Z position.
---@return number z
function DebugProxy.getZ() end

--- Checks whether a mod or API is loaded.
---@param name string Mod/API name
---@return boolean loaded True if available
function DebugProxy.isModLoaded(name) end

--- Executes a server command as a fake player.
--- Requires proper player binding and permission.
---@param command string Command text (e.g. `/say Hello`)
---@return number status 1 = success, 0 = failure
---@return string? result Command output or error message
function DebugProxy.runCommand(command) end

--- General-purpose test method for debugging userdata or conversion logic.
---@return any result
function DebugProxy.test() end

--- Retrieves the scoreboard object for the container's world.
---@return DebugScoreboard scoreboard Scoreboard instance
function DebugProxy.getScoreboard() end

--- Sends arbitrary data to another debug card by its address.
---@param address string Target debug card address
---@vararg any data Variable arguments to send
function DebugProxy.sendToDebugCard(address, ...) end

--- Sends text to a player's system clipboard (if supported).
---@param player string Player name
---@param text string Clipboard text
function DebugProxy.sendToClipboard(player, text) end

--- Returns serialized content at a world location.
--- Can be used to diagnose movement blocking.
---@param x number
---@param y number
---@param z number
---@param worldId number? Defaults to the host world
---@return boolean blocked True if location is obstructed
---@return string kind Type of obstruction (e.g. "solid", "air")
---@return table|string info Serialized data of entity or block
function DebugProxy.scanContentsAt(x, y, z, worldId) end

---@class DebugWorld
local DebugWorld = {}

--- Gets metadata of the block at given coordinates.
---@param x number
---@param y number
---@param z number
---@return number meta Block metadata
function DebugWorld.getMetadata(x, y, z) end

--- Gets the block ID at the specified location.
---@param x number
---@param y number
---@param z number
---@return number id Block ID
function DebugWorld.getBlockId(x, y, z) end

--- Gets the numeric dimension ID of the current world.
---@return number id Dimension ID
function DebugWorld.getDimensionId() end

--- Checks if the block at the location is currently loaded in memory.
---@param x number
---@param y number
---@param z number
---@return number loaded 1 = loaded, 0 = unloaded
function DebugWorld.isLoaded(x, y, z) end

--- Gets the world seed.
---@return number seed Seed value
function DebugWorld.getSeed() end

--- Removes fluid from a tank at the given coordinates.
---@param amount number Fluid amount (in mB)
---@param x number
---@param y number
---@param z number
---@param side number Facing side
---@return boolean success
function DebugWorld.removeFluid(amount, x, y, z, side) end

--- Inserts fluid into a tank at the specified location.
---@param id string Fluid ID
---@param amount number Fluid amount (in mB)
---@param x number
---@param y number
---@param z number
---@param side number Facing side
---@return boolean success
function DebugWorld.insertFluid(id, amount, x, y, z, side) end

--- Gets the name of the current dimension.
---@return string name Dimension name
function DebugWorld.getDimensionName() end

--- Gets the current world time.
---@return number time World time (ticks)
function DebugWorld.getTime() end

--- Sets the world time.
---@param value number Time in ticks
function DebugWorld.setTime(value) end

--- Gets light emission at a block.
---@param x number
---@param y number
---@param z number
---@return number light Light emission value
function DebugWorld.getLightValue(x, y, z) end

--- Returns whether it is raining.
---@return boolean raining
function DebugWorld.isRaining() end

--- Sets the raining state.
---@param value boolean True to start rain
function DebugWorld.setRaining(value) end

--- Returns whether it is thundering.
---@return boolean thundering
function DebugWorld.isThundering() end

--- Sets the thundering state.
---@param value boolean True to start thunder
function DebugWorld.setThundering(value) end

--- Sets a block at specified coordinates.
---@param x number
---@param y number
---@param z number
---@param id number|string Block ID or name
---@param meta number Metadata value
---@return number changed Number of blocks affected
function DebugWorld.setBlock(x, y, z, id, meta) end

--- Sets multiple blocks in a 3D volume.
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@param id number|string Block ID or name
---@param meta number Metadata
---@return number changed Blocks affected
function DebugWorld.setBlocks(x1, y1, z1, x2, y2, z2, id, meta) end

--- Removes items from an inventory at the location.
---@param x number
---@param y number
---@param z number
---@param slot number Inventory slot
---@param count number? Amount to remove
---@return number removed Actual amount removed
function DebugWorld.removeItem(x, y, z, slot, count) end

--- Inserts an item stack into a container.
---@param id string Item ID
---@param count number Quantity
---@param damage number Damage value
---@param nbt string NBT in JSON format
---@param x number
---@param y number
---@param z number
---@param side number Insert side
---@return boolean success
function DebugWorld.insertItem(id, count, damage, nbt, x, y, z, side) end

--- Gets the world spawn point.
---@return number x
---@return number y
---@return number z
function DebugWorld.getSpawnPoint() end

--- Sets the world spawn point.
---@param x number
---@param y number
---@param z number
function DebugWorld.setSpawnPoint(x, y, z) end

--- Checks if the block is directly under the sky.
---@param x number
---@param y number
---@param z number
---@return number result 1 = yes, 0 = no
function DebugWorld.canSeeSky(x, y, z) end

--- Gets the light opacity of a block.
---@param x number
---@param y number
---@param z number
---@return number opacity
function DebugWorld.getLightOpacity(x, y, z) end

--- Checks whether the block has a Tile Entity.
---@param x number
---@param y number
---@param z number
---@return number hasTileEntity 1 or 0
function DebugWorld.hasTileEntity(x, y, z) end

--- Plays a sound at a location.
---@param x number
---@param y number
---@param z number
---@param sound string Sound name
---@param range number Audible distance
function DebugWorld.playSoundAt(x, y, z, sound, range) end

--- Retrieves the NBT data of a tile entity.
---@param x number
---@param y number
---@param z number
---@return table nbt Tile NBT as table
function DebugWorld.getTileNBT(x, y, z) end

--- Overwrites the NBT of a tile entity.
---@param x number
---@param y number
---@param z number
---@param nbt table New NBT data
---@return boolean success
function DebugWorld.setTileNBT(x, y, z, nbt) end

--- Gets the block state at a location.
---@param x number
---@param y number
---@param z number
---@param actualState boolean? Include rendering data
---@return any state Block state
function DebugWorld.getBlockState(x, y, z, actualState) end

---@class DebugPlayer
local DebugPlayer = {}

--- Gets the world the player is in.
---@return DebugWorld world
function DebugPlayer.getWorld() end

--- Gets the player's current game mode.
---@return string mode `"survival"`, `"creative"`, or `"adventure"`
function DebugPlayer.getGameType() end

--- Sets the player's game mode.
---@param mode string One of the valid gametypes
function DebugPlayer.setGameType(mode) end

--- Gets current health value.
---@return number health
function DebugPlayer.getHealth() end

--- Sets current health value.
---@param value number New health
function DebugPlayer.setHealth(value) end

--- Gets maximum health.
---@return number maxHealth
function DebugPlayer.getMaxHealth() end

--- Gets current position.
---@return number x
---@return number y
---@return number z
function DebugPlayer.getPosition() end

--- Teleports player to new position.
---@param x number
---@param y number
---@param z number
function DebugPlayer.setPosition(x, y, z) end

--- Gets total XP earned.
---@return number xp
function DebugPlayer.getExperienceTotal() end

--- Gets current XP level.
---@return number level
function DebugPlayer.getLevel() end

--- Adds XP levels to player.
---@param amount number Number of levels
function DebugPlayer.addExperienceLevel(amount) end

--- Removes XP levels from player.
---@param amount number Number of levels
function DebugPlayer.removeExperienceLevel(amount) end

--- Inserts item stack into inventory.
---@param id string Item ID
---@param amount number Count
---@param meta number Damage/metadata
---@param nbt string? Optional NBT JSON
---@return number added Quantity added
function DebugPlayer.insertItem(id, amount, meta, nbt) end

--- Clears the player's inventory.
function DebugPlayer.clearInventory() end

---@class DebugScoreboard
local DebugScoreboard = {}

--- Creates a new scoreboard objective.
---@param objectiveName string Unique name for the objective
---@param objectiveCriteria string Type of scoring (e.g. "dummy", "health", "deathCount", etc.)
function DebugScoreboard.addObjective(objectiveName, objectiveCriteria) end

--- Deletes an existing scoreboard objective.
---@param objectiveName string Name of the objective to remove
function DebugScoreboard.removeObjective(objectiveName) end

--- Increases a player's score under a specific objective.
---@param playerName string Target player's name
---@param objectiveName string Objective being modified
---@param score integer Amount to add
function DebugScoreboard.increasePlayerScore(playerName, objectiveName, score) end

--- Decreases a player's score under a specific objective.
---@param playerName string Target player's name
---@param objectiveName string Objective being modified
---@param score integer Amount to subtract
function DebugScoreboard.decreasePlayerScore(playerName, objectiveName, score) end

--- Adds a player to a team.
---@param player string Player name
---@param team string Team name
---@return boolean success True if added successfully
function DebugScoreboard.addPlayerToTeam(player, team) end

--- Removes a player from a specific team.
---@param player string Player name
---@param team string Team name
---@return boolean success True if removed successfully
function DebugScoreboard.removePlayerFromTeam(player, team) end

--- Removes a player from all teams they belong to.
---@param player string Player name
---@return boolean success True if removed successfully
function DebugScoreboard.removePlayerFromTeams(player) end

--- Creates a new team.
---@param team string Team name
function DebugScoreboard.addTeam(team) end

--- Deletes a team from the scoreboard.
---@param teamName string Team name to remove
function DebugScoreboard.removeTeam(teamName) end

--- Retrieves the score of a player for a given objective.
---@param playerName string Player name
---@param objectiveName string Objective name
---@return integer score Player's current score
function DebugScoreboard.getPlayerScore(playerName, objectiveName) end

--- Sets the score of a player for a given objective.
---@param playerName string Player name
---@param objectiveName string Objective name
---@param score integer New score to assign
function DebugScoreboard.setPlayerScore(playerName, objectiveName, score) end

return DebugProxy