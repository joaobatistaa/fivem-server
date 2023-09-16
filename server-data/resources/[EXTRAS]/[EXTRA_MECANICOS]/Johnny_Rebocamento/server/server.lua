local ropes = {}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

if Config.useEsx then
    ESX.RegisterUsableItem(Config.towRopeItem, function(source)
        TriggerClientEvent('kuz_towing:openTowingMenu', source)
    end)
end

RegisterServerEvent("kuz_towing:tow")
AddEventHandler("kuz_towing:tow", function(veh1, veh2)
	local xPlayer = ESX.GetPlayerFromId(source)
    local allPlayers = GetPlayers()
    for k, player in pairs(allPlayers) do
        TriggerClientEvent('kuz_towing:makeRope', player, veh1, veh2, source)
    end
    table.insert(ropes, {veh1, veh2, source})
	xPlayer.removeInventoryItem(Config.towRopeItem, 1)
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.ropeSyncDuration * 1000)
        refreshRopes()
    end
end)

function refreshRopes()
    local allPlayers = GetPlayers()
    if #ropes > 0 then
        for k, rope in pairs(ropes) do
            for i, player in pairs(allPlayers) do
                TriggerClientEvent('kuz_towing:makeRope', player, rope[1], rope[2], rope[3], rope[3] == player)
            end
        end
    end
end

RegisterServerEvent("kuz_towing:stopTow")
AddEventHandler("kuz_towing:stopTow", function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local allPlayers = GetPlayers()

    for k, rope in pairs(ropes) do
        if rope[3] == source then
            for i, player in pairs(allPlayers) do
                TriggerClientEvent('kuz_towing:removeRope', player, source, rope[1], rope[2])
                ropes[k] = nil
            end
        end
    end
	xPlayer.addInventoryItem(Config.towRopeItem, 1)
end)