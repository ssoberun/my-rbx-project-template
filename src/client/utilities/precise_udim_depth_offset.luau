return function(screen_point: vector, min_x: number, max_x: number, min_y: number, max_y: number)
	local depth = screen_point.Z or 0

	-- Normalize depth (adjust these values based on your camera's near/far planes)
	local min_depth = 0
	local max_depth = 60
	local normalized_depth = math.clamp((depth - min_depth) / (max_depth - min_depth), 0, 1)

	-- Scale size independently for X and Y axes
	local size_x = max_x - (normalized_depth * (max_x - min_x))
	local size_y = max_y - (normalized_depth * (max_y - min_y))

	return UDim2.fromOffset(size_x, size_y)
end