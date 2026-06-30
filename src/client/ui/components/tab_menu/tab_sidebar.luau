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

-- popups
local bindings_menu = require(ReplicatedStorage.client.ui.components["tab_menu"]["bindings_menu"])

local function tab_sidebar (
	props: {
		world: Jecs.World;
		on_button_click: (button_name: string) -> ();
	}
)
	local buttons = {
		[1] = {
			label = "player-data";
		};
		[2] = {
			label = "settings";
		};
		[3] = {
			label = "keybinds";
		}
	}
	
	
	local on_button_click = props.on_button_click;
	local buttons_source = source(buttons)
	local manipulate_tab_position = source(UDim2.fromScale(-.5,.5))
	local main_tab_position = spring(manipulate_tab_position, .5, .9)
	
	effect(function()
		vide.untrack(function()
			manipulate_tab_position(UDim2.fromScale(0,.5))
		end)
	end)
	
	return Box {
		Name = "tab_menu_container";
		Transparency = 1;
		Position = UDim2.fromScale(.5,.5);
		AnchorPoint = Vector2.new(.5,.5);
		
		Group {
			Size = UDim2.fromScale(1,1);
			Position = UDim2.fromScale(.5,.5);
			AnchorPoint = Vector2.new(.5,.5);
			BackgroundTransparency = 1;
			GroupTransparency = 0;
			
			-- main tab
			
			Box {
				Name = "tab_main";
				Transparency = .02;
				Size = UDim2.new(0, 450, 1,0);
				AnchorPoint = Vector2.new(0,.5);
				Position = main_tab_position;
				Colour = Color3.fromRGB(27,27,27);

				create "UIPadding" {
					PaddingTop = UDim.new(0,10);
					PaddingLeft = UDim.new(0,10);
					PaddingRight = UDim.new(0,10);
					PaddingBottom = UDim.new(0,5)
				};
				
				--create "UIListLayout" {
				--	Padding = UDim.new(0,30);
				--	FillDirection = Enum.FillDirection.Vertical;
				--};
				
			
				create "UIGradient" {
					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(.95, 0),
						NumberSequenceKeypoint.new(1, 1)
					});
					
				};
				-- TITLE 
				Box {
					Name = "tab_title";
					Size = UDim2.fromScale(1, .18);
					Colour = Color3.fromRGB(27,27,27);
					Transparency = 1;
					
					DynamicText {
						Text = ">";
						TextSize = 20;
						TextColour = Color3.fromRGB(255,255,255);
						Font = Enum.Font.RobotoMono;
						Position = UDim2.fromScale(0.1,.5);
						["TextTransparency"] = 0;
					};

					DynamicText {
						Text = "PROJECT_MEMORANDUM";
						TextSize = 30;
						TextColour = Color3.fromRGB(255,255,255);
						Font = Enum.Font.RobotoMono;
						Position = UDim2.fromScale(0.5,.5);
						["TextTransparency"] = 0;
					};
					
					DynamicText {
						Text = `pre-pre-alpha`;
						TextSize = 20;
						TextColour = Color3.fromRGB(255,255,255);
						Font = Enum.Font.RobotoMono;
						Position = UDim2.fromScale(.5,.78);
						["TextTransparency"] = 0;
					};
					DynamicText {
						Text = function()
							return `module build: {tostring(build)}`
						end;
						TextSize = 15;
						TextColour = Color3.fromRGB(255,255,255);
						Font = Enum.Font.RobotoMono;
						Position = UDim2.fromScale(.5,1);
						["TextTransparency"] = 0;
					};
				};
				
				Box {
					Name = "tab_title";
					Position = UDim2.fromScale(.2,.73);
					Size = UDim2.fromScale(.5, .5);
					AnchorPoint = Vector2.new(0.5,.5);
					Colour = Color3.fromRGB(27,27,27);
					Transparency = 1;
					
					DynamicText {
						Text = function()
							return `all UI is not final`
						end;
						TextSize = 15;
						TextColour = Color3.fromRGB(255,255,255);
						Font = Enum.Font.RobotoMono;
						Position = UDim2.fromScale(.5,1);
						["TextTransparency"] = 0;
					};
				};
				
				-- buttons
				Box {
					Name = "button_container";
					Size = UDim2.fromScale(.56, .5);
					Colour = Color3.fromRGB(15, 15, 15);
					Position = UDim2.fromScale(.5,.5);
					AnchorPoint = Vector2.new(0.5,.5);
					Transparency = .1;

					Stroke {
						Name = "InfoStroke";
						Color = Color3.fromRGB(255,255,255);
						["LineJoinMode"] = Enum.LineJoinMode.Round;
						Transparency = 0.5;
					};

					create "UIListLayout" {
						Padding = UDim.new(0,10);
						FillDirection = Enum.FillDirection.Vertical;
						HorizontalAlignment = Enum.HorizontalAlignment.Center;
					};

					create "UIPadding" {
						PaddingTop = UDim.new(0,5);
						PaddingLeft = UDim.new(0,5);
						PaddingRight = UDim.new(0,5);
						PaddingBottom = UDim.new(0,5)
					};
					
					vide.indexes(buttons_source, function(data, index)
						local button_name = data().label
						
						return Box {
							Name = `{index}_tab_button`;
							Size = UDim2.new(1, 0, .1, 0);
							Colour = Color3.fromRGB(17, 17, 17);
							Position = UDim2.fromScale(.5,.5);
							AnchorPoint = Vector2.new(.5,.5);
							Transparency = 1;

							Stroke {
								Name = "InfoStroke";
								Color = Color3.fromRGB(255,255,255);
								["LineJoinMode"] = Enum.LineJoinMode.Round;
								Transparency = 0.5;
							};

							create "UIPadding" {
								PaddingTop = UDim.new(0,2);
								PaddingLeft = UDim.new(0,2);
								PaddingRight = UDim.new(0,2);
								PaddingBottom = UDim.new(0,2)
							};

							Box {
								Name = "tab_button";
								Size = UDim2.fromScale(1, 1);
								Colour = Color3.fromRGB(36, 36, 36);
								Position = UDim2.fromScale(.5,.5);
								AnchorPoint = Vector2.new(.5,.5);
								
								OnActivated = function()
									if not (on_button_click) then
										warn(`No Button Press event set for sidebar buttons!`)
										return
									end
									
									on_button_click(button_name)
								end,
								
								DynamicText {
									Text = button_name;
									TextSize = 15;
									TextColour = Color3.fromRGB(255,255,255);
									Font = Enum.Font.Code;
									Position = UDim2.fromScale(0.5,.5);
									["TextTransparency"] = 0;
								};
							};
						};
					end)
				};
			}
		}
	}
end

return tab_sidebar