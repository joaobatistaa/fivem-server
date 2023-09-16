ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('fakeid', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('fakeid', 1)
	TriggerClientEvent('jsfour-register:open_identity', _source)
end)