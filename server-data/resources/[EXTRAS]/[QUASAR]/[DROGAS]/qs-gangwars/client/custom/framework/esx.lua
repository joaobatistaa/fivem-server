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
    PlayerData = ESX.GetPlayerData()

    while mLibs == nil do
        mLibs = exports["meta_libs"]
        Citizen.Wait(0)
    end

    while Scenes == nil do
        Scenes = mLibs:SynchronisedScene()
        Citizen.Wait(0)
    end

    TriggerServerEvent('gangwars:server:getAreaOwners')
    Citizen.Wait(1250)
    exports['qs-gangwars']:CreateBlip()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    PlayerData = playerData
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function alternativeJob()
    for k,_ in pairs(Config.DropBlipColors) do
        if PlayerData and PlayerData.job and k == PlayerData.job.name then
            return PlayerData.job.name
        end
    end
    return false
end

function ProgressBar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    if GetResourceState('progressbar') ~= 'started' then error('progressbar needs to be started in order for Progressbar to work') end
    exports['progressbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish then
                onFinish()
            end
        else
            if onCancel then
                onCancel()
            end
        end
    end)
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

function ShowRemTimer() -- Timer when you use Config.ProgressBarTimer in false
    SetTextFont(Config.CapturedText.font) 
    SetTextProportional(0) 
    SetTextScale(0.65, 0.65) 
    SetTextDropShadow(0, 0, 0, 0,255) 
    SetTextEdge(1, 0, 0, 0, 255) 
    SetTextEntry("STRING") 
    AddTextComponentString(Lang("GANGWARS_HELP_CAPTURED_AREA")..timer) 
    DrawText(Config.CapturedText.horizontal, Config.CapturedText.vertical) 
end
  
function drawTxt(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.80)
end
  
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
  
function DrawText3Ds(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end