local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])
local set_ref = jecs_utils.ref.set

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase =  Planck.Phase
local Startup = Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)
local cct = ct.client

local ServerScriptService = game:GetService("ServerScriptService")
local get_player_entity = require(ReplicatedStorage.shared.utilities["get_player_entity"])
local add_player_lookup = get_player_entity.add_player_lookup
local remove_player_lookup = get_player_entity.remove_player_lookup

local IS_CLIENT = RunService:IsClient()
local IS_SERVER = RunService:IsServer()

local function cleanup_project_on_part (world: Jecs.World)
	world:set(cct.ProjectOnPart, Jecs.OnAdd, function(id, component, data)
		local tracked_part = world:get(id, component) :: BasePart
		
		if tracked_part then
			tracked_part.Destroying:Once(function() 
				print("deleting tracked_part...")
				world:delete(id)
			end)
		end
	end)
end

return {
	system = cleanup_project_on_part;
	phase = Startup
}