local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local bulk_insert = Jecs.bulk_insert;

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)

local function setup_singletons (world: Jecs.World)
	world:set(ct.SINGLETONS, ct.SINGLETONS)
	
	-- server-owned but not replicated singletons
end

return {
	system = setup_singletons;
	phase = phase
}