local function shallow_import(
	props: {
		path: Instance;
		on_valid_return: ((func: (any) -> (any)) -> (boolean))?;
	}
): {() -> (any)}

	local path = props.path
	local on_valid_return = props.on_valid_return

	local index_of_callbacks = {}

	for itemName, item: Instance in path:GetChildren() do
		if not item:IsA "ModuleScript" then
			continue
		end

		local required = require(item :: ModuleScript)

		if typeof(required) ~= "function" then
			continue
		end

		if not on_valid_return then
			index_of_callbacks[itemName] = required;
			continue
		end

		if on_valid_return(required) then
			index_of_callbacks[itemName] = required;
		end
	end

	return index_of_callbacks
end

return shallow_import