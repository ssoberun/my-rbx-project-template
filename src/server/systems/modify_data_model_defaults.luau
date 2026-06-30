local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase
local Startup = Phase.Startup



local function modify_data_model_defaults(world: Jecs.World)
	Players.CharacterAutoLoads = false;
end

return {
	system = modify_data_model_defaults;
	phase = Startup
}