local pickups = {}
local PlayerBank, PlayerMoney = 0,0
CreateThread(function()
	while not Config.Multichar do
		Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			exports.spawnmanager:setAutoSpawn(false)
			DoScreenFadeOut(0)
			Wait(500)
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)

RegisterNetEvent("esx:requestModel", function(model)
    ESX.Streaming.RequestModel(model)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
	ESX.PlayerData = xPlayer

	if Config.Multichar then
		Wait(3000)
	else
		exports.spawnmanager:spawnPlayer({
			x = ESX.PlayerData.coords.x,
			y = ESX.PlayerData.coords.y,
			z = ESX.PlayerData.coords.z + 0.25,
			heading = ESX.PlayerData.coords.heading,
			model = `mp_m_freemode_01`,
			skipFade = false
		}, function()
			TriggerServerEvent('esx:onPlayerSpawn')
			TriggerEvent('esx:onPlayerSpawn')
			TriggerEvent('esx:restoreLoadout')

			if isNew then
				TriggerEvent('skinchanger:loadDefaultModel', skin.sex == 0)
			elseif skin then
				TriggerEvent('skinchanger:loadSkin', skin)
			end

			TriggerEvent('esx:loadingScreenOff')
			ShutdownLoadingScreen()
			ShutdownLoadingScreenNui()
		end)
	end

	ESX.PlayerLoaded = true

	while ESX.PlayerData.ped == nil do Wait(20) end

		-- enable PVP
	if Config.EnablePVP then
		SetCanAttackFriendly(ESX.PlayerData.ped, true, false)
		NetworkSetFriendlyFireOption(true)
	end

		CreateThread(function()
			local SetPlayerHealthRechargeMultiplier = SetPlayerHealthRechargeMultiplier
			local BlockWeaponWheelThisFrame = BlockWeaponWheelThisFrame
			local DisableControlAction = DisableControlAction
			local IsPedArmed = IsPedArmed
			local SetPlayerLockonRangeOverride = SetPlayerLockonRangeOverride
			local DisablePlayerVehicleRewards = DisablePlayerVehicleRewards
			local RemoveAllPickupsOfType = RemoveAllPickupsOfType
			local HideHudComponentThisFrame = HideHudComponentThisFrame
			local PlayerId = PlayerId()
			local DisabledComps = {}
			for i=1, #(Config.RemoveHudCommonents) do
				if Config.RemoveHudCommonents[i] then
					DisabledComps[#DisabledComps + 1] = i
				end
		 end
			while true do 
				local Sleep = true

				if Config.DisableHealthRegeneration then
					Sleep = false
					SetPlayerHealthRechargeMultiplier(PlayerId, 0.0)
				end

				if Config.DisableWeaponWheel then
					Sleep = false
					BlockWeaponWheelThisFrame()
					DisableControlAction(0, 37,true)
				end

				if Config.DisableAimAssist then
					Sleep = false
					if IsPedArmed(ESX.PlayerData.ped, 4) then
						SetPlayerLockonRangeOverride(PlayerId, 2.0)
					end
				end

				if Config.DisableVehicleRewards then
					Sleep = false
					DisablePlayerVehicleRewards(PlayerId)
				end
			
				if Config.DisableNPCDrops then
					Sleep = false
					RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
					RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
					RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
				end

				if #DisabledComps > 0 then
					Sleep = false
					for i=1, #(DisabledComps) do
						HideHudComponentThisFrame(DisabledComps[i])
					end
				end
				
			Wait(Sleep and 1500 or 0)
			end
		end)

	if Config.EnableHud then
		table.sort(ESX.PlayerData.accounts, function(a, b)
			if a.name == 'money' then
				return true
			elseif b.name == 'money' then
				return false
			elseif a.name == 'bank' then
				return true
			elseif b.name == 'bank' then
				return false
			else
				return true
			end
		end)
		
		for i=1, #(ESX.PlayerData.accounts) do
			local accountTpl = '<div><img src="img/accounts/' .. ESX.PlayerData.accounts[i].name .. '.png"/>&nbsp;{{money}}</div>'
			ESX.UI.HUD.RegisterElement('account_' .. ESX.PlayerData.accounts[i].name, i, 0, accountTpl, {money = ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money)})
		end
		
		local jobTpl = '<div>{{job_label}}{{grade_label}}</div>'
		
		local gradeLabel = ESX.PlayerData.job.grade_label ~= ESX.PlayerData.job.label and ESX.PlayerData.job.grade_label or ''
		if gradeLabel ~= '' then gradeLabel = ' - '..gradeLabel end

		ESX.UI.HUD.RegisterElement('job', #ESX.PlayerData.accounts, 0, jobTpl, {
			job_label = ESX.PlayerData.job.label,
			grade_label = gradeLabel
		})
	end

	SetDefaultVehicleNumberPlateTextPattern(-1, Config.CustomAIPlates)
	StartServerSyncLoops()
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	if Config.EnableHud then ESX.UI.HUD.Reset() end
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight) ESX.SetPlayerData("maxWeight", newMaxWeight) end)

