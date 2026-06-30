local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])
local set_ref = jecs_utils.ref.set

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase =  Planck.Phase
local Startup = Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)

local get_player_entity = require(ReplicatedStorage.shared.utilities["get_player_entity"])
local add_player_lookup = get_player_entity.add_player_lookup
local remove_player_lookup = get_player_entity.remove_player_lookup

local IS_SERVER = RunService:IsServer()

local function setup_player_component_hooks (world: Jecs.World)
	world:set(ct.Player, Jecs.OnAdd, function(player_entity, ct, player)
		print(`{player_entity} added ct.Player ({ct}) to {player}`)
		add_player_lookup(world, player_entity)
		set_ref(player, player_entity)
	end)
	
	world:set(ct.Player, Jecs.OnRemove, function(player_entity, ct)
		local player = world:get(player_entity, ct)
		print(`ct.Player removed from {player_entity} | {player}`)
		remove_player_lookup(world, player)
		set_ref(player, nil)
	end)
	
	if IS_SERVER then
		world:set(ct.server.PlayerConnections, Jecs.OnRemove, function(player_entity, ct)
			local connections = world:get(player_entity, ct)
			for _, connection: RBXScriptConnection in connections do
				print(`Destroying Connection`)
				connection:Disconnect()
			end
		end)
	end
end

return {
	system = setup_player_component_hooks;
	phase = Startup
}