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
local function test_input (world: Jecs.World)
	--local signal = actions:justPressedSignal("test")	
	--local iterator, collector, disconnect = onEvent(signal)
	
	--print(iterator())
	--print(collector()())
	
	if actions:pressed("test") then
		print("hi")
	end
end


return {
	system = test_input;
	phase = custom_phases.Phases.Processing
}