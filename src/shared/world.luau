local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local World = Jecs.World

local ct = require (script.Parent:WaitForChild('ct'))

local replecs = require(ReplicatedStorage.Packages.replecs) -- initialise before world

local world = World.new();

return world