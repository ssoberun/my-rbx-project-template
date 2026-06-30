local ReplicatedStorage = game:GetService("ReplicatedStorage")


local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase

local timePassed = Planck.timePassed;

local PlanckRunService = require(ReplicatedStorage.Packages.PlanckRunService)
local RunServicePhases = PlanckRunService.Phases
local PreRender = RunServicePhases.PreRender

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair;

local Wildcard = Jecs.Wildcard;

local ct = require "../ct"

local Name = ct.Name
local Eats = ct.Eats

local function systemB(world: Jecs.World)
	for id, amount in world:query(pair(Eats, Wildcard)) do
		local food = world:target(id, Eats)
		local foodName = world:get(food, Name)
		local entityName = world:get(id, Name)
		
		print(string.format("%s eats %d %s", entityName, amount, foodName))
	end
end

return {
	system = systemB;
	phase = PreRender;
	runConditions = { timePassed(1) }
}