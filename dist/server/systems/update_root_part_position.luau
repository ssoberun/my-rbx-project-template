local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local interval = Planck.timePassed

local ct = require(ReplicatedStorage.shared.ct)
local name = require(ReplicatedStorage.shared.utilities.name)

local function update_root_part_position (world: Jecs.World)
	local cached_root_parts = world:query(ct.RootPart):with(ct.Position):cached()
	
	for id, root_part in cached_root_parts do
		if root_part then
			world:set(id, ct.Position, root_part.Position)
		end
	end
end

return {
	system = update_root_part_position;
	runConditions = { interval(0.1) }
}