local function onPlayerSpawn()
		ESX.SetPlayerData('ped', PlayerPedId())
		ESX.SetPlayerData('dead', false)
end

AddEventHandler('playerSpawned', onPlayerSpawn)
AddEventHandler('esx:onPlayerSpawn', onPlayerSpawn)

AddEventHandler('esx:onPlayerDeath', function()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', true)
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Wait(100)
	end
	TriggerEvent('esx:restoreLoadout')
end)

AddEventHandler('esx:restoreLoadout', function()
	ESX.SetPlayerData('ped', PlayerPedId())

	if not Config.OxInventory and not Config.QSInventory then
		local ammoTypes = {}
		RemoveAllPedWeapons(ESX.PlayerData.ped, true)

		for k,v in ipairs(ESX.PlayerData.loadout) do
			local weaponName = v.name
			local weaponHash = joaat(weaponName)

			GiveWeaponToPed(ESX.PlayerData.ped, weaponHash, 0, false, false)
			SetPedWeaponTintIndex(ESX.PlayerData.ped, weaponHash, v.tintIndex)

			local ammoType = GetPedAmmoTypeFromWeapon(ESX.PlayerData.ped, weaponHash)

			for k2,v2 in ipairs(v.components) do
				local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash
				GiveWeaponComponentToPed(ESX.PlayerData.ped, weaponHash, componentHash)
			end

			if not ammoTypes[ammoType] then
				AddAmmoToPed(ESX.PlayerData.ped, weaponHash, v.ammo)
				ammoTypes[ammoType] = true
			end
		end
	end
end)

AddStateBagChangeHandler('VehicleProperties', nil, function(bagName, key, value)
	if value then
		Wait(0)
		local NetId = value.NetId
		local Vehicle = NetworkGetEntityFromNetworkId(NetId)
		local Tries = 0
		while not DoesEntityExist(Vehicle) do
			local Vehicle = NetworkGetEntityFromNetworkId(NetId)
			Wait(100)
			Tries = Tries + 1
			if Tries > 300 then
				break
			end
		end
		if NetworkGetEntityOwner(Vehicle) == PlayerId() then
			ESX.Game.SetVehicleProperties(Vehicle, value)
		end
	end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #(ESX.PlayerData.accounts) do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end

	ESX.SetPlayerData('accounts', ESX.PlayerData.accounts)

	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('account_' .. account.name, {
			money = ESX.Math.GroupDigits(account.money)
		})
	end
end)

