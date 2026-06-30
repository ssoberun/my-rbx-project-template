local Jecs = require "@pkg/Jecs"

local function NOOP()
	
end

return function(world, entity: Jecs.Entity, relation: Jecs.Entity)
	local r = Jecs.entity_index_try_get(world.entity_index, entity)
	if not r or not r.archetype then
		return NOOP
	end
	local archetype = r.archetype
	local archetype_id = archetype.id
	local idr = world.component_index[Jecs.pair(relation, Jecs.w)]
	if not idr then return end
	local count = idr.counts[archetype_id] 
	if not count then
		return NOOP
	end
	local types = archetype.types
	local tr = idr.records[archetype_id]
	local i = 0
	return function()
		if i == count then
			return nil
		end

		local index = i + tr
		i+=1
		return Jecs.pair_second(world, types[index])
	end
end