local ReplicatedStorage = game:GetService("ReplicatedStorage")

local replicator = require(ReplicatedStorage.client["client_replicator"])
local GET_FULL_STATE = ReplicatedStorage.shared.packets.GET_FULL_STATE

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase
local Startup = Phase.Startup
local runOnce = Planck.runOnce

local function get_state()
	-- must not yield or scheduler gets messed up
	task.spawn(function()
		local buf, variants = GET_FULL_STATE:InvokeServer()
		replicator:apply_full(buf, variants)
	end)
end

return {
	system = get_state;
	phase = Startup;
}
