---@meta

--- Proxy interface for the Data component (`data`)
---
--- Provided by the Data Card. Offers hashing, encoding, compression, RNG,
--- and tiered cryptographic utilities (AES, ECDSA, ECDH, key generation).
---@class DataProxy
local DataProxy = {}

--==============================================================================
-- Tier 1: Hashing, (en/de)coding, compression
--==============================================================================

--- Computes CRC-32 of the input data.
--- Result is a binary string (raw bytes).
---@param data string
---@return string
function DataProxy.crc32(data) end

--- Base64-decodes the input.
--- Returns the decoded binary string.
---@param data string
---@return string
function DataProxy.decode64(data) end

--- Base64-encodes the input.
--- Result is a binary string (raw bytes of the base64 text).
---@param data string
---@return string
function DataProxy.encode64(data) end

--- Computes MD5 of the input data.
--- Result is a binary string (raw 16-byte digest).
---@param data string
---@return string
function DataProxy.md5(data) end

--- Computes SHA-256 of the input data.
--- Result is a binary string (raw 32-byte digest).
---@param data string
---@return string
function DataProxy.sha256(data) end

--- Deflate-compresses the input.
--- Returns compressed binary string.
---@param data string
---@return string
function DataProxy.deflate(data) end

--- Inflate-decompresses the input.
--- Returns decompressed binary string.
---@param data string
---@return string
function DataProxy.inflate(data) end

--- Gets the maximum size of data accepted by card functions.
---@return number
function DataProxy.getLimit() end

--==============================================================================
-- Tier 2: Symmetric crypto and RNG
--==============================================================================

--- AES-encrypts data using the provided key and IV.
--- Both key and IV are binary strings; IV should be random.
---@param data string
---@param key string
---@param iv string
---@return string
function DataProxy.encrypt(data, key, iv) end

--- AES-decrypts data using the provided key and IV.
---@param data string
---@param key string
---@param iv string
---@return string
function DataProxy.decrypt(data, key, iv) end

--- Generates a cryptographically random binary string of length `len`.
---@param len number
---@return string
function DataProxy.random(len) end

--==============================================================================
-- Tier 3: Asymmetric crypto (EC), key handling, signatures, key agreement
--==============================================================================

--- Generates an EC public/private key pair for cryptographic operations.
--- Optional `bitLen` is the key length; accepted values: 256 or 384.
--- Returns: publicKey, privateKey.
---@param bitLen number|nil
---@return ECPublicKey, ECPrivateKey
function DataProxy.generateKeyPair(bitLen) end

--- Generates or verifies an ECDSA signature.
--- Signing: provide a private key; returns signature (binary string).
--- Verifying: provide a public key and `sig`; returns boolean (true if valid).
---@param data string
---@param key ECKey
---@param sig string|nil
---@return string|boolean
---@overload fun(data: string, key: ECPrivateKey):string
---@overload fun(data: string, key: ECPublicKey, sig: string):boolean
function DataProxy.ecdsa(data, key, sig) end

--- Performs ECDH to derive a shared secret.
--- Use a private key from one party and a public key from the other.
--- Example relation: ecdh(A.private, B.public) == ecdh(B.private, A.public)
---@param privateKey ECPrivateKey
---@param publicKey ECPublicKey
---@return string
function DataProxy.ecdh(privateKey, publicKey) end

--- Deserializes a key from its string form and declared type.
--- `type` examples: "ec-public", "ec-private".
---@param data string
---@param type string
---@return ECKey
function DataProxy.deserializeKey(data, type) end

--==============================================================================
-- Key object model (returned/accepted by Tier 3 functions)
--==============================================================================

--- Base EC key interface.
--- Runtime objects may be userdata/tables; exposed here for IntelliSense.
---@class ECKey
local ECKey = {}

--- Serializes this key to a string.
---@return string
function ECKey:serialize() end

--- Returns true if this key is a public key; false if private.
---@return boolean
function ECKey:isPublic() end

--- EC public key (subset of ECKey).
---@class ECPublicKey: ECKey
local ECPublicKey = {}

--- EC private key (subset of ECKey).
---@class ECPrivateKey: ECKey
local ECPrivateKey = {}

return DataProxy