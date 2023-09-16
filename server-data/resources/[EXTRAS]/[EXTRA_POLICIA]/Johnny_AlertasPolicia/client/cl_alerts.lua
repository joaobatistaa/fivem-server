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

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData.job = job
end)

local currentCallSign = ""

local exlusionZones = {
    {1713.1795654297,2586.6862792969,59.880760192871,250}, -- prison
    {-106.63687896729,6467.7294921875,31.626684188843,45}, -- paleto bank
    {251.21984863281,217.45391845703,106.28686523438,20}, -- city bank
    {-622.25042724609,-230.93577575684,38.057060241699,10}, -- jewlery store
    {699.91052246094,132.29960632324,80.743064880371,55}, -- power 1
    {2739.5505371094,1532.9992675781,57.56616973877,235}, -- power 2
    {12.53, -1097.99, 29.8, 10} -- Adam's Apple / Pillbox Weapon shop
}

local ped = PlayerPedId()
local isInVehicle = IsPedInAnyVehicle(ped, true)
Citizen.CreateThread( function()
    while true do
        Wait(1000)
        ped = PlayerPedId()
        isInVehicle = IsPedInAnyVehicle(ped, true)
    end
end)

function getRandomNpc(basedistance)
    local basedistance = basedistance
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom

    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if ped ~= PlayerPedId() and distance < basedistance and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)

    return rped
end

function GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(),  true)
    local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
    local playerStreetsLocation = GetLabelText(zone)
    local street = street1 .. ", " .. playerStreetsLocation
    return street
end

RegisterNetEvent("police:setCallSign")
AddEventHandler("police:setCallSign", function(pCallSign)
	if pCallSign ~= nil then currentCallSign = pCallSign end
end)

--- Gun Shots ---

Citizen.CreateThread( function()
    local origin = false
    local w = `WEAPON_PetrolCan`
    local w1 = `WEAPON_FIREEXTINGUISHER`
    local w2 = `WEAPON_FLARE`
    local curw = GetSelectedPedWeapon(PlayerPedId())
    local armed = false
    local timercheck = 0
    while true do
        Wait(50)
        

        if not armed then
            if IsPedArmed(ped, 7) and not IsPedArmed(ped, 1) and not IsPedCurrentWeaponSilenced(ped) then
                curw = GetSelectedPedWeapon(ped)
                armed = true
                timercheck = 15
            end
        end

        if armed then

            if IsPedShooting(ped) then

              --  print("shot")
                local inArea = false
                for i,v in ipairs(exlusionZones) do
                    local playerPos = GetEntityCoords(ped)
                    if #(vector3(v[1],v[2],v[3]) - vector3(playerPos.x,playerPos.y,playerPos.z)) < v[4] then
						--if 'WEAPON_FIREEXTINGUISHER' == curw then
                            inArea = true
                       -- end
                    end
                end
				if not inArea then
                    origin = true
                    if IsPedCurrentWeaponSilenced(ped) then
						TriggerEvent("civilian:alertPolice",15.0,"gunshot",0,true)
                    elseif isInVehicle then
						TriggerEvent("civilian:alertPolice",150.0,"gunshotvehicle",0,true)
                    else
						TriggerEvent("civilian:alertPolice",550.0,"gunshot",0,true)
                    end

                    --Wait(60000)
                    origin = false
                end
            end

            if timercheck == 0 then
                armed = false
            else
                timercheck = timercheck - 1
            end
        else
             Citizen.Wait(5000)
        end
    end
end)

RegisterNetEvent('ym-outlawalert:gunshotInProgress')
AddEventHandler('ym-outlawalert:gunshotInProgress', function(targetCoords)
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then
		if Config.gunAlert then
			local alpha = 250
			local targetCoords = GetEntityCoords(PlayerPedId(), true)
			local gunshotBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

			SetBlipScale(gunshotBlip, 1.3)
			SetBlipSprite(gunshotBlip,  432)
			SetBlipColour(gunshotBlip,  1)
			SetBlipAlpha(gunshotBlip, alpha)
			SetBlipAsShortRange(gunshotBlip, true)
			BeginTextCommandSetBlipName("STRING")              -- set the blip's legend caption
			AddTextComponentString('10-71 Tiros Ouvidos')              -- to 'supermarket'
			EndTextCommandSetBlipName(gunshotBlip)
			SetBlipAsShortRange(gunshotBlip,  1)
			PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipGunTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(gunshotBlip, alpha)

				if alpha == 0 then
					RemoveBlip(gunshotBlip)
					return
				end
			end

		end
	end
end)

