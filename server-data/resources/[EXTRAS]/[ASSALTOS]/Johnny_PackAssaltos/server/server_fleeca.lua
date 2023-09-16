lastRob = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
}


ESX.RegisterServerCallback('fleecaheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['FleecaMain']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('fleecaheist:client:showNotification', src, StringsFleeca['need_police'], 'error')
    end
end)

ESX.RegisterServerCallback('fleecaheist:server:checkTime', function(source, cb, index)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastRob[index]) < Config['FleecaHeist'][index]['nextRob'] and lastRob[index] ~= 0 then
        local seconds = Config['FleecaHeist'][index]['nextRob'] - (os.time() - lastRob[index])
        TriggerClientEvent('fleecaheist:client:showNotification', src, StringsFleeca['wait_nextheist'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsFleeca['minute'], 'info')
        cb(false)
    else
        lastRob[index] = os.time()
        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um Assalto a um Banco Fleeca!')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "bancos", true)
        cb(true)
    end
end)

ESX.RegisterServerCallback('fleecaheist:server:hasItem', function(source, cb, item)
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
        print('[rm_fleecaheist] you need add required items to server database')
    end
end)

RegisterNetEvent('fleecaheist:server:policeAlert')
AddEventHandler('fleecaheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('fleecaheist:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
        title = "ASSALTO",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Assalto a decorrer a um Banco Fleeca!"
    }
    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer a um Banco Fleeca!")
end)

local trollys = {
    vector3(-2957.3, 485.690, 14.6753),
    vector3(-2958.4, 484.099, 14.6753),
    vector3(-2954.2, 484.377, 15.525),
    vector3(-1209.4, -333.79, 36.7592),
    vector3(-1207.6, -333.89, 36.7592),
    vector3(-1207.6, -337.40, 37.6093),
    vector3(-351.02, -54.136, 48.0148),
    vector3(-349.86, -55.756, 48.0148),
    vector3(-352.23, -58.215, 48.848),
    vector3(314.184, -283.42, 53.1430),
    vector3(315.230, -284.93, 53.1430),
    vector3(312.756, -287.41, 54.0),
    vector3(1173.69, 2710.93, 37.0662),
    vector3(1172.02, 2712.01, 37.0662),
    vector3(1173.45, 2715.08, 37.9162),
    vector3(149.887, -1045.1, 28.3462),
    vector3(151.036, -1046.6, 28.3462),
    vector3(148.431, -1049.1, 29.19),
    vector3(150.969, -1049.8, 29.6162),
    vector3(148.095, -1051.1, 29.6162),
    vector3(146.459, -1048.4, 29.6162),
    vector3(1173.34, 2717.16, 38.3363),
    vector3(1175.52, 2715.16, 38.3363),
    vector3(1170.95, 2715.26, 38.3363),
    vector3(310.867, -286.82, 54.4430),
    vector3(312.411, -289.41, 54.4430),
    vector3(315.230, -288.20, 54.4430),
    vector3(-349.70, -59.020, 49.3147),
    vector3(-352.81, -60.155, 49.3147),
    vector3(-354.15, -57.592, 49.3147),
    vector3(-1209.1, -338.87, 37.9593),
    vector3(-1206.4, -339.10, 37.9593),
    vector3(-1205.1, -336.54, 37.9593),
    vector3(-2954.2, 482.120, 15.9253),
    vector3(-2954.0, 486.676, 15.9253),
    vector3(-2952.2, 484.135, 15.9253),
}

RegisterServerEvent('fleecaheist:server:rewardItem')
AddEventHandler('fleecaheist:server:rewardItem', function(reward, count)
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if not ESX.playerInsideLocation(src, trollys, 10.0) then
        TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Dinheiro")
        return
    end

    if player then
        if reward.item ~= nil then
            if count ~= nil then
                player.addInventoryItem(reward.item, count)
            else
                player.addInventoryItem(reward.item, reward.count)
            end
        else
            if count ~= nil then
                player.addMoney(count)
            else
                player.addMoney(reward.count)
            end
        end
    end
end)

RegisterServerEvent('fleecaheist:server:sellRewardItems')
AddEventHandler('fleecaheist:server:sellRewardItems', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        local totalMoney = 0
        local rewardItems = Config['FleecaMain']['rewardItems']
        local diamondCount = player.getInventoryItem(rewardItems['diamondTrolly']['item']).count
        local goldCount = player.getInventoryItem(rewardItems['goldTrolly']['item']).count

        if diamondCount > 0 then
            player.removeInventoryItem(rewardItems['diamondTrolly']['item'], diamondCount)
            player.addMoney(rewardItems['diamondTrolly']['sellPrice'] * diamondCount)
            totalMoney = totalMoney + (rewardItems['diamondTrolly']['sellPrice'] * diamondCount)
        end
        if goldCount > 0 then
            player.removeInventoryItem(rewardItems['goldTrolly']['item'], goldCount)
            player.addMoney(rewardItems['goldTrolly']['sellPrice'] * goldCount)
            totalMoney = totalMoney + (rewardItems['goldTrolly']['sellPrice'] * goldCount)
        end

        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' ganhou ' .. totalMoney .. '€ no Assalto ao Banco Fleeca!')
        TriggerClientEvent('fleecaheist:client:showNotification', src, StringsFleeca['total_money'] .. ' ' .. totalMoney.. '€', 'success')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "bancos", false)
    end
end)

RegisterServerEvent('fleecaheist:server:doorSync')
AddEventHandler('fleecaheist:server:doorSync', function(index)
    TriggerClientEvent('fleecaheist:client:doorSync', -1, index)
end)

RegisterServerEvent('fleecaheist:server:lootSync')
AddEventHandler('fleecaheist:server:lootSync', function(index, type, k)
    TriggerClientEvent('fleecaheist:client:lootSync', -1, index, type, k)
end)

RegisterServerEvent('fleecaheist:server:modelSync')
AddEventHandler('fleecaheist:server:modelSync', function(index, k, model)
    TriggerClientEvent('fleecaheist:client:modelSync', -1, index, k, model)
end)

RegisterServerEvent('fleecaheist:server:grabSync')
AddEventHandler('fleecaheist:server:grabSync', function(index, k, model)
    TriggerClientEvent('fleecaheist:client:grabSync', -1, index, k, model)
end)

RegisterServerEvent('fleecaheist:server:resetHeist')
AddEventHandler('fleecaheist:server:resetHeist', function(index)
    TriggerClientEvent('fleecaheist:client:resetHeist', -1, index)
end)

RegisterCommand('pdfleeca', function(source, args)
    local src = source
    local player = ESX.GetPlayerFromId(src)
	
    if player then
        if player['job']['name'] == 'police' then
            TriggerClientEvent('fleecaheist:client:nearBank', src)
        else
            TriggerClientEvent('fleecaheist:client:showNotification', src, 'Não és polícia!', 'error')
        end
    end
end)