if not Config.OxInventory and not Config.QSInventory then
	RegisterNetEvent('esx:addInventoryItem')
	AddEventHandler('esx:addInventoryItem', function(item, count, showNotification)
		for k,v in ipairs(ESX.PlayerData.inventory) do
			if v.name == item then
				ESX.UI.ShowInventoryItemNotification(true, v.label, count - v.count)
				ESX.PlayerData.inventory[k].count = count
				break
			end
		end

		if showNotification then
			ESX.UI.ShowInventoryItemNotification(true, item, count)
		end

		if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
			ESX.ShowInventory()
		end
	end)

	RegisterNetEvent('esx:removeInventoryItem')
	AddEventHandler('esx:removeInventoryItem', function(item, count, showNotification)
		for k,v in ipairs(ESX.PlayerData.inventory) do
			if v.name == item then
				ESX.UI.ShowInventoryItemNotification(false, v.label, v.count - count)
				ESX.PlayerData.inventory[k].count = count
				break
			end
		end

		if showNotification then
			ESX.UI.ShowInventoryItemNotification(false, item, count)
		end

		if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
			ESX.ShowInventory()
		end
	end)

	RegisterNetEvent('esx:addWeapon')
	AddEventHandler('esx:addWeapon', function(weapon, ammo)
		print("[^1ERROR^7] event ^5'esx:addWeapon'^7 Has Been Removed. Please use ^5xPlayer.addWeapon^7 Instead!")
	end)

	RegisterNetEvent('esx:addWeaponComponent')
	AddEventHandler('esx:addWeaponComponent', function(weapon, weaponComponent)
		print("[^1ERROR^7] event ^5'esx:addWeaponComponent'^7 Has Been Removed. Please use ^5xPlayer.addWeaponComponent^7 Instead!")
	end)

	RegisterNetEvent('esx:setWeaponAmmo')
	AddEventHandler('esx:setWeaponAmmo', function(weapon, weaponAmmo)
		print("[^1ERROR^7] event ^5'esx:setWeaponAmmo'^7 Has Been Removed. Please use ^5xPlayer.addWeaponAmmo^7 Instead!")
	end)

	RegisterNetEvent('esx:setWeaponTint')
	AddEventHandler('esx:setWeaponTint', function(weapon, weaponTintIndex)
		SetPedWeaponTintIndex(ESX.PlayerData.ped, joaat(weapon), weaponTintIndex)
		
	end)

	RegisterNetEvent('esx:removeWeapon')
	AddEventHandler('esx:removeWeapon', function(weapon)
		local playerPed = ESX.PlayerData.ped
		RemoveWeaponFromPed(ESX.PlayerData.ped, joaat(weapon))
		SetPedAmmo(ESX.PlayerData.ped, joaat(weapon), 0)
	end)

	RegisterNetEvent('esx:removeWeaponComponent')
	AddEventHandler('esx:removeWeaponComponent', function(weapon, weaponComponent)
		local componentHash = ESX.GetWeaponComponent(weapon, weaponComponent).hash
		RemoveWeaponComponentFromPed(ESX.PlayerData.ped, joaat(weapon), componentHash)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(Job)
	if Config.EnableHud then
		local gradeLabel = Job.grade_label ~= Job.label and Job.grade_label or ''
		if gradeLabel ~= '' then gradeLabel = ' - '..gradeLabel end
		ESX.UI.HUD.UpdateElement('job', {
			job_label = Job.label,
			grade_label = gradeLabel
		})
	end
	ESX.SetPlayerData('job', Job)
end)

