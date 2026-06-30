--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local ct = require(ReplicatedStorage.shared.ct)

local function spawn_corpse (world: Jecs.World, entity: Jecs.Entity)
	local corpse_entity = world:entity()
	world:set(corpse_entity, ct.Corpse, tick())
	world:set(entity, ct.Lootable, { 
		owner = entity; 
		loot = {};
	})
	
	world:add(entity, pair(replecs.reliable, ct.Corpse))
	world:add(entity, pair(replecs.reliable, ct.Lootable))
	
	return world:get(entity, ct.Corpse)
end

return spawn_corpse