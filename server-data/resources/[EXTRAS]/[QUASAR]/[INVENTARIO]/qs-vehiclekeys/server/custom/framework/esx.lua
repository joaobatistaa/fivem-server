--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.
    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

local version = GetResourceMetadata('es_extended', 'version', 0)

if version == '1.1.0' or version == '1.2.0' or version == 'legacy' then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
    ESX = exports['es_extended']:getSharedObject()
end

identifierTypes = 'owner'
vehiclesTable = 'owned_vehicles'
plateTable = 'plate'


function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function GetPlayerFromIdFramework(player)
	local Player = ESX.GetPlayerFromId(player)
	return Player
end

function GetPlayerIdentifier(player)
	return ESX.GetPlayerFromId(player).identifier
end

function GetPlayerJob(player)
    return player.getJob().name
end

function GetPlayerDuty(player)
    return true 
end

function GetPlayers()
	return ESX.GetPlayers()
end

function GetMoney(player)
    return player.getMoney()
end

function RemoveMoney(player, mount)
    return player.removeMoney(mount)
end

function GetAccountMoney(player, account)
    return player.getAccount(account).money
end

function RemovAccountMoney(player, account, mount)
    return player.removeAccountMoney(account, mount)
end

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetItem(player, item)
    return player.getInventoryItem(item)
end

function GetItemCount(player, item)
    return player.getInventoryItem(item).count
end

function AddItem(player, item, metadata)
    player.addInventoryItem(item, 1, metadata)
end

function RemoveItem(player, item)
    player.removeInventoryItem(item, 1, metadata)
end

function SetInventoryItem(player)
    return true
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