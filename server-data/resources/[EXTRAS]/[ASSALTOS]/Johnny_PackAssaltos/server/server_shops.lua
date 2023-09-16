local lastrob = {}

RegisterServerEvent('shoprobbery:server:policeAlert')
AddEventHandler('shoprobbery:server:policeAlert', function(coords)
    if Config['ShopRobbery']['framework']['name'] == 'ESX' then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player['job']['name'] == Config['ShopRobbery']['setjobForPolice'] then
                TriggerClientEvent('shoprobbery:client:policeAlert', players[i], coords)
            end
        end
		
		local alertData = {
			title = "ASSALTO",
			coords = {x = coords.x, y = coords.y, z = coords.z},
			description = "Assalto a decorrer numa Loja!"
		}
		TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
		--TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Assalto a decorrer numa Loja!")
		
    elseif Config['ShopRobbery']['framework']['name'] == 'QB' then
        local players = QBCore.Functions.GetPlayers()
        for i = 1, #players do
            local player = QBCore.Functions.GetPlayer(players[i])
            if player.PlayerData.job.name == Config['ShopRobbery']['setjobForPolice'] then
                TriggerClientEvent('shoprobbery:client:policeAlert', players[i], coords)
            end
        end
    end
end)

Citizen.CreateThread(function()
    if not Config['ShopRobbery']['cooldown']['globalCooldown'] then
        for i = 1, #Config['ShopRobberySetup'] do
            lastrob[i] = 0
        end
    else
        lastrob = 0
    end
    if Config['ShopRobbery']['framework']['name'] == 'ESX' then
		
        ESX.RegisterServerCallback('shoprobbery:server:checkPoliceCount', function(source, cb)
            local src = source
            local players = ESX.GetPlayers()
            local policeCount = 0
        
            for i = 1, #players do
                local player = ESX.GetPlayerFromId(players[i])
                if player['job']['name'] == Config['ShopRobbery']['setjobForPolice'] then
                    policeCount = policeCount + 1
                end
            end
        
            if policeCount >= Config['ShopRobbery']['requiredPoliceCount'] then
                cb({status = true})
            else
                cb({status = false})
                TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['need_police'], 'error')
            end
        end)
        ESX.RegisterServerCallback('shoprobbery:server:checkTime', function(source, cb, index)
            local src = source
            local player = ESX.GetPlayerFromId(src)
            
            if not Config['ShopRobbery']['cooldown']['globalCooldown'] then
                if (os.time() - lastrob[index]) < Config['ShopRobbery']['cooldown']['time'] and lastrob[index] ~= 0 then
                    local seconds = Config['ShopRobbery']['cooldown']['time'] - (os.time() - lastrob[index])
                    TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsShops['minute'], 'info')
                    cb({status = false})
                else
                    lastrob[index] = os.time()
                    discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Começou um Assalto a uma Loja!')
					TriggerEvent('qb-scoreboard:server:SetActivityBusy', "lojas", true)
                    cb({status = true})
                end
            else
                if (os.time() - lastrob) < Config['ShopRobbery']['cooldown']['time'] and lastrob ~= 0 then
                    local seconds = Config['ShopRobbery']['cooldown']['time'] - (os.time() - lastrob)
                    TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsShops['minute'], 'info')
                    cb({status = false})
                else
                    lastrob = os.time()
                    discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' começou um Assalto a uma Loja!')
					TriggerEvent('qb-scoreboard:server:SetActivityBusy', "lojas", true)
                    cb({status = true})
                end
            end
        end)
        ESX.RegisterServerCallback('shoprobbery:server:hasItem', function(source, cb, data)
            local src = source
            local player = ESX.GetPlayerFromId(src)
            local playerItem = player.getInventoryItem(data.itemName)
        
            if player and playerItem ~= nil then
                if playerItem.count >= 1 then
                    cb({status = true, label = playerItem.label})
                else
                    cb({status = false, label = playerItem.label})
                end
            else
                print('[rm_shoprobbery] you need add required items to server database')
            end
        end)
        ESX.RegisterServerCallback('shoprobbery:server:isOwnerOnline', function(source, cb, index)
            local src = source
            if Config['enableLixeiroCharmosoMarkets'] and Config['LixeiroCharmosoMarketsSettings']['require_owner_be_online'] then
                local charmosoMarket = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['marketId']
                local sql = "SELECT user_id FROM store_business WHERE market_id = @market_id";
                local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = charmosoMarket});
                if query and query[1] then
                    local owner = ESX.GetPlayerFromIdentifier(query[1].user_id)
                    if owner and owner.source then
                        cb({status = true})
                    else
                        TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['charmoso_no_owner_online'], 'error')
                        cb({status = false})
                    end
                else
                    cb({status = true})
                end
            else
                cb({status = true})
            end
        end)
    elseif Config['ShopRobbery']['framework']['name'] == 'QB' then
        while not QBCore do
            pcall(function() QBCore =  exports[Config['ShopRobbery']['framework']['scriptName']]:GetCoreObject() end)
            if not QBCore then
                pcall(function() QBCore =  exports[Config['ShopRobbery']['framework']['scriptName']]:GetSharedObject() end)
            end
            if not QBCore then
                TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            end
            Citizen.Wait(1)
        end
        QBCore.Functions.CreateCallback('shoprobbery:server:checkPoliceCount', function(source, cb)
            local src = source
            local players = QBCore.Functions.GetPlayers()
            local policeCount = 0
        
            for i = 1, #players do
                local player = QBCore.Functions.GetPlayer(players[i])
                if player.PlayerData.job.name == Config['ShopRobbery']['setjobForPolice'] then
                    policeCount = policeCount + 1
                end
            end
        
            if policeCount >= Config['ShopRobbery']['requiredPoliceCount'] then
                cb({status = true})
            else
                cb({status = false})
                TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['need_police'], 'error')
            end
        end)
        QBCore.Functions.CreateCallback('shoprobbery:server:checkTime', function(source, cb, index)
            local src = source
            local player = QBCore.Functions.GetPlayer(src)

            if not Config['ShopRobbery']['cooldown']['globalCooldown'] then
                if (os.time() - lastrob[index]) < Config['ShopRobbery']['cooldown']['time'] and lastrob[index] ~= 0 then
                    local seconds = Config['ShopRobbery']['cooldown']['time'] - (os.time() - lastrob[index])
                    TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsShops['minute'], 'info')
                    cb({status = false})
                else
                    lastrob[index] = os.time()
                    discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' started the Shop Robbery!')
                    cb({status = true})
                end
            else
                if (os.time() - lastrob) < Config['ShopRobbery']['cooldown']['time'] and lastrob ~= 0 then
                    local seconds = Config['ShopRobbery']['cooldown']['time'] - (os.time() - lastrob)
                    TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. StringsShops['minute'], 'info')
                    cb({status = false})
                else
                    lastrob = os.time()
                    discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' started the Shop Robbery!')
                    cb({status = true})
                end
            end
        end)
        QBCore.Functions.CreateCallback('shoprobbery:server:hasItem', function(source, cb, data)
            local src = source
            local player = QBCore.Functions.GetPlayer(src)
            local playerItem = player.Functions.GetItemByName(data.itemName)
        
            if player then 
                if playerItem ~= nil then
                    if playerItem.amount >= 1 then
                        cb({status = true, label = data.itemName})
                    end
                else
                    cb({status = false, label = data.itemName})
                end
            end
        end)
        QBCore.Functions.CreateCallback('shoprobbery:server:isOwnerOnline', function(source, cb, index)
            local src = source
            if Config['enableLixeiroCharmosoMarkets'] and Config['LixeiroCharmosoMarketsSettings']['require_owner_be_online'] then
                local charmosoMarket = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['marketId']
                local sql = "SELECT user_id FROM store_business WHERE market_id = @market_id";
                local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = charmosoMarket});
                if query and query[1] then
                    local owner = QBCore.Functions.GetPlayerByCitizenId(query[1].user_id)
                    if owner and owner.PlayerData and owner.PlayerData.source then
                        cb({status = true})
                    else
                        TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['charmoso_no_owner_online'], 'error')
                        cb({status = false})
                    end
                else
                    cb({status = true})
                end
            else
                cb({status = true})
            end
        end)
    end
