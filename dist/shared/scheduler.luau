local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Planck = require(ReplicatedStorage.Packages.Planck)
local Scheduler = Planck.Scheduler

local timePassed = Planck.timePassed
local runOnce = Planck.runOnce

local PlanckJabby = require(ReplicatedStorage.Packages.PlanckJabby)
local jabbyPlugin = PlanckJabby.new()

local PlanckRunService = require(ReplicatedStorage.Packages.PlanckRunService)
local runServicePlugin = PlanckRunService.Plugin.new()

local custom_phases = require (script.Parent:WaitForChild('custom_phases'))
local world = require (script.Parent:WaitForChild('world'))


local scheduler = Scheduler.new(world)
	:addPlugin(runServicePlugin)
	:addPlugin(jabbyPlugin)
	:insert(custom_phases.Pipelines.SharedGameUpdate, RunService, "Heartbeat")

return scheduler

