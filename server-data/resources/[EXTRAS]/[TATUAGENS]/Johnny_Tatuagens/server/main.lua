ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('esx_tattooshop:requestPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

ESX.RegisterServerCallback('esx_tattooshop:purchaseTattoo', function(source, cb, tattooList, price, tattoo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		table.insert(tattooList, tattoo)

		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = xPlayer.identifier
		})

		TriggerClientEvent('esx:showNotification', source, _U('bought_tattoo', ESX.Math.GroupDigits(price)))
		cb(true)
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', source, _U('not_enough_money', ESX.Math.GroupDigits(missingMoney)))
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_tattooshop:removeTattoos', function(source, cb, tattooList, idjogador)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayer2 = ESX.GetPlayerFromId(idjogador)
	
	if xPlayer.job.name == 'ambulance' then
	
		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = nil,
			['@identifier'] = xPlayer2.identifier
		})
		
		TriggerClientEvent('wtrp_tatuagens:limparTabelaTatuagens', idjogador)
		cb(true)
	else
		cb(false)
	end
end)
