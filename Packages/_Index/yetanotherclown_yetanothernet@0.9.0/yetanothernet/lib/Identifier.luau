--[[
Copyright (c) YetAnotherClown, MIT License
The source code can be found at: https://github.com/YetAnotherClown/YetAnotherNet
]]
local identifier = require(script.Parent:WaitForChild('serdes'):WaitForChild('datatypes'):WaitForChild('custom'):WaitForChild('identifier'))
export type Identifier = buffer

local function new(uniquePosition: number?): buffer
	return identifier.serialize(uniquePosition)
end

local function read(_buffer: buffer): number
	return identifier.deserialize(_buffer)
end

return {
	new = new,
	read = read,
}
