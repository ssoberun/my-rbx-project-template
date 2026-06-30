--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local ct = require(ReplicatedStorage.shared.ct)

local get_player_entity = require(ReplicatedStorage.shared.utilities["get_player_entity"])
local entity_from_player = get_player_entity.entity_from_player;

return function(world: Jecs.World, player: Player)
	print(`Unloading {player.Name}`)
	
	local PlayerEntity = entity_from_player(player)
	
	if not PlayerEntity then
		warn(`NON-FATAL: PlayerEntity does not exist for {player.Name}`)
		return
	end
	
	world:delete(PlayerEntity)
end