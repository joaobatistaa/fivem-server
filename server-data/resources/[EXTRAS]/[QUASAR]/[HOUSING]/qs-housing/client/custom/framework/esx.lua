--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

Citizen.CreateThread(function()
    ESX = exports['es_extended']:getSharedObject()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
    PlayerHousesLoaded()
end)

local firstTimeEnter = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
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

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    firstTimeEnter = false
    while not firstTimeEnter do Citizen.Wait(100) end
    PlayerData = ESX.GetPlayerData()
    
    TriggerServerCallback('housing:server:getAllHouses', function(houses)
        Config.Houses = houses
        CreateBlips()
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function GetPlayerIdentifier()
    return ESX.GetPlayerData().identifier
end

function GetPlayers()
    return ESX.Game.GetPlayers()
end

function GetClosestPlayer()
    return ESX.Game.GetClosestPlayer()
end

function CustomLeaveHouse()
    
end

function CustomJoinHouse()

end

RegisterNetEvent('housing:esx_society', function(name, price) 
    TriggerServerEvent('esx_society:depositMoney', name, price)
end)

function SendTextMessage(msg, type)
    if type == 'inform' then 
        exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'info')
    end
    if type == 'error' then 
        exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'error')
    end
    if type == 'success' then 
        exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'success')
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