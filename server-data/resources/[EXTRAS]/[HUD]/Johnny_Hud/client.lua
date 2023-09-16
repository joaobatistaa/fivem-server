local p = PlayerId()
local PlayerJob = {}
local PlayerData = {}
local nuiLoaded = false
local playerLoaded = false
local pauseMenuActive = false
local inRadioTalking = false
local hideAmmoCounts = false
local cs, fs = 0.0, 0.0
local inCar = false
local belt = false
local speedlimiter = false
local limitSet = false
local speedLimit = 0
local defSpeed = 0
local defaultMapLoaded = false
local selectedMap
local lightState
local triggerHided = false
local cinematicMode = false
local blackList = false
local speedType

local hiddedRadarTrigger = false

local hunger, thirst, stress, stamina = 0, 0, 0, 0

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)

local hud = true
RegisterCommand("hud", function()
	if hud then
		ESX.UI.HUD.SetDisplay(0.0)
		SendNUIMessage({
			type = "HUD_STATE",
			state = true,
		})
		hud = false
		hiddedRadarTrigger = true
	else
		ESX.UI.HUD.SetDisplay(1.0)
		SendNUIMessage({
			type = "HUD_STATE",
			state = false,
		})
		hud = true
		hiddedRadarTrigger = false
	end
end)

RegisterNetEvent("johnny_core:toggleHud")
AddEventHandler("johnny_core:toggleHud", function(status)
	if status == false then
		ESX.UI.HUD.SetDisplay(0.0)
		triggerHided = false
		SendNUIMessage({
			type = "HUD_STATE",
			state = true,
		})
		hud = false
		hiddedRadarTrigger = true
	end
	
	if status == true then
		ESX.UI.HUD.SetDisplay(1.0)
		triggerHided = true
		SendNUIMessage({
			type = "HUD_STATE",
			state = false,
		})
		hud = true
		hiddedRadarTrigger = false
	end
end)

RegisterNetEvent("johnny_core:toggleHud2")
AddEventHandler("johnny_core:toggleHud2", function(status)
	if status == false then
		ESX.UI.HUD.SetDisplay(0.0)
		triggerHided = false
		SendNUIMessage({
			type = "HUD_STATE",
			state = true,
		})
		hud = false
	end
	
	if status == true then
		ESX.UI.HUD.SetDisplay(1.0)
		triggerHided = true
		SendNUIMessage({
			type = "HUD_STATE",
			state = false,
		})
		hud = true
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	ESX.UI.HUD.SetDisplay(0.0)
	triggerHided = false
	SendNUIMessage({
		type = "HUD_STATE",
		state = true,
	})
	hiddedRadarTrigger = true
end)

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

RegisterNetEvent('esx:onPlayerLoaded', function(playerData)
	while true do
		if nuiLoaded then
			SendNUIMessage({
				type = "OPEN_UI",
				playerId = GetPlayerServerId(PlayerId()),
			})
			playerLoaded = true
			SetTimeout(2000, function()
				playerLoadFunction()
			end)
			break
		end
		Wait(1)
	end
end)

AddEventHandler('esx:onPlayerLogout', function()
	PlayerData = {}
end)

RegisterNetEvent('esx:setPlayerData', function(val)
	PlayerData = val
	
	if Config.CashItem then
		Wait(1000)
		for k, v in pairs(PlayerData.inventory) do
			if v.name == Config.CashItemName then
				SendNUIMessage({
					type = 'UPDATE_MONEY_2',
					cash = v.count
				})
				break
			end
		end
	end
end)


RegisterNetEvent('esx:setJob', function(job)
    PlayerJob = job
    SendNUIMessage({
        type  = "UPDATE_JOB",
        job   = PlayerJob.label,
        grade = PlayerJob.grade_label,
    })
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
	hunger = newHunger
	thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)

RegisterNetEvent("hud:updateCruiseControl")
AddEventHandler("hud:updateCruiseControl", function(status)
	speedlimiter = status
end)

RegisterNetEvent('wais:totalPlayers', function(onlinePlayers, maxPlayers)
	SendNUIMessage({
		type = "UPDATE_PLAYERS",
		online = tonumber(onlinePlayers),
		max = tonumber(maxPlayers)
	})
end)
local money = 0
local bank = 0
RegisterNetEvent('esx:setAccountMoney', function(account)
	while ESX.GetPlayerData() == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
	
	for i=1, #(PlayerData.accounts) do
		if PlayerData.accounts[i].name == account.name and account.name == 'bank' then
			bank = account.money
		end
		if PlayerData.accounts[i].name == account.name and account.name == 'money' then
			money = account.money
		end
	end
	SendNUIMessage({
		type = "UPDATE_MONEY",
		cash = money,
		bank = bank,
		cashItem = Config.CashItem,
	})
end)

