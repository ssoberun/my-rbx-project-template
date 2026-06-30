local Jecs = require "@pkg/Jecs"

local Planck = require "@pkg/Planck"
local phase = Planck.Phase.PreStartup

local function setup_asset_library (world: Jecs.World)
    task.spawn(function()
        require "@util/asset_library"
        print "Asset Library required"
    end)
end



return {
    system = setup_asset_library,
    phase = phase,
}
