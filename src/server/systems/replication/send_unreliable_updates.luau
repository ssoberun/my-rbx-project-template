local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local Planck = require(ReplicatedStorage.Packages.Planck)
local timePassed = Planck.timePassed

local replicator = require(ServerScriptService.server["server_replicator"])

local UNRELIABLE_UPDATES = ReplicatedStorage.shared.packets.UNRELIABLE_UPDATES
local unreliable_update_interval = timePassed(1/30)

local function send_unreliable_updates (world: Jecs.World)
	for player, buf, variants in replicator:collect_unreliable() do
		UNRELIABLE_UPDATES:FireClient(player, buf, variants)
	end
end

return {
	system = send_unreliable_updates;
	runConditions = { unreliable_update_interval }
}