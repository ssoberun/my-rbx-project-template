local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase
local PostStartup = Phase.PostStartup

local ct = require(ReplicatedStorage.shared.ct)

local load_player = require(ServerScriptService.server.systems.subsystems["load_player"])

local function loadExistingPlayers(world: Jecs.World)
	for _, player in Players:GetPlayers() do
		load_player(world, player)
	end
end

return {
	system = loadExistingPlayers;
	phase = PostStartup;
}