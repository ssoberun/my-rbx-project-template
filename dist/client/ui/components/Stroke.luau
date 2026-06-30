local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)
local create = vide.create;

return function(
	props: {
		Name: string;
		ApplyStrokeMode: Enum.ApplyStrokeMode;
		BorderOffset: UDim;
		BorderStrokePosition: Enum.BorderStrokePosition;
		Color: Color3;
		LineJoinMode: Enum.LineJoinMode;
		StrokeSizingMode: Enum.StrokeSizingMode;
		Thickness: number;
		Transparency: number;
		ZIndex: number;
	}
)
	return create "UIStroke" {
		Name = props.Name or "UIStroke";
		ApplyStrokeMode = props.ApplyStrokeMode or Enum.ApplyStrokeMode.Contextual;
		BorderOffset = props.BorderOffset or UDim.new(0,0);
		BorderStrokePosition = props.BorderStrokePosition or Enum.BorderStrokePosition.Outer;
		Color = props.Color or Color3.fromRGB(0,0,0);
		LineJoinMode = props.LineJoinMode or Enum.LineJoinMode.Round;
		StrokeSizingMode = props.StrokeSizingMode or Enum.StrokeSizingMode.FixedSize;
		Thickness = props.Thickness or 1;
		Transparency = props.Transparency or 0;
		ZIndex = props.ZIndex or 1;
		unpack(props)
	}
end