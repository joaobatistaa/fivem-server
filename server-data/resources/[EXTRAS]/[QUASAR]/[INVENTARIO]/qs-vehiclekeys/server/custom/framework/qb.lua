--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.
    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "qb" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

identifierTypes = 'citizenid'
vehiclesTable = 'player_vehicles'
plateTable = 'plate'

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function GetPlayerIdentifier(player)
	return QBCore.Functions.GetPlayer(player).PlayerData.citizenid
end

function GetPlayerFromIdFramework(player)
    local Player = QBCore.Functions.GetPlayer(player)
    if Player then 
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
    end
    return Player
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetPlayerJob(player)
    local data = player.PlayerData.job
    return data.name
end

function GetPlayerDuty(player)
    local data = player.PlayerData.job
    return data.onduty
end

function GetMoney(player)
    return player.PlayerData.money["cash"]
end

function GetAccountMoney(player, account)
    return player.PlayerData.money[account]
end

function RemovAccountMoney(player, account, mount)
    return player.Functions.RemoveMoney(account, mount)
end

function RemoveMoney(player, mount)
    return player.Functions.RemoveMoney("cash", mount)
end

function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

function GetItem(player, item)
    return player.Functions.GetItemByName(item)
end

function GetItemCount(player, item)
    return player.Functions.GetItemByName(item).amount
end

function AddItem(player, item, metadata)
    player.Functions.AddItem(item, 1, false, metadata)
end

function RemoveItem(player, item, metadata)
    player.Functions.RemoveItem(item, 1, false, metadata or nil)
end

function SetInventoryItem(player)
    player.Functions.SetInventory(player.PlayerData.items, true)
end

function AddItemMetadata(player, item, slot, metadata)
    if Config.InventoryScript == 'qs' then
        exports['qs-inventory']:AddItem(player.source, item, 1, nil, metadata)
    elseif Config.InventoryScript == 'qb' then
        player.Functions.AddItem(item, 1, false, metadata)
    elseif Config.InventoryScript == 'ox' then
        ox_inventory:AddItem(source, item, 1, metadata)
    elseif Config.InventoryScript == 'core_inventory' then
        exports['core_inventory']:updateMetadata(player.source, item, metadata)
    else
        error('Inventory bad configured')
    end
end

function GetMetadata(player, item, slot, metadata)
    if Config.InventoryScript == 'qs' then
        return exports['qs-inventory']:GetInventory(player.source)
    elseif Config.InventoryScript == 'qb' then
        return player.PlayerData.items
    elseif Config.InventoryScript == 'ox' then
        return ox_inventory:GetInventoryItems(player.source)
    elseif Config.InventoryScript == 'core_inventory' then
        exports['core_inventory']:getInventory(player.source)
    else
        error('Inventory bad configured')
    end
end

function RemoveItemMetadata(player, item, slot, metadata)
    if Config.InventoryScript == 'qs' then
        exports['qs-inventory']:RemoveItem(player.source, item, 1, slot, metadata)
    elseif Config.InventoryScript == 'qb' then
        player.Functions.RemoveItem(item, 1, false)
    elseif Config.InventoryScript == 'ox' then
        ox_inventory:RemoveItem(player.source, item, 1, metadata, slot)
    elseif Config.InventoryScript == 'core_inventory' then
        exports['core_inventory']:removeItemExact(player.source, metadata)
    else
        error('Inventory bad configured')
    end
end