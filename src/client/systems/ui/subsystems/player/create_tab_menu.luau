local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])
local monitor = jecs_utils.monitor
local ref = jecs_utils.ref

local find = ref.find

local jecs_vide = require(ReplicatedStorage.Packages["jecs_vide"])
local use_query = jecs_vide.use_query;

local vide = require(ReplicatedStorage.Packages.vide)
local show = vide.show
local source = vide.source
local create = vide.create

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.PostStartup
local runOnce = Planck.runOnce;
local player_entity_replicated = require(ReplicatedStorage.client.utilities["player_entity_replicated"])

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client


local get_player_entity = require(ReplicatedStorage.shared.utilities["get_player_entity"])

-- apps
local tab_main = require(ReplicatedStorage.client.ui.components["tab_menu"]["tab_main"])

-- bindings
local bindings_map = require(ReplicatedStorage.shared.input["bindings_map"])

-- types
local types = require(ReplicatedStorage.shared.types)
type slot_data = types.slot_data
type context = types.context


local function create_test_tab_menu (
	props: {
		world: Jecs.World;
	}
): ScreenGui
	local world = props.world
	
	return tab_main {
		world = world;
		sidebar_keybind_ids = { bindings_map.SIDEBAR };
	};
end

return create_test_tab_menu