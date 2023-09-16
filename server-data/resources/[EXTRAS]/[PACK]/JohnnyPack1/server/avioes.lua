ESX = nil

ESX = exports['es_extended']:getSharedObject()

local precoLicenca = 100000

local Avioes = {
	{model = 'maverick', label = 'Maverick', price = 62000000},
	{model = 'vestra', label = 'Vestra', price = 65000000}
}

ESX.RegisterServerCallback('esx_aviao:buyAviao', function(source, cb, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price   = getPriceFromModelAviao(vehicleProps.model)

	-- vehicle model not found
	if price == 0 then
		print(('esx_aviao: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getAccount('bank').money >= price then
			xPlayer.removeAccountMoney('bank', price)
			local estado = 1
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, in_garage, garage_type, vehicle, type, identifier) VALUES (@owner, @plate, @in_garage, @garage_type, @vehicle, @type, @identifier)', {
				['@owner']   = xPlayer.identifier,
				['@plate']   = vehicleProps.plate,
				['@in_garage'] = 1,
				['@garage_type'] = 'air',
				['@vehicle'] = json.encode(vehicleProps),
				['@type']    = 'air',
				['@identifier'] = xPlayer.identifier,
			}, function(rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_aviao:buyAviaoLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getAccount('bank').money >= precoLicenca then
		xPlayer.removeAccountMoney('bank', precoLicenca)

		TriggerEvent('esx_license:addLicense', source, 'aviao', function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

function getPriceFromModelAviao(model)
	for k,v in ipairs(Avioes) do
		if GetHashKey(v.model) == model then
			return v.price
		end
	end

	return 0
end
