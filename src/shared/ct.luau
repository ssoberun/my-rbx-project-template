--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local vide = require(ReplicatedStorage.Packages.vide)

type source<T> = vide.source<T>
type Entity<T> = Jecs.Entity<T>

local types = require(ReplicatedStorage.shared.types)

local ct = {
	-- if not in either server or client, they are shared
	server = {
		-- Health (server)
		ModifyHealthQueue = Jecs.component() :: Entity<{[number]: types.ModifyHealthContext}>;
		
		--PlayerEntity (server)
		PlayerConnections = Jecs.component() :: Entity<{[number]: RBXScriptConnection}>;
		
		LOAD_PLAYER_CHARACTER = Jecs.component();
	};
	client = {
		CLIENT_SINGLETONS = Jecs.component();
		CLIENT_KEYBINDS = Jecs.component();
		CLIENT_UI_LOADED = Jecs.component();
		
		-- processed markers
		Processed = Jecs.component() :: Entity<boolean>;
		
		-- input
		FrameInputQueue = Jecs.component();
		FrameInput = Jecs.component() :: Entity<string>;
		JustPressed = Jecs.component();
		Pressed_ms = Jecs.component() :: Entity<number>;
		JustReleased = Jecs.component();
		
		-- ui
		CHARACTER_REMOVE_CALLBACK = Jecs.component() :: Entity<{
			[any]: () -> ();
		}>;
		
		DynamicCharacterContext = Jecs.tag();
		DynamicCharacterUI = Jecs.tag(); -- mark any UI entities with this to destroy it
		DynamicInventorySlot = Jecs.component() :: Entity<string>; -- slot name
		ProjectOnPart = Jecs.component() :: Entity<BasePart>;
		ScreenPointSource = Jecs.component() :: Entity<vector>;
		
		PART_PROJECTION_OFFSET = Jecs.component() :: Entity<vector>;
		UI_PROJECTION_OFFSET = Jecs.component() :: Entity<source<UDim2>>;
		UPDATE_OFFSCREEN = Jecs.tag();
		
		-- deprecated
		BoxTest = Jecs.component();
		UI_SIDE_STRING = Jecs.component() :: Entity<string>;
		UI_DISPLAY_AXIS = Jecs.component() :: Entity<string>;
	};
	tools = {
		ODMG = Jecs.component();
	};
	
	-- abbreviated Jecs default components
	Name = Jecs.Name;
	
	-- Singletons
	SINGLETONS = Jecs.component();
	SINGLETON_PERMADEATH = Jecs.component() :: Entity<boolean>;
	SINGLETON_GLOBAL_RESPAWN_TIME = Jecs.component() :: Entity<number>;
	
	-- System tags
	DESTROY = Jecs.tag();
	PLAYER_LOADED = Jecs.tag();
	DATA_LOADED = Jecs.tag();
	
	-- Respawning and death
	RESPAWN_TIMER = Jecs.component() :: Entity<number>;
	PD_DEAD = Jecs.tag();
	DEAD = Jecs.tag();
	
	-- Corpse
	Corpse = Jecs.component() :: Entity<number>;
	Lootable = Jecs.component() :: Entity<{ 
		owner: Jecs.Entity?;
		loot: {};
	}>;
	
	-- PlayerEntity (shared)
	Player = Jecs.component() :: Entity<Player>;

-- CharacterEntity (shared)
	Character = Jecs.component() :: Entity<string>; -- string as identifier
	
	Health = Jecs.component() :: Entity<number>;
	Resist = Jecs.component() :: Entity<number>;
	Defense = Jecs.component() :: Entity<number>;
	Position = Jecs.component() :: Entity<Vector3>;

	UnitPart = Jecs.component() :: Entity<BasePart>;
	Model = Jecs.component() :: Entity<Model?>;
	RootPart = Jecs.component() :: Entity<BasePart?>;
	
	-- Inventory/Slots (generic)
	Equipped = Jecs.component();
	InUse = Jecs.component();
	Stored = Jecs.component();
	Slot = Jecs.component() :: Entity<string>;
	Contains = Jecs.component() :: Entity<Jecs.Entity>;
	
	-- Generic object data
	Description = Jecs.component() :: Entity<string>;
	Rarity = Jecs.component() :: Entity<string>;
	DisplayName = Jecs.component() :: Entity<string>;
	Weight = Jecs.component() :: Entity<number>;
	
	-- Resources
	Gas = Jecs.component() :: Entity<number>;
}

return ct