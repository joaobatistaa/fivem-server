ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("battlepass", function(source, args, rawCommand)
    function on()
        TriggerEvent('battlepass:setLevel', source)
        TriggerEvent('battlepass:sendStdPass', source)
        TriggerEvent('battlepass:sendPrmPass', source)
        TriggerEvent('battlepass:sendTask', source)
        TriggerEvent('battlepass:getName', source)
    end
    on()
end, true)

RegisterNetEvent('battlepass:getName')
AddEventHandler('battlepass:getName', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll('SELECT xp, level FROM `battlepass` WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
    local result_2 = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM `users` WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
    MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)
        if #result > 0 then
            TriggerClientEvent('battlepass:sendName', source, result_2[1].firstname, result_2[1].lastname, result[1].xp, result[1].level, result[1].premium)
        else
            MySQL.Async.execute('INSERT INTO battlepass (`identifier`) VALUES (@identifier);', {   
                identifier = identifier
            }, function()
            end)
            on()
        end
    end)
end)

RegisterNetEvent('battlepass:sendStdPass')
AddEventHandler('battlepass:sendStdPass', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        local identifier = xPlayer.getIdentifier()

        MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)
            local std_1 = result[1].std_redeem_1
            local std_2 = result[1].std_redeem_2
            local std_3 = result[1].std_redeem_3
            local std_4 = result[1].std_redeem_4
            local std_5 = result[1].std_redeem_5

            TriggerClientEvent('battlepass:checkStdPass', source, std_1, std_2, std_3, std_4, std_5)
        end)
    end
end)

RegisterNetEvent('battlepass:sendPrmPass')
AddEventHandler('battlepass:sendPrmPass', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        local identifier = xPlayer.getIdentifier()

        MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)
            local prm_1 = result[1].prm_redeem_1
            local prm_2 = result[1].prm_redeem_2
            local prm_3 = result[1].prm_redeem_3
            local prm_4 = result[1].prm_redeem_4
            local prm_5 = result[1].prm_redeem_5
        
            TriggerClientEvent('battlepass:checkPrmPass', source, prm_1, prm_2, prm_3, prm_4, prm_5)
        end)
    end
end)

RegisterNetEvent('battlepass:sendTask')
AddEventHandler('battlepass:sendTask', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        local identifier = xPlayer.getIdentifier()

        MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)
            local task_1 = result[1].task_1
            local task_2 = result[1].task_2
            local task_3 = result[1].task_3
            local task_4 = result[1].task_4
            local task_5 = result[1].task_5
            local task_6 = result[1].task_6
            local task_7 = result[1].task_7
            local task_8 = result[1].task_8
            local task_9 = result[1].task_9
            local task_10 = result[1].task_10

        
            TriggerClientEvent('battlepass:checkTask', source, task_1, task_2, task_3, task_4, task_5, task_6, task_7, task_8, task_9, task_10)
        end)
    end
end)

RegisterNetEvent('battlepass:addQuest')
AddEventHandler('battlepass:addQuest', function(quest)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)
        if quest == 1 then
            if result[1].task_1 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_1 = @task_1 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_1'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 2 then
            if result[1].task_2 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_2 = @task_2 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_2'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 3 then
            if result[1].task_3 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_3 = @task_3 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_3'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 4 then
            if result[1].task_4 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_4 = @task_4 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_4'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 5 then
            if result[1].task_5 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_5 = @task_5 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_5'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 6 then
            if result[1].task_6 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_6 = @task_6 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_6'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 7 then
            if result[1].task_7 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_7 = @task_7 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_7'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 8 then
            if result[1].task_8 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_8 = @task_8 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_8'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 9 then
            if result[1].task_9 == false then
                local xp = result[1].xp
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_9 = @task_9 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_9'] = 1,
                    ['@identifier'] = identifier
                })
            end
        elseif quest == 10 then
            if result[1].task_10 == false then
                MySQL.Sync.execute("UPDATE battlepass SET xp = @xp, task_10 = @task_10 WHERE identifier = @identifier", {
                    ['@xp'] = xp + 300,
                    ['@task_10'] = 1,
                    ['@identifier'] = identifier
                })
            end
        end
    end)
end)

