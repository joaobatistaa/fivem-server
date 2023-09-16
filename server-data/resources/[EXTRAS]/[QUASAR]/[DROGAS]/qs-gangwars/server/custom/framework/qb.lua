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

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

function GetPlayerFromId(player)
    local Player = QBCore.Functions.GetPlayer(player)
    if Player then 
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
    end
    return Player
end

function AddItem(source, item, count)
    local xPlayer = GetPlayerFromId(source, true)
    xPlayer.Functions.AddItem(item, count)
end

function RemoveItem(source, item, count)
    local xPlayer = GetPlayerFromId(source, true)
    xPlayer.Functions.RemoveItem(item, count)
end

RegisterServerCallback('gangwars:server:getPolice', function(source, cb)
    local PoliceCount = 0
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == Config.ReqJobPolice and v.PlayerData.job.onduty then
            PoliceCount = PoliceCount + 1
        end
    end
    cb(PoliceCount)
end)

AddEventHandler("gangwars:server:loot", function(id)
    local source = id
    local xPlayer = GetPlayerFromId(source)
    local LootItemCount = Config.ItemCount

    while LootItemCount > 0 do
        local new_loot = math.random(1,#Config.ItemsDrop)
        
        current_loot = Config.ItemsDrop[new_loot]
        AddItem(source, current_loot.Item, current_loot.count)
        LootItemCount = LootItemCount - 1
    end
end)