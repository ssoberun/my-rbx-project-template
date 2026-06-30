local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local global_module_data = require(ReplicatedStorage.shared.global_module_data)

type asset_library = {
    asset_bank: Model,
    get_asset: (self: asset_library, asset_path: string) -> Instance?,
    resolve_asset_path: (self: asset_library, asset_path: string) -> Instance?,
}

local function get_asset_bank (assets_folder: Folder)
    local asset_bank = assets_folder:WaitForChild(global_module_data.asset_bank_name)
    return asset_bank
end

local function insert_asset_bank (assetId: number)
    print "Inserting asset bank..."
    local time = tick()
    local asset_container = InsertService:LoadAsset(assetId)
    print("Asset bank inserted in " .. tostring(tick() - time) .. " seconds.")
    local asset = asset_container:GetChildren()[1] :: Model
    asset.Name = global_module_data.asset_bank_name
    asset.Parent = asset_container.Parent
    asset_container:Destroy()
    return asset
end

local function Constructor(asset_bank_id: number, insert_to_folder: Folder): asset_library
   local asset_library = {} :: asset_library
   local asset_bank = nil :: Model?

   if RunService:IsServer() then
        asset_bank = insert_asset_bank(asset_bank_id)
        asset_bank.Parent = insert_to_folder
   else
        asset_bank = get_asset_bank(insert_to_folder)
        if not asset_bank then
            error("Asset bank not found in folder. Initialise on server first.")
        end
   end

   asset_library.asset_bank = asset_bank
   asset_library.get_asset = get_asset
   asset_library.resolve_asset_path = resolve_asset_path

   return asset_library
end

function resolve_asset_path(asset_library: asset_library, asset_path: string): Instance?
    local segments = string.split(asset_path, "/")
    local current: Instance = nil

    for _, segment in ipairs(segments) do
        if current == nil then
            local query = asset_library.asset_bank:FindFirstChild(segment)
            if not query then
                warn("Asset segment not found: " .. segment .. " in path: " .. asset_path)
                return nil
            end
            current = query
        else
            local query = current:FindFirstChild(segment)
            if not query then
                warn("Asset segment not found: " .. segment .. " in path: " .. asset_path)
                return nil
            end
            current = query
        end

        if current == nil then
            warn("Asset segment not found: " .. segment .. " in path: " .. asset_path)
            return nil
        end
    end

    return current
end

function get_asset(self: asset_library, asset_path: string): Instance?
    local resolved_asset = self.resolve_asset_path(self, asset_path)
    if not resolved_asset then
        warn("Asset not found at path:" .. asset_path)
        return nil
    end
    local cloned_asset = resolved_asset:Clone()
    return cloned_asset
end

return Constructor