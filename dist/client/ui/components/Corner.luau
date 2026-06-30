local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)
local create = vide.create;

return function(
	props: {
		Name: string;
		CornerRadius: UDim;
	}
)
	
	return create "UICorner" {
		Name = props.Name or "UICorner";
		CornerRadius = props.CornerRadius or UDim.new(0,8);
		unpack(props)
	}
end