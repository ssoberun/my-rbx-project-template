local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)

local monitor_keybind_id = require(ReplicatedStorage.client.utilities["monitor_keybind_id"])


local vide = require(ReplicatedStorage.Packages.vide)
local create = vide.create
local source = vide.source;
local show = vide.show;
local read = vide.read;
local cleanup = vide.cleanup;

-- jecs components
local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

-- ui components
local character_context_slots = require(ReplicatedStorage.client.ui.components["character_context"]["character_context_slots"])
local character_context_menu = require(ReplicatedStorage.client.ui.components["character_context"]["character_context_menu"])

local bindings_map = require(ReplicatedStorage.shared.input["bindings_map"])

local function roleplay_context(
	props: {
		world: Jecs.World;
		keybind_ids: {string};
		character_menu: {
			slots_context: {Jecs.Entity};
		};
	}
)
	local keybind_ids = props.keybind_ids;
	local character_menu = props.character_menu
	local world = props.world
	
	local should_display_slots = source(false)
	local should_display_slot_menu = source(false)
	
	local last_slot = "head"
	local selected_slot = source(last_slot) :: vide.source<string>;
	
	local cleanup_monitor = monitor_keybind_id {
		world = world;
		keybind_ids = keybind_ids;
		on_added = function()
			local display_value = read(should_display_slots)
			should_display_slots(not (display_value))
			should_display_slot_menu(not (display_value))
			
			if read(selected_slot) == nil then
				selected_slot(last_slot)
			end
		end,
	}
	
	return create "ScreenGui" {
		Name = "roleplay_context_ui";
		IgnoreGuiInset = true;
		
		show(should_display_slots, function()
			return character_context_slots {
				context = character_menu.slots_context;
				world = world;
				on_slot_selected = function(slot_name: string)
					print(`{slot_name} was selected`)
					
					if slot_name == read(selected_slot) then
						should_display_slot_menu(false)
						selected_slot(nil)
						last_slot = slot_name
						return
					end
					
					should_display_slot_menu(true)
					selected_slot(slot_name)
				end,
			}		
end);
		
		show(should_display_slot_menu, function()
			return character_context_menu {
				["world"] = world;
				["selected_slot"] = selected_slot
			}
		end);
		
		cleanup(function()
			cleanup_monitor()
		end)
	}
end

return roleplay_context