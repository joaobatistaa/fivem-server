local HasAlreadyEnteredMarkerReboques, LastZoneReboques = false, nil
local CurrentActionReboques, CurrentActionMsgReboques, CurrentActionDataReboques = nil, '', {}

local currentSelectionReboques = nil
local towtruck = nil
local targetReboques = nil
local helpstate = 1
local towSetupMode = false
local towing = false

function MenuGestaoReboques()
	local elements = {
		{label = 'Garagem da Empresa',   value = 'vehicle_list'},
		{label = 'Roupa Normal',       value = 'cloakroom2'},
		{label = 'Roupa de Trabalho',      value = 'cloakroom'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reboques_actions2', {
		title    = 'Menu Reboques',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then

				local elements = {
					{label = 'Mercedes-Benz Actros - Reboque',  value = 'flatbed'},
				}

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = 'Garagem da Empresa',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					ESX.Game.SpawnVehicle(data2.current.value, Config.ReboquesZones.VehicleSpawnPoint.Pos, 250.63, function(vehicle)
						local playerPed = PlayerPedId()
						local plate = 'REB' .. math.random(100, 900)
						SetVehicleNumberPlateText(vehicle, plate)
						exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
						--TriggerServerEvent('vehiclekeys:server:givekey', plate, data2.current.value)
						exports['qs-vehiclekeys']:GiveKeysAuto()
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					end)
					menu2.close()
					menu.close()
				end, function(data2, menu2)
					menu2.close()
				end)
		elseif data.current.value == 'cloakroom' then
			menu.close()
			setUniformReboques(data.current.value, playerPed)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentActionReboques     = 'mechanic_actions_menu'
		CurrentActionMsgReboques  = ''
		CurrentActionDataReboques = {}
	end)
end

function setUniformReboques(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.ReboquesUniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.ReboquesUniforms[job].male)
			else
				exports['mythic_notify']:DoHudText('error', 'Roupa de trabalho masculina não configurada!')
			end
		else
			if Config.ReboquesUniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.ReboquesUniforms[job].female)
			else
				exports['mythic_notify']:DoHudText('error', 'Roupa de trabalho feminina não configurada!')
			end
		end
	end)
end

function MenuF6Reboques()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reboques_actions', {
		title    = '⚙️ Menu Reboques',
		align    = 'top-left',
		elements = {
			{label = '🧰 Rebocar',      value = 'dep_vehicle'},
	}}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'dep_vehicle' then
			ExecuteCommand('rebocar')
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

