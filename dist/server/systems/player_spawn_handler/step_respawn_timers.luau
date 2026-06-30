local Jecs = require(game:GetService('ReplicatedStorage'):WaitForChild('Packages'):WaitForChild('Jecs'))
local scheduler = require(game:GetService('ReplicatedStorage'):WaitForChild('shared'):WaitForChild('scheduler'))
local PlanckRunService = require(game:GetService('ReplicatedStorage'):WaitForChild('Packages'):WaitForChild('PlanckRunService'))
local phase = PlanckRunService.Phases.First

local ct = require(game:GetService('ReplicatedStorage'):WaitForChild('shared'):WaitForChild('ct'))

local function step_respawn_timers(world: Jecs.World)
	local respawn_timers = world:query(ct.RESPAWN_TIMER):cached()
	local dt = scheduler:getDeltaTime()

	for entity, respawn_time_ms in respawn_timers do
		respawn_time_ms = respawn_time_ms - (dt * 1000)

		if respawn_time_ms <= 0 then
			world:set(entity, ct.RESPAWN_TIMER, 0)
			world:remove(entity, ct.RESPAWN_TIMER)
			local controller_entity = world:parent(entity)
			local PLAYER = world:get(controller_entity, ct.Player)
			if PLAYER then
				world:add(controller_entity, ct.server.LOAD_PLAYER_CHARACTER)
			end
			continue
		end

		world:set(entity, ct.RESPAWN_TIMER, respawn_time_ms)
	end
end

return {
	system = step_respawn_timers,
	phase = phase,
}
