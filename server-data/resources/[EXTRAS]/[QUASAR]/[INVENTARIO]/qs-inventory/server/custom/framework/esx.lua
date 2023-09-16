if Config.Framework ~= "esx" then
    return
end

ESX = exports['es_extended']:getSharedObject()

userTable = 'users'
Identifier = 'identifier'
VehicleTable = 'owned_vehicles'
WeaponList = WeaponList
ItemList = ItemList

StarterItems = { 
    ['water'] = 5,
    ['bread'] = 5,
}

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier)
end

function PlayerIsAdmin(source)
    local player = GetPlayerFromId(source)
    return player.getGroup() == 'admin' or player.getGroup() == 'superadmin'
end

function FrameworkGetPlayers()
    return ESX.GetPlayers()
end

function GetPlayerIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then return Citizen.Wait(100) end
    return player.identifier
end

function GetJobName(source)
    local player = GetPlayerFromId(source)
    return player.getJob().name
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    return player.getAccount(account).money
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.addAccountMoney(account, amount)
end

function GetItems(player)
    return player.getInventory()
end

function GetItem(player, item)
    return player.getInventoryItem(item)
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.removeAccountMoney(account, amount)
end

function GetUserName(identifier)
    local result = MySQL.prepare.await('SELECT firstname, lastname, dateofbirth, sex FROM users WHERE identifier = ?', {identifier})
    if result then
        return result.firstname .. ' ' .. result.lastname, {
            firstname = result.firstname,
            lastname = result.lastname,
            birthdate = result.dateofbirth,
            gender = result.sex
        }
    end
	return '', {}
end