RegisterNetEvent('wais:notification', function(text, type, duration)
	if type ~= nil then
		type = type
	else
		type = "information"
	end

	if duration ~= nil then
		duration = duration
	else
		duration = 2500
	end

	if text ~= nil then
		text = text
	else
		text = "Not have messages..."
	end

	SendNUIMessage({
		type = "ADD_NOTIFICATION",
		text = text,
		types = type,
		duration = duration,
	})
	
end)

RegisterNetEvent('wais:hudHide', function(boolean)
	triggerHided = boolean
	SendNUIMessage({
		type = "HUD_STATE",
		state = boolean,
	})
end)

RegisterNetEvent('wais:hideRadar', function(boolean)
	hiddedRadarTrigger = boolean
end)

RegisterNetEvent('mumble-voip:RadioTrafficStateChanged', function(isSending)
	inRadioTalking = isSending
end)

RegisterNetEvent('mumble-voip:VoiceRangeChanged', function(range)
	SendNUIMessage({
		type  = "UPDATE_MIC_DISTANCE",
		distance = Config.SaltychatRange[tostring(range)][2],
	})
end)

AddEventHandler('onClientResourceStart', function(resName)
	if (GetCurrentResourceName() == resName) then
		while true do
			if nuiLoaded then
				TriggerServerEvent('wais:getTotalPlayers')
				SendNUIMessage({
					type = "OPEN_UI",
					playerId = GetPlayerServerId(PlayerId()),
				})
				playerLoaded = true
				SetTimeout(2000, function()
					playerLoadFunction()
				end)
				break
			end
			Wait(1)
		end
	end
end)

-----------------------------------------------------------------------------------------
-- NUI CALLBACK'S --
-----------------------------------------------------------------------------------------

RegisterNUICallback('nuiloaded', function()
	nuiLoaded = true
end)

RegisterNUICallback('setMapSelection', function(data)
	while true do
		if defaultMapLoaded then
			selectedMap = data.map
			reBuildMap()
			break
		end
		Wait(1)
	end
end)

RegisterNUICallback('cinematic', function(data)
	cinematicMode = data.cinematic
end)

RegisterNUICallback('speedType', function(data)
	speedType = data.type
end)

RegisterNUICallback('close', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "CLOSE_SETTINGS",
	})
end)

-----------------------------------------------------------------------------------------
-- FUNCTION'S --
-----------------------------------------------------------------------------------------

function playerLoadFunction()
	p = PlayerId()

	if not PlayerData.job then
		Wait(2000)
		playerLoadFunction()
		return
	end

	for i=1, #(PlayerData.accounts) do
		if PlayerData.accounts[i].name == 'money' then
			money = PlayerData.accounts[i].money
		end
		
		if PlayerData.accounts[i].name == 'bank' then
			bank = PlayerData.accounts[i].money
		end
	end
	
	SendNUIMessage({
		type = "UPDATE_MONEY",
		cash = money,
        bank = bank,
		cashItem = Config.CashItem,
	})

	SendNUIMessage({
		type  = "UPDATE_JOB",
		job   = PlayerData.job.label,
		grade = PlayerData.job.grade_label,
	})

	if Config.CashItem then
		for k, v in pairs(PlayerData.items) do
			if v.name == Config.CashItemName then
				SendNUIMessage({
					type = "UPDATE_MONEY_2",
					cash = v.amount
				})
				break
			end
		end
	end
	loadKeybinds()
	loadDefaultMap()
end

function ragdollP()
    if not belt then 
		playerPed = PlayerPedId()
        local position = GetEntityCoords(playerPed)
        SetEntityCoords(playerPed, position.x, position.y, position.z - 0.47, true, true, true)
        SetEntityVelocity(playerPed, prevVelocity.x, prevVelocity.y, prevVelocity.z)
        Citizen.Wait(1)
        SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)
        Citizen.Wait(1000)
        if math.random(1, 3) == 1 then SetEntityHealth(playerPed, 0) end
    end
end

