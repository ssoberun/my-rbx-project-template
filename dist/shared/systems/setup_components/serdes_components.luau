local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local replecs = require(ReplicatedStorage.Packages.replecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local phase = Planck.Phase.Startup

local Squash = require(ReplicatedStorage.Packages.Squash)

local ct = require(ReplicatedStorage.shared.ct)


-- cached
local vec3 = Squash.Vector3(Squash.f64())
local u24 = Squash.u24()


local function serdes_components (world: Jecs.World)
	world:set(ct.Position, replecs.serdes, {
		serialize = function(vector: Vector3)
			local cursor = Squash.cursor()
			vec3.ser(cursor, vector)
			return Squash.tobuffer(cursor)
		end;
		deserialize = function(buf: buffer)
			local cursor = Squash.frombuffer(buf)
			local des_vector = vec3.des(cursor)
			return des_vector
		end,
	});
	
	world:set(ct.RESPAWN_TIMER, replecs.serdes, {
		serialize = function(respawn_timer: number)
			local cursor = Squash.cursor()
			u24.ser(cursor, respawn_timer)
			return Squash.tobuffer(cursor)
		end,
		deserialize = function(buf: buffer)
			local cursor = Squash.frombuffer(buf)
			local des_u24 = u24.des(cursor)
			return des_u24
		end,
	})
end

return {
	system = serdes_components;
	phase = phase;
}