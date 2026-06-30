local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local PlanckRunService = require(ReplicatedStorage.Packages.PlanckRunService)
local phase = PlanckRunService.Phases.First
local on_event = Planck.onEvent

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local LocalPlayer = Players.LocalPlayer

local character_removing, characters_removed: () -> {Model} = on_event(LocalPlayer.CharacterRemoving)

local function on_character_removing (world: Jecs.World)
	local CHARACTER_REMOVING_CALLBACKS = world:get(cct.CLIENT_SINGLETONS, cct.CHARACTER_REMOVE_CALLBACK)
	
	for i, character in characters_removed() do
		for _, callback in CHARACTER_REMOVING_CALLBACKS do
			print(`CALLING CLEANUP FUNCTION FROM ON_CHARACTER_REMOVING`)
			callback()
		end
	end
	
	world:set(cct.CLIENT_SINGLETONS, cct.CHARACTER_REMOVE_CALLBACK, {})
end

return {
	system = on_character_removing;
	phase = phase;
	runConditions = { character_removing } 
}