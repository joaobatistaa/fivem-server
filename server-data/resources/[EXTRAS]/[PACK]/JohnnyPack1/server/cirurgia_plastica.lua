ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_plasticsurgery:pay')
AddEventHandler('esx_plasticsurgery:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getAccount('money').money >= 5000 then
		xPlayer.removeMoney(5000)
	elseif xPlayer.getAccount('bank').money >= 5000 then
		xPlayer.removeAccountMoney('bank', 5000)
	end
	
	TriggerClientEvent('Johnny_Notificacoes:Alert', source, "HOSPITAL", "<span style='color:#c7c7c7'>Pagaste <span style='color:#069a19'><b>5000€</b> </span> pela cirurgia plástica!", 5000, 'success')
end)

ESX.RegisterServerCallback('esx_plasticsurgery:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getAccount('money').money >= 5000 then
		cb(true)
	elseif xPlayer.getAccount('bank').money >= 5000 then
		cb(true)
	else
		cb(false)
	end

end)
