local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local bulk_insert = Jecs.bulk_insert
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local ct = require(ReplicatedStorage.shared.ct)

local function give_tool_helper (world: Jecs.World, 
	props: {
		give_to_entity: Jecs.Entity;
		networked_to: {[Player]: boolean};
		tool_ct: Jecs.Entity;
		Slot: string;
		
		equip: boolean?;
		Description: string?;
	}
): Jecs.Entity
	
	local tool_entity = world:entity()
	
	bulk_insert(world, 
		tool_entity,
		{
			replecs.networked; -- network
			ct.Slot; -- set slot (string)
			
			-- tags
			props.tool_ct; -- add tool_ct identifier
			
			---- network 
			pair(replecs.reliable, props.tool_ct);
			pair(replecs.reliable, ct.Slot);
		},
		{
			props.networked_to;
			props.Slot;
		}
	)
	
	
	if props.equip then
		-- if not store, then equip to slot
		-- TODO: add check for what is equipped to that slot
		world:add(props.give_to_entity, pair(ct.Equipped, tool_entity))
		world:add(props.give_to_entity, pair(replecs.pair, ct.Equipped))
	else
		-- store tool item
		world:add(props.give_to_entity, pair(ct.Stored, tool_entity))
		world:add(props.give_to_entity, pair(replecs.pair, ct.Stored))
	end
	
	if props.Description then
		-- set description
		world:set(tool_entity, ct.Description, props.Description)
		world:add(props.give_to_entity, pair(replecs.pair, ct.Equipped))  
	end
	
	return tool_entity
end

return give_tool_helper