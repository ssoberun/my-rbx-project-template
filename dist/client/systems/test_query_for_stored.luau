local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local targets = require(ReplicatedStorage.shared.utilities.targets)
local ct = require(ReplicatedStorage.shared.ct)

local function test_query_for_stored (world: Jecs.World)
	local stored_query = world:query(ct.Character):with(pair(ct.Stored, Jecs.Wildcard)):without(ct.client.Processed):cached()
	
	for entity, char in stored_query do
		local stored = targets(world, entity, ct.Stored)
		
		for target in stored do
			if world:get(target, ct.client.Processed) then
				continue
			end
			
			if world:has(target, ct.tools.ODMG) then
				print(`I have stored ODMG: {target}`)
				print(`It equips to the slot: {world:get(target, ct.Slot)}`)
				world:set(target, ct.client.Processed, true)
			end
		end
	end
	
	--local equipped_query = world:query(ct.Character):with(pair(ct.Equipped, Jecs.Wildcard)):without(ct.client.Processed):cached()

	--for entity, char in equipped_query do
	--	local equipped = targets(world, entity, ct.Equipped)

	--	for target in equipped do
	--		if world:get(target, ct.client.Processed) then
	--			continue
	--		end

	--		if world:has(target, ct.tools.ODMG) then
	--			print(`I have equipped ODMG: {target}`)
	--			print(`It wants to equip to the slot: {world:get(target, ct.Slot)}`)
	--			world:set(target, ct.client.Processed, true)
	--		end
	--	end
	--end
end

return {
	system = test_query_for_stored;
}