AddEventHandler('esx_reboquesjob:hasEnteredMarker', function(zone)
	if zone == 'MechanicActions' then
		CurrentActionReboques     = 'mechanic_actions_menu'
		CurrentActionMsgReboques  = ''
		CurrentActionDataReboques = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentActionReboques     = 'delete_vehicle'
			CurrentActionMsgReboques  = ''
			CurrentActionDataReboques = {vehicle = vehicle}
		end
	elseif zone == 'VehicleDeleter2' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentActionReboques     = 'delete_vehicle2'
			CurrentActionMsgReboques  = ''
			CurrentActionDataReboques = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('esx_reboquesjob:hasExitedMarker', function(zone)
	CurrentActionReboques = nil
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(0)

		if PlayerData.job ~= nil and PlayerData.job.name == 'reboques' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.ReboquesZones) do
				
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 3 then
					if k == 'MechanicActions' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Menu Reboques', 0.3)
					end
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 20 then
					if k == 'VehicleDeleter' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Entregar Veículo', 0.3)
					end
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5 then
					if k == 'VehicleDeleter2' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
					end
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 70 then
					letSleep = false
					if k == 'MechanicActions' then
						DrawMarker(2, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
					if k == 'VehicleDeleter' then
						DrawMarker(1, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 20.0, 20.0, 1.0, 71, 181, 255, 120, false, false, 2, true, false, false, false)
					end
					if k == 'VehicleDeleter2' then
						DrawMarker(2, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
			end

			if letSleep then
				Citizen.Wait(2000)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(100)

		if PlayerData.job ~= nil and PlayerData.job.name == 'reboques' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil
			local canSleep = true

			for k,v in pairs(Config.ReboquesZones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if isInMarker or (isInMarker and LastZoneReboques ~= currentZone) then
				HasAlreadyEnteredMarkerReboques = true
				LastZoneReboques                = currentZone
				TriggerEvent('esx_reboquesjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarkerReboques then
				HasAlreadyEnteredMarkerReboques = false
				TriggerEvent('esx_reboquesjob:hasExitedMarker', LastZoneReboques)
			end

		else
			Citizen.Wait(5000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(0)
		
		if PlayerData.job and PlayerData.job.name == 'reboques' then
			if CurrentActionReboques and not isDead then

				if IsControlJustReleased(0, 38) and PlayerData.job ~= nil then

					if CurrentActionReboques == 'mechanic_actions_menu' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'reboques_actions2') then
						MenuGestaoReboques()
					elseif CurrentActionReboques == 'delete_vehicle2' then
						local model = GetDisplayNameFromVehicleModel(GetEntityModel(CurrentActionDataReboques.vehicle))
						local plate = GetVehicleNumberPlateText(CurrentActionDataReboques.vehicle)
						--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
						exports['qs-vehiclekeys']:RemoveKeysAuto()
						ESX.Game.DeleteVehicle(CurrentActionDataReboques.vehicle)
					elseif CurrentActionReboques == 'delete_vehicle' then
						if towing then
							towing = false
							TriggerServerEvent('esx_reboquesjob:worldtugarp:pagamento', targetReboques)
							ESX.Game.DeleteVehicle(targetReboques)
							targetReboques = nil
							exports['Johnny_Notificacoes']:Alert("REBOQUES", "<span style='color:#c7c7c7'>Veículo entregue com sucesso, recebeste pelo teu trabalho <span style='color:#069a19'><b>"..Config.ReboquesSalario.."€</b></span>.", 5000, 'success')
						else
							exports['Johnny_Notificacoes']:Alert("REBOQUES", "<span style='color:#c7c7c7'>Não tens nenhum veículo rebocado para entregar!", 5000, 'error')
						end
						--ESX.Game.DeleteVehicle(CurrentActionDataReboques.vehicle)
					end

					CurrentActionReboques = nil
				end
			end

			if IsControlJustReleased(0, 167) and not isDead and PlayerData.job and PlayerData.job.name == 'reboques' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'reboques_actions') then
				MenuF6Reboques()
			end
		else	
			Citizen.Wait(2000)
		end
	end
end)

--Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.ReboquesZones.MechanicActions.Pos.x, Config.ReboquesZones.MechanicActions.Pos.y, Config.ReboquesZones.MechanicActions.Pos.z)

	SetBlipSprite (blip, 68)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 10)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Reboques')
	EndTextCommandSetBlipName(blip)
end)


function ShowNotificationSecondary(text1, text2, text3)
    SetNotificationTextEntry("THREESTRINGS")
    AddTextComponentSubstringPlayerName(text1)
    AddTextComponentSubstringPlayerName(text2)
    AddTextComponentSubstringPlayerName(text3)
    DrawNotification(true, true)
end

local showed1 = false
local showed2 = false
local showed3 = false

RegisterCommand("rebocar", function(source, args)
	if PlayerData.job ~= nil and (PlayerData.job.name == 'reboques' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'police') then
		ClearAllHelpMessages()
		ClearHelp(true)
		ClearDrawOrigin()
		if towing then
			towing = false
			DetachEntity(targetReboques, true, true)
			local coords = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -10.0, 0.0)
			
			SetEntityCoords(targetReboques, coords, false, false, false, false)
			SetVehicleOnGroundProperly(targetReboques)
			towtruck = nil
			targetReboques = nil
		else
			if targetReboques ~= nil and towtruck ~= nil then
				local towPos = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -1.9, 3.5)
				SetEntityCoords(targetReboques, towPos, false, false, false, false)
				Citizen.Wait(2000)
				local targetPos = GetEntityCoords(targetReboques, true)
				local attachPos = GetOffsetFromEntityGivenWorldCoords(towtruck, targetPos.x, targetPos.y, targetPos.z)
				AttachEntityToEntity(targetReboques, towtruck, -1, attachPos.x, attachPos.y, attachPos.z, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
				towSetupMode = false
				helpstate = 0
				towing = true
			elseif not towSetupMode then
				--ShowNotification("Vai ao ~r~reboque ~s~e quando vires o ", "~y~marcador amarelo ~s~, pressiona ~r~~h~[E]~h~", "~s~para selecionar o veículo.")
				exports['Johnny_Notificacoes']:Alert("REBOQUE", "<span style='color:#c7c7c7'>Vai até ao Reboque e quando vires o marcador amarelo pressiona E para selecionar o veiculo!", 10000, 'info')
				towSetupMode = true
				towtruck = nil
				targetReboques = nil
				helpstate = 1
				showed1 = false
				showed2 = false
				showed3 = false
			else
				towSetupMode = false
				towtruck = nil
				targetReboques = nil
				helpstate = 3
			end
		end
	else
		exports['Johnny_Notificacoes']:Alert("REBOQUES", "<span style='color:#c7c7c7'>Não tens permissão para rebocar um veículo!", 5000, 'error')
	end
end)

