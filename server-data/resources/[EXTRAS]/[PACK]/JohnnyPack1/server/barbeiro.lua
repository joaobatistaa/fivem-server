ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_barbershop:pay')
AddEventHandler('esx_barbershop:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(100)
	--TriggerClientEvent('esx:showNotification', source, '~g~Pagaste 100€ pelo corte de cabelo')
	TriggerClientEvent('Johnny_Notificacoes:Alert', source, "BARBEARIA", "Pagaste <span style='color:#069a19'><b>10€</b></span> pelo corte de cabelo!", 5000, 'success')
end)

ESX.RegisterServerCallback('esx_barbershop:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getMoney() >= 10)
end)
