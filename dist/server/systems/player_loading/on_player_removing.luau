local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local onEvent = Planck.onEvent;

local onPlayerRemoving, playersRemoved = onEvent(Players.PlayerRemoving)

local unload_player = require(ServerScriptService.server.systems.subsystems["unload_player"])

local function on_player_removing (world: Jecs.World)
	for _, player in playersRemoved() do
		unload_player(world, player)
	end
end

return {
	system = on_player_removing;
	runConditions = { onPlayerRemoving }
}