RegisterNetEvent('esx:registerSuggestions')
AddEventHandler('esx:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

-- Pause menu disables HUD display
if Config.EnableHud then
	CreateThread(function()
		local isPaused = false
		
		while true do
			local time = 500
			Wait(time)

			if IsPauseMenuActive() and not isPaused then
				time = 100
				isPaused = true
				ESX.UI.HUD.SetDisplay(0.0)
			elseif not IsPauseMenuActive() and isPaused then
				time = 100
				isPaused = false
				ESX.UI.HUD.SetDisplay(1.0)
			end
		end
	end)

	AddEventHandler('esx:loadingScreenOff', function()
		ESX.UI.HUD.SetDisplay(1.0)
	end)
end

function StartServerSyncLoops()
	if not Config.OxInventory and not Config.QSInventory then
			-- keep track of ammo

			CreateThread(function()
					local currentWeapon = {Ammo = 0}
					while ESX.PlayerLoaded do
						local sleep = 1500
						if GetSelectedPedWeapon(ESX.PlayerData.ped) ~= -1569615261 then
							sleep = 1000
							local _,weaponHash = GetCurrentPedWeapon(ESX.PlayerData.ped, true)
							local weapon = ESX.GetWeaponFromHash(weaponHash) 
							if weapon then
								local ammoCount = GetAmmoInPedWeapon(ESX.PlayerData.ped, weaponHash)
								if weapon.name ~= currentWeapon.name then 
									currentWeapon.Ammo = ammoCount
									currentWeapon.name = weapon.name
								else
									if ammoCount ~= currentWeapon.Ammo then
										currentWeapon.Ammo = ammoCount
										TriggerServerEvent('esx:updateWeaponAmmo', weapon.name, ammoCount)
									end 
								end   
							end
						end    
					Wait(sleep)
					end
			end)
	end

	-- sync current player coords with server
	CreateThread(function()
		local previousCoords = vector3(ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)

		while ESX.PlayerLoaded do
			local playerPed = PlayerPedId()
			if ESX.PlayerData.ped ~= playerPed then ESX.SetPlayerData('ped', playerPed) end

			if DoesEntityExist(ESX.PlayerData.ped) then
				local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
				local distance = #(playerCoords - previousCoords)

				if distance > 1 then
					previousCoords = playerCoords
					TriggerServerEvent('esx:updateCoords')
				end
			end
			Wait(1500)
		end
	end)
end

-- disable wanted level
if not Config.EnableWantedLevel then
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)
end

----- Admin commnads from esx_adminplus

RegisterNetEvent("esx:tpm")
AddEventHandler("esx:tpm", function()
	local GetEntityCoords = GetEntityCoords
	local GetGroundZFor_3dCoord = GetGroundZFor_3dCoord
	local GetFirstBlipInfoId = GetFirstBlipInfoId
	local DoesBlipExist = DoesBlipExist
	local DoScreenFadeOut = DoScreenFadeOut
	local GetBlipInfoIdCoord = GetBlipInfoIdCoord
	local GetVehiclePedIsIn = GetVehiclePedIsIn

	ESX.TriggerServerCallback("esx:isUserAdmin", function(admin)
		if admin then
			local blipMarker = GetFirstBlipInfoId(8)
			if not DoesBlipExist(blipMarker) then
				--ESX.ShowNotification('No Waypoint Set.', true, false, 140)
				exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Nenhum marcador no mapa!", 5000, 'error')
				return 'marker'
			end
	
			-- Fade screen to hide how clients get teleported.
			DoScreenFadeOut(650)
			while not IsScreenFadedOut() do
					Wait(0)
			end
	
			local ped, coords = ESX.PlayerData.ped, GetBlipInfoIdCoord(blipMarker)
			local vehicle = GetVehiclePedIsIn(ped, false)
			local oldCoords = GetEntityCoords(ped)
	
			-- Unpack coords instead of having to unpack them while iterating.
			-- 825.0 seems to be the max a player can reach while 0.0 being the lowest.
			--local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
			local x, y, groundZ, Z_START = coords['x'], coords['y'], 1, 1
			local found = false
			if vehicle > 0 then
					FreezeEntityPosition(vehicle, true)
			else
					FreezeEntityPosition(ped, true)
			end
	
			for i = Z_START, 850, 5.0 do
					local z = i
					if (i % 2) ~= 0 then
							z = Z_START + i
					end
	
					NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
					local curTime = GetGameTimer()
					while IsNetworkLoadingScene() do
							if GetGameTimer() - curTime > 1000 then
									break
							end
							Wait(0)
					end
					NewLoadSceneStop()
					SetPedCoordsKeepVehicle(ped, x, y, z)
	
					while not HasCollisionLoadedAroundEntity(ped) do
							RequestCollisionAtCoord(x, y, z)
							if GetGameTimer() - curTime > 1000 then
									break
							end
							Wait(0)
					end
	
					-- Get ground coord. As mentioned in the natives, this only works if the client is in render distance.
					found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
					if found then
							Wait(0)
							SetPedCoordsKeepVehicle(ped, x, y, i + 0.0)
							break
					end
					Wait(0)
			end
	
			-- Remove black screen once the loop has ended.
			DoScreenFadeIn(650)
			if vehicle > 0 then
					FreezeEntityPosition(vehicle, false)
			else
					FreezeEntityPosition(ped, false)
			end
	
			if not found then
					-- If we can't find the coords, set the coords to the old ones.
					-- We don't unpack them before since they aren't in a loop and only called once.
					SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
					--ESX.ShowNotification('Successfully Teleported', true, false, 140)
					exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Foste <span style='color:#069a19'>teleportado</span> com sucesso!", 5000, 'success')
			end
	
			-- If Z coord was found, set coords in found coords.
			SetPedCoordsKeepVehicle(ped, x, y, groundZ)
			--ESX.ShowNotification('Successfully Teleported', true, false, 140)
			exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Foste <span style='color:#069a19'>teleportado</span> com sucesso!", 5000, 'success')
		end
	end)
end)

