-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --
local useBilling = true -- OPTIONS: (true/false)
local useCameraSound = true -- OPTIONS: (true/false)
local useFlashingScreen = false -- OPTIONS: (true/false)
local useBlips = true -- OPTIONS: (true/false)
local alertPolice = true -- OPTIONS: (true/false)
local alertSpeed = 150 -- OPTIONS: (1-5000 KMH)

--local defaultPrice60 = 200 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 60 ZONES
local defaultPrice80 = 2000 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 80 ZONES
local defaultPrice120 = 4000 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 120 ZONES

local extraZonePrice10 = 1000 -- THIS IS THE EXTRA COST IF 10 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice20 = 2000 -- THIS IS THE EXTRA COST IF 20 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice30 = 3000 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --

local hasBeenCaught = false
local finalBillingPrice = 0;

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERAS
local blips = {
	-- 60KM/H ZONES
	--171.28 -818.97 31.17
	--{title="Radar (60KM/H)", colour=1, id=1, x = -524.2645, y = -1776.3569, z = 21.3384}, -- 60KM/H ZONE
	
	-- 90/H ZONES
	{title="Radar (90KM/H)", colour=1, id=459, x = 171.28, y = -818.97, z = 31.17}, -- 90KM/H ZONE
	{title="Radar (90KM/H)", colour=1, id=459, x = 289.05, y = -860.4, z = 28.6}, -- 90KM/H ZONE
	{title="Radar (90KM/H)", colour=1, id=459, x = 356.49, y = -269.32, z = 53.26}, -- 90KM/H ZONE
	
	-- 120KM/H ZONES
	{title="Radar (140KM/H)", colour=1, id=459, x = 860.18, y = 107.94, z = 69.62}, -- 140KM/H ZONE
	{title="Radar (140KM/H)", colour=1, id=459, x = -110.4, y = 6267.48, z = 31.2}, -- 140KM/H ZONE
	{title="Radar (140KM/H)", colour=1, id=459, x = -1906.99, y = 4611.81, z = 57.01}, -- 140KM/H ZONE
	{title="Radar (140KM/H)", colour=1, id=459, x = 765.33, y = -2632.11, z = 52.53} -- 140KM/H ZONE
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		if useBlips == true then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.5)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end
end)

-- AREAS
--local Speedcamera60Zone = {
    --{x = -524.2645,y = -1776.3569,z = 21.3384}
--}

local Speedcamera80Zone = {
    {x = 171.28, y = -818.97, z = 31.17},
    {x = 289.05, y = -860.4, z = 28.6},
    {x = 356.49, y = -269.32, z = 53.26}
}

local Speedcamera120Zone = {
	{x = 860.18, y = 107.94, z = 69.62},
    {x = -110.4, y = 6267.48, z = 31.2},
    {x = -1906.99, y = 4611.81, z = 57.01},
    {x = 765.33, y = -2632.11, z = 52.53}
}

