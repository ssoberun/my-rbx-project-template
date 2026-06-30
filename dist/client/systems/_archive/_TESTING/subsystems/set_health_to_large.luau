local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local interval = Planck.timePassed;

local ct = require(ReplicatedStorage.shared.ct)
local get_first_child_with_component = require(ReplicatedStorage.shared.utilities["get_first_child_with_component"])

local function set_health_to_large (world: Jecs.World, player_entity: Jecs.Entity)
	local character_entity = get_first_child_with_component(world, player_entity, ct.Character)
	world:set(character_entity, ct.Health, 2000)
end

return set_health_to_large

