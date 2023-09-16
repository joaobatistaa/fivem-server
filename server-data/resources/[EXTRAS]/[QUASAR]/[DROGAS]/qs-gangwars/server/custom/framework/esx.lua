--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

local legacyEsx = pcall(function()
    ESX = exports['es_extended']:getSharedObject()
end)
if not legacyEsx then  
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function AddItem(source, item, count)
    local xPlayer = GetPlayerFromId(source, true)
    xPlayer.addInventoryItem(item, count)
end

function RemoveItem(source, item, count)
    local xPlayer = GetPlayerFromId(source, true)
    xPlayer.removeInventoryItem(item, count)
end

RegisterServerCallback('gangwars:server:getPolice', function(source, cb)
    local PoliceCount = 0

    for k, v in pairs(ESX.GetPlayers()) do
        local Player = GetPlayerFromId(v)
        if Player ~= nil then
            if (Player.getJob().name == Config.ReqJobPolice) then
                PoliceCount = PoliceCount + 1
            end

        end
    end
    cb(PoliceCount)
end)

AddEventHandler("gangwars:server:loot", function(id)
    local source = id
    local xPlayer = ESX.GetPlayerFromId(source)
    local LootItemCount = Config.ItemCount

    while LootItemCount > 0 do
        local new_loot = math.random(1,#Config.ItemsDrop)

        current_loot = Config.ItemsDrop[new_loot]
        AddItem(source, current_loot.Item, current_loot.count)
        LootItemCount = LootItemCount - 1
    end

    if Config.Weapons then
        random = math.random(1,99)
        if random < Config.WeaponChance then
          local new_weapon = math.random(1,#Config.WeaponsDrop)

          current_weapon = Config.WeaponsDrop[new_weapon]
          xPlayer.addWeapon(current_weapon.weapon, current_weapon.ammo_count)
        end
    end
end)