ESX = nil

ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    while true do
        local totalPlayer = #GetPlayers()
        local maxPlayers = GetConvarInt('sv_maxclients', 128)
        TriggerClientEvent('wais:totalPlayers', -1, totalPlayer, maxPlayers)
        Wait(Config.RefreshPlayersCountTime)
    end
end)

RegisterNetEvent('wais:getTotalPlayers', function()
    local src = source
    local totalPlayer = #GetPlayers()
    local maxPlayers = GetConvarInt('sv_maxclients', 128)
    TriggerClientEvent('wais:totalPlayers', src, totalPlayer, maxPlayers)
end)
