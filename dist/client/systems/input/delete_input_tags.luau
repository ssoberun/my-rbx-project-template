local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Spark = require(ReplicatedStorage.Packages.Spark)

local Planck = require(ReplicatedStorage.Packages.Planck)
local scheduler = require(ReplicatedStorage.shared.scheduler)
local Startup = Planck.Phase.Startup
local onEvent = Planck.onEvent

local custom_phases = require(ReplicatedStorage.shared["custom_phases"])

local collect = require(ReplicatedStorage.shared.utilities.collect)

local actions = require(ReplicatedStorage.client.actions)
local input_state = require(ReplicatedStorage.client["input_state"])

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local function delete_input_tags (world: Jecs.World)
	local released_inputs = world:query(cct.JustReleased):cached()
	local just_pressed_inputs = world:query(cct.JustPressed):cached()

	local dt = scheduler:getDeltaTime() 

	for input_entity, _ in released_inputs do
		world:delete(input_entity)
	end
	
	for input_entity, _ in just_pressed_inputs do
		world:remove(input_entity, cct.JustPressed)
	end
end

return {
	system = delete_input_tags;
	phase = custom_phases.Phases.QueueResolution
}