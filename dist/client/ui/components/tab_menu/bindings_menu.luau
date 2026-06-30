local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

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

local Box = require(ReplicatedStorage.client.ui.components.Box)
local ScrollingBox = require(ReplicatedStorage.client.ui.components.ScrollingBox)
local Text = require(ReplicatedStorage.client.ui.components.Text)
local DynamicText = require(ReplicatedStorage.client.ui.components.DynamicText)
local Stroke = require(ReplicatedStorage.client.ui.components.Stroke)

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

-- util

local types = require(ReplicatedStorage.shared.types)

return function(
	props: {
		world: Jecs.World;
		context: {
			[string]: {
				Enum.KeyCode
			};
		};
		on_bind_set: (action_name: string, new_bind: Enum.KeyCode) -> ();
	})
	
	local world = props.world;
	local context_table = props.context;
	local on_bind_set = props.on_bind_set;
	local Mouse = LocalPlayer:GetMouse()
	
	local shown_keybinds = source(context_table)
	local enable_buttons = source(true)
	
	local function calculateSize(String)
		local Lines = math.ceil(string.len(String) / 30) -- / 30 should be replaced with the max characters on your line.
		return UDim2.fromOffset(210, Lines * 14) -- * 14 should be replaced with however big you want a line to be
	end
	
	return Box {
		AnchorPoint = Vector2.new(.5,.5);
		Position = UDim2.fromScale(.5,.5);
		Size = UDim2.fromScale(.7, .6);
		Transparency = .05;
		Colour = Color3.fromRGB(27, 27, 27);
		
		create "UIListLayout" {
			Padding = UDim.new(0,10);
			FillDirection = Enum.FillDirection.Vertical;
			HorizontalAlignment = Enum.HorizontalAlignment.Center;
		};
		
		create "UIPadding" {
			PaddingTop = UDim.new(0,10);
			PaddingLeft = UDim.new(0,10);
			PaddingRight = UDim.new(0,10);
			PaddingBottom = UDim.new(0,20)
		};
		
		DynamicText {
			Text = "rebind menu";
			AnchorPoint = Vector2.new(0,.5);
			TextSize = 14;
			TextColour = Color3.fromRGB(255,255,255);
			Font = Enum.Font.Code;
			Position = UDim2.fromScale(0,.5);
			["BackgroundTransparency"] = 1;
			["TextTransparency"] = 0;
			["AlignX"] = Enum.TextXAlignment.Center;
		};
		
		create "ScrollingFrame" {
			Name = "keybind_scroll_frame";
			AnchorPoint = Vector2.new(.5,.5);
			Position = UDim2.fromScale(.5,.5);
			Size = UDim2.fromScale(1,1);
			BackgroundColor3 = Color3.fromRGB(27, 27, 27);
			
			create "UIPadding" {
				PaddingTop = UDim.new(0,10);
				PaddingLeft = UDim.new(0,10);
				PaddingRight = UDim.new(0,10);
				PaddingBottom = UDim.new(0,10)
			};

			create "UIListLayout" {
				Padding = UDim.new(0,5);
				FillDirection = Enum.FillDirection.Vertical;
				HorizontalAlignment = Enum.HorizontalAlignment.Center;
			};

			Stroke {
				Name = "WhiteOutline";
				Color = Color3.fromRGB(255,255,255);
				["LineJoinMode"] = Enum.LineJoinMode.Round;
				Transparency = 0;
			};
			
			vide.indexes(shown_keybinds, function(action_data, action_name) 
				local show_mouse_info = source(false)
				local binder_text = source(action_data().KeyCode.Name)
				
				return Box {
					AnchorPoint = Vector2.new(.5,.5);
					Position = UDim2.fromScale(.5,.5);
					Size = UDim2.fromScale(1,.05);
					Transparency = .2;
					Colour = Color3.fromRGB(39, 39, 39);
					OnHoverStart = function()
						show_mouse_info(true)
					end,
					OnHoverEnd = function()
						show_mouse_info(false)
					end,
					create "UIPadding" {
						PaddingLeft = UDim.new(0,10);
						PaddingRight = UDim.new(0,10);
					};

					DynamicText {
						Text = action_name;
						AnchorPoint = Vector2.new(0,.5);
						TextSize = 14;
						TextColour = Color3.fromRGB(255,255,255);
						Font = Enum.Font.Code;
						Position = UDim2.fromScale(0,.5);
						["BackgroundTransparency"] = .2;
						["TextTransparency"] = 0;
						["AlignX"] = Enum.TextXAlignment.Left;
					};

					-- bind
					Box {
						AnchorPoint = Vector2.new(1,.5);
						Position = UDim2.fromScale(1,.5);
						Size = UDim2.fromScale(.5,.5);
						Transparency = 0;
						Colour = Color3.fromRGB(236, 236, 236);
						Active = enable_buttons;
						OnActivated = function()
							enable_buttons(false)
							binder_text("Press any key...")
							
							local newInput =
								rebind.new():withDevices({ "Keyboard", "Mouse" }):withoutInputs({ Enum.KeyCode.Escape }):start():expect()
							
							if newInput ~= Enum.KeyCode.Backspace then
								on_bind_set(action_name, newInput)
							end
							
							binder_text(newInput.Name)
							enable_buttons(true)
						end,
						
						DynamicText {
							Text = binder_text;
							AnchorPoint = Vector2.new(0,.5);
							TextSize = 14;
							TextColour = Color3.fromRGB(27, 27, 27);
							Font = Enum.Font.Code;
							Position = UDim2.fromScale(.5,.5);
							["BackgroundTransparency"] = .2;
							["TextTransparency"] = 0;
						};
					};
					
				}
			end)
		};
	}
end