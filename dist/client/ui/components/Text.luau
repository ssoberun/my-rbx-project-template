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
		ZIndex: number?,
		LayoutOrder: number?,
		Visible: boolean?,

		Text: string,
		TextSize: number,
		Font: Enum.Font,
		TextColour: Color3?,
		WrapBounds: Vector2?,
		AlignX: Enum.TextXAlignment?,
		AlignY: Enum.TextYAlignment?,
	}
)
	local font = props.Font or Enum.Font.Arial
	
	
	local realTextSize = derive(function(use)
		return FONT_SCALES[font] * props.TextSize
	end)
	
	local textBounds = derive(function(use)
		local bounds = TextService:GetTextSize(props.Text, realTextSize(), props.Font, (props.WrapBounds or Vector2.one * math.huge):Floor())
		return bounds
	end)
		
	return create "TextLabel" {
		Name = props.Name or props.Text,
		BackgroundTransparency = 1,
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = derive(function(use)
			local bounds = textBounds()
			return UDim2.fromOffset(bounds.X, bounds.Y + 1)
		end),
		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,
		
		Text = props.Text,
		TextSize = realTextSize,
		TextColor3 = props.TextColour;
			--or palette.text
		TextWrapped = derive(function(use)
			return props.WrapBounds ~= nil
		end),
		TextXAlignment = props.AlignX,
		TextYAlignment = props.AlignY,
		Font = font;
	}
end