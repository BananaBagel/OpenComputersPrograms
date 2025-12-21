# BananaBagel's OpenComputers Programs

A small collection of programs I made/adapted to use on my Project Ozone 3 server (OpenComputers 1.7.7 on MC 1.12.2)

## Programs

### NBT-Related Programs

These programs are (likely) very high RAM-consuming for computers and requires the config setting `opencomputers/integration/vanilla/allowItemStackNBTTags` to be enabled on the server. (My config file has it around line 600)

#### LibNBTneo

`require("nbt")`

A library for decompressing NBT Tags (OpenComputers has them compressed), and converting to objects. Adapted from [Magik6k-Programs](https://github.com/OpenPrograms/Magik6k-Programs/tree/master/libnbt)

#### NBTUtils

`require("nbtutils")`

A library for working with NBT data at a bigger and easier level.
A few features include:

- Parsing NBT data from an array of items (ie, an inventory)
- Easy Parsing of NBT data from a single item