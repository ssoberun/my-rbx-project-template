local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local ct = require(ReplicatedStorage.shared.ct)
local name = require(ReplicatedStorage.shared.utilities.name)

-- local events = ServerScriptService.server.events

local on_damage_dealt = require "./on_damage_dealt"


local function deal_damage(world: Jecs.World, source: Jecs.Entity, damage: number, target: Jecs.Entity)
	local def, res, health = world:get(target, ct.Defense, ct.Resist, ct.Health)

	if not def or not res then
		warn(`No Resist or Defense found for {name(world, target)}`)
		return
	end

	local damage_reduction = def * 0.01
	damage *= 1 - damage_reduction

	if health then
		local new_health = math.max(health - damage, 0)
		world:set(target, ct.Health, new_health)
		if new_health <= 0 then
			world:add(target, ct.DEAD)
		end
	end
	
	on_damage_dealt(world, source, target, damage)
end

return deal_damage