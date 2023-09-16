--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "qb" then
    return
end

Citizen.CreateThread(function()
    QBCore = exports['qb-core']:GetCoreObject()

    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerHousesLoaded()
end)

qbcoreMenu = 'qb-menu' -- Only if use a custom name of qb-menu
qbcoreInput = 'qb-input' -- Only if use a custom name of qb-input
qbcoreRadial = 'qb-radialmenu' -- Only if use a custom name of qb-radialmenu

local firstTimeEnter = false
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(playerData)
    PlayerData = playerData
    while Config.Houses == nil do Citizen.Wait(100) end
    if not firstTimeEnter then
        firstTimeEnter = true
        TriggerServerCallback('housing:server:getInside', function(inside1) 
            if inside1 and inside1 ~= 'nil' and inside1 ~= '' and inside1 ~= nil then
                ShowStashAndWardrobe = false
                Citizen.Wait(250)
                DebugPrint("lastLocationHouse: inside check", json.encode(inside1))
                TriggerEvent('housing:client:lastLocationHouse', inside1)
            end
        end)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    firstTimeEnter = false
    while not firstTimeEnter do Wait(100) end
    PlayerData = QBCore.Functions.GetPlayerData()
    
    TriggerServerCallback('housing:server:getAllHouses', function(houses)
        Config.Houses = houses
        CreateBlips()
    end)
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

function TriggerServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb, ...)
end

function GetPlayerIdentifier()
    return QBCore.Functions.GetPlayerData().citizenid
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetClosestPlayer()
    return QBCore.Functions.GetClosestPlayer()
end

function CustomLeaveHouse()

end

function CustomJoinHouse()

end

function SendTextMessage(msg, type)
    if type == 'inform' then
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
    end
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, false, -1)
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end