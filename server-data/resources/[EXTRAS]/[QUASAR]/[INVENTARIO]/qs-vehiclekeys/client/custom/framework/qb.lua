if Config.Framework ~= "qb" then
    return
end

QBCore = nil

QBCore = exports['qb-core']:GetCoreObject()

qb_menu_name = 'qb-menu'
nh_trigger = 'nh-context:createMenu'

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(playerData)
    if Config.EnableItemPlate then
        Start()
    end
end)

function TriggerServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb, ...)
end

function GetVehicleProperties(vehicle)
	return QBCore.Functions.GetVehicleProperties(vehicle)
end

function GetPlateVeh(vehicle)
    return QBCore.Functions.GetPlate(vehicle)
end

function GetClosestVehicle(vehicle)
    local veh = QBCore.Functions.GetClosestVehicle(vehicle)
    if not veh then return false end
    return veh
end

function GetJobFramework()
    return QBCore.Functions.GetPlayerData().job
end

function GetVehiclesInArea()
    local result = {}
    table.clear(result)
    local vehicles = QBCore.Functions.GetVehicles()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(vehicles) do
        local vehicleCoords = GetEntityCoords(v)
        local distance = #(playerCoords - vehicleCoords)
        if distance <= Config.LockDistance then
            if Config.Debug then
                TriggerServerEvent(Config.Eventprefix..':server:serverLog', 'Vehicles in area : '..json.encode(GetDisplayNameFromVehicleModel(GetEntityModel(v)), {indent=true})..'')
            end
            table.insert(result, v)
        end
    end
    return result
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
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
    end
end