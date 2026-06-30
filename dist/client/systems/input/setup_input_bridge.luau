local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair;
local ChildOf = Jecs.ChildOf

local Spark = require(ReplicatedStorage.Packages.Spark)
local actions = require(ReplicatedStorage.client.actions)

local Planck = require(ReplicatedStorage.Packages.Planck)
local PostStartup = Planck.Phase.PostStartup
local onEvent = Planck.onEvent

local custom_phases = require(ReplicatedStorage.shared["custom_phases"])
local collect = require(ReplicatedStorage.shared.utilities.collect)

local default_keybinds = require(ReplicatedStorage.shared.input["default_keybinds"])

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local get_player_entity = require(ReplicatedStorage.shared.utilities["get_player_entity"])

local function setup_input_bridge (world: Jecs.World)
	for action_name: string, _ in default_keybinds do
		local pressedSignal = actions:justPressedSignal(action_name)  
		pressedSignal:connect(function()
			local inputs = world:query(cct.FrameInput):cached()
			
			for input_entity in inputs do
				local frame_input_data = world:get(input_entity, cct.FrameInput)
				if frame_input_data and frame_input_data == action_name then
					warn(`NON-FATAL ERROR: action_name ({action_name}) already exists; dropping`)
					return
				end
			end
			
			local input_entity = world:entity()
			world:set(input_entity, cct.FrameInput, action_name)
			world:set(input_entity, cct.Pressed_ms, 0)
			world:add(input_entity, cct.JustPressed)
		end)
		
		local releasedSignal = actions:justReleasedSignal(action_name)  
		releasedSignal:connect(function()
			local inputs = world:query(cct.FrameInput):cached()
			local action_input_entity: Jecs.Entity
			
			for input_entity, action_name in inputs do
				local frame_input_data = world:get(input_entity, cct.FrameInput)
				if frame_input_data and frame_input_data == action_name then
					action_input_entity = input_entity
					break
				end
			end
			
			if not action_input_entity then
				warn(`NON-FATAL ERROR: Couldn't find {action_name}'s input_entity under FrameInputQueue`)
				return
			end
			
			world:add(action_input_entity, cct.JustReleased)
			world:remove(action_input_entity, cct.JustPressed)
			world:remove(action_input_entity, cct.Pressed_ms)
		end)
	end
end

return {
	system = setup_input_bridge;
	phase = PostStartup
}