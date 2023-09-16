ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('NB:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

RegisterServerEvent("johnny_scripts:addVehicle")
AddEventHandler("johnny_scripts:addVehicle", function(args, vehicleProps, vehModel, tipo)
	local tPlayer = nil
	local identifier = args
	
	if not string.find(args, "steam") then
		tPlayer = ESX.GetPlayerFromId(tonumber(args))
		identifier = tPlayer.identifier
	end
	
	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, model, type) VALUES (@owner, @plate, @vehicle, @model, @type)',
	{
		['@owner']   = identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@model'] = vehModel,
		['@type'] = tipo
	})
end)


ESX.RegisterServerCallback('johnny_scripts:adicionarVeiculoBD', function(source, cb, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamid = xPlayer.identifier
	local group = xPlayer.group
	local labelCarro = nil
	local tPlayer
	
	if group == 'superadmin' then--if steamid == 'steam:110000115708986' or steamid == 'steam:1100001470baaf7' or  then
		local id = true
		if string.find(args, "steam") then
			id = false
		end
		if id then
		
			if tonumber(args) > 0 then
				tPlayer = ESX.GetPlayerFromId(tonumber(args))
				if tPlayer then
					cb(true)
				else
					cb('offline')
				end
			else
				cb('iderror')
			end
		else
			cb(true)
		end
		--[[
		local result = MySQL.Sync.fetchAll('SELECT * FROM vehicles WHERE model = @model', {
			['@model'] = modeloCarro
		})
		
		if result[1] ~= nil then
			labelCarro = result[1].name
		end
		--]]
		
	else
		cb('notfundador')
	end
end)

local gangs = {'mafia', 'remax', 'advogado', 'ballas', 'bahamas', 'cartel', 'galaxy', 'grove', 'juiz', 'peakyblinders', 'redline', 'vagos', 'vanilla', 'yakuza'}

ESX.RegisterServerCallback('johnny_scripts:adicionarCarroEmpresaBD', function(source, cb, plate, action)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local steamid = xPlayer.identifier
	local job = xPlayer.job.name
	local job_grade = xPlayer.job.grade_name
	local isJobAllowed = false
	
	if job_grade ~= 'boss' then
		cb('notchefe')
	end
	
	if job then
		for k,v in pairs(gangs) do
			if job == v then
				isJobAllowed = true
			end
		end
		
		if not isJobAllowed then
			cb('notjoballowed')
		end
	end
    
	if action == 'pessoal' then
		TriggerClientEvent('cd_garage:SetJobOwnedVehicle', _source, 'pessoal')
		cb(true)
	end
	
	if action == 'empresa' then
		TriggerClientEvent('cd_garage:SetJobOwnedVehicle', _source, 'empresa')
		cb(true)
	end
	--[[
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
        ['@plate'] = plate
    }, function(result)
        if result ~= nil and #result > 0 then
            if tostring(result[1].owner) == steamid then
                MySQL.Async.execute("UPDATE owned_vehicles SET owner = @job WHERE plate = @plate", {
                    ['@job'] = job,
                    ['@plate'] = plate
                })
				cb(true)
			else
				cb('notdonoveiculo')
            end
		else
			cb('notvalidcar')
        end
    end)
	--]]
end)

ESX.RegisterServerCallback('johnny_scripts:removerCarroEmpresaBD', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamid = xPlayer.identifier
	local job = xPlayer.job.name
	local job_grade = xPlayer.job.grade_name
	local isJobAllowed = false
	
	if job_grade ~= 'boss' then
		cb('notchefe')
	end
	
	if job then
		for k,v in pairs(gangs) do
			if job == v then
				isJobAllowed = true
			end
		end
		
		if not isJobAllowed then
			cb('notjoballowed')
		end
	end
    
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
        ['@plate'] = plate
    }, function(result)
        if result ~= nil and #result > 0 then
            if tostring(result[1].job) == job then
                MySQL.Async.execute("UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate", {
                    ['@owner'] = steamid,
                    ['@plate'] = plate
                })
				cb(true)
			else
				cb('notdonoveiculo')
            end
		else
			cb('notvalidcar')
        end
    end)
	
end)

function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end


ESX.RegisterServerCallback('johnnyscripts:getSteamID', function(source, cb, nomeJogador)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--local xTarget = ESX.GetPlayerFromId(idjogo)
	local group = xPlayer.group
	--local steamid = xTarget.identifier
	
	if group == 'superadmin' then --if teste == 'superadmin' or steamid == 'steam:110000115708986' then
		MySQL.Async.fetchAll('SELECT identifier FROM users WHERE name LIKE @name', {
			['@name'] = '%' .. nomeJogador .. '%'
		}, function(result)
			if result[1] then
				identifier = result[1].identifier
				cb(identifier)
			else
				cb('nao_encontrado')
			end
		end)
	else
		cb(false)
	end
end)