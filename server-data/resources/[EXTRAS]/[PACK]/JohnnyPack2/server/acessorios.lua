ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_accessories:pay')
AddEventHandler('esx_accessories:pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(25)
	--TriggerClientEvent('esx:showNotification', source, '~g~Pagaste 25€ pela compra')
	TriggerClientEvent('Johnny_Notificacoes:Alert', source, "LOJA", "Acessório comprado por <span style='color:#069a19'><b>25€</b></span>!", 5000, 'success')
end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		store.set('has' .. accessory, true)

		local itemSkin = {}
		local item1 = string.lower(accessory) .. '_1'
		local item2 = string.lower(accessory) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]

		store.set('skin', itemSkin)
	end)
end)

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get('skin') and store.get('skin') or {})

		cb(hasAccessory, skin)
	end)

end)

ESX.RegisterServerCallback('esx_accessories:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getAccount('money').money >= 25)
end)