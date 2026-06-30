local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

return function (world: Jecs.World, entity: Jecs.Entity): string
	return world:get(entity, Jecs.Name) :: string
end