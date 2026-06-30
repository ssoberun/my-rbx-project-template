local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup


local function disable_core_gui ()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
end

return {
	system = disable_core_gui;
	phase = phase;
}