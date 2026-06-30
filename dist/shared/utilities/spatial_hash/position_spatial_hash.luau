local spatialhashmap = {}
local CHUNKSIZE = 16

local itemmap = {}

local function updatepos(pos: vector, item: any)
	local chunkpos = (pos // CHUNKSIZE) * CHUNKSIZE
	local key = `{chunkpos.x},{chunkpos.y},{chunkpos.z}`

	if itemmap[item] then
		local oldkey = itemmap[item].key
		if oldkey == key then return end -- chunk did not change
		local partition = spatialhashmap[oldkey]
		local idx = table.find(partition, item)
		if idx then table.remove(partition, idx) end
		if #spatialhashmap[oldkey] == 0 then spatialhashmap[oldkey] = nil end
	end

	local new = spatialhashmap[key]
	if not new then
		new = {}
		spatialhashmap[key] = new
	end
	table.insert(new, item)
	itemmap[item] = {key = key}
end

local function queryradius(pos: vector, radius: number): {any}
	local results = {}
	local thischunk = (pos // CHUNKSIZE) * CHUNKSIZE
	local searchradius = math.ceil(radius / CHUNKSIZE)

	-- iterate through nearby chunks
	for dx = -searchradius, searchradius do
		for dy = -searchradius, searchradius do
			for dz = -searchradius, searchradius do
				local checkchunk = thischunk + Vector3.new(dx * CHUNKSIZE, dy * CHUNKSIZE, dz * CHUNKSIZE)
				local key = `{checkchunk.x},{checkchunk.y},{checkchunk.z}`
				local chunk = spatialhashmap[key]

				if chunk then
					-- check distance for each item in the chunk
					for _, item in ipairs(chunk) do
						local dist = vector.magnitude(item.Position - pos)
						if dist <= radius then
							table.insert(results, item)
						end
					end
				end
			end
		end
	end

	return results
end

local function remove(item: any)
	if not itemmap[item] then return end

	local key = itemmap[item].key
	local partition = spatialhashmap[key]

	if partition then
		local idx = table.find(partition, item)
		if idx then table.remove(partition, idx) end

		-- Clean up empty chunks
		if #partition == 0 then
			spatialhashmap[key] = nil
		end
	end

	itemmap[item] = nil
end

return {
	update_pos = updatepos;
	query = queryradius;
	remove = remove;
}