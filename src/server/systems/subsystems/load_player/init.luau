--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair
local bulk_insert = Jecs.bulk_insert;

local replecs = require(ReplicatedStorage.Packages.replecs)

local setup_player_connections = require "@self/setup_player_connections"

local name = require(ReplicatedStorage.shared.utilities.name)
local ct = require(ReplicatedStorage.shared.ct)

return function(world: Jecs.World, player: Player)
	local player_controller_entity = world:entity()
	
	bulk_insert(world, player_controller_entity,  
		{  
			ct.Player,  
			ct.Name,   
			
			-- tags
			ct.server.PlayerConnections,  
			pair(replecs.pair, Jecs.ChildOf),
			pair(replecs.reliable, ct.Player);
			replecs.networked;
		},  
		{  
			player,
			player.Name
		}  
	)
	
	setup_player_connections(world, player_controller_entity)
	world:add(player_controller_entity, ct.server.LOAD_PLAYER_CHARACTER)
	world:add(player_controller_entity, ct.PLAYER_LOADED)
end