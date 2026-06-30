--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Spark = require(ReplicatedStorage.Packages.Spark)
local Actions = Spark.Actions

local default_keybinds = require(ReplicatedStorage.shared.input["default_keybinds"])

--> generate actions from keyboard_bindings
local generated_actions = {}
for action_name, _ in default_keybinds do
	table.insert(generated_actions, action_name)
end

--> create actions object (singleton)
local actions = Actions.new(generated_actions)

--> bind actions
actions:setRebuildBindings(function(bindings)
	for action_name, action_data in default_keybinds do
		local keycode = action_data.KeyCode
		bindings:bind(action_name, keycode)
	end
end)

return actions