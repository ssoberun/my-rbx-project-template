local function shouldIgnore (item: Instance): boolean
	local name = item.Name
	
	if name:sub(1,1) == "_" then
		return true
	end
	
	if name:find("subsystems") or name:find("subsystem") then
		return true
	end
	
	return false
end

local function load_systems (system_table: {any}, folder: Folder)
	for _, item in folder:GetChildren() do
		if item:IsA("Folder") then
			if shouldIgnore(item) then
				continue
			end
			
			load_systems(system_table, item)
		end
		
		if not item:IsA("ModuleScript") then
			continue
		end
		
		if item.Name:sub(1,1) == "_" then
			continue
		end
		
		table.insert(system_table, require(item))
	end
	
	return system_table
end

return load_systems