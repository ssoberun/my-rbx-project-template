local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.PreStartup

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local function client_singletons (world: Jecs.World)
	world:set(cct.CLIENT_SINGLETONS, cct.CHARACTER_REMOVE_CALLBACK, {})
end

return {
	system = client_singletons;
	phase = phase;
}