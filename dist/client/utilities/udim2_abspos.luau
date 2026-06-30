return function (udim2: UDim2)
	local absoluteSize = game:GetService("Workspace").CurrentCamera.ViewportSize
	local xOffset = udim2.X.Scale * absoluteSize.X
	xOffset += udim2.X.Offset
	local yOffset = udim2.Y.Scale * absoluteSize.Y
	yOffset += udim2.Y.Offset
	return Vector2.new(xOffset, yOffset)
end