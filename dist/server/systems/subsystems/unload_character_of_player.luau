local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local ct = require(ReplicatedStorage.shared.ct)

local get_first_child_with_component = require(ReplicatedStorage.shared.utilities["get_first_child_with_component"])

return function (world: Jecs.World, player_entity: Jecs.Entity)
	local character = get_first_child_with_component(world, player_entity, ct.Character)
	
	if not character then
		warn(`NON-FATAL: No Character entity exists for {world:get(player_entity, ct.Player)}`)
		return
	end
	
	world:delete(character)
end