local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)
local TextService = game:GetService("TextService")

local create = vide.create
local source = vide.source
local derive = vide.derive

local FONT_SCALES = {
	[Enum.Font.Cartoon] = 1.209,
	[Enum.Font.LuckiestGuy] = 1.000;
	[Enum.Font.Arial] = 1.000;
	[Enum.Font.Code] = 1.000;
}

return function(
	props: {
		Name: string?,

		Position: UDim2?,
		AnchorPoint: Vector2?,
		Size: UDim2?,
		AutomaticSize: Enum.AutomaticSize;
		ZIndex: number?,
		LayoutOrder: number?,
		Visible: boolean?,
		BackgroundTransparency: number;
		
		Text: string,
		TextColour: Color3?,
		TextSize: number,
		TextScaled: boolean;
		TextTransparency: number;
		
		Font: Enum.Font,
		WrapBounds: Vector2?,
		AlignX: Enum.TextXAlignment?,
		AlignY: Enum.TextYAlignment?,
	}
)
	
	return create "TextLabel" {
		Name = props.Name or props.Text,
		BackgroundTransparency = props.BackgroundTransparency or 1,
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = props.Size,
		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,
		
		Text = props.Text,
		TextSize = props.TextSize,
		TextColor3 = props.TextColour;
		TextScaled = props.TextScaled;
		TextTransparency = props.TextTransparency;
			--or palette.text
		TextWrapped = props.WrapBounds,
		TextXAlignment = props.AlignX,
		TextYAlignment = props.AlignY,
		Font = props.Font
	}
end