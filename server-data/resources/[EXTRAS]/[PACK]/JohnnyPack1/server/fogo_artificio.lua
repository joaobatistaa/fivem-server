ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('fogo_artificio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeInventoryItem('firebox', 1)
    
	TriggerClientEvent('frobski-fireworks:start', source)
end)
