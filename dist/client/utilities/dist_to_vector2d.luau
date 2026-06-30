local GuiService = game:GetService("GuiService")
local LocalPlayer = game.Players.LocalPlayer

return function (target_position: Vector2): number
	local mouse = LocalPlayer:GetMouse()
	local inset = GuiService:GetGuiInset()
	local inset_offset = inset.Y
	
	local mouse_pos = Vector2.new(mouse.X, mouse.Y + inset_offset)
	
	local distance = (mouse_pos - target_position).Magnitude

	return distance 
end