-- ZONES
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

		-- 60 zone
        --for k in pairs(Speedcamera60Zone) do
        --    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        --    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera60Zone[k].x, Speedcamera60Zone[k].y, Speedcamera60Zone[k].z)

        --    if dist <= 20.0 then
		--		local playerPed = GetPlayerPed(-1)
		--		local playerCar = GetVehiclePedIsIn(playerPed, false)
		--		local veh = GetVehiclePedIsIn(playerPed)
		--		local SpeedKM = GetEntitySpeed(playerPed)*3.6
		--		local maxSpeed = 60.0 -- THIS IS THE MAX SPEED IN KM/H
				
		--		if SpeedKM > maxSpeed then
		--			if IsPedInAnyVehicle(playerPed, false) then
		--				if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
		--					if hasBeenCaught == false then
		--						if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FIRETRUK" then -- BLACKLISTED VEHICLE
		--						elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
		--						-- VEHICLES ABOVE ARE BLACKLISTED
		--						else
		--							-- ALERT POLICE (START)
		--							if alertPolice == true then
		--								if SpeedKM > alertSpeed then
		--									local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
		--									TriggerServerEvent('esx_phone:send', 'police', ' Tu foste apanhado pelo radar numa zona de 60KM/H!, above ' .. alertSpeed.. ' KMH', true, {x =x, y =y, z =z})
		--								end
		--							end
		--							 --ALERT POLICE (END)								
		--						
		--							 --FLASHING EFFECT (START)
		--						if useFlashingScreen == true then
		--								TriggerServerEvent('esx_speedcamera:openGUI')
		--							end
		--							
		--							if useCameraSound == true then
		--								TriggerServerEvent("InteractSound_SV:PlayOnSource", "Radar", 0.5)
		--							end
		--							
		--							if useFlashingScreen == true then
		--								Citizen.Wait(200)
		--								TriggerServerEvent('esx_speedcamera:closeGUI')
		--							end
		--							 FLASHING EFFECT (END)								
								
		--							TriggerEvent("pNotify:SendNotification", {text = " Tu foste apanhado pelo radar numa zona de 60KM/H! A tua velocidade era: " .. math.floor(SpeedKM) .. " KM/H", type = "error", timeout = 5000, layout = "centerLeft"})
									
		--							if useBilling == true then
		--								if SpeedKM >= maxSpeed + 30 then
		--									finalBillingPrice = defaultPrice60 + extraZonePrice30
		--								elseif SpeedKM >= maxSpeed + 20 then
		--									finalBillingPrice = defaultPrice60 + extraZonePrice20
		--								elseif SpeedKM >= maxSpeed + 10 then
		--									finalBillingPrice = defaultPrice60 + extraZonePrice10
		--								else
		--									finalBillingPrice = defaultPrice60
		--								end
										
		--								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police' and 'society_sheriff', 'Radar (60KM/H) - A tua velocidade era: ' .. math.floor(SpeedKM) .. ' KM/H - ', finalBillingPrice) -- Sends a bill from the police
		--							else
		--								TriggerServerEvent('esx_speedcamera:PayBill60Zone')
		--							end
										
		--							hasBeenCaught = true
		--							Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
		--						end
		--					end
		--				end
		--			end
					
		--			hasBeenCaught = false
		--		end
       --     end
       -- end
		
		-- 90 zone
		for k in pairs(Speedcamera80Zone) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z)

            if dist <= 27.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 90.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then					
							if hasBeenCaught == false then
								if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FIRETRUK" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
								elseif IsPedInAnyPoliceVehicle(playerPed) then
								elseif IsPedInAnyHeli(playerPed) then
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									local job = ESX.GetPlayerData().job.name
									if job == "police" or job == "sheriff" or job == "ambulance" then
										hasBeenCaught = true
										Citizen.Wait(5000)
									else
										-- ALERT POLICE (START)
										--if alertPolice == true then
										--	if SpeedKM > alertSpeed then
										--		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
										--		TriggerServerEvent('esx_phone:send', 'police', ' Someone passed the speed camera, above ' .. alertSpeed.. ' KMH', true, {x =x, y =y, z =z})
										--	end
										--end
										-- ALERT POLICE (END)								
									
										-- FLASHING EFFECT (START)
										if useFlashingScreen == true then
											TriggerServerEvent('esx_speedcamera:openGUI')
										end
										
										if useCameraSound == true then
											TriggerServerEvent("InteractSound_SV:PlayOnSource", "Radar", 0.5)
										end
										
										if useFlashingScreen == true then
											Citizen.Wait(200)
											TriggerServerEvent('esx_speedcamera:closeGUI')
										end
										-- FLASHING EFFECT (END)								
									
										--TriggerEvent("pNotify:SendNotification", {text = " Tu foste apanhado pelo radar numa zona de 80KM/H! A tua velocidade era: " .. math.floor(SpeedKM) .. " KM/H", type = "error", timeout = 5000, layout = "centerLeft"})
										exports['mythic_notify']:DoHudText('inform', 'Foste apanhado pelo radar numa zona de 80KM/H!')
										
										if useBilling == true then
											if SpeedKM >= maxSpeed + 30 then
												finalBillingPrice = defaultPrice80 + extraZonePrice30
											elseif SpeedKM >= maxSpeed + 20 then
												finalBillingPrice = defaultPrice80 + extraZonePrice20
											elseif SpeedKM >= maxSpeed + 10 then
												finalBillingPrice = defaultPrice80 + extraZonePrice10
											else
												finalBillingPrice = defaultPrice80
											end
		
											TriggerServerEvent("okokBilling:CreateCustomInvoice", GetPlayerServerId(PlayerId()), finalBillingPrice, 'Multa excesso de velocidade', 'Radar', 'society_police', 'PSP')
										else
											TriggerServerEvent('esx_speedcamera:PayBill80Zone')
										end
											
										hasBeenCaught = true
										Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
									end
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end
		
		-- 140 zone
		for k in pairs(Speedcamera120Zone) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera120Zone[k].x, Speedcamera120Zone[k].y, Speedcamera120Zone[k].z)

            if dist <= 27.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 140.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
							if hasBeenCaught == false then
								if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FIRETRUK" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									local job = ESX.GetPlayerData().job.name
									if job == "police" or job == "sheriff" or job == "ambulance" then
										hasBeenCaught = true
										Citizen.Wait(5000)
									else
										-- ALERT POLICE (START)
										--if alertPolice == true then
										--	if SpeedKM > alertSpeed then
										--		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
										--		TriggerServerEvent('esx_phone:send', 'police', ' Someone passed the speed camera, above ' .. alertSpeed.. ' KMH', true, {x =x, y =y, z =z})
										--	end
										--end
										-- ALERT POLICE (END)
									
										-- FLASHING EFFECT (START)
										if useFlashingScreen == true then
											TriggerServerEvent('esx_speedcamera:openGUI')
										end
										
										if useCameraSound == true then
											TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
										end
										
										if useFlashingScreen == true then
											Citizen.Wait(200)
											TriggerServerEvent('esx_speedcamera:closeGUI')
										end
										-- FLASHING EFFECT (END)
									
										--TriggerEvent("pNotify:SendNotification", {text = "Tu foste apanhado pelo radar numa zona de 120KM/H! A tua velocidade era:" .. math.floor(SpeedKM) .. " KM/H", type = "error", timeout = 5000, layout = "centerLeft"})
										exports['mythic_notify']:DoHudText('inform', 'Foste apanhado pelo radar numa zona de 140KM/H!')
										
										if useBilling == true then
											if SpeedKM >= maxSpeed + 30 then
												finalBillingPrice = defaultPrice120 + extraZonePrice30
											elseif SpeedKM >= maxSpeed + 20 then
												finalBillingPrice = defaultPrice120 + extraZonePrice20
											elseif SpeedKM >= maxSpeed + 10 then
												finalBillingPrice = defaultPrice120 + extraZonePrice10
											else
												finalBillingPrice = defaultPrice120
											end

											--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'Radar (140KM/H) - A tua velocidade era: ' .. math.floor(SpeedKM) .. ' KM/H - ', finalBillingPrice) -- Sends a bill from the police
											local data = {
												sendingSociety = 'society_police',
												sendingSocietyName = 'PSP',
												target = GetPlayerServerId(PlayerId()),
												targetName = -1,
												amount = finalBillingPrice,
												paytime = 5,
												reason = 'Radar (140KM/H) - A tua velocidade era: ' .. math.floor(SpeedKM) .. ' KM/H'					
											}
											
											--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'Radar (90KM/H) - A tua velocidade era: ' .. math.floor(SpeedKM) .. ' KM/H - ', finalBillingPrice) -- Sends a bill from the police
											TriggerServerEvent('zapps_billing:sendNewInvoice', data) -- Sends a bill from the police
										else
											TriggerServerEvent('esx_speedcamera:PayBill120Zone')
										end										
--											TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_sheriff', 'Radar (140KM/H) - A tua velocidade era: ' .. math.floor(SpeedKM) .. ' KM/H - ', finalBillingPrice) -- Sends a bill from the police
--										else
--											TriggerServerEvent('esx_speedcamera:PayBill120Zone')
--										end
											
										hasBeenCaught = true
										Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
									end
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end
    end
end)

RegisterNetEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)   

RegisterNetEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)
