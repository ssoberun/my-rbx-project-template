local keyboard_bindings_data = table.clone(require(script.Parent:WaitForChild('default_keybinds')))

local bindings_map = setmetatable({}, {
	__index = function(_, key)
		return key
	end,

	__newindex = function(_, key, value)
		keyboard_bindings_data[key] = value
	end,

	__pairs = function()
		return pairs(keyboard_bindings_data)
	end,

	__metatable = "locked",
})

return bindings_map :: typeof(keyboard_bindings_data)