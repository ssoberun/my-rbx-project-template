local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)

local position_spatial_hash = require(ReplicatedStorage.shared.utilities["spatial_hash"]["position_spatial_hash"])

local function spatial_hash_hooks (world: Jecs.World)
	world:set(ct.RootPart, Jecs.OnRemove, function(entity, root_part)
		local RootPart = world:get(entity, root_part)
		position_spatial_hash.remove(RootPart)
		print(`ROOT PART REMOVED`)
	end)
end


return {
	system = spatial_hash_hooks;
	phase = phase;
}