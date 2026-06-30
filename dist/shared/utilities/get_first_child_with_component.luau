local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

return function(world: Jecs.World, parent_entity: Jecs.Entity, component: Jecs.Entity): Jecs.Entity?
	for child_entity in world:children(parent_entity) do
		if world:has(child_entity, component) then
			return child_entity
		end
	end
end