Keys = {
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

local FirstSpawn, IsBusy = true, false
local blipsCops               = {}
local isDead                  = false
local HasAlreadyEnteredMarker = false
local PlayerLoaded = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

local lib1_char_a, lib2_char_a, lib1_char_b, lib2_char_b, anim_start, anim_pump, anim_success = 'mini@cpr@char_a@cpr_def', 'mini@cpr@char_a@cpr_str', 'mini@cpr@char_b@cpr_def', 'mini@cpr@char_b@cpr_str', 'cpr_intro', 'cpr_pumpchest', 'cpr_success'

Citizen.CreateThread(function()
    RequestAnimDict(lib1_char_a)
    RequestAnimDict(lib2_char_a)

    RequestAnimDict(lib1_char_b)
    RequestAnimDict(lib2_char_b)

    -- RequestAnimDict("mini@cpr")
end)

IsDead = false
PlayerData = {}

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

AddEventHandler('esx:onPlayerSpawn', function()
	IsDead = false
	if FirstSpawn then
		TriggerServerEvent('esx_ambulancejob:firstSpawn')
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsDead then
			--DisableAllControlActions(0)
			--EnableControlAction(0, 47, true)
			--EnableControlAction(0, 245, true)
			--EnableControlAction(0, 38, true)
			EnableControlAction(0, Keys['N'], true)
			--EnableControlAction(0, 46, true)
			--DisableControlAction(0, 1, true) -- Disable pan
			--DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 21, true) --Run
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			--DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F5'], true) -- Disable phone
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			--DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(600)
		end
	end
end)

function OnPlayerDeath()
	IsDead = true
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)

	--StartDeathTimer()
	--StartDistressSignal()

	ClearPedTasks(PlayerPedId())
	--StartScreenEffect('DeathFailOut', 0, false)
	
	--repeat
		--Citizen.Wait(30000)
		--ClearPedTasks(GetPlayerPed(-1))
	--until IsDead == false
end

RegisterNetEvent('esx_ambulancejob:signal:codem')
AddEventHandler('esx_ambulancejob:signal:codem', function()
    SendDistressSignal("Civil Inconsciente")
end)

RegisterNetEvent('codem-client:Revive')
AddEventHandler('codem-client:Revive', function()
    RemoveItemsAfterRPDeath()
	TriggerEvent('johnny_core:toggleHud', true)
end)

--[[
function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and IsDead do
			Citizen.Wait(2)
			timer = timer - 30

			SetTextFont(4)
			SetTextProportional(1)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlPressed(0, Keys['G']) then
				--ESX.TriggerServerCallback('hhfw:docOnline', function(EMSOnline, hasEnoughMoney)

					--if EMSOnline <= 0 then
						--TriggerEvent('Johnny_InemNPC:startEvent')
					--else
						ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "chamada", {
							["title"] = "Nome, Idade e Detalhes da Ocorrência"
						}, function(menuData, dialogHandle)
							local completa = menuData["value"]
							if completa == nil then 
								completa = "Cidadão inconsciente" 
							end
								SendDistressSignal(completa)
								dialogHandle.close()
						end, function(menuData, dialogHandle)
							dialogHandle.close()
						end)
					--end
				--end)
				
				break
			end
		end
	end)
end
--]]
function SendDistressSignal(message)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local alert = {
		message = message,
		-- img = "img url", -- You can add image here (OPTIONAL).
		location = coords,
	}
	
	TriggerServerEvent('qs-smartphone:server:sendJobAlert', alert, "ambulance") -- "Your ambulance job"
	TriggerServerEvent('qs-smartphone:server:AddNotifies', {
		head = "Nova Emergência", -- Message name.
		msg = message,
		app = 'business'
	})
  
	TriggerServerEvent('esx_outlawalert:BackupReq', '112', completa)
	exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>O INEM <span style='color:#069a19'>recebeu</span> o teu alerta!", 5000, 'success')
end 

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	--if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	--end

	local earlySpawnTimer = ESX.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					--TriggerServerEvent('esx_ambulancejob:payFine')
					RemoveItemsAfterRPDeath()
					break
				end
			end

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)
    SetEntityInvincible(PlayerPedId(), true)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
	
	exports['progressbar']:Progress({
		name = "unique_action_name",
		duration = 15000,
		label = "A receber cuidados médicos...",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(status)
		if not status then
			--Do Something If Event Wasn't Cancelled
		end
	end)
	Citizen.Wait(15000)
	TriggerServerEvent('mythic_hospital:server:EnteredBed')
end)


function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityInvincible(PlayerPedId(), false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('mythic_hospital:server:LeaveBed', bedOccupying)

    FreezeEntityPosition(bedObject, false)
	ClearPedTasks(PlayerPedId())
    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end

RegisterNetEvent('mythic_hospital:client:FinishServices')
AddEventHandler('mythic_hospital:client:FinishServices', function()
	local player = PlayerPedId()
	
	if IsPedDeadOrDying(player) then
		local playerPos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
	end
	
	SetEntityHealth(player, GetEntityMaxHealth(player))
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    --TriggerEvent('mythic_hospital:client:RemoveBleed')
    --TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('esx_ambulancejob:revLoureivero')
    exports['mythic_notify']:DoHudText('inform', 'Foste tratado e recebeste uma fatura')
    LeaveBed()
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			ESX.SetPlayerData('loadout', {})
			StopScreenEffect('DeathFailOut')
			TriggerServerEvent('mythic_hospital:server:RequestBed')	
			Citizen.Wait(10)
			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
	TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('mythic_hospital:client:RemoveBleed')
	
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
	
	ESX.UI.Menu.CloseAll()
end

function TeleportFadeEffect(entity, coords)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)
	end)
