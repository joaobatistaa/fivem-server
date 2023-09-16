ESX = nil
local lastNapping = 0
local queryRoom = false
local rapto = {}

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('kidnapping:server:checkQueryRoom', function(source, cb)
    cb(queryRoom)
end)

RegisterServerEvent('kidnapping:server:syncQueryRoom')
AddEventHandler('kidnapping:server:syncQueryRoom', function()
    queryRoom = not queryRoom
end)

ESX.RegisterServerCallback('kidnapping:server:checkTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastNapping) < Config['Kidnapping']['nextNapping'] and lastNapping ~= 0 then
        local seconds = Config['Kidnapping']['nextNapping'] - (os.time() - lastNapping)
		TriggerClientEvent('kidnapping:client:showNotification', src, StringsKidnapping['wait_nextnapping'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsKidnapping['minute'], 'info')
        cb(false)
    else
        lastNapping = os.time()
		discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um trabalho de sequestro')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "rapto", true)
        if rapto[src] == nil then rapto[src] = true end
        cb(true)
    end
end)

RegisterNetEvent('kidnapping:server:policeAlert')
AddEventHandler('kidnapping:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('kidnapping:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
        title = "RAPTO",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Um civil avistou um homem a ser raptado!"
    }
    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer ao Laboratório Humane!")
end)

RegisterServerEvent('kidnapping:server:giveVideoRecord')
AddEventHandler('kidnapping:server:giveVideoRecord', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        player.addInventoryItem(Config['Kidnapping']['videoRecordItem'], 1)
    end
end)

RegisterServerEvent('kidnapping:server:finish')
AddEventHandler('kidnapping:server:finish', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if rapto[src] == nil or not rapto[src] then
        TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Dinheiro")
        return
    end

    if player then
        local count = player.getInventoryItem(Config['Kidnapping']['videoRecordItem']).count
        if count > 0 then -- Crash, drop, etc. that may occur after taking a video recording in the previous job. I make him sell all the video recordings on it for situations like.
            player.removeInventoryItem(Config['Kidnapping']['videoRecordItem'], count)
            player.addMoney(count * Config['Kidnapping']['rewardCash'])
        end
        local random = math.random(1, #Config['Kidnapping']['randomRewardItems'])
        local item = Config['Kidnapping']['randomRewardItems'][random]
        player.addInventoryItem(item, 1)
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "rapto", false)
        rapto[src] = false
    end
end)