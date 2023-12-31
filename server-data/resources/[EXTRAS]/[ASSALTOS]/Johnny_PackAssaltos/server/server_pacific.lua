local lastrob = 0
local start = false

ESX.RegisterServerCallback('pacificheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['PacificHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('pacificheist:client:showNotification', src, StringsPacific['need_police'], 'error')
    end
end)

ESX.RegisterServerCallback('pacificheist:server:checkTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['PacificHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['PacificHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('pacificheist:client:showNotification', src, StringsPacific['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsPacific['minute'], 'info')
        cb(false)
    else
        lastrob = os.time()
        start = true
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "bancoprincipal", true)
        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um Assalto ao Banco Principal!')
        cb(true)
    end
end)

ESX.RegisterServerCallback('pacificheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local playerItem = player.getInventoryItem(item)

    if player and playerItem ~= nil then
        if playerItem.count >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        print('[rm_pacificheist] you need add required items to server database')
    end
end)

RegisterServerEvent('pacificheist:server:policeAlert')
AddEventHandler('pacificheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('pacificheist:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
        title = "ASSALTO",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Assalto a decorrer no Banco Principal!"
    }
    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer no Banco Principal!")
end)

RegisterServerEvent('pacificheist:server:rewardItem')
AddEventHandler('pacificheist:server:rewardItem', function(item, count, type)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local whitelistItems = {}

    if player then
        if type == 'money' then
            local sourcePed = GetPlayerPed(src)
            local sourceCoords = GetEntityCoords(sourcePed)
            local dist = #(sourceCoords - vector3(256.764, 241.272, 101.693))
            if dist > 200.0 then
                TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Dinheiro")
            else
                if Config['PacificHeist']['black_money'] then
                    player.addAccountMoney('black_money', count)
                else
                    player.addMoney(count)
                end
            end
        else
            for k, v in pairs(Config['PacificHeist']['rewardItems']) do
                whitelistItems[v['itemName']] = true
            end

            for k, v in pairs(Config['PacificSetup']['glassCutting']['rewards']) do
                whitelistItems[v['item']] = true
            end

            for k, v in pairs(Config['PacificSetup']['painting']) do
                whitelistItems[v['rewardItem']] = true
            end

            if whitelistItems[item] then
                if count then 
                    player.addInventoryItem(item, count)
                else
                    player.addInventoryItem(item, 1)
                end
            else
                TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Items")
            end
        end
    end
end)

RegisterServerEvent('pacificheist:server:removeItem')
AddEventHandler('pacificheist:server:removeItem', function(item)
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        player.removeInventoryItem(item, 1)
    end
end)

RegisterServerEvent('pacificheist:server:sellRewardItems')
AddEventHandler('pacificheist:server:sellRewardItems', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local totalMoney = 0

    if player then
        for k, v in pairs(Config['PacificHeist']['rewardItems']) do
            local playerItem = player.getInventoryItem(v['itemName'])
            if playerItem.count >= 1 then
                player.removeInventoryItem(v['itemName'], playerItem.count)
                player.addMoney(playerItem.count * v['sellPrice'])
                totalMoney = totalMoney + (playerItem.count * v['sellPrice'])
            end
        end
        
        for k, v in pairs(Config['PacificSetup']['glassCutting']['rewards']) do
            local playerItem = player.getInventoryItem(v['item'])
            if playerItem.count >= 1 then
                player.removeInventoryItem(v['item'], playerItem.count)
                player.addMoney(playerItem.count * v['price'])
                totalMoney = totalMoney + (playerItem.count * v['price'])
            end
        end

        for k, v in pairs(Config['PacificSetup']['painting']) do
            local playerItem = player.getInventoryItem(v['rewardItem'])
            if playerItem.count >= 1 then
                player.removeInventoryItem(v['rewardItem'], playerItem.count)
                player.addMoney(playerItem.count * v['paintingPrice'])
                totalMoney = totalMoney + (playerItem.count * v['paintingPrice'])
            end
        end

        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. math.floor(totalMoney) .. '€ no Assalto ao Banco Principal!')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "bancoprincipal", false)
        TriggerClientEvent('pacificheist:client:showNotification', src, StringsPacific['total_money'] .. ' $' .. math.floor(totalMoney), 'success')
    end
