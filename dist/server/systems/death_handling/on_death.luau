local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local PlanckRunService = require(ReplicatedStorage.Packages.PlanckRunService)
local Last = PlanckRunService.Phases.Last
local onEvent = Planck.onEvent


local ct = require(ReplicatedStorage.shared.ct)
local name = require(ReplicatedStorage.shared.utilities.name)
local add_respawn_timer = require(ServerScriptService.server["server_utils"]["add_respawn_timer"])

local death_subsystems = script.Parent.subsystems
local spawn_corpse = require(death_subsystems.spawn_corpse)

local function on_death (world: Jecs.World)
	local deadQuery = world:query(ct.DEAD):cached()
	local server_time = workspace:GetServerTimeNow()
	
	for dead_entity, dead_ct in deadQuery do
		print(`{dead_entity} has died`)
		local controller = world:parent(dead_entity)
		local PLAYER = world:get(controller, ct.Player)
		
		if world:get(ct.SINGLETONS, ct.SINGLETON_PERMADEATH) == true then
			return
		end
		
		world:remove(dead_entity, ct.DEAD)
		world:remove(dead_entity, ct.server.ModifyHealthQueue)
		
		local respawn_time_ms = world:get(ct.SINGLETONS, ct.SINGLETON_GLOBAL_RESPAWN_TIME)
		
		if respawn_time_ms <= 0 then
			continue
		end
		
		
		if PLAYER then
			add_respawn_timer(world, dead_entity, nil, {
				[PLAYER] = true;
			})
		end
		
		--spawn_corpse(world, entity)
		--world:add(dead_entity, ct.DESTROY)
	end
end

return {
	system = on_death;
	phase = Last;
}