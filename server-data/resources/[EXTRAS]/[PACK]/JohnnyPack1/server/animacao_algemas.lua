ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_ruski_areszt:startAreszt')
AddEventHandler('esx_ruski_areszt:startAreszt', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local targetPlayer = ESX.GetPlayerFromId(target)
	local sourceItem = xPlayer.getInventoryItem('handcuffs').count
	
	--if xPlayer.job.name == 'police' then
		if sourceItem > 0 then
			TriggerClientEvent('esx_ruski_areszt:aresztowany', targetPlayer.source, _source)
			TriggerClientEvent('esx_ruski_areszt:aresztuj', _source)
		else
			TriggerClientEvent('esx:showNotification', _source, '~r~Não tens algemas no inventário!')
		end
	--else
		--print(('esx_policejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	--end
end)