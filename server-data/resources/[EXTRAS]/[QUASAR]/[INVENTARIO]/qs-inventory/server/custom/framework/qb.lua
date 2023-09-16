if Config.Framework ~= "qb" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

userTable = 'players'
Identifier = 'citizenid'
VehicleTable = 'player_vehicles'
WeaponList = QBCore.Shared.Weapons
ItemList = QBCore.Shared.Items

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function GetPlayerFromId(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerFromIdentifier(identifier)
    return QBCore.Functions.GetPlayerByCitizenId(identifier)
end

function PlayerIsAdmin(source)
    local player = GetPlayerFromId(source)
    return QBCore.Functions.HasPermission(source, 'admin')
end

function FrameworkGetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetPlayerIdentifier(source)
    local player = GetPlayerFromId(source)
    return player.PlayerData.citizenid
end

function GetJobName(source)
    local player = GetPlayerFromId(source)
    return player.PlayerData.job.name
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    if account == 'black_money' then account = 'crypto' end
    return player.PlayerData.money[account]
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

function GetItems(player)
    return player.PlayerData.items
end

function GetItem(player, item)
    return player.Functions.GetItemsByName(item)
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

function GetUserName(identifier)
    local player = GetPlayerFromIdentifier(identifier)
    if player then
        return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname, {
            firstname = player.PlayerData.charinfo.firstname,
            lastname = player.PlayerData.charinfo.lastname,
            birthdate = player.PlayerData.charinfo.birthdate,
            gender = player.PlayerData.charinfo.gender
        }
    end
	return '', {}
end