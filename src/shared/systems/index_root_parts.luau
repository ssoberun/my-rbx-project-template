local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local interval = Planck.timePassed

local ct = require(ReplicatedStorage.shared.ct)
local name = require(ReplicatedStorage.shared.utilities.name)

local position_spatial_hash = require(ReplicatedStorage.shared.utilities["spatial_hash"]["position_spatial_hash"])

local function index_root_parts (world: Jecs.World)
	local cached_root_parts = world:query(ct.RootPart):with(ct.Position):cached()

	for id, root_part in cached_root_parts do
		task.spawn(function()
			if root_part then
				local Position = world:get(id, ct.Position)
				position_spatial_hash.update_pos(Position, root_part)
			end
		end)
	end
end

return {
	system = index_root_parts;
	runConditions = { interval(0.5) }
}