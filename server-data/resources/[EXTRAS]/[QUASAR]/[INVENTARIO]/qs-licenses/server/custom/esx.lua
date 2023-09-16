if Config.Framework ~= "esx" then
    return
end

local version = GetResourceMetadata('es_extended', 'version', 0)

if version == '1.1.0' or version == '1.2.0' then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
    ESX = exports['es_extended']:getSharedObject()
end

function GetPlayerFromIdFramework(player)
	return ESX.GetPlayerFromId(player)
end

function GetCharacterData(source)
    local xPlayer = GetPlayerFromIdFramework(source)
    local firstName, lastName, sex, dateofbirth
    if xPlayer.get then
        firstName = xPlayer.get("firstName")
        lastName = xPlayer.get("lastName")
        if xPlayer.get("sex") == 'm' then
            sex = Lang('LICENSES_MAN_LABEL')
        elseif xPlayer.get("sex") == 'f' then
            sex = Lang('LICENSES_WOMEN_LABEL')
        end
        dateofbirth = xPlayer.get("dateofbirth") or "01/01/2000"
    else
        local name = MySQL.Sync.fetchAll("SELECT `firstname`, `lastname`, `dateofbirth`, `sex` FROM `users` WHERE `identifier`=@identifier", {["@identifier"] = ESX.GetIdentifier(source)})
        firstName = name[1]?.firstname
        lastName = name[1]?.lastname
        if name[1]?.sex == 'm' then
            sex = Lang('LICENSES_MAN_LABEL')
        elseif name[1]?.sex == 'f' then
            sex = Lang('LICENSES_WOMEN_LABEL')
        end
        dateofbirth =  name[1]?.dateofbirth
    end

    return firstName, lastName, sex, dateofbirth
end

function GetBankMoney(source)
    local xPlayer = GetPlayerFromIdFramework(source)
    return xPlayer.getAccount('bank').money
end

function RemoveBankMoney(source, price)
    local xPlayer = GetPlayerFromIdFramework(source)
    xPlayer.removeAccountMoney('bank', price)
end