RegisterNetEvent('ym-outlawalert:combatInProgress')
AddEventHandler('ym-outlawalert:combatInProgress', function(targetCoords)
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'pj' or PlayerData.job.name == 'sheriff' then	
		if Config.gunAlert then
			local alpha = 250
			local targetCoords = GetEntityCoords(PlayerPedId(), true)
			local knife = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

			SetBlipScale(knife, 1.3)
			SetBlipSprite(knife,  437)
			SetBlipColour(knife,  1)
			SetBlipAlpha(knife, alpha)
			SetBlipAsShortRange(knife, true)
			BeginTextCommandSetBlipName("STRING")              -- set the blip's legend caption
			AddTextComponentString('10-11 Fight In Progress')              -- to 'supermarket'
			EndTextCommandSetBlipName(knife)
			SetBlipAsShortRange(knife,  1)
			PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipGunTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(knife, alpha)

				if alpha == 0 then
					RemoveBlip(knife)
					return
				end
			end

		end
	end
end)


---- 10-13s Officer Down ----

RegisterNetEvent('police:tenThirteenA')
AddEventHandler('police:tenThirteenA', function()
  if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-13A",
			firstStreet = GetStreetAndZone(),
			callSign = currentCallSign,
			isImportant = true,
			priority = 3,
			-- name = 'Noah Jamerson',
			dispatchMessage = "Officer Down",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			  }
		})
		TriggerEvent('ym-alerts:policealertA')
	end
end)

RegisterNetEvent('ym-alerts:policealertA')
AddEventHandler('ym-alerts:policealertA', function(targetCoords)
  if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local policedown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown,  126)
		SetBlipColour(policedown,  1)
		SetBlipScale(policedown, 1.3)
		SetBlipAsShortRange(policedown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-13A Officer Down')
		EndTextCommandSetBlipName(policedown)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', '10-1314', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown, alpha)

		if alpha == 0 then
			RemoveBlip(policedown)
		return
      end
    end
  end
end)

RegisterNetEvent('police:tenThirteenB')
AddEventHandler('police:tenThirteenB', function()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "Código 1",
			firstStreet = GetStreetAndZone(),
			callSign = currentCallSign,
			isImportant = false,
			priority = 3,
			dispatchMessage = "Informação",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		TriggerEvent('ym-alerts:policealertB')
	end
end)

RegisterNetEvent('ym-alerts:policealertB')
AddEventHandler('ym-alerts:policealertB', function(targetCoords)
if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local policedown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown2,  126)
		SetBlipColour(policedown2,  1)
		SetBlipScale(policedown2, 1.3)
		SetBlipAsShortRange(policedown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Código 1')
		EndTextCommandSetBlipName(policedown2)
		PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown2, alpha)

		if alpha == 0 then
			RemoveBlip(policedown2)
		return
      end
    end
  end
end)

