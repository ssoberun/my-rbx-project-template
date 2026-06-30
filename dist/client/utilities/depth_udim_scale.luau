return function(screen_point: vector, min_scale: number, max_scale: number)
	local depth = screen_point.Z or 0
	
	-- Normalize depth (adjust these values based on your camera's near/far planes)
	local min_depth = 0
	local max_depth = 60
	local normalized_depth = math.clamp((depth - min_depth) / (max_depth - min_depth), 0, 1)

	-- Scale size: larger when close (depth low), smaller when far (depth high)
	local size = max_scale - (normalized_depth * (max_scale - min_scale))

	return UDim2.fromScale(size, size)
end