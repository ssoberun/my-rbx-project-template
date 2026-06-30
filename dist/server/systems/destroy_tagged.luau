local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local PlanckRunService = require(ReplicatedStorage.Packages.PlanckRunService)
local Last = PlanckRunService.Phases.Last

local ct = require(ReplicatedStorage.shared.ct)

local function destroy_tagged (world: Jecs.World)
	local tagged_destroy = world:query(ct.DESTROY):cached()
	
	for entity_id, tag in tagged_destroy do
		world:delete(entity_id)
		print(`Deleted {entity_id}`)
	end
end

return {
	system = destroy_tagged;
	phase = Last;
}