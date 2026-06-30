local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Spark = require(ReplicatedStorage.Packages.Spark)
local actions = require(ReplicatedStorage.client.actions)

local Planck = require(ReplicatedStorage.Packages.Planck)
local Startup = Planck.Phase.Startup
local onEvent = Planck.onEvent

local custom_phases = require(ReplicatedStorage.shared["custom_phases"])

local collect = require(ReplicatedStorage.shared.utilities.collect)
local input_state = require(ReplicatedStorage.client["input_state"])

local input_began = collect(UserInputService.InputBegan)
local input_ended = collect(UserInputService.InputEnded)

local function marcus_input_method (world: Jecs.World)
	for _, input: InputObject in input_began do
		if not(input.UserInputType == Enum.UserInputType.Keyboard) then
			print(`started pressing {input.UserInputType}`)
			continue
		end
		
		print(`started pressing {input.KeyCode}`)
	end
	
	for _, input: InputObject in input_ended do
		if not(input.UserInputType == Enum.UserInputType.Keyboard) then
			print(`stopped pressing {input.UserInputType}`)
			continue
		end

		print(`stopped pressing {input.KeyCode}`)
	end
end


return {
	system = marcus_input_method;
	phase = custom_phases.Phases.Input
}