function loadKeybinds()
	while true do
		if nuiLoaded then
			SendNUIMessage({
				type = "LOAD_KEYBINDS",
				keybinds = Config.KeyBindList,
			})
			SendNUIMessage({
				type = "CLOK_TYPE",
				clock = Config.ClockType,
			})
			break
		end
		Wait(1)
	end
end

function loadDefaultMap() 
	RequestStreamedTextureDict("squaremap", false)
	if not HasStreamedTextureDictLoaded("squaremap") then
		Wait(150)
	end
	SetMinimapClipType(0)
	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
	AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
	-- 0.0 = nav symbol and icons left
	-- 0.1638 = nav symbol and icons stretched
	-- 0.216 = nav symbol and icons raised up
	SetMinimapComponentPosition("minimap", "L", "B", 0.0, -0.047, 0.1638, 0.183)

	-- icons within map
	SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0, 0.0, 0.128, 0.20)

	-- -0.01 = map pulled left
	-- 0.025 = map raised up
	-- 0.262 = map stretched
	-- 0.315 = map shorten
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.0, 0.025, 0.262, 0.300)
	SetBlipAlpha(GetNorthRadarBlip(), 0)
	SetRadarBigmapEnabled(true, false)
	SetMinimapClipType(0)
	Wait(50)
	SetRadarBigmapEnabled(false, false)
	Wait(1200)
	defaultMapLoaded = true
	SendNUIMessage({
		type = "DEFAULT_MAP_LOADED",
	})
end

function reBuildMap()
	if selectedMap == "round" then
		RequestStreamedTextureDict("squaremap", false)
		if not HasStreamedTextureDictLoaded("squaremap") then
			Wait(150)
		end
		SetMinimapClipType(0)
		AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
		AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
		-- 0.0 = nav symbol and icons left
		-- 0.1638 = nav symbol and icons stretched
		-- 0.216 = nav symbol and icons raised up
		SetMinimapComponentPosition("minimap", "L", "B", 0.0, -0.007, 0.1638, 0.183)
	
		-- icons within map
		SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0, 0.0, 0.128, 0.20)
	
		-- -0.01 = map pulled left
		-- 0.025 = map raised up
		-- 0.262 = map stretched
		-- 0.315 = map shorten
		SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.0, 0.025, 0.262, 0.300)
		SetBlipAlpha(GetNorthRadarBlip(), 0)
		SetRadarBigmapEnabled(true, false)
		SetMinimapClipType(0)
		Wait(50)
		SetRadarBigmapEnabled(false, false)
		Wait(1200)
	elseif selectedMap == "circle" then
		local x = -0.025
		local y = -0.015
		local w = 0.16
		local h = 0.25


		RequestStreamedTextureDict("circlemap", false)
		if not HasStreamedTextureDictLoaded("circlemap") then
			Wait(150)
		end

		SetMinimapClipType(1)
		AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

		SetMinimapComponentPosition('minimap', 'L', 'B', x, y, w, h)
		SetMinimapComponentPosition('minimap_mask', 'L', 'B', x + 0.17, y + 0.09, 0.072, 0.162)
		SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.035, -0.02, 0.18, 0.22)

		SetBlipAlpha(GetNorthRadarBlip(), 0)
		SetMinimapClipType(1)
		SetRadarBigmapEnabled(true, false)
		Wait(50)
		SetRadarBigmapEnabled(false, false)

		-- RequestStreamedTextureDict("circlemap", false)
		-- if not HasStreamedTextureDictLoaded("circlemap") then
		-- 	Wait(150)
		-- end

		-- SetMinimapClipType(1)
		-- AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
		-- AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
		-- -- -0.0100 = nav symbol and icons left
		-- -- 0.180 = nav symbol and icons stretched
		-- -- 0.258 = nav symbol and icons raised up
		-- SetMinimapComponentPosition("minimap", "L", "B", 0.0, -0.030, 0.180, 0.258)

		-- -- icons within map
		-- SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0, 0.0, 0.065, 0.20)

		-- -- -0.00 = map pulled left
		-- -- 0.015 = map raised up
		-- -- 0.252 = map stretched
		-- -- 0.338 = map shorten
		-- SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.0, 0.015, 0.252, 0.338)
		-- SetBlipAlpha(GetNorthRadarBlip(), 0)
		-- SetMinimapClipType(1)
		-- SetRadarBigmapEnabled(true, false)
		-- Wait(50)
		-- SetRadarBigmapEnabled(false, false)
	end

end

