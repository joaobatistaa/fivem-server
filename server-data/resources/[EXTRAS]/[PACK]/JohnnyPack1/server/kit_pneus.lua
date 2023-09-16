ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('tyrekit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('tyrekit:onUse', _source)
end)

RegisterNetEvent('esx_repairkit:removeTyreKit')
AddEventHandler('esx_repairkit:removeTyreKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('tyrekit', 1)
end)

RegisterServerEvent("esx_repairkit:SetTyreSync")
AddEventHandler("esx_repairkit:SetTyreSync", function(veh, tyre)
	TriggerClientEvent("TyreSync", -1, veh, tyre)
end)