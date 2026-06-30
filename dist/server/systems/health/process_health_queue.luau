local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local Planck = require(ReplicatedStorage.Packages.Planck)
local PlanckRunService = require(ReplicatedStorage.Packages.PlanckRunService)
local phase = PlanckRunService.Phases.First


local name = require(ReplicatedStorage.shared.utilities.name)
local custom_phases = require(ReplicatedStorage.shared["custom_phases"])
local ct = require(ReplicatedStorage.shared.ct)

local get_first_child_with_component = require(ReplicatedStorage.shared.utilities["get_first_child_with_component"])
local queue_item = require(ReplicatedStorage.shared.utilities["queue_item"])
local types = require(ReplicatedStorage.shared.types)

local deal_damage = require(ServerScriptService.server.systems.subsystems["deal_damage"])

local function greater_than_zero (number: number)
	return number > 0
end

local function process_health_queue (world: Jecs.World)
	local cachedQueueList = world:query(ct.server.ModifyHealthQueue):with(ct.Health):cached()
	
	for id, queueList in cachedQueueList do
		if #queueList == 0 then
			continue
		end
		
		table.sort(queueList, function(a: types.ModifyHealthContext,b: types.ModifyHealthContext)
			return a.timestamp < b.timestamp
		end)
		
		for i, record in queueList do
			print(`processing health record under {name(world, id)} at {i}:`, record)
			
			local sender = record.from
			local target = record.to
			local amount = record.amount;
			local timestamp = record.timestamp;
			
			if not greater_than_zero(amount) then
				local damage_amount = math.abs(amount)
				deal_damage(world, sender, damage_amount, target)
			end
			
			-- processed
			table.clear(record)
			queueList[i] = nil;
		end
	end
end

return {
	system = process_health_queue;
	phase = custom_phases.Phases.Processing;
}