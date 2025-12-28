-- Adapted by BananaBagel
-- Licensed under the MIT license

local math = math
local computer = require("computer")
local zzlib = require("zzlib")

local nbt = { _VERSION = "0.1.0" }

local data = {}
data.pointer = 1
data.raw = ""
data.size = #data.raw

local function ldexp(x, exp)
    -- same as C's ldexp: x * 2^exp
    return x * 2.0 ^ exp
end


data.move = function(self, size)
    size = size or 1
    self.pointer = self.pointer + size
end

data.read = function(self, size)
    size = size or 1
    local result = 0
    for i = 1, size do
        result = result * 0x100 + self.raw:byte(self.pointer)
        self.pointer = self.pointer + 1
    end
    return result
end

data.get = function(self, n)
    n = n or 1
    return self.raw:byte(self.pointer + n - 1)
end


data.readByte = function(data)
    local result = data:read()
    return result
end

data.readShort = function(data)
    local result = data:read(2)   -- big-endian 16-bit
    if result >= 0x8000 then
        result = result - 0x10000 -- convert to negative
    end
    return result
end

data.readInt = function(self)
    local result = self:read(4)       -- 0 .. 0xFFFFFFFF (unsigned)
    if result >= 0x80000000 then      -- if sign bit set
        result = result - 0x100000000 -- convert to negative
    end
    return result                     -- now in range -2^31 .. 2^31-1
end

data.readLong = function(self)
    local hi = self:read(4) -- high 32 bits (unsigned)
    local lo = self:read(4) -- low 32 bits (unsigned)

    -- combine to unsigned 64-bit value (as a Lua number)
    local value = hi * 2 ^ 32 + lo -- 0 .. 2^64-1

    -- if high bit of hi is set, value represents a negative number
    if hi >= 0x80000000 then
        value = value - 2 ^ 64 -- convert to signed range
    end

    return value -- approx -2^63 .. 2^63-1
end

data.readFloat = function(data)
    local sign = 1
    local mantissa = data:get(2) % 128
    for i = 3, 4 do
        mantissa = mantissa * 256 + data:get(i)
    end
    if data:get(1) > 127 then sign = -1 end
    local exponent = (data:get(1) % 128) * 2 + math.floor(data:get(2) / 128)
    data:move(4)
    if exponent == 0 then
        return 0
    end
    mantissa = (ldexp(mantissa, -23) + 1) * sign
    return ldexp(mantissa, exponent - 127)
end

data.readDouble = function(data)
    local sign = 1
    local mantissa = data:get(2) % 2 ^ 4
    for i = 3, 8 do
        mantissa = mantissa * 256 + data:get(i)
    end
    if data:get(1) > 127 then sign = -1 end
    local exponent = (data:get(1) % 128) * 2 ^ 4 + math.floor(data:get(2) / 2 ^ 4)
    data:move(8)
    if exponent == 0 then
        return 0
    end
    mantissa = (ldexp(mantissa, -52) + 1) * sign
    return ldexp(mantissa, exponent - 1023)
end


data.readString = function(data)
    local length = data:readShort()
    local result = ""
    for i = 1, length do
        result = result .. string.char(data:readByte())
    end
    return result
end

data.readByteArray = function(data)
    local result = {}
    for i = 1, data:readInt() do
        result[i] = data:readByte()
    end
    return result
end

data.readList = function(data)
    local result = {}
    local id = data:readByte()
    local length = data:readInt()

    if id == 0 then
        -- Spec: TAG_End list type => length must be 0
        return result
    end

    local fun = data.readFun[id]
    for i = 1, length do
        result[i] = fun(data)
    end
    return result
end

data.readIntArray = function(data)
    local result = {}
    for i = 1, data:readInt() do
        result[i] = data:readInt()
    end
    return result
end

data.readCompound = function(data)
    local result = {}
    while data.pointer <= data.size do
        local id = data:readByte()
        if id == 0 then return result end
        result[data:readString()] = data.readFun[id](data)
    end
    return result
end

data.readLongArray = function(data)
    local result = {}
    local length = data:readInt()
    for i = 1, length do
        result[i] = data:readLong()
    end
    return result
end


data.readFun = {
    [1] = data.readByte,
    [2] = data.readShort,
    [3] = data.readInt,
    [4] = data.readLong,
    [5] = data.readFloat,
    [6] = data.readDouble,
    [7] = data.readByteArray, -- read byte array
    [8] = data.readString,
    [9] = data.readList,      -- List
    [10] = data.readCompound,
    [11] = data.readIntArray, -- Int List
    [12] = data.readLongArray
}

--- Reads NBT data from decompressed data
--- @param rawdata string
--- @return table
local function readFromNBT(rawdata)
    data.raw = rawdata
    data.pointer = 1
    data.size = #data.raw
    return data:readCompound()[""]
end

--- Reads a raw tag object, decompressing if needed
--- @param rawTag string
--- @return table
function nbt.parse(rawTag)
    -- check if tag is empty or nil
    if rawTag == nil or rawTag == "" or type(rawTag) ~= "string" then return {} end
    -- try to decompress, if needed
    local inflatedRawTag
    local id1, id2 = rawTag:byte(1, 2)
    if id1 ~= 31 or id2 ~= 139 then
        inflatedRawTag = zzlib.gunzip(rawTag)
    end
    inflatedRawTag = inflatedRawTag or rawTag
    return readFromNBT(inflatedRawTag)
end

return nbt
