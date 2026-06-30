--!strict

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

		Transparency: number?;
		Color: Color3?;

		AbsoluteSize: Vector2?;
		CanvasSize: UDim2?;
		CanvasPosition: Vector2?;
		ScrollingDirection: Enum.ScrollingDirection?;
		ScrollBarThickness: number?;
		ScrollingEnabled: boolean?;
		AutomaticCanvasSize: Enum.AutomaticSize?;
		VerticalScrollBarInset: Enum.ScrollBarInset?;
		HorizontalScrollBarInset: Enum.ScrollBarInset?;
		ElasticBehavior: Enum.ElasticBehavior?;
		TopImage: string?;
		BottomImage: string?;
		MidImage: string?;
		VerticalScrollBar: Instance?;
		HorizontalScrollBar: Instance?;

		OnHoverStart: (mouse: Mouse) -> ()?;
		OnHoverEnd: (mouse: Mouse) -> ()?;
	}
)
	
	return create "ScrollingFrame" {
		Name = props.Name or "ScrollingFrame",

		Position = props.Position or UDim2.fromScale(0, 0),
		AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
		Size = props.Size or UDim2.fromScale(1, 1),
		Rotation = props.Rotation or 0,
		ZIndex = props.ZIndex or 1,
		LayoutOrder = props.LayoutOrder or 0,
		Visible = if props.Visible ~= nil then props.Visible else true,

		BackgroundTransparency = props.Transparency or if props.Color ~= nil then 0 else 1,
		BackgroundColor3 = props.Color or Color3.fromRGB(255, 255, 255),
		
		CanvasSize = props.CanvasSize or UDim2.fromScale(1, 1),
		CanvasPosition = props.CanvasPosition or Vector2.new(0, 0),
		ScrollingDirection = props.ScrollingDirection or Enum.ScrollingDirection.XY,
		ScrollBarThickness = props.ScrollBarThickness or 12,
		ScrollingEnabled = if props.ScrollingEnabled ~= nil then props.ScrollingEnabled else true,
		AutomaticCanvasSize = props.AutomaticCanvasSize or Enum.AutomaticSize.None,
		VerticalScrollBarInset = props.VerticalScrollBarInset or Enum.ScrollBarInset.None,
		HorizontalScrollBarInset = props.HorizontalScrollBarInset or Enum.ScrollBarInset.None,
		ElasticBehavior = props.ElasticBehavior or Enum.ElasticBehavior.WhenScrollable,
		TopImage = props.TopImage or "rbxasset://textures/Scrollbar/Top.png",
		BottomImage = props.BottomImage or "rbxasset://textures/Scrollbar/Bottom.png",
		MidImage = props.MidImage or "rbxasset://textures/Scrollbar/Middle.png",

		MouseEnter = props.OnHoverStart,
		MouseLeave = props.OnHoverEnd,

		unpack(props)
	}

end