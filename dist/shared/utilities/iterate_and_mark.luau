--!strict
local function iterate_and_mark (tableOfStuff: {any}, on_catch: (index: any, item: any) -> (), ignoreIndexes: {any}?)
	for index, item in pairs(tableOfStuff) do
		if type(item) == "table" then
			if ignoreIndexes and ignoreIndexes[index] then
				continue
			end
			
			iterate_and_mark (item, on_catch, ignoreIndexes)
			continue
		end
		
		on_catch(index, item)
		--print(`Marked {name} as replecs.shared`)
	end
end

return iterate_and_mark