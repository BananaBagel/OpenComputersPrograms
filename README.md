# BananaBagel's OpenComputers Programs

A small collection of programs I made/adapted to use on my Project Ozone 3 server (OpenComputers 1.7.7 on MC 1.12.2)

## Programs

### NBT-Related Programs

These programs are (likely) very high RAM-consuming for computers and requires the config setting `opencomputers/integration/vanilla/allowItemStackNBTTags` to be enabled on the server. (My config file has it around line 600)
* [LibNBTneo](#libnbtneo)
* [NBTUtils](#nbtutils)
  * [Logging](#logging)
  * []


#### LibNBTneo

Install: $`oppm install libnbtneo`

Use: `require("nbt")`

A library for decompressing NBT Tags (OpenComputers has them compressed), and converting to objects. Adapted from [Magik6k-Programs](https://github.com/OpenPrograms/Magik6k-Programs/tree/master/libnbt)

#### NBTUtils

Install: $`oppm install nbtutilsneo`

Use: `require("nbtutils")`

A library for working with NBT data at a bigger and easier level.
A few features include:

- Parsing NBT data from an array of items (ie, an inventory)
- Easy Parsing of NBT data from a single item
  
### Utils

Install all: $`oppm install neoutils`

This collection of random small utilities is used by a few of my programs for silly goofy.

#### Logging

Use: `require("neoutils.logging")`

A simple library for logging to the console.

### Other Programs

Programs that don't fall into the other categories

#### PneumatiPlastic

Install: $`oppm install pneumaticcraft-plastic`

Use: $`plastic`

In use with an AE2 ME system, this powerful program can blah blah blah- it makes pneumaticcraft plastic. Okay?
Put dye in a chest on top of a transposer, it'll output plastic to a chest (or some inventory) on a horizontal side of the transposer. The other sides have to have liquid plastic and a plastic mixer. A redstone controller has to be adjacent to the plastic mixer with the plastic mixer set to redstone selection mode.
This program is a simple program that doesn't have much or really any customizability, I just made it to work with my setup.

#### Whiptail

Install: $`oppm install whiptail`
Use: `require("whiptail")`
A simple library for making text-based user interfaces in OpenComputers.