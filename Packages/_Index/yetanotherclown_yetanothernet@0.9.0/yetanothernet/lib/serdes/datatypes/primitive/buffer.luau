--!native

--[[
    This exists purely to add support for buffers into
    Arrays, Dictionaries, and other custom types which may
    contain a buffer.

    Instead of defining unique behavior for buffers, this
    module allows us to use the prexisting framework for
    serializing/deserializing datatypes for buffers.
]]

--[[
Copyright (c) YetAnotherClown, MIT License
The source code can be found at: https://github.com/YetAnotherClown/YetAnotherNet
]]
local function serialize(_buffer: buffer): buffer
	return _buffer
end

local function deserialize(_buffer: buffer): buffer
	return _buffer
end

return {
	serialize = serialize,
	deserialize = deserialize,

	id = 49,
}
