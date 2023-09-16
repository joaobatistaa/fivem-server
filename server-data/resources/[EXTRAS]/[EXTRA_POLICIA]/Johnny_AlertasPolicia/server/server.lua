ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent("dispatch:svNotify")
AddEventHandler("dispatch:svNotify", function(data)
    TriggerClientEvent('dispatch:clNotify', -1, data)
end)

RegisterCommand('togglealerts', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or ESX.GetPlayerData().job.name == 'pj' or ESX.GetPlayerData().job.name == 'sheriff' then
        TriggerClientEvent('dispatch:toggleNotifications', source, args[1])
    end
end)

RegisterNetEvent('server:ym-outlawalert:gunshotInProgress')
AddEventHandler('server:ym-outlawalert:gunshotInProgress', function(targetCoords)
	TriggerClientEvent('ym-outlawalert:gunshotInProgress', targetCoords)
end)

