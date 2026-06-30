local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local Planck = require(ReplicatedStorage.Packages.Planck)

local client_replicator = require(ReplicatedStorage.client["client_replicator"])
local collect = require(ReplicatedStorage.shared.utilities.collect)

local COLLECT_UPDATES = ReplicatedStorage.shared.packets.COLLECT_UPDATES
local UNRELIABLE_UPDATES = ReplicatedStorage.shared.packets.UNRELIABLE_UPDATES

local updates = collect(COLLECT_UPDATES.OnClientEvent)
local unreliables = collect(UNRELIABLE_UPDATES.OnClientEvent)

local function apply_game_updates (world: Jecs.World)
	for _, buf, variants in updates do
		client_replicator:apply_updates(buf, variants)
	end
	
	for _, buf, variants in unreliables do
		client_replicator:apply_unreliable(buf, variants)
	end
end

return {
	system = apply_game_updates;
}