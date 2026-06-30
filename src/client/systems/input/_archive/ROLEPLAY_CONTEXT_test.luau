local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client
local bindings_map = require(ReplicatedStorage.shared.input["bindings_map"])

local custom_phases = require(ReplicatedStorage.shared["custom_phases"])

local function ROLEPLAY_CONTEXT_test (world: Jecs.World)
	local inputs = world:query(cct.FrameInput):cached()
	local just_pressed = world:query(cct.FrameInput):with(cct.JustPressed):cached()
	local just_released = world:query(cct.FrameInput):with(cct.JustReleased):cached()
	
	for input_entity, action_name, just_pressed in just_pressed do
		if action_name == bindings_map.ROLEPLAY_CONTEXT then
			print(`ROLEPLAY CONTEXT JUST PRESSED`)
		end
	end
	
	for input_entity, action_name in inputs do
		if action_name == bindings_map.ROLEPLAY_CONTEXT then
			print(`ROLEPLAY CONTEXT PRESSED`)
		end
	end
	
	for input_entity, action_name, just_released in just_released do
		if action_name == bindings_map.ROLEPLAY_CONTEXT then
			print(`ROLEPLAY CONTEXT JUST RELEASED`)
		end
	end
end

return {
	system = ROLEPLAY_CONTEXT_test;
	phase = custom_phases.Phases.Processing
}
