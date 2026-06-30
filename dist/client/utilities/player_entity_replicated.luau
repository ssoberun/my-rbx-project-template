local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local jecs_utils = require(ReplicatedStorage.Packages["jecs_utils"])
local ref = jecs_utils.ref
local find = ref.find


return function (world: Jecs.World): () -> boolean
	return function()
		local player = game.Players.LocalPlayer
		local character = player.Character
		
		if not character then 
			print(`early return`)
			return false
		end
		
		local player_ref = ref(player)
		local character_ref = ref(character)
		
		return (player_ref and character_ref) ~= nil
	end
end