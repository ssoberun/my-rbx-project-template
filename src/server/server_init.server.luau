local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local startup = require(ReplicatedStorage.shared.startup)
local load_systems = require(ReplicatedStorage.shared.utilities["load_systems"])

local systems = {}

load_systems(systems, ReplicatedStorage.shared.systems)
load_systems(systems, ServerScriptService.server.systems)

startup(systems)