local noclip = false
RegisterNetEvent("esx:noclip")
AddEventHandler("esx:noclip", function(input)
	ESX.TriggerServerCallback("esx:isUserAdmin", function(admin)
		if admin then
			local player = PlayerId()

			local msg = nil
			if noclip == true then
				msg = "DESATIVADO"
				SetAllCollition(true)
				TriggerEvent("pneus_furam_ao_capotar:setNoclip", false)
				exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>NOCLIP <span style='color:#ff0000'><b>"..msg.."</b></span>!", 5000, 'success')
			end

			if noclip == false then
				msg = "ATIVADO"
				SetAllCollition(false)
				TriggerEvent("pneus_furam_ao_capotar:setNoclip", true)
				exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>NOCLIP <span style='color:#069a19'><b>"..msg.."</b></span>!", 5000, 'success')
			end
			
			if noclip == false then
				noclip = true
			else
				noclip = false
			end
			
			--TriggerEvent("chatMessage", "Noclip has been ^2^*" .. msg)
		end
	end)
end)

local heading = 0
local gtimer = GetGameTimer()
local speed = 10

CreateThread(function()
	while true do
		local Sleep = 1500

		if(noclip)then
			Sleep = 0
			local multiplier = GetGameTimer() - gtimer
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			local camRot = GetGameplayCamRot(0)
			local camHeading = map(camRot.z, -180.0, 180.0, 0.0, 360.0)
			local ax, ay = math.sin(math.rad(camHeading)), -math.cos(math.rad(camHeading))
			local newX, newY, newZ = pos.x, pos.y, pos.z
			if IsControlJustPressed(2, 174) then speed = speed - 2 end -- Left
			if IsControlJustPressed(2, 175) then speed = speed + 2 end -- Right
			
			if speed < 1 then speed = 1 end 
			if IsControlPressed(2, 87) then newX, newY = newX + ax*(multiplier*(speed/100)), newY + ay*(multiplier*(speed/100)) end -- W 
			if IsControlPressed(2, 88) then newX, newY = newX - ax*(multiplier*(speed/100)), newY - ay*(multiplier*(speed/100)) end -- S
			if IsControlPressed(2, 172) then newZ = newZ + multiplier*(speed/100) end -- Up
			if IsControlPressed(2, 173) then newZ = newZ - multiplier*(speed/100) end -- Down
			
			
			if IsControlPressed(2, 89) then -- A
				local newcamHeading = (camHeading + 90) % 360
				ax, ay = math.sin(math.rad(newcamHeading)), -math.cos(math.rad(newcamHeading))
				newX, newY = newX + ax*(multiplier*(speed/100)), newY + ay*(multiplier*(speed/100))
			end
			if IsControlPressed(2, 90) then -- D
				local newcamHeading = (camHeading - 90) % 360
				ax, ay = math.sin(math.rad(newcamHeading)), -math.cos(math.rad(newcamHeading))
				newX, newY = newX + ax*(multiplier*(speed/100)), newY + ay*(multiplier*(speed/100))
			end
			SetAllCoordsNoOffset(newX, newY, newZ, ax, ay, 0.0)
			gtimer = GetGameTimer()
		end
		Wait(Sleep)
	end
end)

