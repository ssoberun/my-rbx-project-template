--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local ct = require(ReplicatedStorage.shared.ct)

return function (world: Jecs.World, entity: Jecs.Entity, custom_time: number?, replicate_to_players: {[Player]: boolean}?)
	local respawn_time_ms = custom_time or world:get(ct.SINGLETONS, ct.SINGLETON_GLOBAL_RESPAWN_TIME) :: number
	
	world:set(entity, ct.RESPAWN_TIMER, respawn_time_ms)
	
	if replicate_to_players then
		print(`Replicating Respawn Timer`, replicate_to_players)
		world:set(entity, pair(replecs.unreliable, ct.RESPAWN_TIMER), replicate_to_players)
	end
end