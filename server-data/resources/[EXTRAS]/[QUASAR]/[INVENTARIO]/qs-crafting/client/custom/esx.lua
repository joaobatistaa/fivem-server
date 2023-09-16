if Config.Framework ~= "esx" then
    return
end

Citizen.CreateThread(function()
    local legacyEsx = pcall(function()
        ESX = exports['es_extended']:getSharedObject()
    end)
    Citizen.Wait(0)
    if legacyEsx then return end
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end  
end)

local inLoad = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    CreateBlips()
    inLoad = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    CreateBlips() 
end)

Citizen.CreateThread(function()
    if not ESX.PlayerData then return end
    CreateBlips() 
end)

function GetJobName()
    if not inLoad then return Citizen.Wait(100) end
    return ESX.PlayerData.job.name
end

function GetJobGrade()
    if not inLoad then return Citizen.Wait(100) end
    return ESX.PlayerData.job.grade
end

function GetGang()
    return false
end

function GetGangLevel()
    return false
end