end)

RegisterServerEvent('pacificheist:server:startHeist')
AddEventHandler('pacificheist:server:startHeist', function()
    TriggerClientEvent('pacificheist:client:startHeist', -1)
end)

RegisterServerEvent('pacificheist:server:resetHeist')
AddEventHandler('pacificheist:server:resetHeist', function()
    TriggerClientEvent('pacificheist:client:resetHeist', -1)
end)

RegisterServerEvent('pacificheist:server:sceneSync')
AddEventHandler('pacificheist:server:sceneSync', function(model, animDict, animName, pos, rotation)
    TriggerClientEvent('pacificheist:client:sceneSync', -1, model, animDict, animName, pos, rotation)
end)

RegisterServerEvent('pacificheist:server:particleFx')
AddEventHandler('pacificheist:server:particleFx', function(pos)
    TriggerClientEvent('pacificheist:client:particleFx', -1, pos)
end)

RegisterServerEvent('pacificheist:server:modelSwap')
AddEventHandler('pacificheist:server:modelSwap', function(pos, radius, model, newModel)
    TriggerClientEvent('pacificheist:client:modelSwap', -1, pos, radius, model, newModel)
end)

RegisterServerEvent('pacificheist:server:globalObject')
AddEventHandler('pacificheist:server:globalObject', function(object, item)
    TriggerClientEvent('pacificheist:client:globalObject', -1, object, item)
end)

RegisterServerEvent('pacificheist:server:someoneVault')
AddEventHandler('pacificheist:server:someoneVault', function(action)
    TriggerClientEvent('pacificheist:client:someoneVault', -1, action)
end)

RegisterServerEvent('pacificheist:server:openVault')
AddEventHandler('pacificheist:server:openVault', function(index)
    TriggerClientEvent('pacificheist:client:openVault', -1, index)
end)

RegisterServerEvent('pacificheist:server:vaultLoop')
AddEventHandler('pacificheist:server:vaultLoop', function()
    TriggerClientEvent('pacificheist:client:vaultLoop', -1)
end)

RegisterServerEvent('pacificheist:server:extendedLoop')
AddEventHandler('pacificheist:server:extendedLoop', function()
    TriggerClientEvent('pacificheist:client:extendedLoop', -1)
end)

RegisterServerEvent('pacificheist:server:vaultSync')
AddEventHandler('pacificheist:server:vaultSync', function(action, index)
    TriggerClientEvent('pacificheist:client:vaultSync', -1, action, index)
end)

RegisterServerEvent('pacificheist:server:extendedSync')
AddEventHandler('pacificheist:server:extendedSync', function(action, index)
    TriggerClientEvent('pacificheist:client:extendedSync', -1, action, index)
end)

RegisterServerEvent('pacificheist:server:doorSync')
AddEventHandler('pacificheist:server:doorSync', function(index)
    TriggerClientEvent('pacificheist:client:doorSync', -1, index)
end)

RegisterServerEvent('pacificheist:server:objectSync')
AddEventHandler('pacificheist:server:objectSync', function(e)
    TriggerClientEvent('pacificheist:client:objectSync', -1, e)
end)

RegisterServerEvent('pacificheist:server:doorFix')
AddEventHandler('pacificheist:server:doorFix', function(hash, heading, pos)
    TriggerClientEvent('pacificheist:client:doorFix', -1, hash, heading, pos)
end)

RegisterCommand('pdpacific', function(source, args)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if player then
        if player['job']['name'] == 'police' then
            if start then
                TriggerClientEvent('pacificheist:client:resetHeist', -1)
                start = false
            end
        else
            TriggerClientEvent('pacificheist:client:showNotification', src, 'Não és policia!', 'error')
        end
    end
end)