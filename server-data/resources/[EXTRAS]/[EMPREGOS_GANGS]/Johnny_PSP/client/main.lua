local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = {}
local DragStatus              = {}
DragStatus.IsDragged          = false
local hasAlreadyJoined        = false
local blipsCops               = {}
local isDead                  = false
local CurrentTask             = {}
local playerInService         = false

local dict = "mp_arresting"
local anim = "idle"
local flags = 49
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")

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

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 2,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

RegisterNetEvent('esx:policejob:sacouniforme')
AddEventHandler('esx:policejob:sacouniforme', function()

	Citizen.Wait(500)
	local playerPed = PlayerPedId()
	
	if IsPedSittingInAnyVehicle(playerPed) then
		MenuRoupas()
	else
		exports['mythic_notify']:DoHudText('error', 'O item só pode ser usado dentro de um veículo!')
	end

end)

function setUniform(job, playerPed)
	if job ~= nil then
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				if Config.Uniforms[job].male ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
				else
					ESX.ShowNotification(_U('no_outfit'))
				end

				if job == 'bullet_wear' or job == 'fardacoletea_wear' or job == 'fardacoleteb_wear' or  job == 'fardagoea_wear' or job == 'fardagoeb_wear' then
					SetPedArmour(playerPed, 100)
				end
			else
				if Config.Uniforms[job].female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
				else
					ESX.ShowNotification(_U('no_outfit'))
				end

				if job == 'bullet_wear' or job == 'fardacoletea_wear' or job == 'fardacoleteb_wear' or  job == 'fardagoea_wear' or job == 'fardagoeb_wear' then
					SetPedArmour(playerPed, 100)
				end
			end
		end)
	end
end

