local lastrob = 0
local start = false

ESX.RegisterUsableItem(Config['HumaneLabs']['wetsuit']['itemName'], function(source)
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        TriggerClientEvent('humanelabsheist:client:wearWetsuit', src)
    end
end)

ESX.RegisterServerCallback('humanelabsheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['HumaneLabs']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('humanelabsheist:client:showNotification', src, StringsHumane['need_police'], 'error')
    end
end)

ESX.RegisterServerCallback('humanelabsheist:server:checkTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['HumaneLabs']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['HumaneLabs']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('humanelabsheist:client:showNotification', src, StringsHumane['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsHumane['minute'], 'info')
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um Assalto ao Laboratório Humane')
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "humane", true)
        cb(true)
    end
end)

RegisterServerEvent('humanelabsheist:server:policeAlert')
AddEventHandler('humanelabsheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('humanelabsheist:client:policeAlert', players[i], coords)
        end
    end
	
	local alertData = {
        title = "ASSALTO",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Assalto a decorrer ao Laboratório Humane!"
    }
    TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
	--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer ao Laboratório Humane!")
end)

RegisterServerEvent('humanelabsheist:server:heistRewards')
AddEventHandler('humanelabsheist:server:heistRewards', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        if start then
            if Config['HumaneLabs']['rewards']['money'] > 0 then
                player.addMoney(Config['HumaneLabs']['rewards']['money'])
                discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. Config['HumaneLabs']['rewards']['money'] .. '€ no Assalto ao Laboratório Humane')
            end

            if Config['HumaneLabs']['rewards']['blackMoney'] > 0 then
                player.addAccountMoney('black_money', Config['HumaneLabs']['rewards']['blackMoney'])
                discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. Config['HumaneLabs']['rewards']['blackMoney'] .. '€ em dinheiro sujo no Assalto ao Laboratório Humane')
            end

            if Config['HumaneLabs']['rewards']['items'] ~= nil then
                for k, v in pairs(Config['HumaneLabs']['rewards']['items']) do
                    local rewardCount = v['count']()
                    player.addInventoryItem(v['name'], rewardCount)
                    discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou: ' .. v['name'] .. ' x' .. rewardCount .. '€ no Assalto ao Laboratório Humane')
                end
            end
            
            start = false
			TriggerEvent('qb-scoreboard:server:SetActivityBusy', "humane", false)
        else
            TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Dinheiro")
            return
        end
    end
end)