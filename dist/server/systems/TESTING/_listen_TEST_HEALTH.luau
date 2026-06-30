--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)

local get_player_entity = require(ReplicatedStorage.shared.utilities["get_player_entity"])
local get_first_child_with_component = require(ReplicatedStorage.shared.utilities["get_first_child_with_component"])


local function setup_listener (world: Jecs.World)
	TEST_HEALTH.OnServerEvent:Connect(function(player: Player)
		local player_ent = get_player_entity.entity_from_player(player) :: Jecs.Entity
		local char_ent = get_first_child_with_component(world, player_ent, ct.Character) :: Jecs.Entity
		world:set(char_ent, ct.Health, 100)
	end)
end

return {
	system = setup_listener;
	phase = phase;
}