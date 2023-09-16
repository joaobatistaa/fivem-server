ESX = nil

ESX = exports['es_extended']:getSharedObject()

-- Binoculars
ESX.RegisterUsableItem('binoculars', function(source)
	local src = source
	TriggerClientEvent('esx_extraitems:binoculars', src)
end)

-- Algemas
ESX.RegisterUsableItem('handcuffs', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:algemar', src, true)
	else
		TriggerClientEvent('esx_policejob:algemar', src, false)
	end
end)
