--[[
Copyright (c) YetAnotherClown, MIT License
The source code can be found at: https://github.com/YetAnotherClown/YetAnotherNet
]]
local array = require(script:WaitForChild('datatypes'):WaitForChild('custom'):WaitForChild('array'))
local dictionary = require(script:WaitForChild('datatypes'):WaitForChild('custom'):WaitForChild('dictionary'))

local boolean = require(script:WaitForChild('datatypes'):WaitForChild('primitive'):WaitForChild('boolean'))
local number = require(script:WaitForChild('datatypes'):WaitForChild('primitive'):WaitForChild('number'))
local _string = require(script:WaitForChild('datatypes'):WaitForChild('primitive'):WaitForChild('string'))

local BrickColor = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('BrickColor'))
local CFrame = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('CFrame'))
local Color3 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Color3'))
local DateTime = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('DateTime'))
local EnumItem = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('EnumItem'))
local Instance = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Instance'))
local Rect = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Rect'))
local Region3 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Region3'))
local Region3int16 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Region3int16'))
local TweenInfo = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('TweenInfo'))
local UDim = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('UDim'))
local UDim2 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('UDim2'))
local Vector2 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Vector2'))
local Vector2int16 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Vector2int16'))
local Vector3 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Vector3'))
local Vector3int16 = require(script:WaitForChild('datatypes'):WaitForChild('userdata'):WaitForChild('Vector3int16'))

return {
	array = array,
	dictionary = dictionary,

	boolean = boolean,
	number = number,
	string = _string,

	BrickColor = BrickColor,
	CFrame = CFrame,
	Color3 = Color3,
	DateTime = DateTime,
	EnumItem = EnumItem,
	Instance = Instance,
	Rect = Rect,
	Region3 = Region3,
	Region3int16 = Region3int16,
	TweenInfo = TweenInfo,
	UDim = UDim,
	UDim2 = UDim2,
	Vector2 = Vector2,
	Vector2int16 = Vector2int16,
	Vector3 = Vector3,
	Vector3int16 = Vector3int16,
}