RegisterNetEvent('standart-redeem')
AddEventHandler('standart-redeem', function(passlevel)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)
        if passlevel == 1 then
            if result[1].std_redeem_1 == false then
                for location, val in pairs(Config.Standart_Pass_Gewinn_1) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 1 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET std_redeem_1 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendStdPass', source)
                    end
                end
            end
        elseif passlevel == 2 then
            if result[1].std_redeem_2 == false then
                for location, val in pairs(Config.Standart_Pass_Gewinn_2) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 2 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET std_redeem_2 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendStdPass', source)
                    end
                end
            end
        elseif passlevel == 3 then
            if result[1].std_redeem_3 == false then
                for location, val in pairs(Config.Standart_Pass_Gewinn_3) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 3 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET std_redeem_3 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendStdPass', source)
                    end
                end
            end
        elseif passlevel == 4 then
            if result[1].std_redeem_4 == false then
                for location, val in pairs(Config.Standart_Pass_Gewinn_4) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 4 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET std_redeem_4 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendStdPass', source)
                    end
                end
            end
        elseif passlevel == 5 then
            if result[1].std_redeem_5 == false then
                for location, val in pairs(Config.Standart_Pass_Gewinn_5) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 5 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end
                    end

                    MySQL.Sync.execute("UPDATE battlepass SET std_redeem_5 = 1 WHERE identifier = @identifier", {
                        ['@identifier'] = identifier
                    })
                    TriggerEvent('battlepass:sendStdPass', source)
                end
            end
        end
    end)
end)

RegisterNetEvent('premium-redeem')
AddEventHandler('premium-redeem', function(passlevel)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)

        if passlevel == 1 then
            print("test")
            if result[1].prm_redeem_1 == false then
                print("test2")
                for location, val in pairs(Config.Premium_Pass_Gewinn_1) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]
                    if result[1].level >= 1 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET prm_redeem_1 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendPrmPass', source)
                    end
                end
            end
        elseif passlevel == 2 then
            if result[1].prm_redeem_2 == false then
                for location, val in pairs(Config.Premium_Pass_Gewinn_2) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 2 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET prm_redeem_2 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendPrmPass', source)
                    end
                end
            end
        elseif passlevel == 3 then
            if result[1].prm_redeem_3 == false then
                for location, val in pairs(Config.Premium_Pass_Gewinn_3) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 3 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET prm_redeem_3 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendPrmPass', source)
                    end
                end
            end
        elseif passlevel == 4 then
            if result[1].prm_redeem_4 == false then
                for location, val in pairs(Config.Premium_Pass_Gewinn_4) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 4 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end

                        MySQL.Sync.execute("UPDATE battlepass SET prm_redeem_4 = 1 WHERE identifier = @identifier", {
                            ['@identifier'] = identifier
                        })
                        TriggerEvent('battlepass:sendPrmPass', source)
                    end
                end
            end
        elseif passlevel == 5 then
            if result[1].prm_redeem_5 == false then
                for location, val in pairs(Config.Premium_Pass_Gewinn_5) do
                    local item = val["item"]
                    local itemreward = val["itemreward"]
                    local money = val["money"]
                    local moneyreward = val["moneyreward"]

                    if result[1].level >= 5 then
                        if item then
                            xPlayer.addInventoryItem(itemreward, 1)
                        elseif money then
                            xPlayer.addMoney(moneyreward)
                        end
                    end

                    MySQL.Sync.execute("UPDATE battlepass SET prm_redeem_5 = 1 WHERE identifier = @identifier", {
                        ['@identifier'] = identifier
                    })
                    TriggerEvent('battlepass:sendPrmPass', source)
                end
            end
        end
        
    end)
end)


RegisterNetEvent('battlepass:setLevel')
AddEventHandler('battlepass:setLevel', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * from battlepass WHERE identifier = @identifier', {["@identifier"] = identifier}, function(result)
        if result[1].xp == 600 then
            local level = result[1].level

            MySQL.Sync.execute("UPDATE battlepass SET level = @level, xp = @xp WHERE identifier = @identifier", {
                ['@level'] = level + 1,
                ['@xp'] = 0,
                ['@identifier'] = identifier
            })
        end
    end)
end)