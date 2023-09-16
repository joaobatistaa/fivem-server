-- VARIABLES
local waittime = 500
local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,15,16,17,18,19,20};
local toghud = true
--seatbelt locals
local seatbeltEjectSpeed = 65
local seatbeltEjectAccel = 80
local seatbeltIsOn = false
local inVehicle = false
local currSpeed = 0.0
--location
local zones = { ['AIRP'] = "Airport LS", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "Klub Golfowy", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port LS", ['ZQ_UAR'] = "Davis Quartz" }
-- time
local curTime = ''

RegisterNetEvent('veh:seatbelt')
AddEventHandler('veh:seatbelt', function(status)
	seatbeltIsOn = status
end)

-- HUD
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(waittime)
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, false) then
			
			waittime = 150
			local playerVeh = GetVehiclePedIsIn(playerPed, false)
			local fuel = exports['Johnny_Combustivel']:GetFuel(GetVehiclePedIsIn(GetPlayerPed(-1)))
			local engine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
			
			if not inVehicle then
				inVehicle = true
				SendNUIMessage({action = "toggleCar", show = true})
			end

			SendNUIMessage({action = "updateGas", key = "gas", value = fuel})
			SendNUIMessage({action = "updateNitro", key = "nitro", value = engine})
			
		else
			
			if seatbeltIsOn or IsRadarEnabled() or not toghud then 
				waittime = 500
				TriggerEvent("veh:seatbelt", false)
				SendNUIMessage({action = "seatbelt", status = seatbeltIsOn})
				if inVehicle then
					inVehicle = false
					SendNUIMessage({action = "toggleCar", show = false})
				end
			end
		end
	end
end)

-- HEADLIGHTS
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		local player = PlayerPedId()
		local canSleep = true
		local vehicle = GetVehiclePedIsIn(player, false)
		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
		
		if IsPedInAnyVehicle(player, false) and vehicleIsOn then
			canSleep = false
			
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local carSpeed =  math.ceil(vehicleSpeedSource * 3.6)
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn

			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
			end
			SendNUIMessage({action = "lights", status = vehicleIsLightsOn})
			SendNUIMessage({
				showhud = toghud,
				speed = carSpeed,
				showlocation = true,
				location = locationMessage
			})
		end
		
		if canSleep then
			Citizen.Wait(1000)
		end
	end
end)

-- A CADA 1 MS VERIFICA SE O JOGADOR COLOCA O CINTO
local seatbeltEjectSpeed = 45.0 
local seatbeltEjectAccel = 100.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local canSleep = true
		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local position = GetEntityCoords(player)
		
		-- SEATBELT
		if IsPedInAnyVehicle(player, false) then
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local vehicleClass = GetVehicleClass(vehicle)
			canSleep = false
			local vehicle = GetVehiclePedIsIn(player, false)
			local vehicleClass = GetVehicleClass(vehicle)

			-- Vehicle Seatbelt
			if has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8 then

				local prevSpeed = currSpeed
                currSpeed = vehicleSpeedSource

                SetPedConfigFlag(PlayerPedId(), 32, true)

                if not seatbeltIsOn then
                	local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then

                        SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end
                else
                	DisableControlAction(0, 75)
                end
			end

			if IsControlJustReleased(0, 29) and vehicleClass ~= 8 then
				
				if not seatbeltIsOn then
				--	ESX.ShowNotification('~g~CINTO COLOCADO')
					TriggerEvent('InteractSound_CL:PlayOnOne','seatbelt-buckle',0.8)
					Citizen.Wait(2500)
					SendNUIMessage({action = "seatbelt", status = true})
					TriggerEvent("veh:seatbelt", true)
					exports['Johnny_Notificacoes']:Alert("CINTO", "<span style='color:#c7c7c7'>Colocaste o <span style='color:#069a19'>cinto</span>!", 3000, 'success')
				else
				--	ESX.ShowNotification('~r~CINTO RETIRADO')
					TriggerEvent('InteractSound_CL:PlayOnOne','seatbelt-unbuckle',0.8)
					Citizen.Wait(1300)
					SendNUIMessage({action = "seatbelt", status = false})
					TriggerEvent("veh:seatbelt", false)
					exports['Johnny_Notificacoes']:Alert("CINTO", "<span style='color:#c7c7c7'>Retiraste o <span style='color:#ff0000'>cinto</span>!", 5000, 'error')
				end
			end
		end
		
		if canSleep then
			Citizen.Wait(1000)
		end
	end
end) 

--[[

-- A CADA 300MS VERIFICA A LOCALIZAÇÃO DO JOGADOR
Citizen.CreateThread(function()
	while true do
		local sleep = 300
		local Ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(Ped, false)

		if IsPedInAnyVehicle(Ped, false) then
			
			local pos = GetEntityCoords(Ped)
			local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
			local current_zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))
			PedCar = GetVehiclePedIsIn(Ped, false)
			if not PedCar or PedCar == 0 then
				PedCar = GetVehiclePedIsIn(Ped, true)
			end
			carSpeed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6

			if GetStreetNameFromHashKey(var2) ~= '' then
				locationMessage = GetStreetNameFromHashKey(var1) .. ' - ' .. GetStreetNameFromHashKey(var2) .. ', ' .. current_zone
			else 
				locationMessage = GetStreetNameFromHashKey(var1) .. ', ' .. current_zone
			end

			SendNUIMessage({
				showhud = toghud,
				speed = carSpeed,
				showlocation = true,
				location = locationMessage,
				clock = true,
				showclock = curTime
			})
		else
			sleep=1000
		end
		Citizen.Wait(sleep)
	end
end) --]]

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
