local Jecs = require (game:GetService('ReplicatedStorage'):WaitForChild('Packages'):WaitForChild('Jecs'))

local Planck = require (game:GetService('ReplicatedStorage'):WaitForChild('Packages'):WaitForChild('Planck'))
local phase = Planck.Phase.PreStartup

local function setup_asset_library (world: Jecs.World)
    task.spawn(function()
        require (script.Parent.Parent:WaitForChild('utilities'):WaitForChild('asset_library'))        
print "Asset Library required"
    end)
end



return {
    system = setup_asset_library,
    phase = phase,
}
