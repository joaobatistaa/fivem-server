ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('battlepass:sendName')
AddEventHandler('battlepass:sendName', function(firstname, lastname, xp, level, preimum)
    SetDisplay(not Display, firstname, lastname, xp, level, preimum)
end)

RegisterNetEvent('battlepass:checkStdPass')
AddEventHandler('battlepass:checkStdPass', function(std_1, std_2, std_3, std_4, std_5)
    SendNUIMessage({
        std_1 = std_1,
        std_2 = std_2,
        std_3 = std_3,
        std_4 = std_4,
        std_5 = std_5,
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        TriggerEvent('battlepass:task_1')
        TriggerEvent('battlepass:task_3')
        TriggerEvent('battlepass:task_9')
    end
end)

RegisterNetEvent('battlepass:task_1')
AddEventHandler('battlepass:task_1', function()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local enterVector = vector3(1803.6670, 2605.2202, 45.5688)
    local dstCheckEnter = #(plyCoords - enterVector)
    if dstCheckEnter <= 90.0 then
        TriggerServerEvent('battlepass:addQuest', 1)
    end
end)

RegisterNetEvent('battlepass:task_3')
AddEventHandler('battlepass:task_3', function()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local enterVector = vector3(448.3494, -987.4963, 30.6896)
    local dstCheckEnter = #(plyCoords - enterVector)
    if dstCheckEnter <= 90.0 then
        TriggerServerEvent('battlepass:addQuest', 3)
    end
end)

RegisterNetEvent('battlepass:task_9')
AddEventHandler('battlepass:task_9', function()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local enterVector = vector3(-1602.0599, -949.9454, 13.0174)
    local dstCheckEnter = #(plyCoords - enterVector)
    if dstCheckEnter <= 90.0 then
        TriggerServerEvent('battlepass:addQuest', 9)
    end
end)

RegisterNetEvent('battlepass:checkPrmPass')
AddEventHandler('battlepass:checkPrmPass', function(prm_1, prm_2, prm_3, prm_4, prm_5)
    SendNUIMessage({
        prm_1 = prm_1,
        prm_2 = prm_2,
        prm_3 = prm_3,
        prm_4 = prm_4,
        prm_5 = prm_5,
    })
end)

RegisterNetEvent('battlepass:checkTask')
AddEventHandler('battlepass:checkTask', function(task_1, task_2, task_3, task_4, task_5, task_6, task_7, task_8, task_9, task_10)
    SendNUIMessage({
        task_1 = task_1,
        task_2 = task_2,
        task_3 = task_3,
        task_4 = task_4,
        task_5 = task_5,
        task_6 = task_6,
        task_7 = task_7,
        task_8 = task_8,
        task_9 = task_9,
        task_10 = task_10,
    })
end)

RegisterNUICallback("standart-pass-redeem-1", function(data)
    local passlevel = 1
    TriggerServerEvent('standart-redeem', passlevel)
end)
RegisterNUICallback("standart-pass-redeem-2", function(data)
    local passlevel = 2
    TriggerServerEvent('standart-redeem', passlevel)
end)
RegisterNUICallback("standart-pass-redeem-3", function(data)
    local passlevel = 3
    TriggerServerEvent('standart-redeem', passlevel)
end)
RegisterNUICallback("standart-pass-redeem-4", function(data)
    local passlevel = 4
    TriggerServerEvent('standart-redeem', passlevel)
end)
RegisterNUICallback("standart-pass-redeem-5", function(data)
    local passlevel = 5
    TriggerServerEvent('standart-redeem', passlevel)
end)

RegisterNUICallback("premium-pass-redeem-1", function(data)
    local passlevel = 1
    TriggerServerEvent('premium-redeem', passlevel)
end)
RegisterNUICallback("premium-pass-redeem-2", function(data)
    local passlevel = 2
    TriggerServerEvent('premium-redeem', passlevel)
end)
RegisterNUICallback("premium-pass-redeem-3", function(data)
    local passlevel = 3
    TriggerServerEvent('premium-redeem', passlevel)
end)
RegisterNUICallback("premium-pass-redeem-4", function(data)
    local passlevel = 4
    TriggerServerEvent('premium-redeem', passlevel)
end)
RegisterNUICallback("premium-pass-redeem-5", function(data)
    local passlevel = 5
    TriggerServerEvent('premium-redeem', passlevel)
end)


RegisterNUICallback("exit", function(data)
    SetDisplay(false) 
end)

function SetDisplay(bool, firstname, lastname, xp, level, premium)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        firstname = firstname,
        lastname = lastname,
        xp = xp,
        level = level,
        premium = premium,
    })
end