function hasBlackListVehicle(hash)
	if not blackList then
		for k, v in pairs(Config.BlackListVehicle) do
			if hash == GetHashKey(v) then
				blackList = true
				return true
			end
		end
		return false
	else
		return true
	end
end

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

RegisterKeyMapping('cinto', 'Cinto', 'keyboard', Config.Sealtbelt)
RegisterCommand('cinto', function()
	if not IsPauseMenuActive() then
		if inCar then
			if not belt then
				TriggerEvent('InteractSound_CL:PlayOnOne', 'plug', 0.5)
				exports['Johnny_Notificacoes']:Alert("CINTO", "<span style='color:#c7c7c7'>Colocaste o <span style='color:#069a19'>cinto</span>!", 3000, 'success')
				belt = true
			else
				TriggerEvent('InteractSound_CL:PlayOnOne', 'out', 0.5)
				exports['Johnny_Notificacoes']:Alert("CINTO", "<span style='color:#c7c7c7'>Retiraste o <span style='color:#ff0000'>cinto</span>!", 5000, 'error')
				belt = false
			end
		end
	end
end)

--[[
RegisterKeyMapping('speedlimiter', 'Speed limiter', 'keyboard', Config.SpeedLimiter)
RegisterCommand('speedlimiter', function()
	if not IsPauseMenuActive() then
		if inCar then
			if not limitSet then
				ESX.ShowNotification(Config.Langs["dont-set-limit"])
			else
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				if GetPedInVehicleSeat(vehicle, -1) then
					local speed = GetEntitySpeed(vehicle)
					if not speedlimiter then
						if tonumber(speed) <= 20 then
							speedlimiter = true
							SetEntityMaxSpeed(vehicle, speedLimit)
						else
							ESX.ShowNotification(Config.Langs["limiter-error"])
						end
					else
						speedlimiter = false
						maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
						SetEntityMaxSpeed(vehicle, maxSpeed)
					end
				end
			end
		end
	end
end)


RegisterCommand(Config.SpeedLimitCommand, function(x, args)
	if not tonumber(args[1]) then
		ESX.ShowNotification(Config.Langs["dont-enter-speed"])
		return
	end

	if speedType == "kmh" then
		speedLimit = tonumber(args[1]) / 3.6 + 0.25
	elseif speedType == "mph" then
		speedLimit = tonumber(args[1]) / 1.6 + 0.25
	end

	limitSet = true
end)
--]]

--RegisterKeyMapping('hudsettings', 'Definições HUD', 'keyboard', Config.SettingsMenu)
RegisterCommand('definicoeshud', function()
	if not IsPauseMenuActive() and not exports['qs-housing']:inDecorate() then
		if playerLoaded then
			SetNuiFocus(true, true)
			SendNUIMessage({
				type = "OPEN_SETTINGS"
			})
		end
	end
end)

