local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local get_first_child_with_component = require (script.Parent:WaitForChild('get_first_child_with_component'))

local ct = require(ReplicatedStorage.shared.ct)

return function (world: Jecs.World, entity: Jecs.Entity): Jecs.Entity?
	return get_first_child_with_component(world, entity, ct.Character)
end