function MenuRoupas()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' }
	}

	if PlayerData.job.grade_name == 'recruit' then
	
		  table.insert(elements, {label = 'PSP - Recruta', value = 'fardarecruta_wear'})
		  
	elseif PlayerData.job.grade_name == 'aspirante' then	  
	
		  table.insert(elements, {label = 'PSP - Agende em Formação', value = 'fardaagentef_wear'})
		  
	elseif PlayerData.job.grade_name == 'officer' then
	
		  table.insert(elements, {label = '---------// AGENTES //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Agente ', value = 'fardaagente_wear'}) 
		  table.insert(elements, {label = 'PSP - Agente C/ Colete de Trânsito', value = 'fardaagentecolete_wear'}) 
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})
		  
	elseif PlayerData.job.grade_name == 'sergeant' then
	
		  table.insert(elements, {label = '---------// AGENTES //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Agente ', value = 'fardaagente2_wear'}) 
		  table.insert(elements, {label = 'PSP - Agente C/ Colete de Trânsito', value = 'fardaagente2colete_wear'}) 
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})
	
	elseif PlayerData.job.grade_name == 'lieutenant' then
	
		  table.insert(elements, {label = '---------// AGENTES //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Agente ', value = 'fardaagente3_wear'}) 
		  table.insert(elements, {label = 'PSP - Agente C/ Colete de Trânsito', value = 'fardaagente3colete_wear'})
		  table.insert(elements, {label = 'PSP - Agente Colete', value = 'fardaagente3colete2_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})

	elseif PlayerData.job.grade_name == 'chefe' then
	
		  table.insert(elements, {label = '---------// CHEFES //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Chefe', value = 'fardachefe_wear'})
		  table.insert(elements, {label = 'PSP - Chefe com Colete', value = 'fardachefecolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})		  
	
	elseif PlayerData.job.grade_name == 'chefeprincipal' then
	 
		  table.insert(elements, {label = '---------// CHEFES //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Chefe Principal', value = 'fardachefeprincipal_wear'})  
		  table.insert(elements, {label = 'PSP - Chefe Principal com Colete', value = 'fardachefeprincipalcolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})
  
	elseif PlayerData.job.grade_name == 'chefecoordenador' then
		
		  table.insert(elements, {label = '---------// OFICIAIS //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Chefe Coordenador', value = 'fardachefecoordenador_wear'})
		  table.insert(elements, {label = 'PSP - Chefe Coordenador C/ Colete', value = 'fardachefecoordenadorcolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})

	elseif PlayerData.job.grade_name == 'subcomissario' then
	
		  table.insert(elements, {label = '---------// OFICIAIS //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Sub Comissário', value = 'fardasubcomissario_wear'})
		  table.insert(elements, {label = 'PSP - Sub Comissário com Colete', value = 'fardasubcomissariocolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})

	elseif PlayerData.job.grade_name == 'comissario' then
	
		  table.insert(elements, {label = '---------// OFICIAIS //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Comissário', value = 'fardacomissario_wear'})
		  table.insert(elements, {label = 'PSP - Comissário com Colete', value = 'fardacomissariocolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})

	elseif PlayerData.job.grade_name == 'subintendente' then
	
		  table.insert(elements, {label = '---------// 1º OFICIAIS //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Subintendente', value = 'fardasubintendente_wear'})
		  table.insert(elements, {label = 'PSP - Subintendente com Colete', value = 'fardasubintendentecolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})
  
	elseif PlayerData.job.grade_name == 'intendente' then
	
		  table.insert(elements, {label = '---------// 1º OFICIAIS //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Intendente', value = 'fardaintendente_wear'})
		  table.insert(elements, {label = 'PSP - Intendente com Colete', value = 'fardaintendentecolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})
  
	elseif PlayerData.job.grade_name == 'superintendente' then
	
		  table.insert(elements, {label = '---------// 1º OFICIAIS //---------', value = ''})
		  table.insert(elements, {label = 'PSP - SuperIntendente', value = 'fardasuperintendente_wear'})
		  table.insert(elements, {label = 'PSP - SuperIntendente com Colete', value = 'fardasuperintendentecolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})

	elseif PlayerData.job.grade_name == 'superintendentechefe' then	
	
		  table.insert(elements, {label = '---------// 1º OFICIAIS //---------', value = ''})
		  table.insert(elements, {label = 'PSP - SuperIntendente Chefe', value = 'fardasuperintendentechefe_wear'})
		  table.insert(elements, {label = 'PSP - SuperIntendente Chefe com Colete', value = 'fardasuperintendentechefecolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})
	
	elseif PlayerData.job.grade_name == 'goe' then
	
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})

	elseif PlayerData.job.grade_name == 'diretornacionaladjunto' then
	
		  table.insert(elements, {label = '---------// DIRETOR NACIONAL ADJUNTO//---------', value = ''})
		  table.insert(elements, {label = 'PSP - Diretor Nacional Adjunto', value = 'fardadnajunto_wear'})
		  table.insert(elements, {label = 'PSP - Diretor Nacional Adjunto com colete', value = 'fardadnajuntocolete_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})

	elseif PlayerData.job.grade_name == 'boss' then
	
		  table.insert(elements, {label = '---------// DIRETOR NACIONAL //---------', value = ''})
		  table.insert(elements, {label = 'PSP - Diretor Nacional', value = 'fardadn_wear'})
		  table.insert(elements, {label = 'PSP - Diretor Nacional com colete', value = 'fardadncolete_wear'})
		  table.insert(elements, {label = 'PSP - Diretor Nacional Cerimonia', value = 'fardadncerimonica_wear'})
		  table.insert(elements, {label = '---------// UNIDADES ESPECIAIS //---------', value = ''})
		  table.insert(elements, {label = 'UEP - EPRI', value = 'fardaepri_wear'})
		  table.insert(elements, {label = 'GOE - FARDA GOE', value = 'fardagoe_wear'})
		  table.insert(elements, {label = 'PSP - AGUIA', value = 'fardaaguia_wear'})
		  
	
	end  

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value ~= '' then
			setUniform(data.current.value, playerPed)
		end

	end, function(data, menu)
		menu.close()

		--CurrentAction     = 'menu_cloakroom'
		--CurrentActionMsg  = _U('open_cloackroom')
		--CurrentActionData = {}
	end)
end

function GaragemVeiculos(station, partNum)

	ESX.UI.Menu.CloseAll()
	
	local elements = {}

	local sharedVehicles = Config.AuthorizedVehicles.Shared
	for i=1, #sharedVehicles, 1 do
		table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
	end
	
	local carros = Config.AuthorizedVehicles[PlayerData.job.grade_name]
	for i=1, #carros, 1 do
		table.insert(elements, { label = carros[i].label, model = carros[i].model})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
	{
		title    = _U('vehicle_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local foundSpawnPoint, spawnPoint = ProcuraSpawnVeiculo(station, partNum, data.current.model)

		if foundSpawnPoint then
			if data.current.model == 'mcc' then
				ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					SetVehicleExtra(vehicle, 2,true)
					SetVehicleMaxMods(vehicle)
					--SetVehicleNumberPlateText(vehicle, "ESTADO")
					exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
					local plate = 'PSP' .. math.random(100, 900)
					SetVehicleNumberPlateText(vehicle, plate)
					exports['qs-vehiclekeys']:GiveKeysAuto()
					--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
				end)
			else
				ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					SetVehicleMaxMods(vehicle)
					--SetVehicleNumberPlateText(vehicle, "ESTADO")
					local plate = 'PSP' .. math.random(100, 900)
					SetVehicleNumberPlateText(vehicle, plate)
					exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
					exports['qs-vehiclekeys']:GiveKeysAuto()
					--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
				end)
			end
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end)

end

function HeliportoSpawner(station, partNum)

	ESX.UI.Menu.CloseAll()
	
	local elements = {}
	
	local authorizedVehicles = Config.AuthorizedVehicles2
		for i=1, #authorizedVehicles, 1 do
			table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model})
		end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner2',
	{
		title		= 'Héliporto',
		align		= 'top-left',
		elements	= elements
	}, function(data, menu)
		menu.close()
		
		local foundSpawnPoint, spawnPoint = ProcuraSpawnHeliporto(station, partNum)
		
		ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
			local playerPed = PlayerPedId()
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			local plate = 'PSP' .. math.random(100, 900)
			SetVehicleNumberPlateText(vehicle, plate)
			exports['qs-vehiclekeys']:GiveKeysAuto()
			--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
		end)
		
	end, function(data, menu)
		menu.close()
		CurrentAction		= 'vehicle_spawner_menu2'
		CurrentActionMsg	= _U('heli_spawner')
		CurrentActionData	= {}
	end)
end

function BarcosPSPSpawner(station, partNum)

	ESX.UI.Menu.CloseAll()

	local elements = {}

	local sharedVehicles = Config.AuthorizedVehicles3
	for i=1, #sharedVehicles, 1 do
		table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_spawner',
	{
		title    = 'Garagem de Barcos da PSP',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local foundSpawnPoint, spawnPoint = ProcuraSpawnBarco(station, partNum)

		if foundSpawnPoint then
			ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
				TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
				SetVehicleMaxMods(vehicle)
				local plate = 'PSP' .. math.random(100, 900)
				SetVehicleNumberPlateText(vehicle, plate)
				exports['qs-vehiclekeys']:GiveKeysAuto()
				--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_boat_spawner'
		CurrentActionMsg  = _U('boat_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end)
end

function BarcosBombeirosSpawner(station, partNum)

	ESX.UI.Menu.CloseAll()

	local elements = {}

	local sharedVehicles = Config.AuthorizedVehicles4
	for i=1, #sharedVehicles, 1 do
		table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_spawner',
	{
		title    = 'Garagem de Barcos dos Bombeiros',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local foundSpawnPoint, spawnPoint = ProcuraSpawnBarco(station, partNum)

		if foundSpawnPoint then
			ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
				TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
				SetVehicleMaxMods(vehicle)
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_boat_spawner2'
		CurrentActionMsg  = _U('boat_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end)
end

function ProcuraSpawnVeiculo(station, partNum, carro)
	
	local spawnPoints
	local found, foundSpawnPoint = false, nil
	
	if carro == 'mcc' then
		spawnPoints2 = Config.PoliceStations[station].Vehicles[partNum].SpawnPoints2
		
		for i=1, #spawnPoints2, 1 do
			if ESX.Game.IsSpawnPointClear(spawnPoints2[i], spawnPoints2[i].radius) then
				found, foundSpawnPoint = true, spawnPoints2[i]
				break
			end
		end
	else
		spawnPoints = Config.PoliceStations[station].Vehicles[partNum].SpawnPoints
	
		for i=1, #spawnPoints, 1 do
			if ESX.Game.IsSpawnPointClear(spawnPoints[i], spawnPoints[i].radius) then
				found, foundSpawnPoint = true, spawnPoints[i]
				break
			end
		end
	end
	

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function ProcuraSpawnBarco(station, partNum)
	local spawnPoints = Config.PoliceStations[station].Boats[partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i], spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function ProcuraSpawnHeliporto(station, partNum)
	local spawnPoints = Config.PoliceStations[station].Helicopters[partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i], spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function ApagarBarco(station, partNum)
	local tp = Config.PoliceStations[station].Boats[partNum].Teleport
	local playerPed = PlayerPedId()
	
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(CurrentActionData.vehicle))
	local plate = GetVehicleNumberPlateText(CurrentActionData.vehicle)
	--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
	exports['qs-vehiclekeys']:RemoveKeysAuto()
	ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					
	ESX.Game.Teleport(playerPed, tp, function()
		SetEntityHeading(playerPed, tp.heading)
	end)
end

function AbrirMenuPolicia()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions',
	{
		title    = '👮 PSP',
		align    = 'top-left',
		elements = {
			{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
			{label = _U('object_spawner'),		value = 'object_spawner'},
			{label = "⛓️ Menu Prisional",      value = 'jail_menu'}
		}
	}, function(data, menu)
	
		if data.current.value == 'jail_menu' then
            TriggerEvent("esx-qalle-jail:openJailMenu")
        end
		
		if data.current.value == 'cao_policial' then
            TriggerEvent('esx_policedog:openMenu')
        end

		if data.current.value == 'citizen_interaction' then
			local elements = {
				--{label = _U('id_card'),			value = 'identity_card'},
				{label = _U('search'),			value = 'body_search'},
				{label = _U('handcuff'),		value = 'handcuff'},
				{label = '🔒 Algemar c/ animação', value = 'handcuffcomanim'},
				{label = _U('drag'),			value = 'drag'},
				{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
				--{label = _U('fine'),			value = 'fine'},
				{label = '🧬 Recolher ADN',		value = 'adn'},
				{label = '🧬 Remover ADN',		value = 'adn1'},
				--{label = _U('unpaid_bills'),	value = 'unpaid_bills'},
				{label = "📇 Emitir Porte de Arma", value = 'weapon_license'},
				{label = "📇 Emitir Licença de Caça", value = 'hunting_license'},
			}
		
			if Config.EnableLicenses then
				table.insert(elements, { label = _U('license_check'), value = 'license' })
			end
		
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('citizen_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'body_search' then
						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
						TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", GetPlayerServerId(closestPlayer))
						menu2.close()
						menu.close()
					elseif action == 'handcuff' then
						TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
					elseif action == 'handcuffcomanim' then
						TriggerServerEvent('esx_ruski_areszt:startAreszt', GetPlayerServerId(closestPlayer))		
						Citizen.Wait(5000)
						TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
					elseif action == 'drag' then
						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					elseif action == 'adn' then
					  local player, distance = ESX.Game.GetClosestPlayer()
						if distance ~= -1 and distance <= 3.0 then
							TriggerEvent('jsfour-dna:get', player)
						end
					elseif action == 'adn1' then
						TriggerEvent('jsfour-dna:remove')
					elseif action == 'hunting_license' then
						TriggerServerEvent('esx_policejob:server:giveLicenseCaca', GetPlayerServerId(closestPlayer))
					elseif action == 'weapon_license' then
						TriggerServerEvent('esx_policejob:server:giveLicenseArma', GetPlayerServerId(closestPlayer))
					end

				else
					exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			
			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'),	value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
				--table.insert(elements, {label = _U('impound'),		value = 'impound'})
				--table.insert(elements, {label = _U('impound2'),		value = 'impound2'})
				table.insert(elements, {label = '⚙️ Rebocar',		value = 'rebocar_veiculo'})
				--table.insert(elements, {label = '🧾 Verificar Seguro',		value = 'seguro_carro'})
			end
			
			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_interaction',
			{
				title    = _U('vehicle_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value
				
				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					if action == 'vehicle_infos' then
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'seguro_carro' then
						local plate = vehicleData.plate
						TriggerEvent("t1ger_carinsurance:checkVehInsurance", plate)
					elseif action == 'rebocar_veiculo' then
						ExecuteCommand('rebocar')
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
						local valor_multa
						ESX.UI.Menu.CloseAll()
	
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'valor_carro', { title = "Indica a que preço o veículo poderá ser recuperado: " }, function(data4, menu4)
							local amount = tonumber(data4.value)
							if amount == nil or amount < 0 then
								ESX.ShowNotification("Montante Inválida!")
							else
								menu4.close()
								valor_multa = amount
								if CurrentTask.Busy then
									return
								end

								ESX.ShowHelpNotification(_U('impound_prompt'))
								
								TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
								
								CurrentTask.Busy = true
								CurrentTask.Task = ESX.SetTimeout(10000, function()
									ClearPedTasks(playerPed)
									ImpoundVehicle(vehicle, valor_multa)
									Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
								end)
								
								-- keep track of that vehicle!
								Citizen.CreateThread(function()
									while CurrentTask.Busy do
										Citizen.Wait(1000)
									
										vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
										if not DoesEntityExist(vehicle) and CurrentTask.Busy then
											ESX.ShowNotification(_U('impound_canceled_moved'))
											ESX.ClearTimeout(CurrentTask.Task)
											ClearPedTasks(playerPed)
											CurrentTask.Busy = false
											break
										end
									end
								end)
							end
						end, function(data4, menu4)
							menu4.close()
						end)
						menu2.close()
						menu.close()
						-- is the script busy?
						
					elseif action == 'impound2' then
						ESX.UI.Menu.CloseAll()
						-- is the script busy?
						if CurrentTask.Busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						
						CurrentTask.Busy = true
						CurrentTask.Task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle2(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)
						
						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while CurrentTask.Busy do
								Citizen.Wait(1000)
							
								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(CurrentTask.Task)
									ClearPedTasks(playerPed)
									CurrentTask.Busy = false
									break
								end
							end
						end)
					end
				else
					exports['mythic_notify']:DoHudText('error', "Não há veículos por perto!")
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = '❌ Remover Objeto',		value = 'remover'},
					{label = _U('cone'),		value = 'prop_roadcone02a'},
					{label = _U('barrier'),		value = 'prop_barrier_work05'},
					{label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
					{label = _U('box'),			value = 'prop_boxpile_07d'},
					{label = _U('cash'),		value = 'hei_prop_cash_crate_half_full'},
					{label = '🎪 Tenda',		value = 'prop_busstop_02'},
				}
			}, function(data2, menu2)
				if data2.current.value == 'remover' then
					DeleteOBJ()
				else
					SpawnObject(data2.current.value)
				end
				
			end, function(data2, menu2)
				menu2.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_policejob:algemar')
AddEventHandler('esx_policejob:algemar', function(isPSP)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		if isPSP then
			TriggerServerEvent('esx_ruski_areszt:startAreszt', GetPlayerServerId(closestPlayer))		
			Citizen.Wait(5000)
			TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
		else
			TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
	end
end)

function SpawnObject(objectname)
    local Player = GetPlayerPed(-1)
    local x, y, z = table.unpack(GetEntityCoords(Player, true))
    local heading = GetEntityHeading(Player)
   
    RequestModel(objectname)

    while not HasModelLoaded(objectname) do
	    Citizen.Wait(1)
    end

    local obj = CreateObject(GetHashKey(objectname), x, y, z-1.90, true, true, true)
	PlaceObjectOnGroundProperly(obj)
    SetEntityHeading(obj, heading)
    FreezeEntityPosition(obj, true)

end

function DeleteOBJ()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full',
		'prop_busstop_02'
	}

	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	local closestDistance = -1
	local closestEntity   = nil

	for i=1, #trackedEntities, 1 do
		local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey(trackedEntities[i]), false, false, false)
		
		
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)
			local distance  = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, objCoords.x, objCoords.y, objCoords.z, true)
			DeleteObject(object)
		end
	end
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
			if data.name ~= nil then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
	
		end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = _U('license_label'), value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = _U('citizen_interaction'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

function OpenFineMenu(player)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
	{
		title    = _U('fine'),
		align    = 'top-left',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3},
			{label = 'Multa Personalizada',   value = 4}
		}
	}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)

end

function OpenFineCategoryMenu(player, category)
	
	if category == 4 then
		ESX.UI.Menu.CloseAll()
		local razaoMulta
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'razao_fatura', { title = "Introduza a razão da multa:" }, function(data, menu)
			razaoMulta = data.value
			if razaoMulta == nil then
				ESX.ShowNotification("Razão Inválida!")
			else
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'preco_fatura', { title = "Introduza o preço da multa:" }, function(data2, menu2)
					local preco = tonumber(data2.value)
					if preco == nil or preco < 0 or preco == 0 then
						ESX.ShowNotification("Montante Inválido!")
					else
						--TriggerServerEvent("okokBilling:createInvoicePlayer", data)
						TriggerServerEvent("okokBilling:CreateCustomInvoice", GetPlayerServerId(player), preco, _U('fine_total', razaoMulta), 'Multa', 'society_police', 'PSP')
						exports['mythic_notify']:DoHudText('inform', 'Multa enviada com sucesso!')
						--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', razaoMulta), preco)
						menu2.close()
						menu.close()
					end
				end, function(data2, menu2)
					menu2.close()
				end)	
			end
		end, function(data, menu)
			menu.close()
		end)
		
	else
		ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)

			local elements = {}

			for i=1, #fines, 1 do
				table.insert(elements, {
					label     = fines[i].label .. ' <span style="color: green;">' .. fines[i].amount .. '€</span>',
					value     = fines[i].id,
					amount    = fines[i].amount,
					fineLabel = fines[i].label
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
			{
				title    = _U('fine'),
				align    = 'top-left',
				elements = elements,
			}, function(data, menu)

				local label  = data.current.fineLabel
				local amount = data.current.amount

				menu.close()
			
				TriggerServerEvent("okokBilling:CreateCustomInvoice", GetPlayerServerId(player), amount, _U('fine_total', label), 'Multa', 'society_police', 'PSP')
				exports['mythic_notify']:DoHudText('inform', 'Multa enviada com sucesso!')

				--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', label), amount)

				ESX.SetTimeout(300, function()
					OpenFineCategoryMenu(player, category)
				end)

			end, function(data, menu)
				menu.close()
			end)

		end, category)
	end
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Apreendeste a "..data.current.label.." com sucesso!</span>", 5000, 'success')
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('okokBilling:getTargetInvoices', function(bills)
		for i=1, #bills, 1 do
			table.insert(elements, {label = bills[i].item .. ' - <span style="color: red;">' .. bills[i].invoice_value .. '€</span>', value = bills[i].ref_id})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function JailPlayer(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_menu', {
		title = _U('jail_menu_info'),
	}, function (data2, menu)
		local jailTime = tonumber(data2.value)
		if jailTime == nil then
			ESX.ShowNotification('Número inválido!')
		else
			TriggerServerEvent("esx_jail:sendToJail", player, jailTime * 60)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end
		
		if retrivedInfo.insurance ~= nil and retrivedInfo.insurance ~= 'none' then
			table.insert(elements, {label = 'Seguro: Válido', value = nil})
		else
			table.insert(elements, {label = 'Seguro: Não', value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		{
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)

end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)

	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionData = {}

	elseif part == 'Armory' then

		CurrentAction     = 'menu_armory'
		CurrentActionData = {station = station}
		
	elseif part == 'Armario_Evidencias' then

		CurrentAction     = 'menu_armory_evidencias'
		CurrentActionData = {station = station}
		
	elseif part == 'Armario_ItensIlegais' then

		CurrentAction     = 'menu_armory_itensilegais'
		CurrentActionData = {station = station}
		
	elseif part == 'Armario_ItensAssalto' then

		CurrentAction     = 'menu_armory_itensassalto'
		CurrentActionData = {station = station}
		
	elseif part == 'Armario_Lixo' then

		CurrentAction     = 'menu_armory_lixo'
		CurrentActionData = {station = station}
		
	elseif part == 'Armario_Outros' then

		CurrentAction     = 'menu_armory_outros'
		CurrentActionData = {station = station}
		
	elseif part == 'Armario_Pessoal' then

		CurrentAction     = 'menu_armory_pessoal'
		CurrentActionData = {station = station}

	elseif part == 'VehicleSpawner' then

		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}

	elseif part == 'HelicopterSpawner' then

		CurrentAction     = 'menu_vehicle_spawner2'
		CurrentActionMsg  = _U('heli_spawner')
		CurrentActionData = {station = station, partNum = partNum}
		
	elseif part == 'BoatSpawner' and PlayerData.job.name == 'police' then

		CurrentAction     = 'menu_boat_spawner'
		CurrentActionMsg  = _U('boat_spawner')
		CurrentActionData = {station = station, partNum = partNum}
		
	elseif part == 'BoatSpawner' and PlayerData.job.name == 'bombeiros' then

		CurrentAction     = 'menu_boat_spawner2'
		CurrentActionMsg  = _U('boat_spawner')
		CurrentActionData = {station = station, partNum = partNum}


	elseif part == 'VehicleDeleter' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_vehicle')
				CurrentActionData = {vehicle = vehicle}
			end

		end
		
	elseif part == 'VehicleDeleter3' and PlayerData.job.name == 'police' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_boat'
				CurrentActionMsg  = _U('store_boat')
				CurrentActionData = {vehicle = vehicle, station = station, partNum = partNum}
			end

		end
		
	elseif part == 'VehicleDeleter3' and PlayerData.job.name == 'bombeiros' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_boat'
				CurrentActionMsg  = _U('store_boat')
				CurrentActionData = {vehicle = vehicle, station = station, partNum = partNum}
			end

		end
	

	elseif part == 'VehicleDeleter2' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_vehicle2')
				CurrentActionData = {vehicle = vehicle}
			end

		end

	elseif part == 'BossActions' then

		CurrentAction     = 'menu_boss_actions'
	--	CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}

	end

end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()

    ped = PlayerPedId()
    
    RequestAnimDict(dict)
    

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    if IsHandcuffed then

        ClearPedTasks(ped)
		
        SetEnableHandcuffs(ped, false)
        
		TriggerEvent("canUseInventoryAndHotbar:toggle", true)
		TriggerEvent("canHandsUp:toggle", true)

		--exports['qs-inventory']:setInventoryDisabled(false)
		exports['qs-smartphone']:canUsePhone(true)

        UncuffPed(ped)

        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
			
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end
        
    else
		
        if GetEntityModel(ped) == femaleHash then -- mp female
            prevFemaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        
        elseif GetEntityModel(ped) == maleHash then -- mp male
            prevMaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 41, 0, 0)
        end
        
        SetEnableHandcuffs(ped, true)
        TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
        TriggerEvent("canUseInventoryAndHotbar:toggle", false)
        TriggerEvent("canHandsUp:toggle", false)
		--exports['qs-inventory']:setInventoryDisabled(true)
		exports['qs-smartphone']:canUsePhone(false)
    end

    IsHandcuffed = not IsHandcuffed

    changed = true
end)

RegisterNetEvent('esx_policejob:algemar1')
AddEventHandler('esx_policejob:algemar1', function()

    ped = PlayerPedId()
    
    RequestAnimDict(dict)
    

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    if not IsHandcuffed then
		
        if GetEntityModel(ped) == femaleHash then -- mp female
            prevFemaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        
        elseif GetEntityModel(ped) == maleHash then -- mp male
            prevMaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 41, 0, 0)
        end
        
        SetEnableHandcuffs(ped, true)
		TriggerEvent("canUseInventoryAndHotbar:toggle", false)
		TriggerEvent("canHandsUp:toggle", false)
		--exports['qs-inventory']:setInventoryDisabled(true)
		exports['qs-smartphone']:canUsePhone(false)
        TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
        
    end

    IsHandcuffed = true

    changed = true
end)

RegisterNetEvent('esx_policejob:desalgemar1')
AddEventHandler('esx_policejob:desalgemar1', function()

    ped = PlayerPedId()
    
    RequestAnimDict(dict)
    

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    if IsHandcuffed then

        ClearPedTasks(ped)
		
        SetEnableHandcuffs(ped, false)
        

        UncuffPed(ped)
		TriggerEvent("canUseInventoryAndHotbar:toggle", true)
		TriggerEvent("canHandsUp:toggle", true)
		--exports['qs-inventory']:setInventoryDisabled(false)
		exports['qs-smartphone']:canUsePhone(true)
        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
			
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end
        
    end

    IsHandcuffed = false

    changed = true
end)

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(500)
        
        if not changed then
            ped = PlayerPedId()
            
            local IsCuffed = IsPedCuffed(ped) 
            
            
            if IsCuffed and not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
                Citizen.Wait(500)
                TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
            end
        
        else
            changed = false
        end
    end
end)

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
        
    if IsHandcuffed then
		
        if GetEntityModel(ped) == femaleHash then -- mp female
            prevFemaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        
        elseif GetEntityModel(ped) == maleHash then -- mp male
            prevMaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 41, 0, 0)
        end
        
        SetEnableHandcuffs(ped, true)
        TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
        
        -- Wait 0ms, makes the loop run every tick.
        Citizen.Wait(0)
        
        -- (Re)set the ped _AGAIN_!
        ped = PlayerPedId()
        
        -- If the player is currently cuffed....
        if IsHandcuffed then
			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F6'], true) -- Job
			
            --DisableControlAction(0, 1, true) -- Disable pan
			--DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['B'], true) -- apontar
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
		
		
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
            
            SetPedDropsWeapon(ped)
            
            local veh = GetVehiclePedIsIn(ped, false) 

            if DoesEntityExist(veh) and not IsEntityDead(veh) and GetPedInVehicleSeat(veh, -1) == ped then
                DisableControlAction(0, 59, true)
            end
		elseif IsEntityDead(ped) then
			IsHandcuffed = false
		else
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


local mostrado1 = false
local mostrado2 = false
local mostrado3 = false
local mostrado4 = false
local mostrado5 = false
local mostrado6 = false

-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)
		local canSleep = true
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			for k,v in pairs(Config.PoliceStations) do

				for i=1, #v.Cloakrooms, 1 do
					if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < 3 then
						DrawText3Ds(v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z + 0.2, '~b~E~s~ - Vestiário', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Armario_Evidencias, 1 do	
					if GetDistanceBetweenCoords(coords, v.Armario_Evidencias[i].x, v.Armario_Evidencias[i].y, v.Armario_Evidencias[i].z, true) < 3 then
						DrawText3Ds(v.Armario_Evidencias[i].x, v.Armario_Evidencias[i].y, v.Armario_Evidencias[i].z + 0.2, '~b~E~s~ - Evidências', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Armario_Evidencias[i].x, v.Armario_Evidencias[i].y, v.Armario_Evidencias[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Armario_Evidencias[i].x, v.Armario_Evidencias[i].y, v.Armario_Evidencias[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Armario_ItensIlegais, 1 do	
					if GetDistanceBetweenCoords(coords, v.Armario_ItensIlegais[i].x, v.Armario_ItensIlegais[i].y, v.Armario_ItensIlegais[i].z, true) < 3 then
						DrawText3Ds(v.Armario_ItensIlegais[i].x, v.Armario_ItensIlegais[i].y, v.Armario_ItensIlegais[i].z + 0.2, '~b~E~s~ - Itens Ilegais', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Armario_ItensIlegais[i].x, v.Armario_ItensIlegais[i].y, v.Armario_ItensIlegais[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Armario_ItensIlegais[i].x, v.Armario_ItensIlegais[i].y, v.Armario_ItensIlegais[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Armario_ItensAssalto, 1 do
					if GetDistanceBetweenCoords(coords, v.Armario_ItensAssalto[i].x, v.Armario_ItensAssalto[i].y, v.Armario_ItensAssalto[i].z, true) < 3 then
						DrawText3Ds(v.Armario_ItensAssalto[i].x, v.Armario_ItensAssalto[i].y, v.Armario_ItensAssalto[i].z + 0.2, '~b~E~s~ - Itens de Assaltos', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Armario_ItensAssalto[i].x, v.Armario_ItensAssalto[i].y, v.Armario_ItensAssalto[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Armario_ItensAssalto[i].x, v.Armario_ItensAssalto[i].y, v.Armario_ItensAssalto[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Armario_Lixo, 1 do	
					if GetDistanceBetweenCoords(coords, v.Armario_Lixo[i].x, v.Armario_Lixo[i].y, v.Armario_Lixo[i].z, true) < 3 then
						DrawText3Ds(v.Armario_Lixo[i].x, v.Armario_Lixo[i].y, v.Armario_Lixo[i].z + 0.2, '~b~E~s~ - Lixo', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Armario_Lixo[i].x, v.Armario_Lixo[i].y, v.Armario_Lixo[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Armario_Lixo[i].x, v.Armario_Lixo[i].y, v.Armario_Lixo[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Armario_Outros, 1 do	
					if GetDistanceBetweenCoords(coords, v.Armario_Outros[i].x, v.Armario_Outros[i].y, v.Armario_Outros[i].z, true) < 3 then
						DrawText3Ds(v.Armario_Outros[i].x, v.Armario_Outros[i].y, v.Armario_Outros[i].z + 0.2, '~b~E~s~ - Outros Itens', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Armario_Outros[i].x, v.Armario_Outros[i].y, v.Armario_Outros[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Armario_Outros[i].x, v.Armario_Outros[i].y, v.Armario_Outros[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Armario_Pessoal, 1 do	
					if GetDistanceBetweenCoords(coords, v.Armario_Pessoal[i].x, v.Armario_Pessoal[i].y, v.Armario_Pessoal[i].z, true) < 3 then
						DrawText3Ds(v.Armario_Pessoal[i].x, v.Armario_Pessoal[i].y, v.Armario_Pessoal[i].z + 0.2, '~b~E~s~ - Cofre Pessoal', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Armario_Pessoal[i].x, v.Armario_Pessoal[i].y, v.Armario_Pessoal[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Armario_Pessoal[i].x, v.Armario_Pessoal[i].y, v.Armario_Pessoal[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				for i=1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < 3 then
						DrawText3Ds(v.Armories[i].x, v.Armories[i].y, v.Armories[i].z + 0.2, '~b~E~s~ - Arsenal', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				--[[
				for i=1, #v.Vehicles, 1 do
					
					if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < 2 and not mostrado1 then
						--DrawText3Ds(v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z + 0.2, '~b~E~s~ - Retirar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Retirar Veículo', 'darkgreen', 'left')
							coords2 = GetEntityCoords(playerPed)
							mostrado1 = true
						end
						if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) > 2 and mostrado1 then
							exports['okokTextUI']:Close()
							mostrado1 = false			
						end
						
					end
						
					
					if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				
				for i=1, #v.Boats, 1 do
					if GetDistanceBetweenCoords(coords, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, true) < 2 and not mostrado2 then
							--DrawText3Ds(v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z + 0.2, '~b~E~s~ - Retirar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Retirar Barco', 'darkgreen', 'left')
							mostrado2 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, true) > 2 and mostrado2 then
							exports['okokTextUI']:Close()
							mostrado2 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				for i=1, #v.Helicopters, 1 do
					if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < 2 and not mostrado3 then
							--DrawText3Ds(v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z + 0.2, '~b~E~s~ - Retirar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Retirar Helicóptero', 'darkgreen', 'left')
							mostrado3 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) > 2 and mostrado3 then
							exports['okokTextUI']:Close()
							mostrado3 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				for i=1, #v.VehicleDeleters, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < 3 and not mostrado4 then
							--DrawText3Ds(v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Guardar Veículo', 'darkgreen', 'left')
							mostrado4 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) > 3 and mostrado4 then
							exports['okokTextUI']:Close()
							mostrado4 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				for i=1, #v.VehicleDeleters2, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters2[i].x, v.VehicleDeleters2[i].y, v.VehicleDeleters2[i].z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.VehicleDeleters2[i].x, v.VehicleDeleters2[i].y, v.VehicleDeleters2[i].z, true) < 3 and not mostrado5 then
							--DrawText3Ds(v.VehicleDeleters2[i].x, v.VehicleDeleters2[i].y, v.VehicleDeleters2[i].z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Guardar Helicóptero', 'darkgreen', 'left')
							mostrado5 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.VehicleDeleters2[i].x, v.VehicleDeleters2[i].y, v.VehicleDeleters2[i].z, true) > 3 and mostrado5 then
							exports['okokTextUI']:Close()
							mostrado5 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters2[i].x, v.VehicleDeleters2[i].y, v.VehicleDeleters2[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.VehicleDeleters2[i].x, v.VehicleDeleters2[i].y, v.VehicleDeleters2[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.VehicleDeleters3, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters3[i].x, v.VehicleDeleters3[i].y, v.VehicleDeleters3[i].z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.VehicleDeleters3[i].x, v.VehicleDeleters3[i].y, v.VehicleDeleters3[i].z, true) < 3 and not mostrado6 then
							--DrawText3Ds(v.VehicleDeleters3[i].x, v.VehicleDeleters3[i].y, v.VehicleDeleters3[i].z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Guardar Barco', 'darkgreen', 'left')
							mostrado6 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.VehicleDeleters3[i].x, v.VehicleDeleters3[i].y, v.VehicleDeleters3[i].z, true) > 3 and mostrado6 then
							exports['okokTextUI']:Close()
							mostrado6 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters3[i].x, v.VehicleDeleters3[i].y, v.VehicleDeleters3[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.VehicleDeleters3[i].x, v.VehicleDeleters3[i].y, v.VehicleDeleters3[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				--]]
				
				if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						
						if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < 3 then
							DrawText3Ds(v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z + 0.2, '~b~E~s~ - Gerir Empresa', 0.3)
						end
						
						if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < 50 then
							canSleep = false
							DrawMarker(2, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
						end

					end
				end

			end
		else
			Citizen.Wait(5000)
		end
			
		if canSleep then
			Citizen.Wait(3000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

	while true do

		Citizen.Wait(10)

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local isInMarker     = false
			local currentStation = nil
			local currentPart    = nil
			local currentPartNum = nil

			for k,v in pairs(Config.PoliceStations) do

				for i=1, #v.Cloakrooms, 1 do
					if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Cloakroom'
						currentPartNum = i
					end
				end

				for i=1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armory'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Armario_Evidencias, 1 do
					if GetDistanceBetweenCoords(coords, v.Armario_Evidencias[i].x, v.Armario_Evidencias[i].y, v.Armario_Evidencias[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armario_Evidencias'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Armario_ItensIlegais, 1 do
					if GetDistanceBetweenCoords(coords, v.Armario_ItensIlegais[i].x, v.Armario_ItensIlegais[i].y, v.Armario_ItensIlegais[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armario_ItensIlegais'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Armario_ItensAssalto, 1 do
					if GetDistanceBetweenCoords(coords, v.Armario_ItensAssalto[i].x, v.Armario_ItensAssalto[i].y, v.Armario_ItensAssalto[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armario_ItensAssalto'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Armario_Lixo, 1 do
					if GetDistanceBetweenCoords(coords, v.Armario_Lixo[i].x, v.Armario_Lixo[i].y, v.Armario_Lixo[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armario_Lixo'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Armario_Pessoal, 1 do
					if GetDistanceBetweenCoords(coords, v.Armario_Pessoal[i].x, v.Armario_Pessoal[i].y, v.Armario_Pessoal[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armario_Pessoal'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Armario_Outros, 1 do
					if GetDistanceBetweenCoords(coords, v.Armario_Outros[i].x, v.Armario_Outros[i].y, v.Armario_Outros[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armario_Outros'
						currentPartNum = i
					end
				end
				
				--[[
				for i=1, #v.Vehicles, 1 do
					if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleSpawner'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Boats, 1 do
					if GetDistanceBetweenCoords(coords, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'BoatSpawner'
						currentPartNum = i
					end
				end		

				for i=1, #v.Helicopters, 1 do
					if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'HelicopterSpawner'
						currentPartNum = i
					end
				end

				for i=1, #v.VehicleDeleters, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < 3 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleDeleter'
						currentPartNum = i
					end
				end

				for i=1, #v.VehicleDeleters2, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters2[i].x, v.VehicleDeleters2[i].y, v.VehicleDeleters2[i].z, true) < 5 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleDeleter2'
						currentPartNum = i
					end
				end
				
				for i=1, #v.VehicleDeleters3, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters3[i].x, v.VehicleDeleters3[i].y, v.VehicleDeleters3[i].z, true) < 5 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleDeleter3'
						currentPartNum = i
					end
				end
				--]]

				if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < 2 then
							isInMarker     = true
							currentStation = k
							currentPart    = 'BossActions'
							currentPartNum = i
						end
					end
				end

			end

			local hasExited = false

			if isInMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

				if
					(LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end
		else
			Citizen.Wait(5000)
		end

	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not isDead then
			local playerPed      = PlayerPedId()
			local carro = IsPedInAnyVehicle(playerPed,  false)
			if CurrentAction ~= nil then

				if IsControlJustReleased(0, Keys['E']) then

					if CurrentAction == 'menu_cloakroom' then
						MenuRoupas()
					elseif CurrentAction == 'menu_armory' then
						
					elseif CurrentAction == 'menu_armory_evidencias' then
						
						if PlayerData.job.grade < 0 then
							ESX.ShowNotification('~r~Não tens permissão para aceder ao armário!')
						else
							TriggerServerEvent("inventory:server:OpenInventory", "stash", "police_evidencias")
							TriggerEvent("inventory:client:SetCurrentStash", "police_evidencias")
						end
					elseif CurrentAction == 'menu_armory_itensilegais' then
						if PlayerData.job.grade < 0 then
							ESX.ShowNotification('~r~Não tens permissão para aceder ao armário!')
						else
							TriggerServerEvent("inventory:server:OpenInventory", "stash", "police_itens_ilegais")
							TriggerEvent("inventory:client:SetCurrentStash", "police_itens_ilegais")
						end
					elseif CurrentAction == 'menu_armory_itensassalto' then
						if PlayerData.job.grade < 0 then
							ESX.ShowNotification('~r~Não tens permissão para aceder ao armário!')
						else
							TriggerServerEvent("inventory:server:OpenInventory", "stash", "police_itens_assaltos")
							TriggerEvent("inventory:client:SetCurrentStash", "police_itens_assaltos")
						end
					elseif CurrentAction == 'menu_armory_lixo' then
						if PlayerData.job.grade < 0 then
							ESX.ShowNotification('~r~Não tens permissão para aceder ao armário!')
						else
							TriggerServerEvent("inventory:server:OpenInventory", "stash", "police_lixo")
							TriggerEvent("inventory:client:SetCurrentStash", "police_lixo")
						end
					elseif CurrentAction == 'menu_armory_outros' then
						if PlayerData.job.grade < 0 then
							ESX.ShowNotification('~r~Não tens permissão para aceder ao armário!')
						else
							TriggerServerEvent("inventory:server:OpenInventory", "stash", "police_outros")
							TriggerEvent("inventory:client:SetCurrentStash", "police_outros")
						end	
					elseif CurrentAction == 'menu_armory_pessoal' then
						local identifier = ESX.GetPlayerData().identifier
						TriggerServerEvent("inventory:server:OpenInventory", "stash", "police_"..identifier)
						TriggerEvent("inventory:client:SetCurrentStash", "police_"..identifier)
					elseif CurrentAction == 'menu_vehicle_spawner' then
						if carro then
							exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Não podes fazer isso dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						else
							GaragemVeiculos(CurrentActionData.station, CurrentActionData.partNum)
						end
					elseif CurrentAction == 'menu_vehicle_spawner2' then
						if carro then
							exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Não podes fazer isso dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						else
							HeliportoSpawner(CurrentActionData.station, CurrentActionData.partNum)
						end
					elseif CurrentAction == 'menu_boat_spawner' then
						if carro then
							exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Não podes fazer isso dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						else
							BarcosPSPSpawner(CurrentActionData.station, CurrentActionData.partNum)
						end
					elseif CurrentAction == 'delete_vehicle' then
						local model = GetDisplayNameFromVehicleModel(GetEntityModel(CurrentActionData.vehicle))
						local plate = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle).plate
						--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
						exports['qs-vehiclekeys']:RemoveKeysAuto()
						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
						exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Veículo <span style='color:#069a19'>guardado</span> na garagem!", 5000, 'success')
					elseif CurrentAction == 'delete_boat' then
						ApagarBarco(CurrentActionData.station, CurrentActionData.partNum)
						exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Barco <span style='color:#069a19'>guardado</span> no porto!", 5000, 'success')
					elseif CurrentAction == 'menu_boss_actions' then
						ESX.UI.Menu.CloseAll()
						TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
							menu.close()
							CurrentAction     = 'menu_boss_actions'
						end, { wash = false }) -- disable washing money
					elseif CurrentAction == 'remove_entity' then
						DeleteEntity(CurrentActionData.entity)
					end
					
					CurrentAction = nil
				end
			end -- CurrentAction end
		
			if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
				AbrirMenuPolicia()
			end
			
			if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
				ESX.ShowNotification(_U('impound_canceled'))
				ESX.ClearTimeout(CurrentTask.Task)
				ClearPedTasks(PlayerPedId())
				
				CurrentTask.Busy = false
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipColour (blip, 29)
		SetBlipAsShortRange(blip, false)
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

-- Create blip for colleagues
function createBlip2(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipColour (blip, 52)
		SetBlipAsShortRange(blip, true)
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_policejob:updateBlip')
AddEventHandler('esx_policejob:updateBlip', function()
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
	
	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end
	
	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job ~= nil and (PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'police') then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' then
					local id = GetPlayerFromServerId(players[i].source)
					ESX.TriggerServerCallback('esx_policejob:hasLocator', function(hasItem)
						if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() and hasItem then
							createBlip(id)
						end
					end, players[i].source)
				end
				if players[i].job.name == 'sheriff' then
					local id = GetPlayerFromServerId(players[i].source)
					ESX.TriggerServerCallback('esx_policejob:hasLocator', function(hasItem)
						if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() and hasItem then
						createBlip2(id)
						end
					end, players[i].source)
				end
			end
		end)
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_policejob:unrestrain')
		HandcuffTimer.Active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle, valor_multa)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	
	ESX.TriggerServerCallback('wtrp:apreenderCarro', function(apreendido)
		if apreendido then
			ESX.Game.DeleteVehicle(vehicle) 
			exports['mythic_notify']:DoHudText('success', 'O veículo foi apreendido!')
		else
			exports['mythic_notify']:DoHudText('error', 'Erro ao apreender o veículo!')
		end
	end, vehicleProps.plate, valor_multa)
	CurrentTask.Busy = false
end

function ImpoundVehicle2(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	ESX.Game.DeleteVehicle(vehicle) 
	exports['mythic_notify']:DoHudText('success', 'O veículo foi apreendido!')
	CurrentTask.Busy = false
end
