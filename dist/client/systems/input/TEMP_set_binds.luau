local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.PreStartup

local default_keybinds = require(ReplicatedStorage.shared.input["default_keybinds"])

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local function TEMP_set_binds (world: Jecs.World)
	world:set(cct.CLIENT_SINGLETONS, cct.CLIENT_KEYBINDS, default_keybinds)
	warn(`SET TEMPORARY KEYBINDS IN cct.CLIENT_KEYBINDS, \nPLEASE REPLICATE!`)
end

return {
	system = TEMP_set_binds;
	phase = phase;
}