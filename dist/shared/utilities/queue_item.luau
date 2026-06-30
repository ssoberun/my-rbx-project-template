local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

return function(queue: {}, item: any)
	table.insert(queue, item)
	return queue
end