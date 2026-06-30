local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local runOnce = Planck.runOnce
local interval = Planck.timePassed

local ct = require(ReplicatedStorage.shared.ct)

local function npc_test (world: Jecs.World)
	local npc = world:entity()
	world:add(npc, replecs.networked)
	world:set(npc, ct.Health, 100)
	world:set(npc, ct.Name, "King Kunta")
	
	world:add(npc, pair(replecs.reliable, ct.Health))
	
	print("Replicated")
end

return {
	system = npc_test;
	runConditions = { interval(.1) }
}