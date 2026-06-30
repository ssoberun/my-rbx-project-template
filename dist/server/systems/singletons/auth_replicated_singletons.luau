local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local pair = Jecs.pair
local bulk_insert = Jecs.bulk_insert;

local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup

local ct = require(ReplicatedStorage.shared.ct)

local function setup_singletons (world: Jecs.World)
	world:set(ct.SINGLETONS, ct.SINGLETONS)
	
	bulk_insert(world, ct.SINGLETONS, {
		ct.SINGLETON_PERMADEATH;
		ct.SINGLETON_GLOBAL_RESPAWN_TIME;
		
		-- tags below
		pair(replecs.reliable, ct.SINGLETON_PERMADEATH);
		pair(replecs.reliable, ct.SINGLETON_GLOBAL_RESPAWN_TIME); 
	}, 
	{
		false;
		50;
	})
end

return {
	system = setup_singletons;
	phase = phase
}