local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])
local jecs_assemblies = require(ReplicatedStorage.Packages["jecs_assemblies"])
local jecs_vide = require(ReplicatedStorage.Packages["jecs_vide"])
local jecs_gizmo = require(ReplicatedStorage.Packages["jecs_gizmo"])

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup

local function set_jecs_utils_world (world: Jecs.World)
	jecs_utils.world(world)
	jecs_assemblies.world(world)
	jecs_gizmo.world(world)
	jecs_vide.world(world)
end

return {
	system = set_jecs_utils_world;
	phase = phase;
}