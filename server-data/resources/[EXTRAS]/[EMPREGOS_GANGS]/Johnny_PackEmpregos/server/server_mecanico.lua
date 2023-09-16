TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'private'})

RegisterServerEvent('esx_mechanicjob:darItem')
AddEventHandler('esx_mechanicjob:darItem', function(item, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	sourceXPlayer.addInventoryItem(item,amount)		
end)