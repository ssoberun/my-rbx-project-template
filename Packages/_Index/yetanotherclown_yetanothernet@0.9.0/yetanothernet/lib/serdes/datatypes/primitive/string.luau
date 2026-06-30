--!native

--[[
Copyright (c) YetAnotherClown, MIT License
The source code can be found at: https://github.com/YetAnotherClown/YetAnotherNet
]]
local function serialize(_string: string): buffer
	return buffer.fromstring(_string)
end

local function deserialize(_buffer: buffer): string
	return buffer.tostring(_buffer)
end

return {
	serialize = serialize,
	deserialize = deserialize,

	id = 5,
}
