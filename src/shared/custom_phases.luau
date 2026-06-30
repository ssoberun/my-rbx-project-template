local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Planck = require(ReplicatedStorage.Packages.Planck)
local Pipeline = Planck.Pipeline
local Phase = Planck.Phase

-- local Processing = Phase.new("Processing")
-- local Replication = Phase.new("Replication")


local Phases = {
	-- server
	Input = Phase.new("Input");
	Processing = Phase.new("Processing");
	QueueResolution = Phase.new("QueueResolution");
	Replication = Phase.new("Replication");
	
	--client
	UI = Phase.new("UI")
}

local Pipelines = {
	SharedGameUpdate = Pipeline.new("GameUpdate")
		:insert(Phases.Input)
		:insert(Phases.UI)
		:insert(Phases.Processing)
		:insert(Phases.QueueResolution)
		:insert(Phases.Replication);
}

return {
	Pipelines = Pipelines;
	Phases = Phases;
}
