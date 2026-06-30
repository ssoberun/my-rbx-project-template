local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local vide = require(ReplicatedStorage.Packages.vide)
local root = vide.root
local read = vide.read
local cleanup = vide.cleanup
local source = vide.source

local Planck = require (game:GetService('ReplicatedStorage'):WaitForChild('Packages'):WaitForChild('Planck'))
local on_event = Planck.onEvent

local ct = require (game:GetService('ReplicatedStorage'):WaitForChild('shared'):WaitForChild('ct'))
local cct = ct.client

local LocalPlayer = game.Players.LocalPlayer

-- events
local on_character_loaded, character: () -> ({Model}) = on_event(LocalPlayer.CharacterAppearanceLoaded)

-- util
local shallow_import = require (game:GetService('ReplicatedStorage'):WaitForChild('shared'):WaitForChild('utilities'):WaitForChild('shallow_import'))
local queue_item = require(ReplicatedStorage.shared.utilities["queue_item"])

-- ui cts
local ui_folder = script.Parent.subsystems.character :: Folder

local function create_character_ui (world: Jecs.World)
	local callbacks = shallow_import {
		["path"] = ui_folder;
	} :: {() -> (ScreenGui)}
	
	print(`REGENERATING CHARACTER_UI`)
	
	for _, character in character() do
		local cleanup_character_ui = 
			root(function()
			local cleanup_instances = source({}) :: () -> {ScreenGui}

			for _, app_callback in callbacks do
				local app = app_callback {
					world = world;
					character = character;
				} :: ScreenGui?
				
				if not(app:IsA("ScreenGui")) then
					warn("Expected app, got", app)
					continue
				end
				
				print(`ADDING CHARACTER UI APP: {app.Name}`)
				app.Parent = LocalPlayer.PlayerGui
				
				-- track for cleanup
				local instances = read(cleanup_instances)
				table.insert(instances, app)
				cleanup_instances(instances)
			end
			
			cleanup(function()
				print(`CLEAN UP CALLED`)
				for _, screen_gui in cleanup_instances() do
					print(`CLEANING UP {screen_gui}`)
					screen_gui:ClearAllChildren()
					screen_gui:Destroy()
				end
				
				local query = world:each(cct.DynamicCharacterUI)

				for id, tag in query do
					world:delete(id)
				end
			end)
		end)
		
		local remove_callbacks = world:get(cct.CLIENT_SINGLETONS,cct.CHARACTER_REMOVE_CALLBACK)
		local queue = queue_item(remove_callbacks, cleanup_character_ui)
		world:set(cct.CLIENT_SINGLETONS, cct.CHARACTER_REMOVE_CALLBACK, queue)
		print(`CHARACTER_REMOVE_CALLBACK QUEUE: `, queue)
	end
	
	print(`SUCCESSFULLY REGENERATED CHARACTER UI`)
end

return {
	system = create_character_ui;
	runConditions = { on_character_loaded }
}
