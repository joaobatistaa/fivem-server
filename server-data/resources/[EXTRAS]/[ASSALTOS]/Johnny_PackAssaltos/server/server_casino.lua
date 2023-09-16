CasinoHeist = {
    ['start'] = false,
    ['lastHeist'] = 0,
    ['heistFriends'] = {},
    ['npcSpawned'] = false,
    ['finishedFriends'] = 0,
	['rappel']= { -- rappel coords (enough)
		{ coords = vector3(2570.48, -253.72, -64.660), busy = false},
		{ coords = vector3(2571.48, -253.72, -64.660), busy = false},
		{ coords = vector3(2572.53, -253.72, -64.660), busy = false},
		{ coords = vector3(2573.53, -253.72, -64.660), busy = false},
		{ coords = vector3(2574.53, -253.72, -64.660), busy = false},
	}
}

AddEventHandler('playerDropped', function (reason)
    local src = source
    for k, v in pairs(CasinoHeist['heistFriends']) do
        if tonumber(v) == src then
            table.remove(CasinoHeist['heistFriends'], k)
        end
    end
    if CasinoHeist['finishedFriends'] == #CasinoHeist['heistFriends'] then
        CasinoHeist['start'] = false
        CasinoHeist['npcSpawned'] = false
        CasinoHeist['heistFriends'] = {}
        CasinoHeist['finishedFriends'] = 0
    end
end)

ESX.RegisterServerCallback('casinoheist:server:checkTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - CasinoHeist['lastHeist']) < Config['CasinoHeist']['nextHeist'] and CasinoHeist['lastHeist'] ~= 0 then
        local seconds = Config['CasinoHeist']['nextHeist'] - (os.time() - CasinoHeist['lastHeist'])
        TriggerClientEvent('casinoheist:client:showNotification', src, StringsCasino['wait_nextheist'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsCasino['minute'], 'info')
        cb(false)
    else
        CasinoHeist['lastHeist'] = os.time()
		discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um assalto ao Casino!')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "casino", true)
        cb(true)
    end
end)

ESX.RegisterServerCallback('casinoheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local playerItem = player.getInventoryItem(item)

    if player and playerItem ~= nil then
        if playerItem.count >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    end
end)

RegisterNetEvent('casinoheist:server:policeAlert')
AddEventHandler('casinoheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('casinoheist:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
        title = "ASSALTO",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Assalto a decorrer no Casino!"
    }
    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer no Casino")
end)

RegisterServerEvent('casinoheist:server:startHeist')
AddEventHandler('casinoheist:server:startHeist', function(coords)
    local players = ESX.GetPlayers()
    CasinoHeist['start'] = true
    CasinoHeist['npcSpawned'] = false
    CasinoHeist['heistFriends'] = {}
    CasinoHeist['finishedFriends'] = 0
    local src = source
    local player = ESX.GetPlayerFromId(src)
	
    for i = 1, #players do
        local ped = GetPlayerPed(players[i])
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - coords)
        if dist <= 7.0 then
            CasinoHeist['heistFriends'][i] = players[i]
            TriggerClientEvent('casinoheist:client:startHeist', players[i])
        end
    end
end)

RegisterServerEvent('casinoheist:server:rappelBusy')
AddEventHandler('casinoheist:server:rappelBusy', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:rappelBusy', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:rewardItem')
AddEventHandler('casinoheist:server:rewardItem', function(reward)
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        if CasinoHeist['start'] then
            if reward.item ~= nil then
                player.addInventoryItem(reward.item, reward.count)
            else
                player.addMoney(reward.count)
            end
        end
    end
end)

RegisterServerEvent('casinoheist:server:sellRewardItems')
AddEventHandler('casinoheist:server:sellRewardItems', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
	
    if player then
		local totalMoney = 0
        local rewardItems = Config['CasinoHeist']['rewardItems']
        local diamondCount = player.getInventoryItem(rewardItems['diamondTrolly']['item']).count
        local goldCount = player.getInventoryItem(rewardItems['goldTrolly']['item']).count
        local cokeCount = player.getInventoryItem(rewardItems['cokeTrolly']['item']).count

        if diamondCount > 0 then
            player.removeInventoryItem(rewardItems['diamondTrolly']['item'], diamondCount)
            player.addMoney(rewardItems['diamondTrolly']['sellPrice'] * diamondCount)
			totalMoney = totalMoney + rewardItems['diamondTrolly']['sellPrice'] * diamondCount
			TriggerClientEvent('casinoheist:client:showNotification', src, 'Vendeste todos os Diamantes por: '..rewardItems['diamondTrolly']['sellPrice'] * diamondCount..'€', 'success')
        end
        if goldCount > 0 then
            player.removeInventoryItem(rewardItems['goldTrolly']['item'], goldCount)
            player.addMoney(rewardItems['goldTrolly']['sellPrice'] * goldCount)
			totalMoney = totalMoney + rewardItems['goldTrolly']['sellPrice'] * goldCount
			TriggerClientEvent('casinoheist:client:showNotification', src, 'Vendeste todos os Ouros por: '..rewardItems['goldTrolly']['sellPrice'] * goldCount..'€', 'success')
        end
        if cokeCount > 0 then
            player.removeInventoryItem(rewardItems['cokeTrolly']['item'], cokeCount)
            player.addMoney(rewardItems['cokeTrolly']['sellPrice'] * cokeCount)
			totalMoney = totalMoney + rewardItems['cokeTrolly']['sellPrice'] * cokeCount
			TriggerClientEvent('casinoheist:client:showNotification', src, 'Vendeste todos os Pacotes de Cocaína por: '..rewardItems['cokeTrolly']['sellPrice'] * cokeCount..'€', 'success')
        end
		
		discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. math.floor(totalMoney) .. '€ no Assalto ao Casino!')
        CasinoHeist['finishedFriends'] = CasinoHeist['finishedFriends'] + 1
        if CasinoHeist['finishedFriends'] == #CasinoHeist['heistFriends'] then
            CasinoHeist['start'] = false
            CasinoHeist['npcSpawned'] = false
            CasinoHeist['heistFriends'] = {}
            CasinoHeist['finishedFriends'] = 0
        end
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "casino", false)
    end
end)

RegisterServerEvent('casinoheist:server:nightVision')
AddEventHandler('casinoheist:server:nightVision', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:nightVision', v)
    end
end)

RegisterServerEvent('casinoheist:server:syncDoor')
AddEventHandler('casinoheist:server:syncDoor', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:syncDoor', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:vaultSync')
AddEventHandler('casinoheist:server:vaultSync', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:vaultSync', v)
    end
end)

RegisterServerEvent('casinoheist:server:drillSync')
AddEventHandler('casinoheist:server:drillSync', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:drillSync', v)
    end
end)

RegisterServerEvent('casinoheist:server:lockboxSync')
AddEventHandler('casinoheist:server:lockboxSync', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:lockboxSync', v)
    end
end)

RegisterServerEvent('casinoheist:server:deleteLockbox')
AddEventHandler('casinoheist:server:deleteLockbox', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:deleteLockbox', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:lootSync')
AddEventHandler('casinoheist:server:lootSync', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:lootSync', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:vaultKeypadsSync')
AddEventHandler('casinoheist:server:vaultKeypadsSync', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:vaultKeypadsSync', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:npcSync')
AddEventHandler('casinoheist:server:npcSync', function()
    local src = source
    if CasinoHeist['npcSpawned'] then return end
    CasinoHeist['npcSpawned'] = true
    TriggerClientEvent('casinoheist:client:npcSync', src)
end)