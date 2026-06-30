local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local runOnce = Planck.runOnce
local interval = Planck.timePassed

local ct = require(ReplicatedStorage.shared.ct)

local add_health_record_helper = require(ServerScriptService.server["server_utils"]["add_health_record_helper"])

--local deal_damage = require(ServerScriptService.server.systems.subsystems["deal_damage

local function deal_damage_test (world: Jecs.World)
	--local cached_health = world:query(ct.Health):with(ct.Character):cached()
	--local npc = world:entity()
	--world:set(npc, replecs.networked)
	
	--for entity, health in cached_health do
	--	deal_damage(world, npc, 100, entity)
	--end
	
	local cached_health = world:query(ct.server.ModifyHealthQueue):with(ct.Health):cached()
	local npc = world:entity()
	world:set(npc, Jecs.Name, "bob")
	
	for entity, health in cached_health do
		add_health_record_helper(world, entity, {
			["position"] = Vector3.zero;
			["amount"] = -50;
			["timestamp"] = workspace:GetServerTimeNow();
			["to"] = entity;
			["from"] = npc;
			["damageType"] = "whatever";
		})
		add_health_record_helper(world, entity, {
			["position"] = Vector3.zero;
			["amount"] = -30;
			["timestamp"] = workspace:GetServerTimeNow() + 1;
			["to"] = entity;
			["from"] = npc;
			["damageType"] = "whatever";
		})
		add_health_record_helper(world, entity, {
			["position"] = Vector3.zero;
			["amount"] = -25;
			["timestamp"] = workspace:GetServerTimeNow() + 2;
			["to"] = entity;
			["from"] = npc;
			["damageType"] = "whatever";
		})
	end
end

return {
	system = deal_damage_test;
	runConditions = { interval(2) }
}