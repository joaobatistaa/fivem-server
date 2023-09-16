local lastrob = 0
local start = false

ESX.RegisterServerCallback('trainheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['TrainHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('trainheist:client:showNotification', src, StringsTrain['need_police'], 'error')
    end
end)

ESX.RegisterServerCallback('trainheist:server:checkTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['TrainHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['TrainHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('trainheist:client:showNotification', src, StringsTrain['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsTrain['minute'], 'info')
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou o Assalto ao Comboio!')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "comboio", true)
        cb(true)
    end
end)

ESX.RegisterServerCallback('trainheist:server:hasItem', function(source, cb, item)
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
        print('[rm_trainheist] you need add required items to server database')
    end
end)

RegisterServerEvent('trainheist:server:policeAlert')
AddEventHandler('trainheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('trainheist:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
		title = "ASSALTO",
		coords = {x = coords.x, y = coords.y, z = coords.z},
		description = "Assalto a decorrer num Comboio!"
	}
	TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer num Comboio!")
end)

RegisterServerEvent('trainheist:server:rewardItems')
AddEventHandler('trainheist:server:rewardItems', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        player.addInventoryItem(Config['TrainHeist']['reward']['itemName'], Config['TrainHeist']['reward']['grabCount'])
    end
end)

RegisterServerEvent('trainheist:server:sellRewardItems')
AddEventHandler('trainheist:server:sellRewardItems', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if not start then
        TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Dinheiro - Train")
        return
    end

    if player then
        local count = player.getInventoryItem(Config['TrainHeist']['reward']['itemName']).count
        if count > 0 then
            player.removeInventoryItem(Config['TrainHeist']['reward']['itemName'], count)
            player.addMoney(Config['TrainHeist']['reward']['sellPrice'] * count)
            discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. math.floor(Config['TrainHeist']['reward']['sellPrice'] * count) .. '€ no Assalto ao Comboio!')
            TriggerClientEvent('trainheist:client:showNotification', src, StringsTrain['total_money'] .. ' ' .. Config['TrainHeist']['reward']['sellPrice'] * count ..'€', 'success')
        end
    end
	TriggerEvent('qb-scoreboard:server:SetActivityBusy', "comboio", false)
end)

RegisterServerEvent('trainheist:server:containerSync')
AddEventHandler('trainheist:server:containerSync', function(coords, rotation)
    TriggerClientEvent('trainheist:client:containerSync', -1, coords, rotation)
end)

RegisterServerEvent('trainheist:server:objectSync')
AddEventHandler('trainheist:server:objectSync', function(e)
    TriggerClientEvent('trainheist:client:objectSync', -1, e)
end)

RegisterServerEvent('trainheist:server:trainLoop')
AddEventHandler('trainheist:server:trainLoop', function()
    TriggerClientEvent('trainheist:client:trainLoop', -1)
end)

RegisterServerEvent('trainheist:server:lockSync')
AddEventHandler('trainheist:server:lockSync', function(index)
    TriggerClientEvent('trainheist:client:lockSync', -1, index)
end)

RegisterServerEvent('trainheist:server:grabSync')
AddEventHandler('trainheist:server:grabSync', function(index, index2)
    TriggerClientEvent('trainheist:client:grabSync', -1, index, index2)
end)

RegisterServerEvent('trainheist:server:resetHeist')
AddEventHandler('trainheist:server:resetHeist', function()
    if not start then return end
    start = false
    TriggerClientEvent('trainheist:client:resetHeist', -1)
end)