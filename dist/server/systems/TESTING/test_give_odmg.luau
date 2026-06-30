local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local replecs = require(ReplicatedStorage.Packages.replecs)

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local Planck = require(ReplicatedStorage.Packages.Planck)

local ct = require(ReplicatedStorage.shared.ct)

-- util
local handout_tool_helper = require(ServerScriptService.server["server_utils"]["handout_tool_helper"])
local targets = require(ReplicatedStorage.shared.utilities.targets)

local function give_odmg (world: Jecs.World, props: {
		player: Player;
		give_to_entity: Jecs.Entity;
	})
	local player = props.player;
	local give_to_entity = props.give_to_entity
	
	handout_tool_helper(world, {
		networked_to = {
			[player] = true;
		};
		["give_to_entity"] = give_to_entity;
		tool_ct = ct.tools.ODMG;
		Slot = "hips";
		["equip"] = false;
		["Description"] = "You're a dirtbag.";
	})
	
	
	print(`Gave ODMG to {player}`)
end

local function test_give_odmg (world: Jecs.World)
	local stored_query = world:query(ct.Character):with(pair(ct.Stored, Jecs.Wildcard)):cached()
	local no_stored_query = world:query(ct.Character):without(pair(ct.Stored, Jecs.Wildcard)):cached()
	
	for char_entity, char in stored_query do
		local player_entity = world:parent(char_entity)
		local player = world:get(player_entity, ct.Player)

		if not player then
			error(`NO PLAYER ENTITY FOR {char}`)
		end
		
		local has_odmg_stored = false
		local stored = targets(world, char_entity, ct.Stored)
		
		for target in stored do
			if world:has(target, ct.tools.ODMG) then
				has_odmg_stored = true
				break
			end
		end
		
		if not has_odmg_stored then
			give_odmg(world, { player = player; give_to_entity = char_entity })
		end
	end
	
	for char_entity, char in no_stored_query do  
		local player_entity = world:parent(char_entity)  
		local player = world:get(player_entity, ct.Player)  
		
		if not player then  
			error(`NO PLAYER ENTITY FOR {char}`)  
		end  
		
		give_odmg(world, { player = player; give_to_entity = char_entity })
	end  
	
	
	--local char_query = world:query(ct.Character):with(pair(ct.Equipped, Jecs.Wildcard)):cached()
	
	--for char_entity, char in char_query do
	--	local player_entity = world:parent(char_entity)
	--	local player = world:get(player_entity, ct.Player)
		
	--	if not player then
	--		error(`NO PLAYER ENTITY FOR {char}`)
	--	end
		
	--	local has_odmg_equipped = false  
	--	local i = 0 
	--	local equipped_entity = world:target(char_entity, ct.Equipped, i)  
		
	--	while equipped_entity do  
	--		if world:has(equipped_entity, ct.tools.ODMG) then  
	--			has_odmg_equipped = true  
	--			break  
	--		end  
	--		i += 1  
	--		equipped_entity = world:target(char_entity, ct.Equipped, i)  
	--	end  

	--	-- If no ODMG equipped, create and equip one  
	--	if not has_odmg_equipped then  
	--		give_odmg(world, { player = player; give_to_entity = char_entity })
	--	end  
	--end
	
	--local no_equipped_query = world:query(ct.Character):without(pair(ct.Equipped, Jecs.Wildcard)):cached()  

	--for char_entity, char in no_equipped_query do  
	--	local player_entity = world:parent(char_entity)  
	--	local player = world:get(player_entity, ct.Player)  

	--	if not player then  
	--		error(`NO PLAYER ENTITY FOR {char}`)  
	--	end  
		
	--	give_odmg(world, { player = player; give_to_entity = char_entity })
	--end  
end

return {
	system = test_give_odmg;
}