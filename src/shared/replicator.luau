local ReplicatedStorage = game:GetService("ReplicatedStorage")
local replecs = require(ReplicatedStorage.Packages.replecs)
local world = require (script.Parent:WaitForChild('world'))

return replecs.create(world)