Citizen.CreateThread(function()
    while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and (PlayerData.job.name == 'reboques' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'police') then
			if towSetupMode then
				local veh = nil
				if helpstate == 3 then
					helpstate = 0
				end
				if helpstate ~= 0 then
					local pos = GetEntityCoords(PlayerPedId(), true)
					local targetPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, -1.0)
					local rayCast = StartShapeTestCapsule(pos.x, pos.y, pos.z, targetPos.x, targetPos.y, targetPos.z, 2, 10, PlayerPedId(), 7)
					local _,hit,_,_,veh = GetShapeTestResult(rayCast)
					if hit and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
						currentSelectionReboques = veh
						if not showed1 then
							exports['Johnny_Notificacoes']:Alert("REBOQUE", "<span style='color:#c7c7c7'>Clica no E para selecionar o reboque quando vires o marcador amarelo por cima dele!", 10000, 'info')
							showed1 = true
						end
						if (IsControlJustPressed(0, 38)) then
							showed = false
							if helpstate == 1 then
								if not showed2 then
									exports['Johnny_Notificacoes']:Alert("REBOQUE", "<span style='color:#c7c7c7'>Vai até ao veículo que pretendes rebocar e quando vires o marcador amarelo pressiona E para confirmar o veículo a rebocar!", 10000, 'info')
									showed2 = true
								end
								towtruck = veh
								helpstate = 2
							elseif helpstate == 2 and veh ~= towtruck then
								if not showed3 then
									exports['Johnny_Notificacoes']:Alert("REBOQUE", "<span style='color:#c7c7c7'>Veículo selecionado, clica em Rebocar no F6 para rebocar o veículo!", 10000, 'info')
									showed3 = true
								end
								targetReboques = veh
								helpstate = 3
							end
						end
					else
						currentSelectionReboques = nil
					end
				elseif helpstate == 0 and IsControlJustPressed(0, 38) and towtruck ~= nil and targetReboques ~= nil then
					towtruck = nil
					targetReboques = nil
					helpstate = 1
				end
				
				DisableControlAction(0, 44)
			else
				Citizen.Wait(300)
				currentSelectionReboques = nil
			end
		else
			Citizen.Wait(5000)
		end 
    end
end)

local markerType = 0
local scale = 0.3
local alpha = 255
local bounce = true
local faceCam = false
local iUnk = 0
local rotate = false
local textureDict = nil
local textureName = nil
local drawOnents = false

Citizen.CreateThread(function()
    while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
        Citizen.Wait(0)
		if PlayerData.job ~= nil and (PlayerData.job.name == 'reboques' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'police') then
			if towSetupMode then
				if (currentSelectionReboques ~= nil and currentSelectionReboques ~= towtruck) then
					local pos = GetEntityCoords(currentSelectionReboques, true)
					local red = 255
					local green = 255
					local blue = 0
					DrawMarker(markerType, pos.x, pos.y, pos.z + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale, scale, scale - 0.1, red, green, blue, alpha, bounce, faceCam, iUnk, rotate, textureDict, textureName, drawOnents)
				end
				if (towtruck ~= nil) then
					local pos = GetEntityCoords(towtruck, true)
					local red = 255
					local green = 50
					local blue = 0
					DrawMarker(markerType, pos.x, pos.y, pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale, scale, scale - 0.1, red, green, blue, alpha, bounce, faceCam, iUnk, rotate, textureDict, textureName, drawOnents)
				end
				if (targetReboques ~= nil) then
					local pos = GetEntityCoords(targetReboques, true)
					local red = 255
					local green = 0
					local blue = 50
					DrawMarker(markerType, pos.x, pos.y, pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale, scale, scale - 0.1, red, green, blue, alpha, bounce, faceCam, iUnk, rotate, textureDict, textureName, drawOnents)
				end
			else
				Citizen.Wait(300)
			end
			
		else
			Citizen.Wait(5000)
		end
    end
end)