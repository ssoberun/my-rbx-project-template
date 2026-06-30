local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)
local name = require(ReplicatedStorage.shared.utilities.name)

local function on_entity_damaged (world: Jecs.World)
	world:set(ct.Health, Jecs.OnChange, function(entity, ct, newNumber)
		--print(`{name(world, ct)} component for {name(world, entity)} changed to {newNumber}`)
	end)
end

return {
	system = on_entity_damaged;
	phase = phase;
}