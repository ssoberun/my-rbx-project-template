local ReplicatedStorage = game:GetService("ReplicatedStorage")
local create_asset_library = require "@util/create_asset_library"
local global_module_data = require "@shared/global_module_data"
local asset_bank_id = global_module_data.asset_bank_id

local asset_folder = ReplicatedStorage.shared:FindFirstChild("assets")

if not asset_folder then
    asset_folder = Instance.new("Folder")
    asset_folder.Name = "assets"
    asset_folder.Parent = ReplicatedStorage.shared
end

local asset_lib = create_asset_library(asset_bank_id, asset_folder)
return asset_lib
