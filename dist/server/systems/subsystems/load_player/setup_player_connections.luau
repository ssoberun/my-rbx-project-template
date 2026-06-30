local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local get_character = require(ReplicatedStorage.shared.utilities["get_character"])

local ct = require(ReplicatedStorage.shared.ct)

return function(world: Jecs.World, player_entity: Jecs.Entity)
	local PLAYER = world:get(player_entity, ct.Player)
	
	local Connection = PLAYER.CharacterAdded:Connect(function(character: Model)
		local RootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
		if not RootPart then
			error(`No RootPart could be found for {character}`)
		end
		
		local indexed_char_ent = get_character(world, player_entity)
		
		if not indexed_char_ent then
			error (`No Character entity for {world:get(player_entity, ct.Player)}`)
		end
		
		world:set(indexed_char_ent, ct.RootPart, RootPart)
		world:set(indexed_char_ent, ct.Model, character)
		print(`Set ct.Model for {world:get(player_entity, ct.Player)} to {world:get(indexed_char_ent, ct.Model)}`)
	end)

	local Connection2 = PLAYER.CharacterRemoving:Connect(function(character: Model) 
		local indexed_char_ent = get_character(world, player_entity)
		
		if not indexed_char_ent then
			error (`No Character entity for {world:get(player_entity, ct.Player)}`)
		end

		world:set(indexed_char_ent, ct.Model, nil)
		world:set(indexed_char_ent, ct.RootPart, nil)
		--print(`Set ct.Model for {world:get(player_entity, ct.Player)} to {world:get(indexed_char_ent, ct.Model)}`)
	end)

	local connection_table = {}
	table.insert(connection_table, Connection)
	table.insert(connection_table, Connection)
	world:set(player_entity, ct.server.PlayerConnections, connection_table)
end