end)

RegisterServerEvent('shoprobbery:server:rewardItem')
AddEventHandler('shoprobbery:server:rewardItem', function(item, count, type, index)
    local src = source

    if Config['ShopRobbery']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        local whitelistItems = {}

        if player then
            if type == 'money' then
                local sourcePed = GetPlayerPed(src)
                local sourceCoords = GetEntityCoords(sourcePed)
                local dist = #(sourceCoords - Config['ShopRobberySetup'][index]['pedSetup']['coords'])
                if dist > 30.0 then
                    TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Dinheiro")
                else
                    local charmosoMarket = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['marketId']
                    if item == 'safecrack' then
                        --This is safecrack money
                        if Config['enableLixeiroCharmosoMarkets'] then
                            local sql = "SELECT user_id, stock, stock_prices FROM `store_business` WHERE market_id = @market_id";
                            local query = MySQL.Sync.fetchAll(sql,{['@market_id'] = charmosoMarket})[1];
                            if query then
                                local arr_stock = json.decode(query.stock)
                                for k, v in pairs(arr_stock) do
                                    local robbedAmount = math.floor(v*Config['LixeiroCharmosoMarketsSettings']['items_percentage_earned'])
                                    arr_stock[k] = arr_stock[k] - robbedAmount
                                    if arr_stock[k] == 0 then
                                        arr_stock[k] = nil
                                    end
                                    player.addInventoryItem(k, robbedAmount)
                                    discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. k .. ' x' .. robbedAmount .. ' no Assalto à Loja!')
                                end
                                local sql = "UPDATE `store_business` SET stock = @stock WHERE market_id = @market_id";
                                MySQL.Sync.execute(sql, {['@market_id'] = charmosoMarket, ['@stock'] = json.encode(arr_stock)});
                                
                                local owner = ESX.GetPlayerFromIdentifier(query.user_id)
                                if owner and owner.source then
                                    TriggerClientEvent('shoprobbery:client:showNotification', owner.source, StringsShops['charmoso_store_being_robbed'], 'info')
                                end
                            else
                                if Config['ShopRobbery']['black_money']['status'] then
                                    player.addAccountMoney('black_money', count)
                                    discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. count .. '€ no Assalto à Loja!')
                                else
                                    player.addMoney(count)
                                    discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. count .. '€ no Assalto à Loja!')
                                end
                            end
                        else
                            if Config['ShopRobbery']['black_money']['status'] then
                                player.addAccountMoney('black_money', count)
                                discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. count .. '€ no Assalto à Loja!')
                            else
                                player.addMoney(count)
                                discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. count .. '€ no Assalto à Loja!')
                            end
                        end
                    else
                        --This is grab till money
                        if Config['enableLixeiroCharmosoMarkets'] then
                            local sql = "SELECT user_id, money, stock_prices FROM store_business WHERE market_id = @market_id";
                            local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = charmosoMarket});
                            if query and query[1] then
                                if Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] > 0 then
                                    count = query[1].money / Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill']
                                    count = math.floor(count * Config['LixeiroCharmosoMarketsSettings']['money_percentage_earned'])
                                else
                                    count = 0
                                end

                                local sql = "UPDATE `store_business` SET money = money - @count WHERE market_id = @market_id";
                                MySQL.Sync.execute(sql, {['@market_id'] = charmosoMarket, ['@count'] = count});
                                Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] - 1

                                local sql = "INSERT INTO `store_balance` (market_id,income,title,amount,date) VALUES (@market_id,@income,@title,@amount,@date)";
	                            MySQL.Sync.execute(sql, {['@market_id'] = charmosoMarket, ['@income'] = 1, ['@title'] = StringsShops['charmoso_log_title'], ['@amount'] = count, ['@date'] = os.time()});

                                local owner = ESX.GetPlayerFromIdentifier(query[1].user_id)
                                if owner and owner.source then
                                    TriggerClientEvent('shoprobbery:client:showNotification', owner.source, StringsShops['charmoso_store_being_robbed'], 'info')
                                end
                            end
                        end

                        if Config['ShopRobbery']['black_money']['status'] then
                            player.addAccountMoney('black_money', count)
                            discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. count .. '€ no Assalto à Loja!')
                        else
                            player.addMoney(count)
                            discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. count .. '€ no Assalto à Loja!')
                        end
                    end
                end
            else
                --This is safecrack reward items
                for k, v in pairs(Config['ShopRobbery']['rewardItems']) do
                    whitelistItems[v['itemName']] = true
                end

                if whitelistItems[item] then
                    if count then 
                        player.addInventoryItem(item, count)
                        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. item .. ' x' .. count .. ' no Assalto à Loja!')
                    else
                        player.addInventoryItem(item, 1)
                        discordLog(GetPlayerName(src) ..  ' - ' .. player.getIdentifier(), ' Ganhou ' .. item .. ' x' .. 1 .. ' no Assalto à Loja!')
                    end
                else
                    print('[rm_shoprobbery] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
                end
            end
        end
		TriggerEvent('qb-scoreboard:server:SetActivityBusy', "lojas", false)
    elseif Config['ShopRobbery']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
        local whitelistItems = {}

        if player then
            if type == 'money' then
                local sourcePed = GetPlayerPed(src)
                local sourceCoords = GetEntityCoords(sourcePed)
                local dist = #(sourceCoords - Config['ShopRobberySetup'][index]['pedSetup']['coords'])
                if dist > 30.0 then
                    print('[rm_shoprobbery] add money exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
                else
                    local charmosoMarket = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['marketId']
                    if item == 'safecrack' then
                        --This is safecrack money
                        if Config['enableLixeiroCharmosoMarkets'] then
                            local sql = "SELECT user_id, stock, stock_prices FROM `store_business` WHERE market_id = @market_id";
                            local query = MySQL.Sync.fetchAll(sql,{['@market_id'] = charmosoMarket})[1];
                            if query then
                                local arr_stock = json.decode(query.stock)
                                for k, v in pairs(arr_stock) do
                                    local robbedAmount = math.floor(v*Config['LixeiroCharmosoMarketsSettings']['items_percentage_earned'])
                                    arr_stock[k] = arr_stock[k] - robbedAmount
                                    if arr_stock[k] == 0 then
                                        arr_stock[k] = nil
                                    end
                                    player.Functions.AddItem(k, robbedAmount)
                                    discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. k .. ' x' .. robbedAmount .. ' on Shop Robbery!')
                                end
                                local sql = "UPDATE `store_business` SET stock = @stock WHERE market_id = @market_id";
                                MySQL.Sync.execute(sql, {['@market_id'] = charmosoMarket, ['@stock'] = json.encode(arr_stock)});
                                
                                local owner = QBCore.Functions.GetPlayerByCitizenId(query.user_id)
                                if owner and owner.PlayerData and owner.PlayerData.source then
                                    TriggerClientEvent('shoprobbery:client:showNotification', owner.PlayerData.source, StringsShops['charmoso_store_being_robbed'], 'info')
                                end
                            else
                                if Config['ShopRobbery']['black_money']['status'] then
                                    player.Functions.AddItem(Config['ShopRobbery']['black_money']['itemName'], count)
                                    discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Shop Robbery!')
                                else
                                    player.Functions.AddMoney('cash', count)
                                    discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Shop Robbery!')
                                end
                            end
                        else
                            if Config['ShopRobbery']['black_money']['status'] then
                                player.Functions.AddItem(Config['ShopRobbery']['black_money']['itemName'], count)
                                discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Shop Robbery!')
                            else
                                player.Functions.AddMoney('cash', count)
                                discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Shop Robbery!')
                            end
                        end
                    else
                        --This is grab till money
                        if Config['enableLixeiroCharmosoMarkets'] then
                            local sql = "SELECT user_id, money, stock_prices FROM store_business WHERE market_id = @market_id";
                            local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = charmosoMarket});
                            if query and query[1] then
                                if Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] > 0 then
                                    count = query[1].money / Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill']
                                    count = math.floor(count * Config['LixeiroCharmosoMarketsSettings']['money_percentage_earned'])
                                else
                                    count = 0
                                end

                                local sql = "UPDATE `store_business` SET money = money - @count WHERE market_id = @market_id";
                                MySQL.Sync.execute(sql, {['@market_id'] = charmosoMarket, ['@count'] = count});
                                Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] - 1

                                local sql = "INSERT INTO `store_balance` (market_id,income,title,amount,date) VALUES (@market_id,@income,@title,@amount,@date)";
	                            MySQL.Sync.execute(sql, {['@market_id'] = charmosoMarket, ['@income'] = 1, ['@title'] = StringsShops['charmoso_log_title'], ['@amount'] = count, ['@date'] = os.time()});

                                local owner = QBCore.Functions.GetPlayerByCitizenId(query[1].user_id)
                                if owner and owner.PlayerData and owner.PlayerData.source then
                                    TriggerClientEvent('shoprobbery:client:showNotification', owner.PlayerData.source, StringsShops['charmoso_store_being_robbed'], 'info')
                                end
                            end
                        end
                        
                        if Config['ShopRobbery']['black_money']['status'] then
                            player.Functions.AddItem(Config['ShopRobbery']['black_money']['itemName'], count)
                            discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Shop Robbery!')
                        else
                            player.Functions.AddMoney('cash', count)
                            discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Gain ' .. count .. '$ on Shop Robbery!')
                        end
                    end
                end
            else
                for k, v in pairs(Config['ShopRobbery']['rewardItems']) do
                    whitelistItems[v['itemName']] = true
                end

                if whitelistItems[item] then
                    if count then 
                        player.Functions.AddItem(item, count)
                        discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Ganhou ' .. item .. ' x' .. count .. ' on Shop Robbery!')
                    else
                        player.Functions.AddItem(item, 1)
                        discordLog(player.PlayerData.name ..  ' - ' .. player.PlayerData.license, ' Ganhou ' .. item .. ' x' .. 1 .. ' on Shop Robbery!')
                    end
                else
                    print('[rm_shoprobbery] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
                end
            end
        end
    end
end)