end

RegisterNetEvent('esx_ambulancejob:revLoureivero')
AddEventHandler('esx_ambulancejob:revLoureivero', function()
	TriggerEvent('codem-deathscreen:revive')
	TriggerEvent('johnny_core:toggleHud', true)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)
	
	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
end)


RegisterNetEvent('esx_ambulancejob:requestDeath')
AddEventHandler('esx_ambulancejob:requestDeath', function()
	if Config.AntiCombatLog then
		while not PlayerLoaded do
			Citizen.Wait(5000)
		end
		Citizen.Wait(5000)
		SetEntityHealth(PlayerPedId(), 0)
	end
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

-- String string
function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end


function setUniform(job, playerPed)
	if job ~= nil then
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				if Config.UniformsInem[job].variations.male ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.UniformsInem[job].variations.male)
				else
					ESX.ShowNotification('Erro ao carregar roupa!')
				end
			else
				if Config.UniformsInem[job].variations.female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.UniformsInem[job].variations.female)
				else
					ESX.ShowNotification('Erro ao carregar roupa!')
				end
			end
		end)
	end
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function MenuRoupasInem()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{label = 'Desfardar', value = 'citizen_wear' },
	}
	
	for i=1, #Config.UniformsInem, 1 do
		print(PlayerData.job.grade)
		if PlayerData.job.grade >= Config.UniformsInem[i].minimum_grade then
			table.insert(elements, {label = Config.UniformsInem[i].label, value = i})
		end
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom_ambulance',
	{
		title    = 'Vestiário',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		else
			setUniform(data.current.value, playerPed)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = ''
		CurrentActionData = {}
	end)
end

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

function GaragemVeiculosInem(station, partNum)

	ESX.UI.Menu.CloseAll()
	
	local elements = {}

	local sharedVehicles = Config.VeiculosInem
	for i=1, #sharedVehicles, 1 do
		table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
	{
		title    = 'Garagem',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local foundSpawnPoint, spawnPoint = ProcuraSpawnVeiculoInem(station, partNum, data.current.model)
		
		if foundSpawnPoint then
			if data.current.model == 'ambulance' then
				local num = math.random(3,4)
				ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					SetVehicleLivery(vehicle, num)
					SetVehicleMaxMods(vehicle)
					local plate = 'INEM' .. math.random(100, 900)
					SetVehicleNumberPlateText(vehicle, plate)
					exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
					--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
					exports['qs-vehiclekeys']:GiveKeysAuto()
				end)
			 else
				ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					SetVehicleMaxMods(vehicle)
					local plate = 'INEM' .. math.random(100, 900)
					SetVehicleNumberPlateText(vehicle, plate)
					exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
					--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)	
					exports['qs-vehiclekeys']:GiveKeysAuto()
				end)
			 end
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = ''
		CurrentActionData = {station = station, partNum = partNum}
	end)

end

function HeliportoInemSpawner(station, partNum)

	ESX.UI.Menu.CloseAll()
	
	local elements = {}
	
	local authorizedVehicles = Config.HelicopteroInem
		for i=1, #authorizedVehicles, 1 do
			table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model})
		end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner2',
	{
		title		= 'Héliporto INEM',
		align		= 'top-left',
		elements	= elements
	}, function(data, menu)
		menu.close()
		
		local foundSpawnPoint, spawnPoint = ProcuraSpawnHeliportoInem(station, partNum)
		
		ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
			local playerPed = PlayerPedId()
			local plate = 'INEM' .. math.random(100, 900)
			SetVehicleNumberPlateText(vehicle, plate)
			exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
			--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
			exports['qs-vehiclekeys']:GiveKeysAuto()
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
		
	end, function(data, menu)
		menu.close()
		CurrentAction		= 'vehicle_spawner_menu2'
		CurrentActionMsg	= _U('heli_spawner')
		CurrentActionData	= {}
	end)
end

