--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Spark = require(ReplicatedStorage.Packages.Spark)

export type keybindings_table = {
	[string]: {
		KeyCode: Enum.KeyCode;
	}
}

local default_keybinds = {
	-- modifiers
	["MODIFIER_PRIMARY"] = {
		KeyCode = Enum.KeyCode.LeftShift;
	};
	["MODIFIER_SECONDARY"] = {
		KeyCode = Enum.KeyCode.LeftAlt;
	};
	["MODIFIER_TERTIARY"] = {
		KeyCode = Enum.KeyCode.LeftControl
	};
	
	-- main
 	["ROLEPLAY_CONTEXT"] = {
		KeyCode = Enum.KeyCode.T;
	};
	["SIDEBAR"] = {
		KeyCode = Enum.KeyCode.Tab;
	};
}

return default_keybinds