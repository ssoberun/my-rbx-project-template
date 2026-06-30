local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local pair = Jecs.pair;

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase

local ct = require "../ct"

local Name = ct.Name
local Eats = ct.Eats
local Apples = ct.Apples
local Oranges = ct.Oranges


local function systemA(world: Jecs.World)
	world:set(Apples, Name, "apples")
	world:set(Oranges, Name, "oranges")

	local bob = world:entity()
	world:set(bob, pair(Eats, Apples), 10)
	world:set(bob, pair(Eats, Oranges), 5)
	world:set(bob, Name, "bob")

	local alice = world:entity()
	world:set(alice, pair(Eats, Apples), 4)
	world:set(alice, Name, "alice")
end

return {
	system = systemA;
	phase = Phase.Startup;
}