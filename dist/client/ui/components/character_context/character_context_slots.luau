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

local VideRipple = require(ReplicatedStorage.Packages.VideRipple)

local Box = require(ReplicatedStorage.client.ui.components.Box)
local ScrollingBox = require(ReplicatedStorage.client.ui.components.ScrollingBox)
local Text = require(ReplicatedStorage.client.ui.components.Text)
local DynamicText = require(ReplicatedStorage.client.ui.components.DynamicText)
local Stroke = require(ReplicatedStorage.client.ui.components.Stroke)
local Group = require(ReplicatedStorage.client.ui.components.Group)

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

-- util
local dist_to_vector2d = require(ReplicatedStorage.client.utilities["dist_to_vector2d"])
local udim2_abspos = require(ReplicatedStorage.client.utilities["udim2_abspos"])
local depth_udim_scale = require(ReplicatedStorage.client.utilities["depth_udim_scale"])
local depth_udim_offset = require(ReplicatedStorage.client.utilities["depth_udim_offset"])

local types = require(ReplicatedStorage.shared.types)
type context = types.context

return function(
	props: {
		world: Jecs.World;
		context: {Jecs.Entity};
		on_slot_selected: (slot_name: string) -> ();
	})
	
	local world = props.world
	local context = props.context
	local on_slot_selected = props.on_slot_selected;
	
	local camera = workspace.CurrentCamera;
	
	-- container_frame (must be the size of the screen)
	return Box {
		Name = "character_context_container";
		AnchorPoint = Vector2.new(.5,.5);
		Position = UDim2.fromScale(.5,.5);
		Size = UDim2.fromScale(1,1);
		
		-- for each body part, make a slot_container
		vide.values(context, function(context_entity, index) 
			local slot_query = world:children(context_entity)

			local slots = source({})
			local slot_table = {}
			for slot_entity in slot_query do
				local slot_name = world:get(slot_entity, ct.Name)
				slot_table[slot_name] = slot_entity
			end
			
			slots(slot_table)
			
			local screen_point_variable = world:get(context_entity, cct.ScreenPointSource)
			
			local container_target_pos = source(UDim2.fromScale(.5,.5))
			local container_animated_pos = spring(container_target_pos, .2, .95)
			
			-- update position
			vide.effect(function()
				local viewport_size = camera.ViewportSize
				local screen_point = screen_point_variable()
				
				local norm_x = screen_point.X / viewport_size.X
				local norm_y = screen_point.Y / viewport_size.Y
				
				container_target_pos(UDim2.fromScale(norm_x, norm_y))
			end)
			
			
			return Box {
				Name = "dynamic_tracking_container";
				Position = container_animated_pos;
				Transparency = 1;
				AnchorPoint = Vector2.new(.5,.5);
				Size = function()
					return depth_udim_scale(screen_point_variable(),.05,.5)
				end;
				
				-- the container for all slots
				--create "UIPadding" {
				--	PaddingTop = UDim.new(0,5);
				--	PaddingLeft = UDim.new(0,5);
				--	PaddingRight = UDim.new(0,5);
				--	PaddingBottom = UDim.new(0,5)
				--};
				
				Box {
					Name = `dynamic_inv_container`;
					Position = UDim2.fromScale(.5,.5);
					AnchorPoint = Vector2.new(.5,.2);
					Size = function()
						return depth_udim_scale(screen_point_variable(),.035,.35)
					end;
					Transparency = 1;
					Colour = Color3.fromRGB(27, 27, 27);

					create "UIPadding" {
						PaddingTop = UDim.new(0,5);
						PaddingLeft = UDim.new(0,5);
						PaddingRight = UDim.new(0,5);
						PaddingBottom = UDim.new(0,5)
					};

					create "UIListLayout" {
						Padding = UDim.new(0,3);
						FillDirection = Enum.FillDirection.Horizontal;
						HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly;
						VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly;
						HorizontalAlignment = Enum.HorizontalAlignment.Center;
					};
					
					-- slots themselves
					vide.values(slots, function(slot_table, slot_name)
						local target_transparency = source(-0.5)
						local animated_transparency = spring(target_transparency, .5, .9)
						
						effect(function()
							vide.untrack(function()
								target_transparency(.9)
							end)
						end)
						
						return Box {
							Name = slot_name;
							Position = UDim2.fromScale(.5,.5);
							AnchorPoint = Vector2.new(.5,.5);
							Size = function()
								return depth_udim_offset(screen_point_variable(),6,60)
							end;
							Transparency = animated_transparency;
							Colour = Color3.fromRGB(27, 27, 27);
							OnHoverStart = function()
								target_transparency(.1)
							end,
							OnHoverEnd = function() 
								target_transparency(.9)
							end,
							OnActivated = function(input_object)
								on_slot_selected(slot_name())
							end;
							
							DynamicText {
								Text = slot_name;
								TextSize = 10;
								TextColour = Color3.fromRGB(255,255,255);
								Font = Enum.Font.Code;
								Position = UDim2.fromScale(0.5,.5);
								["TextTransparency"] = animated_transparency;
							};

							Stroke {
								Name = "InfoStroke";
								Color = Color3.fromRGB(255,255,255);
								["LineJoinMode"] = Enum.LineJoinMode.Round;
								Transparency = animated_transparency;
							};
						}
					end)
				}
			}
		end)
	}
end