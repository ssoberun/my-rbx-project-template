local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase
local Startup = Phase.Startup

local shared_ct = require(ReplicatedStorage.shared.ct)

local function shared_init_replication (world: Jecs.World)
	if RunService:IsServer() then
		local replicator = require(ServerScriptService.server.server_replicator)
		replicator:init()
	elseif RunService:IsClient() then
		local replicator = require(ReplicatedStorage.client.client_replicator)
		replicator:init()
	end
end

return {
	system = shared_init_replication;
	phase = Startup
}