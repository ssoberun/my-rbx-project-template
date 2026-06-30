local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local ct = require(ReplicatedStorage.shared.ct)
local name = require(ReplicatedStorage.shared.utilities.name)

local function on_damage_dealt(world: Jecs.World, source: Jecs.Entity, target: Jecs.Entity, amount: number)
	print(`{name(world, target)} was hit by {name(world, source)} for {amount}`)
end



return on_damage_dealt