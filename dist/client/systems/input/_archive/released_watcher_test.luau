local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local cct = require(ReplicatedStorage.shared.ct).client

local custom_phases = require(ReplicatedStorage.shared["custom_phases"])

local function watcher_test (world: Jecs.World)
	local released_this_frame = world:query(cct.JustReleased)
	for input_entity, _ in released_this_frame do
		print(`An observed keybind was dropped`)
	end
end

return {
	system = watcher_test;
	phase = custom_phases.Phases.Processing
}