function BarcosInemSpawner(station, partNum)

	ESX.UI.Menu.CloseAll()

	local elements = {}

	local sharedVehicles = Config.BarcosInem
	for i=1, #sharedVehicles, 1 do
		table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_spawner',
	{
		title    = 'Garagem de Barcos INEM',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local foundSpawnPoint, spawnPoint = ProcuraSpawnBarco(station, partNum)

		if foundSpawnPoint then
			ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
				TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
				local plate = 'INEM' .. math.random(100, 900)
				SetVehicleNumberPlateText(vehicle, plate)
				exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
				--TriggerServerEvent('vehiclekeys:server:givekey', plate, data.current.model)
				exports['qs-vehiclekeys']:GiveKeysAuto()
				SetVehicleMaxMods(vehicle)
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_boat_spawner'
		CurrentActionMsg  = _U('boat_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end)
end


function ProcuraSpawnVeiculoInem(station, partNum, carro)
	
	local spawnPoints
	local found, foundSpawnPoint = false, nil
	
	spawnPoints = Config.ambulanceStations[station].Veiculos[partNum].SpawnPoints

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

function ProcuraSpawnBarco(station, partNum)
	local spawnPoints = Config.ambulanceStations[station].Boats[partNum].SpawnPoints
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

function ProcuraSpawnHeliportoInem(station, partNum)
	local spawnPoints = Config.ambulanceStations[station].Helicopters[partNum].SpawnPoints
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
	local tp = Config.ambulanceStations[station].Boats[partNum].Teleport
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

function AbrirMenuInem()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inem_actions',
	{
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'},
			{label = '🚗 Interagir com o Veículo', value = 'vehicle_interaction'},
			{label = '💉 Realizar Cirurgias', value = 'cirurgias_menu'}
		}
	}, function(data, menu)
	
		if data.current.value == 'vehicle_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title		= _U('ems_menu_title'),
				align		= 'top-left',
				elements	= {
					{label = '🚗 Abrir/Fechar Portas da Ambulância', value = 'abrir_portas'},
					{label = '🛏️ Spawner Maca/Cama', value = 'object_spawner'},
					{label = '🛏️ Guardar Maca/Cama', value = 'object_spawner2'},
					{label = '🛏️ Colocar/Retirar Maca da Ambulância', value = 'maca_veiculo'},
				}
			}, function(data2, menu2)
				if IsBusy then return end
				
				if data2.current.value == 'object_spawner' then

					local playerPed = PlayerPedId()
			   
					if IsPedSittingInAnyVehicle(playerPed) then
					   exports['mythic_notify']:DoHudText('error', 'Não podes fazer isso dentro de um veículo!')
					   return
					end
			   
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions_spawn', {
						title    = 'Spawner Macas',
						align    = 'top-left',
						elements = {
							{label = 'Cama Hospital', value = 'v_med_emptybed'},
							{label = 'Maca',  value = 'prop_ld_binbag_01'}
						}
					}, function(data3, menu3)
						local model   = data3.current.value
						local coords  = GetEntityCoords(playerPed)
						local forward = GetEntityForwardVector(playerPed)
						local x, y, z = table.unpack(coords + forward * 1.0)
			   
						if model == 'v_med_emptybed' then
							z = z - 2.0
							y = y + 1.0
							ESX.Game.SpawnObject(model, {
								x = x,
								y = y,
								z = z
							}, function(obj)
								SetEntityHeading(obj, GetEntityHeading(playerPed))
								PlaceObjectOnGroundProperly(obj)
							end)
						elseif model == 'prop_ld_binbag_01' then
							z = z - 2.0
							y = y + 1.0
							ESX.Game.SpawnObject(model, {
								x = x,
								y = y,
								z = z
							}, function(obj)
								SetEntityHeading(obj, GetEntityHeading(playerPed))											
								PlaceObjectOnGroundProperly(obj)
								local coords = GetEntityCoords(obj, false)
								SetEntityCoords(obj, coords.x,coords.y,coords.z+0.8)
							end)
						end
					end, function(data3, menu3)
					   menu3.close()
					end)
				elseif data2.current.value == 'object_spawner2' then	
					ExecuteCommand('dvcama')
				elseif data2.current.value == 'maca_veiculo' then	
					ExecuteCommand("togglestr")
				elseif data2.current.value == 'abrir_portas' then
					AbrirPortasAmbulancia()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		
		elseif data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title		= _U('ems_menu_title'),
				align		= 'top-left',
				elements	= {
					--{label = '📝 Passar fatura', value = 'billing'},
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = '🚗 Retirar do Veículo',	value = 'out_the_vehicle'},
					{label = '🧑‍🤝‍🧑 Pegar ao colo',	value = 'drag'},
					{label = '💺 Cadeira de Rodas', value = 'cadeira_rodas'},
					{label = '💺 Guardar Cadeira de Rodas', value = 'cadeira_rodas2'}
				}
			}, function(data2, menu2)
				if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				
				
				if data2.current.value == 'cadeira_rodas' then	
					ExecuteCommand("cadeirarodas")
				elseif data2.current.value == 'cadeira_rodas2' then		
					local wheelchair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('prop_wheelchair_01'))
					if DoesEntityExist(wheelchair) then
						DeleteEntity(wheelchair)
					end
				end	
				if data2.current.value == 'billing' or data2.current.value == 'revive' or data2.current.value == 'small' or data2.current.value == 'big' or data2.current.value == 'put_in_vehicle' or data2.current.value == 'out_the_vehicle' or data2.current.value == 'drag' then
					if closestPlayer == -1 or closestDistance > 3.0 then
						exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
					elseif data2.current.value == 'billing' then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
							title = 'Valor da Fatura'
						}, function(data3, menu)
							
							local amount = tonumber(data3.value)
							if amount == nil or amount < 0 then
								exports['mythic_notify']:DoHudText('error', 'Valor inválido!')
							else
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 3.0 then
									exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
								else
									menu3.close()
									menu2.close()
									menu.close()
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', _U('ambulance'), amount)
								end
							end
						end, function(data3, menu3)
							menu3.close()
						end)
					elseif data2.current.value == 'revive' then
						IsBusy = true
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							local target, distance = ESX.Game.GetClosestPlayer()
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(target)
								local target, distance = ESX.Game.GetClosestPlayer()
								playerheading = GetEntityHeading(GetPlayerPed(-1))
								playerlocation = GetEntityForwardVector(PlayerPedId())
								playerCoords = GetEntityCoords(GetPlayerPed(-1))						
								local target_id = GetPlayerServerId(target)

								if IsEntityDead(closestPlayerPed) or IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()
									
									local cpr = true

                                    Citizen.CreateThread(function()
                                        while cpr do
                                            Citizen.Wait(0)
                                            DisableAllControlActions(0)
                                            EnableControlAction(0, 1, true)
                                        end
                                    end)
									
									TriggerServerEvent('CUSTOM_esx_ambulance:requestCPR', GetPlayerServerId(closestPlayer), GetEntityHeading(playerPed), GetEntityCoords(playerPed), GetEntityForwardVector(playerPed))
									
									menu2.close()
									menu.close()
									
									exports['progressbar']:Progress({
										name = "unique_action_name",
										duration = 59000,
										label = "Tratamento em progresso...",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
										--animation = {
											--animDict = "mini@repair",
											--anim = "fixing_a_player",
										--},
									}, function(status)
										if not status then
											--Do Something If Event Wasn't Cancelled
										end
									end)
									
									--ClampGameplayCamPitch(0.0, -90.0)

                                    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)

                                    TaskPlayAnim(playerPed, lib1_char_a, anim_start, 8.0, 8.0, -1, 0, 0, false, false, false)

                                    Citizen.Wait(15800 - 900)
									for i=1, 15, 1 do
										Citizen.Wait(900)
										TaskPlayAnim(playerPed, lib2_char_a, anim_pump, 8.0, 8.0, -1, 0, 0, false, false, false)
									end

                                    cpr = false

									TaskPlayAnim(playerPed, lib2_char_a, anim_success, 8.0, 8.0, -1, 0, 0, false, false, false)

                                    Citizen.Wait(28000)
									
									TriggerServerEvent('esx_ambulancejob:removeItem', 'medkit')
									TriggerServerEvent('esx_ambulancejob:revLoureivero', GetPlayerServerId(target))

									exports['mythic_notify']:DoHudText('inform', 'O civil foi tratado!')
			
								else
									exports['mythic_notify']:DoHudText('error', 'O civil não está inconsciente!')
								--	exports['mythic_notify']:DoCustomHudText('inform', _U('player_not_conscious'), 2500, { ['background-color'] = '#FF0000', ['color'] = '#ffffff' })
								end
							else
								exports['mythic_notify']:DoHudText('error', 'Não tens Kit Médicos!')
							--	exports['mythic_notify']:DoCustomHudText('inform', _U('not_enough_medikit'), 2500, { ['background-color'] = '#FF0000', ['color'] = '#ffffff' })
							end
						end, 'medkit')
							
						IsBusy = false
					elseif data2.current.value == 'small' then
						IsBusy = true
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()
									
									local cpr = true

                                    Citizen.CreateThread(function()
                                        while cpr do
                                            Citizen.Wait(0)
                                            DisableAllControlActions(0)
                                            EnableControlAction(0, 1, true)
                                        end
                                    end)
									
									--exports['mythic_notify']:DoHudText('inform', 'Tratamento em progresso...')
									--TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									TriggerServerEvent('CUSTOM_esx_ambulance:requestHeal', GetPlayerServerId(closestPlayer), GetEntityHeading(playerPed), GetEntityCoords(playerPed), GetEntityForwardVector(playerPed))
									menu2.close()
									menu.close()
									
									
									exports['progressbar']:Progress({
										name = "unique_action_name",
										duration = 11000,
										label = "Tratamento em progresso...",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
										--animation = {
											--animDict = "mini@repair",
											--anim = "fixing_a_player",
										--},
									}, function(status)
										if not status then
											--Do Something If Event Wasn't Cancelled
										end
									end)
									
									SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
									
									local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
									local playerHeading = GetEntityHeading(closestPlayerPed)
									local playerCoords = GetEntityCoords(closestPlayerPed)
									
									ESX.Streaming.RequestAnimDict(lib, function()
										--SetEntityHeading(PlayerPedId(), playerHeading - 180.0)
										TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

										Citizen.Wait(500)
										while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
											Citizen.Wait(0)
											DisableAllControlActions(0)
										end
										
										TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
										TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
										exports['mythic_notify']:DoHudText('inform', 'O civil foi tratado!')
										cpr = false
									end)
								else
									exports['mythic_notify']:DoHudText('error', 'O civil está inconsciente! Tens que o reanimar!')
								--	exports['mythic_notify']:DoCustomHudText('inform', _U('player_not_conscious'), 2500, { ['background-color'] = '#FF0000', ['color'] = '#ffffff' })
								end
							else
								exports['mythic_notify']:DoHudText('error', 'Não tens Ligaduras!')	
							--exports['mythic_notify']:DoCustomHudText('inform', _U('not_enough_bandage'), 2500, { ['background-color'] = '#FF0000', ['color'] = '#ffffff' })
							end
						end, 'bandage')
								
						IsBusy = false
					elseif data2.current.value == 'big' then
						IsBusy = true
						
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()
									
									local cpr = true

                                    Citizen.CreateThread(function()
                                        while cpr do
                                            Citizen.Wait(0)
                                            DisableAllControlActions(0)
                                            EnableControlAction(0, 1, true)
                                        end
                                    end)
									
									--exports['mythic_notify']:DoHudText('inform', 'Tratamento em progresso...')
									--TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									TriggerServerEvent('CUSTOM_esx_ambulance:requestHeal', GetPlayerServerId(closestPlayer), GetEntityHeading(playerPed), GetEntityCoords(playerPed), GetEntityForwardVector(playerPed))
									menu2.close()
									menu.close()
									
									
									exports['progressbar']:Progress({
										name = "unique_action_name",
										duration = 11000,
										label = "Tratamento em progresso...",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
										--animation = {
											--animDict = "mini@repair",
											--anim = "fixing_a_player",
										--},
									}, function(status)
										if not status then
											--Do Something If Event Wasn't Cancelled
										end
									end)

									SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
									
									local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
									local playerHeading = GetEntityHeading(closestPlayerPed)
									local playerCoords = GetEntityCoords(closestPlayerPed)
									
									ESX.Streaming.RequestAnimDict(lib, function()
										--SetEntityHeading(PlayerPedId(), playerHeading - 180.0)
										TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

										Citizen.Wait(500)
										while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
											Citizen.Wait(0)
											DisableAllControlActions(0)
										end
										
										TriggerServerEvent('esx_ambulancejob:removeItem', 'gauze')
										TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
										exports['mythic_notify']:DoHudText('inform', 'O civil foi tratado!')
										cpr = false
									end)
									
									--[[
									exports['mythic_notify']:DoHudText('inform', 'Tratamento em progresso...')
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medkit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))--]]
								else
									exports['mythic_notify']:DoHudText('error', 'O civil está inconsciente! Tens que o reanimar!')
								--	exports['mythic_notify']:DoCustomHudText('inform', _U('player_not_conscious'), 2500, { ['background-color'] = '#FF0000', ['color'] = '#ffffff' })
								end
							else
								exports['mythic_notify']:DoHudText('error', 'Não tens Kit Médicos!')
							--	exports['mythic_notify']:DoCustomHudText('inform', _U('not_enough_medikit'), 2500, { ['background-color'] = '#FF0000', ['color'] = '#ffffff' })
							end
						end, 'gauze')
						
						IsBusy = false
					elseif data2.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif data2.current.value == 'out_the_vehicle' then
						TriggerServerEvent('esx_ambulancejob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif data2.current.value == 'drag' then
						TriggerEvent('esx_barbie_lyftupp')
					end
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'cirurgias_menu' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_cirurgias',
			{
				title		= '💉 Realizar Cirurgias',
				align		= 'top-left',
				elements	= {
					{label = '✒️ Remover Tatuagens', value = 'remover_tatuagens'},
				}
			}, function(data3, menu3)
				if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				
				if closestPlayer == -1 or closestDistance > 3.0 then
					exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
				else
					if data3.current.value == 'remover_tatuagens' then
						exports['progressbar']:Progress({
							name = "unique_action_name",
							duration = 15000,
							label = "A realizar cirurgia...",
							useWhileDead = false,
							canCancel = false,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "mp_prison_break",
								anim = "hack_loop",
							},
						}, function(status)
							if not status then
								--Do Something If Event Wasn't Cancelled
							end
						end)
						Citizen.Wait(15000)
						StopAnimTask(PlayerPedId(), "mp_prison_break", "hack_loop", 1.0)
						TriggerEvent('wtrp_tatuagens:removerTatuagens', GetPlayerServerId(closestPlayer))
					end
				end
				
			end, function(data3, menu3)
				menu3.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function AbrirPortasAmbulancia()
	local playerPed = PlayerPedId()
	local vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 7.0, 0, 70)
	local vehicleModel = GetEntityModel(vehicle)

	--if vehicleModel == GetHashKey("ambulance") then
	print(GetVehicleDoorAngleRatio(vehicle, 2))
	if GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 then
		SetVehicleDoorShut(vehicle, 2, false)
	else
		SetVehicleDoorOpen(vehicle, 2, false)
	end
	
	if GetVehicleDoorAngleRatio(vehicle, 3) > 0.0 then
		SetVehicleDoorShut(vehicle, 3, false)
	else
		SetVehicleDoorOpen(vehicle, 3, false)
	end
	--end
