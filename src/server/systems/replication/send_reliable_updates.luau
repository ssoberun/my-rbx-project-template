local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Planck = require(ReplicatedStorage.Packages.Planck)
local timePassed = Planck.timePassed

local replicator = require(ServerScriptService.server["server_replicator"])

local COLLECT_UPDATES = ReplicatedStorage.shared.packets.COLLECT_UPDATES

local reliable_update_interval = timePassed(1/20)

local function send_reliable_updates ()
	for player, buf, variants in replicator:collect_updates() do
		COLLECT_UPDATES:FireClient(player, buf, variants)
	end
end

return {
	system = send_reliable_updates;
	runConditions = { reliable_update_interval }
}