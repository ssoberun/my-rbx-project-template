local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

type source<T> = vide.source<T>;

local VideRipple = require(ReplicatedStorage.Packages.VideRipple)

local Box = require(ReplicatedStorage.client.ui.components.Box)
local ScrollingBox = require(ReplicatedStorage.client.ui.components.ScrollingBox)
local Text = require(ReplicatedStorage.client.ui.components.Text)
local DynamicText = require(ReplicatedStorage.client.ui.components.DynamicText)
local Stroke = require(ReplicatedStorage.client.ui.components.Stroke)
local Group = require(ReplicatedStorage.client.ui.components.Group)

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local function create_context_menu (
	props: {
		world: Jecs.World;
		selected_slot: vide.source<string>;
	}
)
	
	print(`showing menu for {read(props.selected_slot)}`)
	
	return Box {
		Position = UDim2.fromScale(.25, .65);
		AnchorPoint = Vector2.new(.5,.5);
		Size = UDim2.fromScale(.3,.6);
		Transparency = 0;
		Colour = Color3.fromRGB(255,255,255);
	}
end

return create_context_menu