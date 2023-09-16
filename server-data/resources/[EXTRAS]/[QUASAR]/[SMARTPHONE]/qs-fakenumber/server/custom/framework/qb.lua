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

function GetPlayerFromId(player)
    local Player = QBCore.Functions.GetPlayer(player)
    if Player then 
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
    end
    return Player
end

function CheckPhone(player)
    local havePhone = false
    local xPlayer = QBCore.Functions.GetPlayer(player)
    if xPlayer then
        for k,v in pairs(Config.PhonesProps) do
            local HasPhone = xPlayer.Functions.GetItemByName(k)
            if HasPhone and HasPhone.amount > 0 then
                havePhone = true
                break
            end
        end
    end
    return havePhone
end

function GetJob(player)
    return QBCore.Functions.GetPlayer(player).PlayerData.job
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end