RegisterNetEvent('police:panic1')
AddEventHandler('police:panic1', function()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "Código 1",
			firstStreet = GetStreetAndZone(),
			callSign = PlayerData.job.grade_label..' '..GetPlayerName(PlayerId()),
			isImportant = false,
			priority = 1,
			dispatchMessage = "Informação",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

RegisterNetEvent('police:panic2')
AddEventHandler('police:panic2', function()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "Código 2",
			firstStreet = GetStreetAndZone(),
			callSign = PlayerData.job.grade_label..' '..GetPlayerName(PlayerId()),
			isImportant = false,
			priority = 2,
			dispatchMessage = "Apoio Solicitado",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

RegisterNetEvent('police:panic3')
AddEventHandler('police:panic3', function()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "Código 3",
			firstStreet = GetStreetAndZone(),
			callSign = PlayerData.job.grade_label..' '..GetPlayerName(PlayerId()),
			isImportant = false,
			priority = 3,
			dispatchMessage = "Reforços Urgentes",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
	end
end)

RegisterNetEvent('police:panic99')
AddEventHandler('police:panic99', function()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "Código 99",
			firstStreet = GetStreetAndZone(),
			callSign = PlayerData.job.grade_label..' '..GetPlayerName(PlayerId()),
			isImportant = true,
			priority = 3,
			dispatchMessage = "Emergência",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		playCode99Sound2()
	end
end)

RegisterNetEvent('police:assaltos')
AddEventHandler('police:assaltos', function(msgAssalto, pos, rua)
	--if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then		
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-90",
			firstStreet = rua,
			isImportant = true,
			priority = 3,
			dispatchMessage = msgAssalto,
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		playCode99Sound2()
	--end
end)

RegisterNetEvent('police:assaltoLojas')
AddEventHandler('police:assaltoLojas', function(localAssalto, pos, rua)
	--if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then		
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-90",
			firstStreet = rua,
			isImportant = true,
			priority = 3,
			dispatchMessage = "Assalto à Loja "..localAssalto,
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		playCode99Sound2()
	--end
end)

RegisterNetEvent('police:assaltoJoalharia')
AddEventHandler('police:assaltoJoalharia', function(localAssalto, pos, rua)
	--if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then		
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-90",
			firstStreet = rua,
			isImportant = true,
			priority = 3,
			dispatchMessage = "Assalto à "..localAssalto,
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		playCode99Sound2()
	--end
end)

RegisterNetEvent('police:assaltoBancoPrincipal')
AddEventHandler('police:assaltoBancoPrincipal', function(localAssalto, pos, rua)
	--if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then		
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-90",
			firstStreet = rua,
			isImportant = true,
			priority = 3,
			dispatchMessage = "Assalto ao "..localAssalto,
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		playCode99Sound2()
	--end
end)

RegisterNetEvent('police:assaltoIate')
AddEventHandler('police:assaltoIate', function(localAssalto, pos, rua)
	--if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then		
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-90",
			firstStreet = rua,
			isImportant = true,
			priority = 3,
			dispatchMessage = "Assalto ao "..localAssalto,
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		playCode99Sound2()
	--end
end)

function playCode99Sound2()
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
	Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
end


---- 10-14 EMS ----

RegisterNetEvent("police:tenForteenA")
AddEventHandler("police:tenForteenA", function()	
if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'pj' then	
	local pos = GetEntityCoords(PlayerPedId(),  true)
	TriggerServerEvent("dispatch:svNotify", {
		dispatchCode = "10-14A",
		firstStreet = GetStreetAndZone(),
		callSign = currentCallSign,
		isImportant = true,
		priority = 3,
		dispatchMessage = "Medic Down",
		origin = {
			x = pos.x,
			y = pos.y,
			z = pos.z
		}
	})
		TriggerEvent('ym-alerts:tenForteenA')
	end
end)

RegisterNetEvent('ym-alerts:tenForteenA')
AddEventHandler('ym-alerts:tenForteenA', function(targetCoords)
  if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local medicDown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown,  126)
		SetBlipColour(medicDown,  1)
		SetBlipScale(medicDown, 1.3)
		SetBlipAsShortRange(medicDown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14A Medic Down')
		EndTextCommandSetBlipName(medicDown)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'polalert', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown, alpha)

		if alpha == 0 then
			RemoveBlip(medicDown)
		return
      end
    end
  end
end)

RegisterNetEvent("police:tenForteenB")
AddEventHandler("police:tenForteenB", function()
if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'pj' then	
	local pos = GetEntityCoords(PlayerPedId(),  true)
	TriggerServerEvent("dispatch:svNotify", {
		dispatchCode = "10-14B",
		firstStreet = GetStreetAndZone(),
		callSign = currentCallSign,
		isImportant = false,
		priority = 3,
		dispatchMessage = "Medic Down",
		origin = {
			x = pos.x,
			y = pos.y,
			z = pos.z
		}
	})
		TriggerEvent('ym-alerts:tenForteenB')
	end
end)

RegisterNetEvent('ym-alerts:tenForteenB')
AddEventHandler('ym-alerts:tenForteenB', function(targetCoords)
if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local medicDown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown2,  126)
		SetBlipColour(medicDown2,  1)
		SetBlipScale(medicDown2, 1.3)
		SetBlipAsShortRange(medicDown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14B Agente abatido')
		EndTextCommandSetBlipName(medicDown2)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown2, alpha)

		if alpha == 0 then
			RemoveBlip(medicDown2)
		return
      end
    end
  end
end)

---- Down Person ----

