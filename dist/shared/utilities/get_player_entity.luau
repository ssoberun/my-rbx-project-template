--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local ct = require(ReplicatedStorage.shared.ct)

local player_to_entity = {} :: {[Player]: Jecs.Entity}

local function entity_from_player (player: Player): Jecs.Entity?
	return player_to_entity[player]
end

local function add_player_lookup (world: Jecs.World, entity: Jecs.Entity)
	local player = world:get(entity, ct.Player)
	
	if not player then
		error(`No Player data assigned to ct`)
	end
	
	player_to_entity[player] = entity
end

local function remove_player_lookup (world:Jecs.World, player: Player)
	local query = player_to_entity[player]
	
	if not query then
		warn(`Player already removed/Never added to lookup`)
	end
	
	player_to_entity[player] = nil
end

return {
	entity_from_player = entity_from_player;
	add_player_lookup = add_player_lookup;
	remove_player_lookup = remove_player_lookup;
}