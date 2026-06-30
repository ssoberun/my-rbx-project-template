local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase
local Startup = Phase.Startup

local GET_FULL_STATE = ReplicatedStorage.shared.packets.GET_FULL_STATE

local server_replicator = require(ServerScriptService.server["server_replicator"])

local function setup_game_state_listener (world: Jecs.World)
	GET_FULL_STATE.OnServerInvoke = function(player)
		server_replicator:mark_player_ready(player)
		return server_replicator:get_full(player)
	end
end

return {
	system = setup_game_state_listener;
	phase = Startup;
}