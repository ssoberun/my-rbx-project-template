local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase
local Startup = Phase.Startup

local shared_ct = require(ReplicatedStorage.shared.ct)

local iterate_and_mark = require(ReplicatedStorage.shared.utilities["iterate_and_mark"])

local function mark_cts_as_replicated (world: Jecs.World)
	iterate_and_mark(shared_ct, function(index, item)
		world:set(item, Jecs.Name, index)
		world:add(item, replecs.shared)
		--print(`{world:get(item, Jecs.Name)}`)
	end, {
		"client";
		"server";
	})
end

return {
	system = mark_cts_as_replicated;
	phase = Startup
}