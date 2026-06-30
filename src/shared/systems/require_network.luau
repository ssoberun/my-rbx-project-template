local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Jecs = require "@pkg/Jecs"
local Planck = require "@pkg/Planck"
local phase = Planck.Phase.Startup

local function require_network (world: Jecs.World)
	if RunService:IsClient() then
		require(ReplicatedStorage.network.blink_client)
	else
		require(ReplicatedStorage.network.blink_server)
	end
end

return {
	system = require_network;
	phase = phase;
}