function map(x, in_min, in_max, out_min, out_max)
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function SetAllCollition(mode)
	local ped = PlayerPedId()
	SetEntityCollision(ped, mode, mode)
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsUsing(ped)
		SetEntityCollision(veh, mode, mode)
	end
end

function SetAllCoordsNoOffset(x, y, z, zx, zy, zz)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsUsing(ped)
		SetEntityCoordsNoOffset(veh, x, y, z, zx, zy, zz)
	else
		SetEntityCoordsNoOffset(ped, x, y, z, zx, zy, zz)
	end
end

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicle)
	local modelo = vehicle
	if IsModelInCdimage(vehicle) then
		local playerPed = PlayerPedId()
		local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

		ESX.Game.SpawnVehicle(vehicle, playerCoords, playerHeading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle)) --Quasar Vehiclekeys Modify.
			--TriggerServerEvent("johnny:server:darChaves", GetVehicleNumberPlateText(vehicle), modelo)
		end)
	else
		--local time = os.date('%H:%M')
		local years, months, days, hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
		local time = hours..":"..minutes
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">Modelo do veículo inválido!</div></div>',
			args = { time }
		})
	end
end)

RegisterNetEvent("esx:killPlayer")
AddEventHandler("esx:killPlayer", function()
	SetEntityHealth(ESX.PlayerData.ped, 0)
end)

RegisterNetEvent('esx:slap')
AddEventHandler('esx:slap', function()
	local ped = PlayerPedId()

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent("esx:freezePlayer")
AddEventHandler("esx:freezePlayer", function(input)
    local player = PlayerId()
	local msg = "CONGELADO"
    if input == 'freeze' then
        SetEntityCollision(ESX.PlayerData.ped, false)
        FreezeEntityPosition(ESX.PlayerData.ped, true)
        SetPlayerInvincible(player, true)
    elseif input == 'unfreeze' then
        SetEntityCollision(ESX.PlayerData.ped, true)
	    FreezeEntityPosition(ESX.PlayerData.ped, false)
        SetPlayerInvincible(player, false)
		msg = "DESCONGELADO"
    end
	exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>O Jogador foi <span style='color:#069a19'><b>"..msg.."</b></span>!", 5000, 'success')
end)

RegisterNetEvent("esx:GetVehicleType", function(Model, Request)
	local Model = Model
	local VehicleType = GetVehicleClassFromName(Model)
	local type = "automobile"
	if VehicleType == 15 then
		type = "heli"
	elseif VehicleType == 16 then
		type = "plane"
	elseif VehicleType == 14 then
		type = "boat"
	elseif VehicleType == 11 then
		type = "trailer"
	elseif VehicleType == 21 then
		type = "train"
	elseif VehicleType == 13 or VehicleType == 8 then
		type = "bike"
	end
	if Model == `submersible` or Model == `submersible2` then
		type = "submarine"
	end
	TriggerServerEvent("esx:ReturnVehicleType", type, Request)
end)


local DoNotUse = {
	'essentialmode',
	'es_admin2',
	'basic-gamemode',
	'mapmanager',
	'fivem-map-skater',
	'fivem-map-hipster',
	'qb-core',
	'default_spawnpoint',
}

for i=1, #DoNotUse do
	if GetResourceState(DoNotUse[i]) == 'started' or GetResourceState(DoNotUse[i]) == 'starting' then
		print("[^1ERROR^7] YOU ARE USING A RESOURCE THAT WILL BREAK ^1ESX^7, PLEASE REMOVE ^5"..DoNotUse[i].."^7")
	end
end

RegisterNetEvent('qs-core:setPlayerData')
AddEventHandler('qs-core:setPlayerData', function(data)
    local Inventory = data.items
    for _, slot in pairs(Inventory) do
        Inventory[_].count = Inventory[_].amount
    end
    ESX.PlayerData.inventory = Inventory
end)