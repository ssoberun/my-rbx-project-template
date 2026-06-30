local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")

local Jabby = require(ReplicatedStorage.Packages.Jabby)
local Jecs = require(ReplicatedStorage.Packages.Jecs)
local Name = Jecs.Name

-- local ByteNetMax = require(ReplicatedStorage.Packages.ByteNetMax) -- initialise networker

local scheduler = require (script.Parent:WaitForChild('scheduler'))
local world = require (script.Parent:WaitForChild('world'))
local ct = require (script.Parent:WaitForChild('ct'))

return function (systems)
	if #systems ~= 0 then
		scheduler:addSystems(systems)
	end
	
	if RunService:IsClient() then
		local client = Jabby.obtain_client()

		local function createWidget(_, state: Enum.UserInputState)
			if state ~= Enum.UserInputState.Begin then
				return
			end

			client.spawn_app(client.apps.home, nil)
		end

		ContextActionService:BindAction("Open Jabby", createWidget, false, Enum.KeyCode.F4)
	end

	Jabby.register({
		applet = Jabby.applets.world,
		name = "Jecs World",
		configuration = {
			world = world
		}
	})
end