
Citizen.CreateThread(function()
	for i = 1, 15 do
		EnableDispatchService(i, false)-- Disabel Dispatch
	end
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
    while true do
		Citizen.Wait(0)
		
		local ped = PlayerPedId()
		SetVehicleDensityMultiplierThisFrame(0.0) --Seleciona densidade do trafico
		SetPedDensityMultiplierThisFrame(0.0) --seleciona a densidade de Npc
		SetRandomVehicleDensityMultiplierThisFrame(0.0) --seleciona a densidade de viaturas estacionadas a andar etc
		SetParkedVehicleDensityMultiplierThisFrame(0.0) --seleciona a densidade de viaturas estacionadas
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) --seleciona a densidade de Npc a andar pela cidade
		SetGarbageTrucks(false) --Desactiva os Camioes do Lixo de dar Spawn Aleatoriamente
		SetRandomBoats(false) --Desactiva os Barcos de dar Spawn na agua
        SetCreateRandomCops(false) --Desactiva a Policia a andar pela cidade
		SetCreateRandomCopsNotOnScenarios(false) --Para o Spanw Aleatorio de Policias Fora do Cenario
		SetCreateRandomCopsOnScenarios(false) --Para o Spanw Aleatorio de Policias no Cenario
		local coords = GetEntityCoords(ped)
        local x,y,z = table.unpack(coords)
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);		
		
		if IsPedInAnyVehicle(ped, false) then -- se o jogador estiver em um veículo desativa a radio
			SetUserRadioControlEnabled(false)
			if GetPlayerRadioStationName() ~= nil then
				SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()),"OFF")
			end
		end
		--local ped = PlayerPedId()
        --DisableControlAction(0, 140, true)
		
		--if IsPedArmed(ped,6) then
			--DisableControlAction(0,140,true)
			--DisableControlAction(0,141,true)
			--DisableControlAction(0,142,true)
		--end
		
		
		----------- ILHA -------------
		-- misc natives
		--Citizen.InvokeNative(0xF74B1FFA4A15FBEA, true) -- ISTO DA ERRO COM O MINIMAPA
		--Citizen.InvokeNative(0x53797676AD34A9AA, false)    
		--SetScenarioGroupEnabled('Heist_Island_Peds', true)

		-- audio stuff
		--SetAudioFlag('PlayerOnDLCHeist4Island', true)
		--SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
		--SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
		----------- ILHA -------------
   end
end) 

if IsPedInAnyVehicle(playerPed, false) then -- se o jogador estiver em um veículo
      Citizen.InvokeNative(0x109697e2, true) -- desativa a rádio
    end


--[[
local islandVec = vector3(4840.571, -5174.425, 2.0)
Citizen.CreateThread(function()
    while true do
		local pCoords = GetEntityCoords(GetPlayerPed(-1))		
			local distance1 = #(pCoords - islandVec)
			if distance1 < 2000.0 then
				Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true)  -- load the map and removes the city
				Citizen.InvokeNative("0x5E1460624D194A38", true) -- load the minimap/pause map and removes the city minimap/pause map
			else
				Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)
				Citizen.InvokeNative("0x5E1460624D194A38", false)
			end
		Citizen.Wait(5000)
    end
end)
--]]


----------------------------------------------------------------------------------
---------------------------- IDS EM CIMA DA CABECA -------------------------------
----------------------------------------------------------------------------------

local group
local IsAdminMod = false
local displayIDHeight = 1.8
local playerNamesDist = 20

RegisterNetEvent('johnny_core:setGroup')
AddEventHandler('johnny_core:setGroup', function(g)
	group = g
end)

AddEventHandler('modoadmin:client:TogglePermissao', function(modoAdmin)
	IsAdminMod = modoAdmin
end)

function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.3*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end



function DrawText3D2(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


local disPlayerNames = 50
local disPlayerNames2 = 5
local ids = true
playerDistances = {}

RegisterCommand('ids', function()
	ids = not ids
	if ids then
		exports['mythic_notify']:DoHudText('success', 'IDS ATIVADOS')
	else
		exports['mythic_notify']:DoHudText('error', 'IDS DESATIVADOS')
	end
end)

local function IsPlayerInvisible(player)
    local routingBucket = GetPlayerRoutingBucket(player)
    return routingBucket == -1
end

Citizen.CreateThread(function()
    while true do
		local canSleep=true
        for _, player in ipairs(GetActivePlayers()) do
			if NetworkIsPlayerActive(player) and (group ~= "user" and group ~= "mod") and IsAdminMod == true then
				if playerDistances[player] ~= nil then
					if GetPlayerPed(player) ~= GetPlayerPed(-1) then
						if (playerDistances[player] < disPlayerNames) then
							x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
							if NetworkIsPlayerTalking(player) then
								DrawText3D(x2, y2, z2+1, GetPlayerServerId(player).." | "..GetPlayerName(player), 63,165,191)
								canSleep = false
							else
								DrawText3D(x2, y2, z2+1, GetPlayerServerId(player).." | "..GetPlayerName(player), 255,255,255)
								canSleep = false
							end
						end  
					end
				end
			elseif NetworkIsPlayerActive(player) and ids then
				if GetPlayerPed(player) ~= GetPlayerPed(-1) then
					if playerDistances[player] ~= nil then
						if (playerDistances[player] < disPlayerNames2) and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(player), 17) and not IsPlayerInvisible(player) then
							x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
							if NetworkIsPlayerTalking(player) then
								DrawText3D2(x2, y2, z2+1, GetPlayerServerId(player), 63,165,191)
								canSleep = false
							else
								DrawText3D2(x2, y2, z2+1, GetPlayerServerId(player), 255,255,255)
								canSleep = false
							end
						end
					end  
				end					
			end
        end
        if canSleep then
			Citizen.Wait(2000)
		end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        for _, player in ipairs(GetActivePlayers()) do
            if GetPlayerPed(player) ~= GetPlayerPed(-1) then
                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				playerDistances[player] = distance
            end
        end
        Citizen.Wait(2000)
    end
end)

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- prevent crashing

        -- These natives have to be called every frame.
        SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
        SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
        SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
        SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
        SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
        SetRandomBoats(false) -- Stop random boats from spawning in the water.
        SetCreateRandomCops(false) -- disable random cops walking/driving around.
        SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
        SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
        DisablePlayerVehicleRewards(PlayerId())
		
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
        RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
    end
end) --]]