end

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(station, part, partNum)

	if part == 'Vestiario' then
		CurrentAction     = 'menu_vestiario'
		CurrentActionData = {}

	elseif part == 'Cofre' then

		CurrentAction     = 'menu_cofre'
		CurrentActionData = {station = station}
	
	elseif part == 'Cofre_Pessoal' then

		CurrentAction     = 'menu_cofre_pessoal'
		CurrentActionData = {station = station}

	elseif part == 'RetirarVeiculoInem' then

		CurrentAction     = 'retirar_veiculo'
		CurrentActionMsg  = ''
		CurrentActionData = {station = station, partNum = partNum}

	elseif part == 'RetirarHeliInem' then

		CurrentAction     = 'retirar_heli'
		CurrentActionMsg  = ''
		CurrentActionData = {station = station, partNum = partNum}
		
	elseif part == 'RetirarBarco' then

		CurrentAction     = 'retirar_barco'
		CurrentActionMsg  = ''
		CurrentActionData = {station = station, partNum = partNum}
		
	elseif part == 'GuardarVeiculoInem' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'apagar_veiculo'
				CurrentActionMsg  = ''
				CurrentActionData = {vehicle = vehicle}
			end

		end
		
	elseif part == 'GuardarBarcoInem' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'apagar_barco'
				CurrentActionMsg  = ''
				CurrentActionData = {vehicle = vehicle, station = station, partNum = partNum}
			end

		end

	elseif part == 'GuardarHeliInem' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'apagar_heli'
				CurrentActionMsg  = ''
				CurrentActionData = {vehicle = vehicle}
			end

		end

	elseif part == 'BossActions' then

		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = ''
		CurrentActionData = {}

	end

