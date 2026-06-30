local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Jecs = require (game:GetService('ReplicatedStorage'):WaitForChild('Packages'):WaitForChild('Jecs'))
local Planck = require (game:GetService('ReplicatedStorage'):WaitForChild('Packages'):WaitForChild('Planck'))
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