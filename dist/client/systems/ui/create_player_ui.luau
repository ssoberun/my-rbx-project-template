local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local vide = require(ReplicatedStorage.Packages.vide)
local root = vide.root

local Planck = require(ReplicatedStorage.Packages.Planck)
local on_event = Planck.onEvent
local phase = Planck.Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local LocalPlayer = game.Players.LocalPlayer

-- utils
local shallow_import = require(ReplicatedStorage.shared.utilities["shallow_import"])

-- ui cts
local ui_folder = script.Parent.subsystems.player

-- this is A SYSTEM
local function create_player_ui (world: Jecs.World)
	
	local callbacks = shallow_import {
		["path"] = ui_folder;
	} :: {() -> (ScreenGui)}
	
	print(callbacks)
	
	root(function()
		for _, app_callback in callbacks do
			local app = app_callback {
				world = world;
			} :: ScreenGui?
			
			if not(app:IsA("ScreenGui")) then
				warn("Expected app, got", app)
				continue
			end
			
			print(app)
			app.Parent = LocalPlayer.PlayerGui
		end
	end)
	
	
end

return {
	system = create_player_ui;
	phase = phase;
}