end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

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

RegisterNetEvent('esx_ambulancejob:OutVehicle')
AddEventHandler('esx_ambulancejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.ambulanceStations) do
		local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Hospital')
		EndTextCommandSetBlipName(blip)
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
		if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
			
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			for k,v in pairs(Config.ambulanceStations) do

				for i=1, #v.Vestiario, 1 do
					if GetDistanceBetweenCoords(coords, v.Vestiario[i].x, v.Vestiario[i].y, v.Vestiario[i].z, true) < 3 then
						DrawText3Ds(v.Vestiario[i].x, v.Vestiario[i].y, v.Vestiario[i].z + 0.2, '~b~E~s~ - Vestiário', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Vestiario[i].x, v.Vestiario[i].y, v.Vestiario[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Vestiario[i].x, v.Vestiario[i].y, v.Vestiario[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Cofre, 1 do	
					if GetDistanceBetweenCoords(coords, v.Cofre[i].x, v.Cofre[i].y, v.Cofre[i].z, true) < 3 then
						DrawText3Ds(v.Cofre[i].x, v.Cofre[i].y, v.Cofre[i].z + 0.2, '~b~E~s~ - Cofre INEM', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Cofre[i].x, v.Cofre[i].y, v.Cofre[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Cofre[i].x, v.Cofre[i].y, v.Cofre[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.Cofre_Pessoal, 1 do	
					if GetDistanceBetweenCoords(coords, v.Cofre_Pessoal[i].x, v.Cofre_Pessoal[i].y, v.Cofre_Pessoal[i].z, true) < 3 then
						DrawText3Ds(v.Cofre_Pessoal[i].x, v.Cofre_Pessoal[i].y, v.Cofre_Pessoal[i].z + 0.2, '~b~E~s~ - Cofre Pessoal', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Cofre_Pessoal[i].x, v.Cofre_Pessoal[i].y, v.Cofre_Pessoal[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Cofre_Pessoal[i].x, v.Cofre_Pessoal[i].y, v.Cofre_Pessoal[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				--[[
				for i=1, #v.Veiculos, 1 do
					
					if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 2 and not mostrado1 then
						--DrawText3Ds(v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z + 0.2, '~b~E~s~ - Retirar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Retirar Veículo', 'darkgreen', 'left')
							coords2 = GetEntityCoords(playerPed)
							mostrado1 = true
						end
						if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) > 2 and mostrado1 then
							exports['okokTextUI']:Close()
							mostrado1 = false			
						end
						
					end
						
					
					if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
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

				for i=1, #v.GuardarVeiculo, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarVeiculo[i].x, v.GuardarVeiculo[i].y, v.GuardarVeiculo[i].z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.GuardarVeiculo[i].x, v.GuardarVeiculo[i].y, v.GuardarVeiculo[i].z, true) < 3 and not mostrado4 then
							--DrawText3Ds(v.GuardarVeiculo[i].x, v.GuardarVeiculo[i].y, v.GuardarVeiculo[i].z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Guardar Veículo', 'darkgreen', 'left')
							mostrado4 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.GuardarVeiculo[i].x, v.GuardarVeiculo[i].y, v.GuardarVeiculo[i].z, true) > 3 and mostrado4 then
							exports['okokTextUI']:Close()
							mostrado4 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.GuardarVeiculo[i].x, v.GuardarVeiculo[i].y, v.GuardarVeiculo[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.GuardarVeiculo[i].x, v.GuardarVeiculo[i].y, v.GuardarVeiculo[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				for i=1, #v.GuardarHeli, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarHeli[i].x, v.GuardarHeli[i].y, v.GuardarHeli[i].z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.GuardarHeli[i].x, v.GuardarHeli[i].y, v.GuardarHeli[i].z, true) < 3 and not mostrado5 then
							--DrawText3Ds(v.GuardarHeli[i].x, v.GuardarHeli[i].y, v.GuardarHeli[i].z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Guardar Helicóptero', 'darkgreen', 'left')
							mostrado5 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.GuardarHeli[i].x, v.GuardarHeli[i].y, v.GuardarHeli[i].z, true) > 3 and mostrado5 then
							exports['okokTextUI']:Close()
							mostrado5 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.GuardarHeli[i].x, v.GuardarHeli[i].y, v.GuardarHeli[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.GuardarHeli[i].x, v.GuardarHeli[i].y, v.GuardarHeli[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				for i=1, #v.GuardarBarco, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarBarco[i].x, v.GuardarBarco[i].y, v.GuardarBarco[i].z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.GuardarBarco[i].x, v.GuardarBarco[i].y, v.GuardarBarco[i].z, true) < 3 and not mostrado6 then
							--DrawText3Ds(v.GuardarBarco[i].x, v.GuardarBarco[i].y, v.GuardarBarco[i].z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Guardar Barco', 'darkgreen', 'left')
							mostrado6 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.GuardarBarco[i].x, v.GuardarBarco[i].y, v.GuardarBarco[i].z, true) > 3 and mostrado6 then
							exports['okokTextUI']:Close()
							mostrado6 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.GuardarBarco[i].x, v.GuardarBarco[i].y, v.GuardarBarco[i].z, true) < 50 then
						canSleep = false
						DrawMarker(2, v.GuardarBarco[i].x, v.GuardarBarco[i].y, v.GuardarBarco[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				--]]
				
				if PlayerData.job.grade_name == 'boss' then
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

		if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then

			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local isInMarker     = false
			local currentStation = nil
			local currentPart    = nil
			local currentPartNum = nil

			for k,v in pairs(Config.ambulanceStations) do

				for i=1, #v.Vestiario, 1 do
					if GetDistanceBetweenCoords(coords, v.Vestiario[i].x, v.Vestiario[i].y, v.Vestiario[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Vestiario'
						currentPartNum = i
					end
				end

				for i=1, #v.Cofre, 1 do
					if GetDistanceBetweenCoords(coords, v.Cofre[i].x, v.Cofre[i].y, v.Cofre[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Cofre'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Cofre_Pessoal, 1 do
					if GetDistanceBetweenCoords(coords, v.Cofre_Pessoal[i].x, v.Cofre_Pessoal[i].y, v.Cofre_Pessoal[i].z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Cofre_Pessoal'
						currentPartNum = i
					end
				end
				
				--[[
				for i=1, #v.Veiculos, 1 do
					if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'RetirarVeiculoInem'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Boats, 1 do
					if GetDistanceBetweenCoords(coords, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'RetirarBarco'
						currentPartNum = i
					end
				end		

				for i=1, #v.Helicopters, 1 do
					if GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < 2 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'RetirarHeliInem'
						currentPartNum = i
					end
				end

				for i=1, #v.GuardarVeiculo, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarVeiculo[i].x, v.GuardarVeiculo[i].y, v.GuardarVeiculo[i].z, true) < 3 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'GuardarVeiculoInem'
						currentPartNum = i
					end
				end

				for i=1, #v.GuardarHeli, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarHeli[i].x, v.GuardarHeli[i].y, v.GuardarHeli[i].z, true) < 5 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'GuardarHeliInem'
						currentPartNum = i
					end
				end
				
				for i=1, #v.GuardarBarco, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarBarco[i].x, v.GuardarBarco[i].y, v.GuardarBarco[i].z, true) < 5 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'GuardarBarcoInem'
						currentPartNum = i
					end
				end
				--]]
				
				if PlayerData.job.grade_name == 'boss' then
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
					TriggerEvent('esx_ambulancejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

		else
			Citizen.Wait(5000)
		end

	end
end)

RegisterNetEvent('esx_ambulancejob:revLoureivero_1')
AddEventHandler('esx_ambulancejob:revLoureivero_1', function(source)
    Revive()
end)

function Revive()
    local playerPed = GetPlayerPed(-1)
	
    Citizen.CreateThread(function()	
		RequestAnimSet("move_m@drunk@slightlydrunk")
		while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
			Citizen.Wait(0)
		end
		
		SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
		StartScreenEffect('DrugsMichaelAliensFightOut', 0, true)
		Citizen.Wait(20000)
		StartScreenEffect('DrugsMichaelAliensFightIn', 0, true)
		Citizen.Wait(20000)
		StopAllScreenEffects(GetPlayerPed(-1))
		ResetPedMovementClipset(playerPed, 0)
	end)
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('esx_ambulancejob:Bandage')
AddEventHandler('esx_ambulancejob:Bandage', function(source)
    Bandage()
end)

function Bandage()
    local playerPed = GetPlayerPed(-1)
	
    Citizen.CreateThread(function()	
		StopAllScreenEffects(GetPlayerPed(-1))
		ResetPedMovementClipset(playerPed, 0)
	end)
end

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and not isDead then
			local playerPed      = PlayerPedId()
			local carro = IsPedInAnyVehicle(playerPed,  false)
			if CurrentAction ~= nil then

				if IsControlJustReleased(0, Keys['E']) then

					if CurrentAction == 'menu_vestiario' then
						MenuRoupasInem()
					elseif CurrentAction == 'menu_cofre' then
					
						TriggerServerEvent("inventory:server:OpenInventory", "stash", "ambulance")
						TriggerEvent("inventory:client:SetCurrentStash", "ambulance")
						
					elseif CurrentAction == 'menu_cofre_pessoal' then
					
						TriggerServerEvent("inventory:server:OpenInventory", "stash", "ambulance_"..ESX.GetPlayerData().identifier)
						TriggerEvent("inventory:client:SetCurrentStash", "ambulance_"..ESX.GetPlayerData().identifier)
						
					elseif CurrentAction == 'retirar_veiculo' then
						if carro then
							exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Não podes fazer isso dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						else
							GaragemVeiculosInem(CurrentActionData.station, CurrentActionData.partNum)
						end
					elseif CurrentAction == 'retirar_heli' then
						if carro then
							exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Não podes fazer isso dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						else
							HeliportoInemSpawner(CurrentActionData.station, CurrentActionData.partNum)
						end
					elseif CurrentAction == 'retirar_barco' then
						if carro then
							exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Não podes fazer isso dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						else
							BarcosInemSpawner(CurrentActionData.station, CurrentActionData.partNum)
						end
					elseif CurrentAction == 'apagar_veiculo' then
						local model = GetDisplayNameFromVehicleModel(GetEntityModel(CurrentActionData.vehicle))
						local plate = GetVehicleNumberPlateText(CurrentActionData.vehicle)
						--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
						exports['qs-vehiclekeys']:RemoveKeysAuto()
						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
						exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Veículo <span style='color:#069a19'>guardado</span> na garagem!", 5000, 'success')
						
					elseif CurrentAction == 'apagar_heli' then
						local model = GetDisplayNameFromVehicleModel(GetEntityModel(CurrentActionData.vehicle))
						local plate = GetVehicleNumberPlateText(CurrentActionData.vehicle)
						TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
						exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Helicóptero <span style='color:#069a19'>guardado</span> na garagem!", 5000, 'success')
						
					elseif CurrentAction == 'apagar_barco' then
						ApagarBarcoInem(CurrentActionData.station, CurrentActionData.partNum)
						exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Barco <span style='color:#069a19'>guardado</span> no porto!", 5000, 'success')
						
					elseif CurrentAction == 'menu_boss_actions' then
						ESX.UI.Menu.CloseAll()
						TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
							menu.close()
							CurrentAction     = 'menu_boss_actions'
						end, { wash = false })
					end
					
					CurrentAction = nil
				end
			end -- CurrentAction end
		
			if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'ambulance_actions') then
				AbrirMenuInem()
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
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_ambulancejob:updateBlip')
AddEventHandler('esx_ambulancejob:updateBlip', function()
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
	
	-- Clean the blip table
	blipsCops = {}
	
	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'ambulance' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() and hasItem then
						createBlip(id)
					end
				end
			end
		end)
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false

	if not hasAlreadyJoined then
		TriggerServerEvent('society_ambulance:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

-------------- animacoes novas ---------------

RegisterNetEvent('CUSTOM_esx_ambulance:playCPR')
AddEventHandler('CUSTOM_esx_ambulance:playCPR', function(playerheading, playercoords, playerlocation)
	local playerPed = PlayerPedId()

    local cpr = true

    Citizen.CreateThread(function()
        while cpr do
            Citizen.Wait(0)
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
        end
    end)

    ClampGameplayCamPitch(0.0, -90.0)

    local heading = 0.0

    -- SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
    local coords = GetEntityCoords(playerPed)
	-- NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    --local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
    local x, y, z = table.unpack(playercoords + playerlocation)
	NetworkResurrectLocalPlayer(x, y, z, playerheading, true, false)
	-- SetPlayerInvincible(playerPed, false)
	-- TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)

    -- SetEntityCoords(playerPed, x, y, z)
    SetEntityHeading(playerPed, playerheading - 270.0)


    TaskPlayAnim(playerPed, lib1_char_b, anim_start, 8.0, 8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(15800 - 900)
    for i=1, 15, 1 do
        Citizen.Wait(900)
        TaskPlayAnim(playerPed, lib2_char_b, anim_pump, 8.0, 8.0, -1, 0, 0, false, false, false)
    end

    cpr = false

    TaskPlayAnim(playerPed, lib2_char_b, anim_success, 8.0, 8.0, -1, 0, 0, false, false, false)
end)

RegisterNetEvent('CUSTOM_esx_ambulance:playHeal')
AddEventHandler('CUSTOM_esx_ambulance:playHeal', function(playerheading, playercoords, playerlocation)
	local playerPed = PlayerPedId()

    local cpr = true

    Citizen.CreateThread(function()
        while cpr do
            Citizen.Wait(0)
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
        end
    end)

    local heading = 0.0

    -- SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
    local coords = GetEntityCoords(playerPed)
	-- NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    --local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
    local x, y, z = table.unpack(playercoords + playerlocation)
	NetworkResurrectLocalPlayer(x, y, z, playerheading, true, false)
	-- SetPlayerInvincible(playerPed, false)
	-- TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)

    -- SetEntityCoords(playerPed, x, y, z)
    SetEntityHeading(playerPed, playerheading - 270.0)

    TaskPlayAnim(playerPed, lib1_char_b, anim_start, 8.0, 8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(11500)
	ClearPedTasks(playerPed)
    cpr = false
end)