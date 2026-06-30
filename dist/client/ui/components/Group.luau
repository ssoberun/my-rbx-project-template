local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)
local create = vide.create

return function(
	props:{
		GroupColor: Color3;
		GroupTransparency: number?;
		BackgroundTransparency: number?;
		BackgroundColor: Color3;
		Size: UDim2;
		Position: UDim2;
		AnchorPoint: Vector2;
	}
)
	
	return create "CanvasGroup" {
		GroupColor3 = props.GroupColor;
		BackgroundColor3 = props.BackgroundColor;
		Position = props.Position;
		AnchorPoint = props.AnchorPoint;
		Size = props.Size;
		
		BackgroundTransparency = props.BackgroundTransparency;
		GroupTransparency = props.GroupTransparency;
		unpack(props);
	}
end