if Config.Framework ~= "qb" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

local firstTime = false
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
    if not firstTime then
        CreateBlips()
    end
end)

function GetJobName()
    return QBCore.Functions.GetPlayerData().job.name
end

function GetJobGrade()
    return QBCore.Functions.GetPlayerData().job.grade
end

function GetGang()
    return false
end

function GetGangLevel()
    return false
end