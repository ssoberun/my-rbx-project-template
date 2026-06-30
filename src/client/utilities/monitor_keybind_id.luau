local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])
local monitor = jecs_utils.monitor;

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local function check_all_pressed(keybinds_set: {[string]: boolean}, active_keys: {string})
	for keybind_id, _ in pairs(keybinds_set) do
		if not active_keys[keybind_id] then
			return false
		end
	end
	return true
end

-- Monitors provided keybind id (spark)
-- Returns a cleanup function
local function monitor_keybind_id (
	props: {
		world: Jecs.World;
		keybind_ids: {string};
		on_added: ((frame_input_entity: Jecs.Entity<any>) -> ())?;
		on_removed: ((frame_input_entity: Jecs.Entity<any>) -> ())?;
	}
): () -> ()
	
	local world = props.world
	local keybind_ids = props.keybind_ids
	local on_added = props.on_added;
	local on_removed = props.on_removed;
	
	local frame_input_monitor = monitor(world:query(cct.FrameInput))
	
	local active_keys = {};
	
	local keybind_set = {};
	for _, id in ipairs(keybind_ids) do
		keybind_set[id] = true
	end
	
	frame_input_monitor.added(function(entity: Jecs.Entity)
		local input_id = world:get(entity, cct.FrameInput)
		
		if keybind_set[input_id] then
			active_keys[input_id] = true
			local all_pressed = check_all_pressed(keybind_set, active_keys)
			
			if all_pressed and on_added then
				on_added (entity)
			end
		end
		
		--if world:get(entity, cct.FrameInput) == keybind_id then
		--	if on_added then
		--		on_added(entity)
		--	end
		--end
	end)
	
	frame_input_monitor.removed(function(entity: Jecs.Entity)
		local input_id = world:get(entity, cct.FrameInput)
		
		if keybind_set[input_id] then
			active_keys[input_id] = false
			local all_pressed = check_all_pressed(keybind_set, active_keys)
			
			if on_removed and all_pressed then
				on_removed (entity)
			end
		end
		
		--if world:get(entity, cct.FrameInput) == keybind_id then
		--	if on_removed then 
		--		on_removed(entity) 
		--	end
		--end
	end)
	
	return frame_input_monitor.disconnect
end

return monitor_keybind_id