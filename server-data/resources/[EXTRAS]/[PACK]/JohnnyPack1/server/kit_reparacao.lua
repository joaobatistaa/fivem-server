ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('fixtool', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Attrezzatura = xPlayer.getInventoryItem('fixtool').count
	if Attrezzatura == 0 then
		TriggerClientEvent('esx:showNotification', source, 'Não tens um Kit de Reparação!')
	else
		TriggerClientEvent('nk_repair:MenuRipara', source)
	end
end)

RegisterServerEvent('nk_repair:RimuoviItem')
AddEventHandler('nk_repair:RimuoviItem', function(ped, coords, veh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('fixtool', 1)
	TriggerClientEvent('nk_repair:MettiCrick', _source, ped, coords, veh)
end)

RegisterServerEvent('nk_repair:RimuoviItem2')
AddEventHandler('nk_repair:RimuoviItem2', function(ped, coords, veh)
	local _source = source
	TriggerClientEvent('nk_repair:MettiCrick', _source, ped, coords, veh)
end)