local lastrob = 0

ESX.RegisterServerCallback('artheist:server:checkRobTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
		TriggerClientEvent('artheist:client:showNotification', src, StringsArt['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsArt['minute'], 'info')
        cb(false)
    else
        lastrob = os.time()
		discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um assalto à Casa da Arte!')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "art", true)
        cb(true)
    end
end)

RegisterNetEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('artheist:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
        title = "ASSALTO",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Assalto a decorrer na Casa da Arte!"
    }
    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer na Casa da Arte!")
end)

RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
	local src = source
    local player = ESX.GetPlayerFromId(src)
	
	TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local item = scene['rewardItem']

    if player then
        player.addInventoryItem(item, 1)
    end
end)

RegisterServerEvent('artheist:server:finishHeist')
AddEventHandler('artheist:server:finishHeist', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "art", false)
        for k, v in pairs(Config['ArtHeist']['painting']) do
            local count = player.getInventoryItem(v['rewardItem']).count
            if count > 0 then
                player.removeInventoryItem(v['rewardItem'], 1)
                player.addMoney(v['paintingPrice'])
            end
        end
    end
end)