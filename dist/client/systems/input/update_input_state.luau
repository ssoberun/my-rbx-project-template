local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])

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

local function update_input_state (world: Jecs.World)
	actions:update(input_state)
	input_state:clear()
	
	local dt = scheduler:getDeltaTime() 
	
	local pressed_inputs = world:query(cct.Pressed_ms):cached()
	
	for input_entity, pressed_ms in pressed_inputs do
		pressed_ms = pressed_ms + (dt * 1000)
		world:set(input_entity, cct.Pressed_ms, pressed_ms)
	end
end

return {
	system = update_input_state;
	phase = custom_phases.Phases.Input
}