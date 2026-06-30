local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local name = require(ReplicatedStorage.shared.utilities.name)
local ct = require(ReplicatedStorage.shared.ct)
local queue_item = require(ReplicatedStorage.shared.utilities["queue_item"])
local types = require(ReplicatedStorage.shared.types)

return function (world: Jecs.World, entity: Jecs.Entity, health_record: types.ModifyHealthContext): boolean
	local health_queue = world:get(entity, ct.server.ModifyHealthQueue)
	
	if not health_queue then
		warn(`NON-FATAL: No ModifyHealthQueue for {entity} ({name(world, entity)})`)
		return false
	end
	
	local new_queue = queue_item(health_queue, health_record)
	world:set(entity, ct.server.ModifyHealthQueue, new_queue)
	
	return true
end