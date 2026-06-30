local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local onEvent = Planck.onEvent;
local isNot = Planck.isNot

local onPlayerAdded, newPlayers: () -> ({Player}) = onEvent(Players.PlayerAdded)

local load_player = require(ServerScriptService.server.systems.subsystems["load_player"])


local function onPlayerAdded(world: Jecs.World)
	for _, player in newPlayers() do
		print(`{player.Name} has joined the game!`)
		load_player(world, player)
	end
end

return {
	system = onPlayerAdded;
	runConditions = { onPlayerAdded }
}