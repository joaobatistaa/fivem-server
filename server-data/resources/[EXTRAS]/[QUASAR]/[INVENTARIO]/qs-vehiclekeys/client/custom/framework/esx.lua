if Config.Framework ~= "esx" then
    return
end

ESX = nil

ESX = exports['es_extended']:getSharedObject()

nh_trigger = 'nh-context:createMenu'

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    if Config.EnableItemPlate then
        Start()
    end
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function GetVehicleProperties(vehicle)
	return ESX.Game.GetVehicleProperties(vehicle)
end

function GetPlateVeh(vehicle)
	local veh = ESX.Game.GetVehicleProperties(vehicle)
    if not veh then return false end
    return veh.plate
end

function GetClosestVehicle()
    return ESX.Game.GetClosestVehicle()
end

function GetJobFramework()
    return ESX.GetPlayerData().job
end

function GetVehiclesInArea()
    if Config.Debug then
        TriggerServerEvent(Config.Eventprefix..':server:serverLog', 'Vehicles in area : '..json.encode(ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), Config.LockDistance), {indent=true})..'')
    end
    return ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), Config.LockDistance)
end

function CheckPolice()
    if Config.ReqPolice then 
        local canRob = nil
        TriggerServerCallback(Config.Eventprefix..':server:GetPolice', function(check)
            canRob = check
        end)
        repeat Wait(250) until canRob ~= nil
        return canRob
    else 
        return true
    end
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