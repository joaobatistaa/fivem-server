local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil
local tempTipo = nil

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

function StartTheoryTest()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})

	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

	TriggerServerEvent('esx_dmvschool:johnny:payLicense', Config.Prices['dmv'])
end

RegisterCommand('cancelarteste', function(source)
	StopDriveTest(false)
	RemoveBlip(CurrentBlip)
end)

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

	if success then
		TriggerServerEvent('esx_dmvschool:johnny:addLicence', 'dmv')
		exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Foste aprovado no <span style='color:#069a19'>Exame Téorico</span>!", 5000, 'success')
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Reprovaste no <span style='color:#ff0000'>Exame Téorico</span>!", 5000, 'error')
	end
end

function StartDriveTest(type)
	if type == 'drive' then
		tempTipo = 'B'
	end
	
	if type == 'drive_bike' then
		tempTipo = 'A'
	end
	if type == 'drive_truck' then
		tempTipo = 'CE'
	end
	
	ESX.Game.SpawnVehicle(Config.VehicleModels[type], Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'drive'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)
		exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)

		local playerPed   = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

		--TriggerServerEvent("johnny:server:darChaves", GetVehicleNumberPlateText(vehicle), Config.VehicleModels[type])
		--TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))

	end)

	TriggerServerEvent('esx_dmvschool:johnny:payLicense', Config.Prices[type])
end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('esx_dmvschool:johnny:addLicence', CurrentTestType)
		exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Estás Aprovado no <span style='color:#069a19'>Exame Prático</span>!<br> Estás agora <span style='color:#069a19'>apto</span> para conduzir veículos da categoria <span style='color:#069a19'>"..tempTipo.."</span>!", 5000, 'success')
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Reprovaste no <span style='color:#ff0000'>Exame Prático</span>!<br>Volta numa próxima para tentares novamente!", 5000, 'error')
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
	CurrentZoneType = type
end

function OpenDMVSchoolMenu()
	local ownedLicenses = {}

	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end

	local elements = {}

	if not ownedLicenses['dmv'] then
		table.insert(elements, {
			label = (('%s: <span style="color:green;">%s</span>'):format(_U('theory_test'), _U('school_item', ESX.Math.GroupDigits(Config.Prices['dmv'])))),
			value = 'theory_test'
		})
	end

	if ownedLicenses['dmv'] then
		if not ownedLicenses['drive'] then
			table.insert(elements, {
				label = (('%s: <span style="color:green;">%s</span>'):format(_U('road_test_car'), _U('school_item', ESX.Math.GroupDigits(Config.Prices['drive'])))),
				value = 'drive_test',
				type = 'drive'
			})
		end

		if not ownedLicenses['drive_bike'] then
			table.insert(elements, {
				label = (('%s: <span style="color:green;">%s</span>'):format(_U('road_test_bike'), _U('school_item', ESX.Math.GroupDigits(Config.Prices['drive_bike'])))),
				value = 'drive_test',
				type = 'drive_bike'
			})
		end

		if not ownedLicenses['drive_truck'] then
			table.insert(elements, {
				label = (('%s: <span style="color:green;">%s</span>'):format(_U('road_test_truck'), _U('school_item', ESX.Math.GroupDigits(Config.Prices['drive_truck'])))),
				value = 'drive_test',
				type = 'drive_truck'
			})
		end
		
		table.insert(elements, {
			label = (('%s: <span style="color:green;">%s</span>'):format('Pedir Segunda Via da Carta de Condução', _U('school_item', ESX.Math.GroupDigits(5000)))),
			value = 'segunda_via'
		})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions', {
		title    = _U('driving_school'),
		elements = elements,
		align    = 'top-left'
	}, function(data, menu)
		if data.current.value == 'theory_test' then
			menu.close()
			ESX.TriggerServerCallback("esx_dmvschool:server:checkmoney", function(hasMoney) 
				if hasMoney then
					StartTheoryTest()
				else
					exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>dinheiro</span> suficiente!", 5000, 'error')
				end
			end, Config.Prices['dmv'])
			
		elseif data.current.value == 'drive_test' then
			menu.close()
			StartDriveTest(data.current.type)
		elseif data.current.value == 'segunda_via' then
			menu.close()
			TriggerServerEvent("esx_dmvschool:johnny:segundaVia", 5000)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'dmvschool_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end)
end

function CamaraMunicipal()
	local elements = {}
	table.insert(elements, {
		label = ('Segunda Via do Cartão de Cidadão: <span style="color:green;">1000€</span>'),
		value = 'segunda_via'
	})
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions', {
		title    = 'Câmara Municipal',
		elements = elements,
		align    = 'top-left'
	}, function(data, menu)
		if data.current.value == 'segunda_via' then
			menu.close()
			TriggerServerEvent('wtrp:segundavia_cartao_cidadao')
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'camara_municipal'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end)
end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb()
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb()
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)

AddEventHandler('esx_dmvschool:hasEnteredMarker', function(zone)
	if zone == 'DMVSchool' then
		CurrentAction     = 'dmvschool_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	elseif zone == 'CamaraMunicipal' then
		CurrentAction     = 'camara_municipal'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_dmvschool:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z)

	SetBlipSprite (blip, 498)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('driving_school_blip'))
	EndTextCommandSetBlipName(blip)
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		local coords = GetEntityCoords(PlayerPedId())
		local sleep = 3000
		
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				sleep = 5
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5 then
					DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z+0.8, 'Pressiona ~g~[E]~s~ para abrir o menu')
					if IsControlJustReleased(0, 38) then
						if k == 'DMVSchool' then
							OpenDMVSchoolMenu()
						--else
							--CamaraMunicipal()
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(100)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_dmvschool:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_dmvschool:hasExitedMarker', LastZone)
		end
	end
end)

-- Block UI
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentTest == 'theory' then
			local playerPed = PlayerPedId()

			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(500)
		end
	end
end)


-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'drive' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil
				
				exports['Johnny_Notificacoes']:Alert("EXAMINADOR", "<span style='color:#c7c7c7'>Terminaste o teu <span style='color:#069a19'>Exame Prático</span>!", 5000, 'success')
				
				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'drive' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							exports['Johnny_Notificacoes']:Alert("EXAMINADOR", "<span style='color:#c7c7c7'>Estás a conduzir muito <span style='color:#ff0000'>rápido</span>!<br>O limite de velocidade é: "..v.."km/h", 5000, 'error')
							exports['Johnny_Notificacoes']:Alert("EXAMINADOR", "<span style='color:#c7c7c7'>ERROS: <span style='color:#fff'>"..DriveErrors.."</span>/<span style='color:#ff0000'>"..Config.MaxErrors.."</span> !", 5000, 'info')
							
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					exports['Johnny_Notificacoes']:Alert("EXAMINADOR", "<span style='color:#c7c7c7'>Danificaste o <span style='color:#ff0000'>veículo</span> da Escola de Condução!", 5000, 'error')
					exports['Johnny_Notificacoes']:Alert("EXAMINADOR", "<span style='color:#c7c7c7'>ERROS: <span style='color:#fff'>"..DriveErrors.."</span>/<span style='color:#ff0000'>"..Config.MaxErrors.."</span> !", 5000, 'info')

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)
