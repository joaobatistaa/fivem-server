ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount = ESX.Math.Round(price)

	if price > 0 then
		xPlayer.removeMoney(amount)
	end
end)

RegisterServerEvent('fuel:givecan')
AddEventHandler('fuel:givecan', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('weapon_petrolcan', 1)
end)