RegisterCommand('pdshop', function(source, args)
    local src = source

    if Config['ShopRobbery']['framework']['name'] == 'ESX' then
        local player = ESX.GetPlayerFromId(src)
        
        if player then
            if player['job']['name'] == Config['ShopRobbery']['setjobForPolice'] then
                local sourcePed = GetPlayerPed(src)
                local sourceCoords = GetEntityCoords(sourcePed)
                local near = false
                for i = 1, #Config['ShopRobberySetup'] do
                    local dist = #(sourceCoords - Config['ShopRobberySetup'][i]['pedSetup']['coords'])
                    if dist <= 10.0 then
                        near = true
                        index = i
                        break
                    end
                end
                if near then
                    Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['tillAmount']
                    TriggerClientEvent('shoprobbery:client:resetHeist', -1, index)
                else
                    TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['not_near'], 'error')
                end
            else
                TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['not_cop'], 'error')
            end
        end
    elseif Config['ShopRobbery']['framework']['name'] == 'QB' then
        local player = QBCore.Functions.GetPlayer(src)
    
        if player then
            if player.PlayerData.job.name == Config['ShopRobbery']['setjobForPolice'] then
                local sourcePed = GetPlayerPed(src)
                local sourceCoords = GetEntityCoords(sourcePed)
                local near = false
                for i = 1, #Config['ShopRobberySetup'] do
                    local dist = #(sourceCoords - Config['ShopRobberySetup'][i]['pedSetup']['coords'])
                    if dist <= 10.0 then
                        near = true
                        index = i
                        break
                    end
                end
                if near then
                    Config['ShopRobberySetup'][index]['lixeiroCharmoso']['remainingTill'] = Config['ShopRobberySetup'][index]['lixeiroCharmoso']['tillAmount']
                    TriggerClientEvent('shoprobbery:client:resetHeist', -1, index)
                else
                    TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['not_near'], 'error')
                end
            else
                TriggerClientEvent('shoprobbery:client:showNotification', src, StringsShops['not_cop'], 'error')
            end
        end
    end
end)

RegisterServerEvent('shoprobbery:server:sync')
AddEventHandler('shoprobbery:server:sync', function(type, index, index2)
    if type ~= 'startRobbery' then
        TriggerClientEvent('shoprobbery:client:sync', -1, type, index, index2)
    else
        local chance = math.random(1, 100)
        TriggerClientEvent('shoprobbery:client:sync', -1, type, index, index2, chance)
    end
end)