-----------------------------------------------------------------------------------------
-- THREAD'S --
-----------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local vhc = IsPedInAnyVehicle(ped, false)
		local maxHealth = GetEntityMaxHealth(ped)
		local heal = maxHealth == 175 and (GetEntityHealth(ped) + 25) - 100 or GetEntityHealth(ped) - 100
		local armour = GetPedArmour(ped)
        local sleep = Config.RefreshTime
        local pos = GetEntityCoords(ped)

		if playerLoaded then
			if not IsPauseMenuActive() then
				local weapon = GetSelectedPedWeapon(ped)
				local ammo = GetAmmoInPedWeapon(ped, weapon)
				local _, ammoclip = GetAmmoInClip(ped, weapon)
				local street1, street2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)

				SetPedConfigFlag(ped, 35, false)

				if vhc then
					sleep = Config.InCarRefreshTime
					local door = false
					local veh = GetVehiclePedIsIn(ped, false)
					if not hasBlackListVehicle(GetEntityModel(veh)) then
						local gear = GetVehicleCurrentGear(veh)
						local speed = GetEntitySpeed(veh)
						local damage  = GetVehicleEngineHealth(veh)
						local hbreake = GetVehicleHandbrake(veh)
						local _,lightson,highbeams = GetVehicleLightsState(veh)
						--local fuel    = GetVehicleFuelLevel(veh)
						local fuel = exports['Johnny_Combustivel']:GetFuel(veh)
						local engine  = GetIsVehicleEngineRunning(veh)
						local rpm     = GetVehicleCurrentRpm(veh)
						defSpeed = GetVehicleHandlingFloat(veh,"CHandlingData","fInitialDriveMaxFlatVel")
						
						if lightson == 1 then
							lightState = true
						elseif highbeams == 1 then
							lightState = true
						else
							lightState = false
						end

						if GetVehicleDoorAngleRatio(veh, 0) ~= 0 then
							door = true
						end
						if GetVehicleDoorAngleRatio(veh, 1) ~= 0 then
							door = true
						end
						if GetVehicleDoorAngleRatio(veh, 2) ~= 0 then
							door = true
						end
						if GetVehicleDoorAngleRatio(veh, 3) ~= 0 then
							door = true
						end
						if GetVehicleDoorAngleRatio(veh, 4) ~= 0 then
							door = true
						end
						if GetVehicleDoorAngleRatio(veh, 5) ~= 0 then
							door = true
						end

						if not inCar then
							inCar = true
							SendNUIMessage({
								type = "PLAYER_INCAR"
							})
						end

						SendNUIMessage({
							type    = "UPDATE_VEHICLE_STATUS",
							gear    = gear,
							speed   = speed,
							belt    = belt,
							door    = door,
							light   = lightState,
							engine  = engine,
							hbreake = hbreake,
							limiter = speedlimiter,
							damage  = damage,
							rpm 	= rpm,
							maxGear = GetVehicleHighGear(veh),
							fuel 	= fuel,
						})

						--fs = cs
						--cs =  speed
						--mfwd = GetEntitySpeedVector(veh, true).y > 1.0
						--vhfr = (fs - cs) / GetFrameTime() > 981
						
						--if not belt then
						--	if mfwd and fs*3.6 > 80 and vhfr then
						--		ragdollP()
						--	else
						--		prevVelocity = GetEntityVelocity(veh)
						--	end
						--end
					end
				else
					sleep = Config.RefreshTime
					blackList = false
					if inCar then
						belt = false
						inCar = false
						speedlimiter = false
						SetEntityMaxSpeed(veh, defSpeed)
						SendNUIMessage({
							type = "PLAYER_OUTCAR"
						})
					end
				end

				if not IsEntityInWater(ped) then
					stamina = 100 - GetPlayerSprintStaminaRemaining(p)
				end

				if IsEntityInWater(ped) then
					stamina = GetPlayerUnderwaterTimeRemaining(p) * 10
				end
				
				TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
					TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
						hunger = hunger.getPercent()
						thirst = thirst.getPercent()
						
						SendNUIMessage({
						type 	= "UPDATE_STATUS",
						heal    = heal,
						armour  = armour,
						hunger  = hunger,
						thirst  = thirst,
						stamina = stamina,
						weather = IsEntityInWater(ped),
						streetTitle = GetStreetNameFromHashKey(street1),
						streetName = GetStreetNameFromHashKey(street2)
					})
					end)
				end)
				

				SendNUIMessage({
					type = "UPDATE_WEAPON",
					weapon = weapon,
					ammo = ammo,
					ammoclip = ammoclip,
				})

				if weapon == -1569615261 then
					hideAmmoCounts = false
				else
					hideAmmoCounts = true
				end
				--print(pauseMenuActive)
				if pauseMenuActive then
					pauseMenuActive = false
					--if not triggerHided then
						SendNUIMessage({
							type = "PAUSEMENU_STATE",
							state = false
						})
					--end
				end
			else
				pauseMenuActive = true
				SendNUIMessage({
					type = "PAUSEMENU_STATE",
					state = true
				})
			end
		end

		Wait(sleep)
	end
end)

local HideHudComponentThisFrame = HideHudComponentThisFrame
local DisplayRadar = DisplayRadar
local DisableControlAction = DisableControlAction
local NetworkIsPlayerTalking = NetworkIsPlayerTalking

CreateThread(function()
	while true do
		if not Config.SaltyChat then
			SendNUIMessage({
				type  = 'UPDATE_MIC',
				state = NetworkIsPlayerTalking(p),
				radio = inRadioTalking
			})
		else
			break
		end
		Wait(250)
	end
end)

CreateThread(function()
	while true do

		if hideAmmoCounts then
			HideHudComponentThisFrame(2)
		end

		if inCar and belt then
			DisableControlAction(0, 75, true)
		end

		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)

		if cinematicMode then
			DisplayRadar(false)
		else
			if not hiddedRadarTrigger then
				DisplayRadar(true)
			else
				DisplayRadar(false)
			end
		end

		Wait(1)
	end
end)