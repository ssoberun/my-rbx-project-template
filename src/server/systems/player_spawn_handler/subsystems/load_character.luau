--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local bulk_insert = Jecs.bulk_insert;
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)
local ct = require(ReplicatedStorage.shared.ct)

return function (world: Jecs.World, controller_entity: Jecs.Entity): Jecs.Entity
	-- REMEMBER! Because CharacterAutoLoad is off, on first spawn, Character is set to nil (as there is no CharacterAdded event)
	
	local PLAYER = world:get(controller_entity, ct.Player)
	local transformed_entity_name = `{world:get(controller_entity, ct.Name)}_char`
	
	local character_entity = world:entity()
	
	bulk_insert(world, character_entity, {  
		ct.Name;  
		ct.Character;  
		ct.Health;  
		ct.Defense;  
		ct.Resist;  
		ct.Position;
		ct.server.ModifyHealthQueue;  
		
		-- initialised as nil variables
		ct.Model;  
		ct.RootPart;
		
		-- tags/always nil
		
		replecs.networked;
		pair(Jecs.ChildOf, controller_entity);
		pair(replecs.pair, Jecs.ChildOf);  
		pair(replecs.reliable, ct.Character);
		pair(replecs.reliable, ct.Position);
		pair(replecs.reliable, ct.Model);  
		pair(replecs.reliable, ct.Health);  
		pair(replecs.reliable, ct.Player);  
		pair(replecs.reliable, ct.Defense);  
		pair(replecs.reliable, ct.Resist);  
		pair(replecs.reliable, ct.RootPart);
	},  
	{  
		transformed_entity_name;  
		transformed_entity_name;  
		100;  
		20;  
		20;  
		Vector3.zero;
		{};
		
		nil;
		nil;
	})

	-- perhaps everything below moved?
	if PLAYER then
		local player_entity = controller_entity
		if not(Players.CharacterAutoLoads) then
			task.spawn(function()
				if PLAYER then
					print(PLAYER)
					PLAYER:LoadCharacterAsync()
					print(`Loaded {PLAYER.Name} character`)
				end
			end)
		else
			-- > messy code
			PLAYER.CharacterAdded:Once(function(Character: Model) 
				local RootPart = Character:FindFirstChild("HumanoidRootPart") :: BasePart
				world:set(character_entity, ct.RootPart, RootPart)
				world:set(character_entity, ct.Model, Character)

				print(`Set ct.Model to {world:get(character_entity,ct.Model)} and ct.RootPart {world:get(character_entity, ct.RootPart)}`)
			end)
		end
	else
		print(`Custom Character loading not implemented yet for non-player entities`)
	end
	
	return character_entity
end