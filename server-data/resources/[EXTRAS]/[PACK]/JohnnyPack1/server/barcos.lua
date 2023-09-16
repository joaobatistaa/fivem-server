ESX = nil

ESX = exports['es_extended']:getSharedObject()

local precoLicenca = 20000

local Barcos = {
	{model = 'seashark', label = 'Seashark (Random Color)', price = 200000},
	{model = 'suntrap', label = 'Suntrap', price = 300000},
	{model = 'jetmax', label = 'Jetmax', price = 500000},
	{model = 'tropic2', label = 'Tropic', price = 460000},
	{model = 'marquis', label = 'Dinka Marquis', price = 900000},
	{model = 'speeder', label = 'Speeder', price = 650000},
	{model = 'squalo', label = 'Squalo (Random Color)', price = 400000},
	{model = 'toro', label = 'Toro', price = 800000},
	{model = 'submersible', label = 'Submersible', price = 5000000}
}

ESX.RegisterServerCallback('esx_boat:buyBoat', function(source, cb, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price   = getPriceFromModelBarco(vehicleProps.model)

	-- vehicle model not found
	if price == 0 then
		print(('esx_boat: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getAccount('bank').money >= price then
			xPlayer.removeAccountMoney('bank', price)
			local estado = 1
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, in_garage, garage_type, vehicle, type, identifier) VALUES (@owner, @plate, @in_garage, @garage_type, @vehicle, @type, @identifier)', {
				['@owner']   = xPlayer.identifier,
				['@plate']   = vehicleProps.plate,
				['@in_garage'] = 1,
				['@garage_type'] = 'boat',
				['@vehicle'] = json.encode(vehicleProps),
				['@type']    = 'boat',
				['@identifier'] = xPlayer.identifier,
			}, function(rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_boat:buyBoatLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getAccount('bank').money >= precoLicenca then
		xPlayer.removeAccountMoney('bank', precoLicenca)

		TriggerEvent('esx_license:addLicense', source, 'boat', function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

function getPriceFromModelBarco(model)
	for k,v in ipairs(Barcos) do
		if GetHashKey(v.model) == model then
			return v.price
		end
	end

	return 0
end
