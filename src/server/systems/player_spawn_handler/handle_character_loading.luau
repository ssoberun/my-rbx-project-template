local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local custom_phases = require(ReplicatedStorage.shared["custom_phases"])
local phase = custom_phases.Phases.QueueResolution

local ct = require(ReplicatedStorage.shared.ct)

local load_character = require "./subsystems/load_character"
local get_character = require "@util/get_character"

local name = require(ReplicatedStorage.shared.utilities.name)

local function handle_character_loading (world: Jecs.World)
	local load_requests = world:query(ct.server.LOAD_PLAYER_CHARACTER):with(ct.Player)
	
	for player_entity, request in load_requests do
		local indexed_char_ent = get_character(world, player_entity)
		
		if indexed_char_ent then
			print(`Deleting character entity for {name(world, player_entity)}`)
			world:delete(indexed_char_ent)
		end
		
		local character_entity = load_character(world, player_entity)
		world:remove(player_entity, ct.server.LOAD_PLAYER_CHARACTER)
	end
end

return {
	system =handle_character_loading;
	phase = phase;
}