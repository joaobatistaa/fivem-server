local lastrob = 0
local start = false

ESX.RegisterUsableItem(Config['VangelicoHeist']['gasMask']['itemName'], function(source)
    local src = source
    TriggerClientEvent('vangelicoheist:client:wearMask', src)
end)

ESX.RegisterServerCallback('vangelicoheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['VangelicoHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('vangelicoheist:client:showNotification', src, StringsVangelico['need_police'], 'error')
    end
end)

ESX.RegisterServerCallback('vangelicoheist:server:checkTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['VangelicoHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['VangelicoHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('vangelicoheist:client:showNotification', src, StringsVangelico['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsVangelico['minute'], 'error')
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um assalto à Joalharia!')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "joalharia", true)
        cb(true)
    end
end)

ESX.RegisterServerCallback('vangelicoheist:server:hasItem', function(source, cb, item)
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
        print('[rm_vangelicoheist] you need add required items to server database')
    end
end)

RegisterServerEvent('vangelicoheist:server:policeAlert')
AddEventHandler('vangelicoheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('vangelicoheist:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
        title = "ASSALTO",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Assalto a decorrer na Joalharia!"
    }
    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer na Joalharia!")
end)

RegisterServerEvent('vangelicoheist:server:rewardItem')
AddEventHandler('vangelicoheist:server:rewardItem', function(item)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local whitelistItems = {}

    if not start then 
        TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Items - Joalharia")
        return
    end

    if player then
        for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
            whitelistItems[v['item']] = true
        end

        for k, v in pairs(Config['VangelicoInside']['glassCutting']['rewards']) do
            whitelistItems[v['item']] = true
        end

        for k, v in pairs(Config['VangelicoInside']['painting']) do
            whitelistItems[v['rewardItem']] = true
        end

        if whitelistItems[item] then
            player.addInventoryItem(item, 1)
        else
            print('[rm_vangelicoheist] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
        end
    end
end)

RegisterServerEvent('vangelicoheist:server:sellRewardItems')
AddEventHandler('vangelicoheist:server:sellRewardItems', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local totalMoney = 0

    if player then
        for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
            local playerItem = player.getInventoryItem(v['item'])
            if playerItem.count >= 1 then
                player.removeInventoryItem(v['item'], playerItem.count)
                player.addMoney(playerItem.count * v['price'])
                totalMoney = totalMoney + (playerItem.count * v['price'])
            end
        end

        for k, v in pairs(Config['VangelicoInside']['glassCutting']['rewards']) do
            local playerItem = player.getInventoryItem(v['item'])
            if playerItem.count >= 1 then
                player.removeInventoryItem(v['item'], playerItem.count)
                player.addMoney(playerItem.count * v['price'])
                totalMoney = totalMoney + (playerItem.count * v['price'])
            end
        end

        for k, v in pairs(Config['VangelicoInside']['painting']) do
            local playerItem = player.getInventoryItem(v['rewardItem'])
            if playerItem.count >= 1 then
                player.removeInventoryItem(v['rewardItem'], playerItem.count)
                player.addMoney(playerItem.count * v['paintingPrice'])
                totalMoney = totalMoney + (playerItem.count * v['paintingPrice'])
            end
        end

        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' ganhou ' .. math.floor(totalMoney) .. '€ no Assalto à Joalharia!')
        TriggerClientEvent('vangelicoheist:client:showNotification', src, StringsVangelico['total_money'] .. ' ' .. math.floor(totalMoney) .. '€', 'success')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "joalharia", false)
    end
end)

RegisterCommand('pdvangelico', function(source, args)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if player then
        if player['job']['name'] == 'police' then
            if start then
                TriggerClientEvent('vangelicoheist:client:resetHeist', -1)
                start = false
            end
        else
            TriggerClientEvent('vangelicoheist:client:showNotification', src, 'Não és polícia!', 'error')
        end
    end
end)

RegisterServerEvent('vangelicoheist:server:startGas')
AddEventHandler('vangelicoheist:server:startGas', function()
    TriggerClientEvent('vangelicoheist:client:startGas', -1)
end)

RegisterServerEvent('vangelicoheist:server:insideLoop')
AddEventHandler('vangelicoheist:server:insideLoop', function()
    TriggerClientEvent('vangelicoheist:client:insideLoop', -1)
end)

RegisterServerEvent('vangelicoheist:server:lootSync')
AddEventHandler('vangelicoheist:server:lootSync', function(type, index)
    TriggerClientEvent('vangelicoheist:client:lootSync', -1, type, index)
end)

RegisterServerEvent('vangelicoheist:server:globalObject')
AddEventHandler('vangelicoheist:server:globalObject', function(obj, random)
    TriggerClientEvent('vangelicoheist:client:globalObject', -1, obj, random)
end)

RegisterServerEvent('vangelicoheist:server:smashSync')
AddEventHandler('vangelicoheist:server:smashSync', function(sceneConfig)
    TriggerClientEvent('vangelicoheist:client:smashSync', -1, sceneConfig)
end)