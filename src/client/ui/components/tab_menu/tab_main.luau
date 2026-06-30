local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

local globalmoduledata = require(ReplicatedStorage.shared["global_module_data"])
local build = globalmoduledata.build

local LocalPlayer = Players.LocalPlayer

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local jecs_vide = require(ReplicatedStorage.Packages["jecs_vide"])
local use_query = jecs_vide.use_query;
local use_target = jecs_vide.use_target

local vide = require(ReplicatedStorage.Packages.vide)
local action = vide.action
local effect = vide.effect
local create = vide.create
local spring = vide.spring
local source = vide.source
local cleanup = vide.cleanup
local switch = vide.switch
local show = vide.show
local read = vide.read
local derive = vide.derive;

local Spark = require(ReplicatedStorage.Packages.Spark)
local actions = require(ReplicatedStorage.client.actions)
local rebind = Spark.Rebind

local Group = require(ReplicatedStorage.client.ui.components.Group)
local Box = require(ReplicatedStorage.client.ui.components.Box)
local ScrollingBox = require(ReplicatedStorage.client.ui.components.ScrollingBox)
local Text = require(ReplicatedStorage.client.ui.components.Text)
local DynamicText = require(ReplicatedStorage.client.ui.components.DynamicText)
local Stroke = require(ReplicatedStorage.client.ui.components.Stroke)

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

-- util
local monitor_keybind_id = require(ReplicatedStorage.client.utilities["monitor_keybind_id"])

-- tab cts
local tab_sidebar = require "./tab_sidebar"
local bindings_menu = require "./bindings_menu"

local function on_bind_set (world: Jecs.World, action_name: string, new_keycode: Enum.KeyCode)
	local client_keybinds = world:get(cct.CLIENT_SINGLETONS, cct.CLIENT_KEYBINDS)
	client_keybinds[action_name].KeyCode = new_keycode
	world:set(cct.CLIENT_SINGLETONS, cct.CLIENT_KEYBINDS, client_keybinds)
	
	actions:rebuildBindings()
	
	warn(`BINDS RESET; NOT REPLICATED TO SERVER; NOT SAVED`)
end

local function tab_main (
	props: {
		world: Jecs.World;
		sidebar_keybind_ids: {string};
	}
)
	local world = props.world;
	
	local sidebar_keybind_ids = props.sidebar_keybind_ids;
	local display_sidebar = source(false)
	
	local cleanup_keybind_monitor = monitor_keybind_id {
		world = world;
		keybind_ids = sidebar_keybind_ids;
		on_added = function()
			local display_value = read(display_sidebar)
			display_sidebar(not (display_value))
		end,
	}
	
	local display_binding_menu = source(false)
	
	local button_name_to_menu: {[string]: vide.source<boolean>} = {
		["keybinds"] = display_binding_menu;
	}
	
	local function hide_all_popups (except_for: string)
		for name, display_source in button_name_to_menu do
			if except_for and name == except_for then continue end
			display_source(false)
		end
	end
	
	return create "ScreenGui" {
		Name = "tab_menu_container";
		IgnoreGuiInset = true;
		
		-- pop up tabs
		show(display_sidebar, function()
			return Box {
				Name = "tab_popups";
				AnchorPoint = Vector2.new(1,.5);
				Position = UDim2.fromScale(1,.5);
				Size = UDim2.fromScale(.6,1);
				["Colour"] = Color3.fromRGB(255,255,255);
				Transparency = .99;
				
				show(display_binding_menu, function()
					return bindings_menu {
						context = world:get(cct.CLIENT_SINGLETONS, cct.CLIENT_KEYBINDS);
						["on_bind_set"] = function(action_name, new_keycode)
							on_bind_set (world, action_name, new_keycode)
						end,
					}
				end)
			};
		end);
		
		show(display_sidebar, function()
			return tab_sidebar {
				world = world;
				on_button_click = function(button_name: string)
					hide_all_popups(button_name)
					local display_source = button_name_to_menu[button_name]
					display_source(not read(display_source))
				end,
			}
		end);
		
		vide.cleanup(function()
			cleanup_keybind_monitor()
		end)
	}
end

return tab_main