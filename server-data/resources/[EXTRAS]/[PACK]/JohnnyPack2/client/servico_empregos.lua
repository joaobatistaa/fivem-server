local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)


--------------- ESX_DUTY ---------------

local infoDuty = {}

infoDuty.DrawDistance = 20.0

infoDuty.Zones = {
	Duty = {
		Blips = {
			{x = -1092.68, y = -835.77, z = 19.1, job1 = 'police', job2 = 'offpolice'},
			{x = -447.37, y = 6014.06, z = 31.8, job1 = 'police', job2 = 'offpolice'},
			{x = 1853.91, y = 3687.79, z = 34.26, job1 = 'police', job2 = 'offpolice'},
			{x = 443.97, y = -991.92, z = 30.69, job1 = 'police', job2 = 'offpolice'},

			{x = 311.0066, y = -597.219, z = 43.284, job1 = 'ambulance', job2 = 'offambulance'},

			{x = -207.01, y = -1341.69, z = 34.89, job1 = 'mechanic', job2 = 'offmechanic'},
		}
	}
}

---------------- ESX_DUTY --------------

--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil

--- esx
local GUI = {}
ESX                           = nil
GUI.Time                      = 0

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

----markers
AddEventHandler('esx_duty:hasEnteredMarker', function()
    CurrentAction     = 'onoff'
end)

AddEventHandler('esx_duty:hasExitedMarker', function()
  CurrentAction = nil
end)

RegisterNetEvent('duty:limpar')
AddEventHandler('duty:limpar', function()
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
end) 

--keycontrols
Citizen.CreateThread(function ()
    while true do
        
		Citizen.Wait(0)
		local letSleep = true
        local playerPed = GetPlayerPed(-1)
        
        local jobs = {
            'offambulance',
            'offpolice',
			'offsheriff',
			'offmechanic',
            'police',
            'ambulance',
			'sheriff',
			'mechanic',
			'pj',
			'offpj'
			
        }

        if CurrentAction ~= nil then
			letSleep = false
            for k,v in pairs(jobs) do
			
                if PlayerData.job.name == v then
				
                    if IsControlJustPressed(0, Keys['E']) then
                        TriggerServerEvent('duty:onoff')
						Citizen.Wait(500)
					end
					
                end
            end

        end
		if letSleep then
			Citizen.Wait(500)
		end
    end       
end)

function DrawText3Ds(x, y, z, text)
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

Citizen.CreateThread(function ()
  while true do
    
	Citizen.Wait(0)
	local letSleep = true
    local coords = GetEntityCoords(GetPlayerPed(-1))
	local isInMarker  = false
    local currentZone = nil
	
	for k,v in pairs(infoDuty.Zones) do
		
		for i=1, #v.Blips, 1 do

			if GetDistanceBetweenCoords(coords, v.Blips[i].x, v.Blips[i].y, v.Blips[i].z, true) < 20 and (v.Blips[i].job1 == PlayerData.job.name or v.Blips[i].job2 == PlayerData.job.name) then
				letSleep = false
				DrawMarker(2, v.Blips[i].x, v.Blips[i].y, v.Blips[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
				
				if GetDistanceBetweenCoords(coords, v.Blips[i].x, v.Blips[i].y, v.Blips[i].z, true) < 3 and (v.Blips[i].job1 == PlayerData.job.name) then
					DrawText3Ds(v.Blips[i].x, v.Blips[i].y, v.Blips[i].z + 0.2, '~b~E~s~ - Sair de Serviço', 0.3)
					isInMarker  = true
				end
				
				if GetDistanceBetweenCoords(coords, v.Blips[i].x, v.Blips[i].y, v.Blips[i].z, true) < 3 and (v.Blips[i].job2 == PlayerData.job.name) then
					DrawText3Ds(v.Blips[i].x, v.Blips[i].y, v.Blips[i].z + 0.2, '~b~E~s~ - Entrar de Serviço', 0.3)
					isInMarker  = true
				end	
			end
		end
		
	end
	
	if isInMarker then
      HasAlreadyEnteredMarker = true
      TriggerEvent('esx_duty:hasEnteredMarker')
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_duty:hasExitedMarker')
    end
	if letSleep then
		Citizen.Wait(2000)
	end
  end
end)