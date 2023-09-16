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
userColumns = 'players'
accountsType = 'money'
skinTable = 'playerskins'

RegisterNetEvent('QBCore:Client:OnJobUptade')
AddEventHandler('QBCore:Client:OnJobUptade', function(id, xPlayer)
    Citizen.Wait(500)
    TriggerClientEvent('housing:client:setIplData', id, iplHouses)
end)

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

function GetIdentifier(player)
    return QBCore.Functions.GetPlayerByCitizenId(player)
end

function GetCharacterName(source)
    local player = GetPlayerFromId(source).PlayerData.charinfo
    return player.firstname, player.lastname
end

function GetJob(player)
    return GetPlayerFromId(player).PlayerData.job
end

function GetJobName(player)
    return GetPlayerFromId(player).PlayerData.job.name
end

function GetJobGrade(player)
    return GetPlayerFromId(player).PlayerData.job.grade.level
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetPlayerIdentifier(id)
    local player = QBCore.Functions.GetPlayerByCitizenId(id)
    if player then 
        player.source = player.PlayerData.source
    end
    return player
end

function GetMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.PlayerData.money['cash']
end

function AddMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.AddMoney('cash', price)
end

function RemoveMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.RemoveMoney('cash', price)
end

function GetBankMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.PlayerData.money['bank']
end

function AddBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.AddMoney('bank', price)
end

function RemoveBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.RemoveMoney('bank', price)
end

function RemoveItem(source, item, count)
    local xPlayer = GetPlayerFromId(source, true)
    xPlayer.Functions.RemoveItem(item, count)
end

function GetItem(player, item)
    return player.Functions.GetItemByName(item)
end

function GetItemCount(player, item)
    return player.Functions.GetItemByName(item).amount
end

function AddItem(source, item, count)
    local xPlayer = GetPlayerFromId(source, true)
    xPlayer.Functions.AddItem(item, count)
end

function RemoveItem(source, item, count)
    local xPlayer = GetPlayerFromId(source, true)
    xPlayer.Functions.RemoveItem(item, count)
end