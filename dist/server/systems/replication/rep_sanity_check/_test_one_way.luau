local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local interval = Planck.timePassed;

local ct = require(ReplicatedStorage.shared.ct)

local function test_one_way (world: Jecs.World)
	local test_entity = world:entity()
	world:add(test_entity, replecs.networked)
	world:set(test_entity, Jecs.Name, "Pierre")
	world:add(test_entity, pair(replecs.reliable, Jecs.Name))
	
	task.delay(1, function()
		world:remove(test_entity, replecs.networked)
	end)
end

return {
	system = test_one_way;
	runConditions = { interval(2) }
}