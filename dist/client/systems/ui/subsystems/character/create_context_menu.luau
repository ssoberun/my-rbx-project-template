local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair

local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])
local monitor = jecs_utils.monitor
local ref = jecs_utils.ref
local find = ref.find

local queue_item = require(ReplicatedStorage.shared.utilities["queue_item"])

local Planck = require(ReplicatedStorage.Packages.Planck)
local on_event = Planck.onEvent

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

local LocalPlayer = Players.LocalPlayer

-- apps
local roleplay_context = require(ReplicatedStorage.client.ui.apps["roleplay_context"])

-- bindings
local bindings_map = require(ReplicatedStorage.shared.input["bindings_map"])

-- types
local types = require(ReplicatedStorage.shared.types)
type slot_data = types.slot_data
type context = types.context

local function create_context_slots (
	props: {
		world: Jecs.World;
		character: Model;
	}
	
)
	
	local world = props.world
	local character = props.character;
	print(`CONTEXT RECEIVED CHARACTER: {character}`)
	
	local mock_character_context_data: context = {
		["head_context"] = {
			part_label = "head";
			project_on_part = character:FindFirstChild("Head");
			projection_offset = vector.create(0,1,0);
			slots = {
				["helmet"] = { amount = 1; };
				["eyes"] = { amount = 1; };
				["face"] = { amount = 2; };
			};
		};
		["torso_context"] = {
			part_label = "torso";
			project_on_part = character:FindFirstChild("Torso");
			projection_offset = vector.create(0,.6,0);
			slots = {
				["back"] = { amount = 2; };
				["front"] = { amount = 1; };
			};
		};
		["hip_context"] = {
			part_label = "hip";
			project_on_part = character:FindFirstChild("Torso");
			projection_offset = vector.create(0,-0.6,0);
			slots = {
				["hips"] = { amount = 1; };
			};
		};
		["left_arm_context"] = {
			part_label = "left arm";
			--projection_offset = vector.create(-.5,.6,0);
			projection_offset = vector.create(0,.6,0);
			project_on_part = character:FindFirstChild("Left Arm");
			slots = {
				["shoulder"] = { amount = 1; };
			}
		};
		["right_arm_context"] = {
			part_label = "right arm";
			--projection_offset = vector.create(.5,.6,0);
			projection_offset = vector.create(0,.6,0);
			project_on_part = character:FindFirstChild("Right Arm");
			slots = {
				["shoulder"] = { amount = 1; };
			}
		};
		["left_hand_contet"] = {
			part_label = "left hand";
			--projection_offset = vector.create(-.5,.6,0);
			projection_offset = vector.create(0,-0.6,0);
			project_on_part = character:FindFirstChild("Left Arm");
			slots = {
				["glove"] = { amount = 1; };
			}
		};
		["right_hand_context"] = {
			part_label = "right hand";
			--projection_offset = vector.create(.5,.6,0);
			projection_offset = vector.create(0,-0.6,0);
			project_on_part = character:FindFirstChild("Right Arm");
			slots = {
				["glove"] = { amount = 1; };
			}
		};
		["left_leg_context"] = {
			part_label = "left leg";
			projection_offset = vector.create(0,-0.6,0);
			project_on_part = character:FindFirstChild("Left Leg");
			slots = {
				["who_knows"] = { amount = 1; };
			}
		};
		["right_leg_context"] ={
			part_label = "right leg";
			projection_offset = vector.create(0,-0.6,0);
			project_on_part = character:FindFirstChild("Right Leg");
			slots = {
				["who_knows"] = { amount = 1; };
			}
		};
	}
	
	local function entities_from_context (context: context)
		for name, data in context do
			print(`GENERATING {name}`)
			local context_entity = world:entity()
			world:add(context_entity, cct.DynamicCharacterContext)
			world:add(context_entity, cct.DynamicCharacterUI)
			world:set(context_entity, ct.Name, name)
			world:set(context_entity, cct.ScreenPointSource, source(vector.create(0,0,0)))
			print(`SET SCREEN POINT SOURCE FOR {name}`)
			
			if not (data.project_on_part) then
				error(`FATAL ERROR: NO PART TO PROJECT UI ON FOR {name} ({context_entity})`)
			end
			world:set(context_entity, cct.ProjectOnPart, data.project_on_part)
			
			local offset = data.projection_offset
			if offset then
				world:set(context_entity, cct.PART_PROJECTION_OFFSET, vector.create(offset.x, offset.y, offset.z))
			end
			
			for name, slot in data.slots do
				print(`GENERATING SLOT {name}`)
				local slot_entity = world:entity()
				world:set(slot_entity, cct.DynamicInventorySlot, name)
				world:set(slot_entity, ct.Name, name)
				
				world:add(slot_entity, ct.Contains)
				world:add(slot_entity, pair(Jecs.ChildOf, context_entity))
			end
		end
		
		print(`FINISHED GENERATING SLOTS`)
	end
	
	print(`GENERATING ENTITIES FROM CONTEXT`)
	entities_from_context(mock_character_context_data)
	print(`FINISHED GENERATING ENTITIES FROM CONTEXT`)
	
	local query = use_query(world:query(cct.DynamicCharacterContext))
	
	local app = roleplay_context {
		character_menu = {
			["slots_context"] = query;
		};
		["world"] = world;
		["keybind_ids"] = {
			bindings_map.ROLEPLAY_CONTEXT;
		};
	}
	
	return app
end

return create_context_slots