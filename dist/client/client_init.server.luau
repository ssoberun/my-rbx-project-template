local ReplicatedStorage = game:GetService("ReplicatedStorage")

local startup = require(ReplicatedStorage.shared.startup)

local load_systems = require(ReplicatedStorage.shared.utilities["load_systems"])
local _Spark = require(ReplicatedStorage.Packages.Spark)

local systems = {}

load_systems(systems, ReplicatedStorage.shared.systems)
load_systems(systems, ReplicatedStorage.client.systems)

startup(systems)