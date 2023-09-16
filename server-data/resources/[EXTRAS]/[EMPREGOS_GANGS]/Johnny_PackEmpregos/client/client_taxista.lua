local HasAlreadyEnteredMarkerTaxi, CurrentActionDataTaxi = false, {}
local LastZoneTaxi, CurrentActionTaxi, CurrentActionMsgTaxi

function OpenCloakroomTaxi()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'taxi_cloakroom',
	{
		title    = 'Vestiário',
		align    = 'top-left',
		elements = {
			{ label = 'Roupa Normal', value = 'wear_citizen' },
			{ label = 'Roupa de Serviço',    value = 'wear_work'}
		}
	}, function(data, menu)
		if data.current.value == 'wear_citizen' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'wear_work' then
			--[[
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
			--]]
			setUniformTaxista(data.current.value)
		end
	end, function(data, menu)
		menu.close()

		CurrentActionTaxi     = 'cloakroom'
		CurrentActionMsgTaxi  = ''
		CurrentActionDataTaxi = {}
	end)
end

function setUniformTaxista(job)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.TaxistaUniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.TaxistaUniforms[job].male)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		else
			if Config.TaxistaUniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.TaxistaUniforms[job].female)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		end
	end)
end

function MenuF6Taxista()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'taxi_actions', {
		title    = '🚕 Menu Taxista',
		align    = 'top-left',
		elements = {
			{label = '⏲️ Ativar/Desativar Medidor de Táxi',      value = 'medidor_taxi'},
	}}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'medidor_taxi' then
			ExecuteCommand('medidortaxi')
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenuTaxi()
	ESX.UI.Menu.CloseAll()

	local elements = {}


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
	{
		title		= 'Garagem',
		align		= 'top-left',
		elements	= Config.TaxiInfo.Veiculos
	}, function(data, menu)
		if not ESX.Game.IsSpawnPointClear(Config.TaxiInfo.Zones.VehicleSpawnPoint.Pos, 5.0) then
			exports['mythic_notify']:DoHudText('error', 'Está um veículo a bloquear o spawnpoint!')
			return
		end

		menu.close()
		ESX.Game.SpawnVehicle(data.current.model, Config.TaxiInfo.Zones.VehicleSpawnPoint.Pos, Config.TaxiInfo.Zones.VehicleSpawnPoint.Heading, function(vehicle)
			local playerPed = PlayerPedId()
			local plate = 'TAXI' .. math.random(100, 900)
			SetVehicleNumberPlateText(vehicle, plate)
			exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
			exports['qs-vehiclekeys']:GiveKeysAuto()
			--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Usa o comando /medidortaxi para ativar/desativar o Medidor de Táxi!", 10000, 'success')
		end)
	end, function(data, menu)
		CurrentActionTaxi     = 'vehicle_spawner'
		CurrentActionMsgTaxi  = ''
		CurrentActionDataTaxi = {}

		menu.close()
	end)

end

AddEventHandler('esx_taxijob:hasEnteredMarker', function(zone)
	if zone == 'VehicleSpawner' then
		CurrentActionTaxi     = 'vehicle_spawner'
		CurrentActionMsgTaxi  = ''
		CurrentActionDataTaxi = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentActionTaxi     = 'delete_vehicle'
			CurrentActionMsgTaxi  = ''
			CurrentActionDataTaxi = { vehicle = vehicle }
		end

	elseif zone == 'Cloakroom' then
		CurrentActionTaxi     = 'cloakroom'
		CurrentActionMsgTaxi  = ''
		CurrentActionDataTaxi = {}
	end
end)

AddEventHandler('esx_taxijob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentActionTaxi = nil
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.TaxiInfo.Zones.Cloakroom.Pos.x, Config.TaxiInfo.Zones.Cloakroom.Pos.y, Config.TaxiInfo.Zones.Cloakroom.Pos.z)

	SetBlipSprite (blip, 198)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Central de Táxis')
	EndTextCommandSetBlipName(blip)
end)

-- Enter / Exit marker events, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'taxi' then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, letSleep, currentZone = false, true

			for k,v in pairs(Config.TaxiInfo.Zones) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
				
				if distance < 3 then
					if k == 'Cloakroom' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Vestiário', 0.3)
					end
					if k == 'VehicleDeleter' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
					end
					if k == 'VehicleSpawner' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Retirar Veículo', 0.3)
					end
				end
				
				if distance < 30 then
					letSleep = false
					if k ~= 'VehicleSpawnPoint' then
						DrawMarker(2, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end

			if isInMarker or (isInMarker and LastZoneTaxi ~= currentZone) then
				HasAlreadyEnteredMarkerTaxi, LastZoneTaxi = true, currentZone
				TriggerEvent('esx_taxijob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarkerTaxi then
				HasAlreadyEnteredMarkerTaxi = false
				TriggerEvent('esx_taxijob:hasExitedMarker', LastZoneTaxi)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if PlayerData.job and PlayerData.job.name == 'taxi' then
			if CurrentActionTaxi and not isDead then
				--ESX.ShowHelpNotification(CurrentActionMsgTaxi)

				if IsControlJustReleased(0, 38) then
					if CurrentActionTaxi == 'cloakroom' then
						OpenCloakroomTaxi()
					elseif CurrentActionTaxi == 'vehicle_spawner' then
						OpenVehicleSpawnerMenuTaxi()
					elseif CurrentActionTaxi == 'delete_vehicle' then
						local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
						local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
						local plate = GetVehicleNumberPlateText(veh)
						exports['qs-vehiclekeys']:RemoveKeysAuto()
						--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
						DeleteVehicle(veh)
						exports['mythic_notify']:DoHudText('success', 'Veículo guardado na garagem!')
					end

					CurrentActionTaxi = nil
				end
			end
			if IsControlJustReleased(0, 167) and not isDead and PlayerData.job and PlayerData.job.name == 'taxi' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'taxi_actions') then
				MenuF6Taxista()
			end
		else
			Citizen.Wait(2000)
		end
	end
end)