RegisterNetEvent('ym-alerts:downalert')
AddEventHandler('ym-alerts:downalert', function(targetCoords)
if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(injured,  126)
		SetBlipColour(injured,  18)
		SetBlipScale(injured, 1.5)
		SetBlipAsShortRange(injured,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-47 Civil ferido')
		EndTextCommandSetBlipName(injured)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dispatch', 0.1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

		if alpha == 0 then
			RemoveBlip(injured)
		return
      end
    end
  end
end)

---- Car Crash ----
RegisterNetEvent('ym-alerts:vehiclecrash')
AddEventHandler('ym-alerts:vehiclecrash', function(targetCoords)
if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(injured,  488)
		SetBlipColour(injured,  1)
		SetBlipScale(injured, 1.5)
		SetBlipAsShortRange(injured,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-50 Acidente de viaturas')
		EndTextCommandSetBlipName(injured)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

		if alpha == 0 then
			RemoveBlip(injured)
		return
      end
    end
  end
end)

---- Vehicle Theft ----

RegisterNetEvent('ym-alerts:vehiclesteal')
AddEventHandler('ym-alerts:vehiclesteal', function(targetCoords)
if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local thiefBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(thiefBlip,  488)
		SetBlipColour(thiefBlip,  1)
		SetBlipScale(thiefBlip, 1.5)
		SetBlipAsShortRange(thiefBlip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-60 Vehicle Theft')
		EndTextCommandSetBlipName(thiefBlip)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(thiefBlip, alpha)

		if alpha == 0 then
			RemoveBlip(thiefBlip)
		return
      end
    end
  end
end)

---- Store Robbery ----

RegisterNetEvent('ym-alerts:storerobbery')
AddEventHandler('ym-alerts:storerobbery', function(targetCoords)
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local store = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(store, true)
		SetBlipSprite(store,  52)
		SetBlipColour(store,  1)
		SetBlipScale(store, 1.3)
		SetBlipAsShortRange(store,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31B Robbery In Progress')
		EndTextCommandSetBlipName(store)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(store, alpha)

			if alpha == 0 then
				RemoveBlip(store)
				return
			end
		end
	end
end)

---- House Robbery ----

RegisterNetEvent('ym-alerts:houserobbery')
AddEventHandler('ym-alerts:houserobbery', function(targetCoords)
if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local burglary = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(burglary, true)
		SetBlipSprite(burglary,  411)
		SetBlipColour(burglary,  1)
		SetBlipScale(burglary, 1.3)
		SetBlipAsShortRange(burglary,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31A Burglary')
		EndTextCommandSetBlipName(burglary)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(burglary, alpha)

		if alpha == 0 then
			RemoveBlip(burglary)
		return
      end
    end
  end
end)

---- Bank Truck ----

RegisterNetEvent('ym-alerts:banktruck')
AddEventHandler('ym-alerts:banktruck', function(targetCoords)
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local truck = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(truck,  477)
		SetBlipColour(truck,  47)
		SetBlipScale(truck, 1.5)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 Bank Truck In Progress')
		EndTextCommandSetBlipName(truck)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(truck, alpha)

		if alpha == 0 then
			RemoveBlip(truck)
		return
      end
    end
  end
end)

---- Jewerly Store ----

RegisterNetEvent('ym-alerts:jewelrobbey')
AddEventHandler('ym-alerts:jewelrobbey', function()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local jew = AddBlipForCoord(-634.02, -239.49, 38)

		SetBlipSprite(jew,  487)
		SetBlipColour(jew,  4)
		SetBlipScale(jew, 1.8)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(jew)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jew, alpha)

		if alpha == 0 then
			RemoveBlip(jew)
		return
      end
    end
  end
end)

---- Jail Break ----

RegisterNetEvent('ym-alerts:jailbreak')
AddEventHandler('ym-alerts:jailbreak', function(targetCoords)
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local jail = AddBlipForCoord(1779.65, 2590.39, 50.49)

		SetBlipSprite(jail,  487)
		SetBlipColour(jail,  4)
		SetBlipScale(jail, 1.8)
		SetBlipAsShortRange(jail,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-98 Jail Break')
		EndTextCommandSetBlipName(jail)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jail, alpha)

		if alpha == 0 then
			RemoveBlip(jail)
		return
      end
    end
  end
end)