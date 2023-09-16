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

vehiclesOwner = 'citizenid'
plateTable = 'plate'
vehiclesTable = 'player_vehicles'

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function GetPlayerFromIdFramework(player)
    local Player = QBCore.Functions.GetPlayer(player)
    if Player then 
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
        Player.PlayerData.charinfo.phone = tostring(Player.PlayerData.charinfo.phone)
    end
    return Player
end

function GetPlayerFromId(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetJob(player)
    if not player then return end
    local data = QBCore.Functions.GetPlayer(player)
    if not data then return "unemployed" end
    local ppdata = data.PlayerData
    return ppdata.job
end

function GetPlayerIdentifier()
    return QBCore.Functions.GetPlayerByCitizenId()
end

function math.round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetDuty(a)
    return QBCore.Functions.GetDutyCount(a)
end