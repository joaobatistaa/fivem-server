if Config.Framework ~= "qb" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

function GetPlayerFromIdFramework(player)
    local Player = QBCore.Functions.GetPlayer(player)
    if Player then 
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
    end
    return Player
end

function GetCharacterData(source)
    local player = GetPlayerFromIdFramework(source).PlayerData.charinfo
    local sex
    if player.gender == 0 then
        sex = Lang('LICENSES_MAN_LABEL')
    elseif player.gender == 1 then
        sex = Lang('LICENSES_WOMEN_LABEL')
    end
    return player.firstname, player.lastname, sex, player.birthdate 
end

function GetBankMoney(source)
    local xPlayer = GetPlayerFromIdFramework(source)
    return xPlayer.PlayerData.money['bank']
end

function RemoveBankMoney(source, price)
    local xPlayer = GetPlayerFromIdFramework(source)
    xPlayer.Functions.RemoveMoney('bank', price)
end