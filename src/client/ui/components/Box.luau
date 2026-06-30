local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)

local create = vide.create

type source<T> = vide.source<T>

return function(
	props: {
		Name: string?;
		Position: UDim2?;
		AnchorPoint: Vector2?;
		Size: UDim2?;
		Rotation: number?;
		ZIndex: number?;
		LayoutOrder: number?;
		
		Visible: boolean?;
		Active: boolean?;
		
		Transparency: number?;
		Colour: Color3?;
		
		AbsoluteSize: Vector2?;
		
		OnActivated: nil | () -> (),
		OnHoverStart: nil | () -> (),
		OnHoverEnd: nil | () -> (),
		OnPressStart: nil | () -> (),
		OnPressEnd: nil | () -> (),
	}
)
	local passthroughInputs = (props.OnActivated or props.OnPressStart or props.OnPressEnd) == nil
	if passthroughInputs then
		return create "Frame" {
			Name = props.Name or "Box (passthrough inputs)",
			
			Position = props.Position,
			AnchorPoint = props.AnchorPoint,
			Size = props.Size or UDim2.fromScale(1, 1),
			Rotation = props.Rotation,
			ZIndex = props.ZIndex,
			LayoutOrder = props.LayoutOrder,
			
			Active = props.Active or false;
			Visible = props.Visible,

			BackgroundTransparency = props.Transparency or if props.Colour ~= nil then 0 else 1,
			BackgroundColor3 = props.Colour,
			
			AbsoluteSize = props.AbsoluteSize;
			MouseEnter = props.OnHoverStart;
			MouseLeave = props.OnHoverEnd;
			
			unpack(props)
		}
	else
		return create "ImageButton" {
			Position = props.Position,
			AnchorPoint = props.AnchorPoint,
			Size = props.Size or UDim2.fromScale(1, 1),
			Rotation = props.Rotation,
			ZIndex = props.ZIndex,
			LayoutOrder = props.LayoutOrder,
			
			Active = props.Active or true;
			Visible = props.Visible,
			
			BackgroundTransparency = props.Transparency or if props.Colour ~= nil then 0 else 1,
			BackgroundColor3 = props.Colour,

			AbsoluteSize = props.AbsoluteSize;
			
			Activated = props.OnActivated;
			MouseEnter = props.OnHoverStart;
			MouseLeave = function()
				if props.OnHoverEnd ~= nil then
					props.OnHoverEnd()
				end
				if props.OnPressEnd ~= nil then
					props.OnPressEnd()
				end
			end,
			MouseButton1Down = props.OnPressStart;
			MouseButton1Up = props.OnPressEnd;
			unpack(props)
		}
	end
	
end