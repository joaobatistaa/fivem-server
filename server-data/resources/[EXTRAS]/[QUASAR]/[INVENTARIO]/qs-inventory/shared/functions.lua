table.matches = function(t1, t2)
	local type1, type2 = type(t1), type(t2)
	if type1 ~= type2 then return false end
	if type1 ~= 'table' and type2 ~= 'table' then return t1 == t2 end

	for k1,v1 in pairs(t1) do
	   local v2 = t2[k1]
	   if v2 == nil or not table.matches(v1,v2) then return false end
	end

	for k2,v2 in pairs(t2) do
	   local v1 = t1[k2]
	   if v1 == nil or not table.matches(v1,v2) then return false end
	end
	return true
end

table.find = function(arr, func)
    for i, v in pairs(arr) do
        if func(v, i) then return v, k end
    end
end

table.filter = function(arr, func)
	local new = {}
	for i, v in pairs(arr) do
		if func(v, i) then table.insert(new, v) end
	end
	return new
end

function DebugPrint(...)
    if Config.Debug then
        local data = {...}
        local str = ""
        for i = 1, #data do
            if type(data[i]) == "table" then
                str = str .. json.encode(data[i])
            elseif type(data[i]) ~= "string" then
                str = str .. tostring(data[i])
            else
                str = str .. data[i]
            end
            if i ~= #data then
                str = str .. " "
            end
        end
    
        print("^4[QS Inventory] ^3[Debug]^0: " .. str)
    end
end