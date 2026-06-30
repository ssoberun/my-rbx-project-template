local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local custom_phases = require(ReplicatedStorage.shared["custom_phases"])

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client
local camera = workspace.CurrentCamera

local function update_projected_positions (world: Jecs.World)
	if not camera then
		warn(`NON-FATAL: NO CLIENT_CAMERA`)
		return
	end
	
	local projected_part_update = world:query(cct.ScreenPointSource ,cct.ProjectOnPart):cached()
	
	for entity_id, screen_point_source, target_part in projected_part_update do
		if not target_part then
			warn(`NON-FATAL ERROR: No target_part for {entity_id}`)
			continue
		end
		
		local target_pos = target_part.Position
		
		local offset_pos = world:get(entity_id, cct.PART_PROJECTION_OFFSET)
		if offset_pos then
			target_pos = target_pos + offset_pos
		end
		
		local screenPoint = camera:WorldToViewportPoint(target_pos) :: Vector3
		local depth = screenPoint.Z
		local should_update_off_screen = world:get(entity_id, cct.UPDATE_OFFSCREEN)
		
		local onScreen = not(depth < -0.1)
		
		if not(onScreen) and should_update_off_screen then
			screen_point_source(screenPoint)
			continue
		end
		
		if onScreen then
			screen_point_source(screenPoint)
		end
	end
end

return {
	system = update_projected_positions;
	phase = custom_phases.Phases.UI
}