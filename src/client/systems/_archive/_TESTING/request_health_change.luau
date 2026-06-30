local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local interval = Planck.timePassed;


local TEST_HEALTH = ReplicatedStorage.shared.packets.TEST_HEALTH
local ct = require(ReplicatedStorage.shared.ct)
local set_health_to_large = require(ReplicatedStorage.client.systems.TESTING.subsystems["set_health_to_large"])

local function request_health_change (world: Jecs.World)
	for player_entity, player in world:query(ct.Player) do
		set_health_to_large(world, player_entity)
		TEST_HEALTH:FireServer()
	end
end

return {
	system = request_health_change;
	runConditions = { interval (1/2) }
}
