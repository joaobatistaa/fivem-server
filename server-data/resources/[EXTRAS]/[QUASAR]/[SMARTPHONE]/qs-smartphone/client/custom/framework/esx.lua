--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
	while QS == nil do
		TriggerEvent('qs-base:getSharedObject', function(ASD) QS = ASD end)
		Citizen.Wait(0)
	end
	Citizen.Wait(200)
	TriggerServerEvent('qs-smartphone:server:btShare', false)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    
    LoadPhone() 

    if Config.UseESXchecks then
        TriggerServerEvent('qs-smartphone:CheckHavePhoneStatus')
    end
    TriggerServerEvent('smartphone:playerLoaded')

    TriggerServerCallback('qs-smartphone:GetUserApps', function(apps)
        SendNUIMessage({
            action = "UpdateApplications",
            JobData = PlayerData.job,
            applications = Config.PhoneApplications
        })
    end)
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    PlayerData = {}
    isLoggedIn = false
    loading = false
    FirstCheckHavePhone = false
    --Config.PhoneApplications = configDefault

    deletePhone()
    deleteMusic()
    UnloadPhone()

    Citizen.Wait(1000)
    TriggerServerEvent('qs-smartphone:CheckHavePhoneStatus')
    TriggerServerEvent('smartphone:unloaded')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    TriggerServerCallback('qs-smartphone:GetUserApps', function(apps)
        SendNUIMessage({
            action = "UpdateApplications",
            JobData = job,
            applications = Config.PhoneApplications
        })
    end)
    PlayerData.job = job
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function GetPlayerIdentifier()
	return ESX.GetPlayerData().identifier
end

function GetPlayerDataFramework()
	return QS.GetPlayerData()
end

function GetJobFramework()
	return ESX.GetPlayerData().job
end

function GetClosestVehicleFramework()
	return ESX.Game.GetClosestVehicle()
end

function GetVehicles()
	return ESX.Game.GetVehicles()
end

function GetClosestPlayer()
	return ESX.Game.GetClosestPlayer()
end
 
function Trim(number)
	return ESX.Math.Trim(number)
end

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