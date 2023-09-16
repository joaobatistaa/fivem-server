local IsDead = false
local IsAnimated = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)


AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
	--TriggerEvent('esx_status:set', 'stress', 100000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	--TriggerEvent('esx_status:set', 'stress', 200000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return false
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return false
	end, function(status)
		status.remove(75)
	end)
	
	--TriggerEvent('esx_status:registerStatus', 'stress', 100000, '#cadfff', function(status)
		--return false
	--end, function(status)
		--status.add(20)
	--end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
			
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)


RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name, time)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.11, 0.045, 0.02, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			
			exports['progressbar']:Progress({
				name = "on_eat_burguer",
				duration = time,
				label = "A comer...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_inteat@burger",
					anim = "mp_player_int_eat_burger_fp",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(time)
			StopAnimTask(PlayerPedId(), "mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name, time)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_water",
				duration = time,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(time)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

-- Bar drinks
RegisterNetEvent('esx_basicneeds:onDrinkBeer')
AddEventHandler('esx_basicneeds:onDrinkBeer', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_amb_beer_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_beer",
				duration = time,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(time)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkWine')
AddEventHandler('esx_basicneeds:onDrinkWine', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_wine_bot_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.3, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_wine",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkVodka')
AddEventHandler('esx_basicneeds:onDrinkVodka', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_vodka_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.3, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_vodka",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkWhisky')
AddEventHandler('esx_basicneeds:onDrinkWhisky', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_whiskey_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.2, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_whiskey",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkTequila')
AddEventHandler('esx_basicneeds:onDrinkTequila', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_tequila_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.3, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_tequila",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkMojito')
AddEventHandler('esx_basicneeds:onDrinkMojito', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_tequila_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.3, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_mojito",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkMilk')
AddEventHandler('esx_basicneeds:onDrinkMilk', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_milk_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, -0.009, -0.03, -0.1, -90.0, 270.0, -90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_milk",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

-- Disco
RegisterNetEvent('esx_basicneeds:onDrinkGin')
AddEventHandler('esx_basicneeds:onDrinkGin', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_rum_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.3, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_gin",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkAbsinthe')
AddEventHandler('esx_basicneeds:onDrinkAbsinthe', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_bottle_cognac'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.3, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_absinthe",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrinkChampagne')
AddEventHandler('esx_basicneeds:onDrinkChampagne', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_wine_white'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.008, -0.02, -0.3, 90.0, 270.0, 90.0, true, true, false, true, 1, true)

			exports['progressbar']:Progress({
				name = "on_drink_champagne",
				duration = 3000,
				label = "A beber...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mp_player_intdrink",
					anim = "loop_bottle",
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(3000)
			StopAnimTask(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0)
			DeleteObject(prop)
			IsAnimated = false
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:OnSmokeCigarett')
AddEventHandler('esx_basicneeds:OnSmokeCigarett', function()
	prop_name = prop_name or 'ng_proc_cigarette01a' ---used cigarett prop for now. Tired of trying to place object.
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped, true))
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(ped, 64017)
			
    if not IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) then
        RequestAnimDict("amb@world_human_smoking@male@male_b@idle_a")
        while not HasAnimDictLoaded("amb@world_human_smoking@male@male_b@idle_a") do
            Citizen.Wait(100)
        end

		Wait(100)
		AttachEntityToEntity(prop, ped, boneIndex, 0.015, 0.0100, 0.0250, 0.024, -100.0, 40.0, true, true, false, true, 1, true)
        TaskPlayAnim(ped, 'amb@world_human_smoking@male@male_b@idle_a', 'idle_a', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        while IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) do
            Wait(1)
			if IsControlPressed(0, 154) then
				--Citizen.Wait(5000)--5 secondes
				ClearPedSecondaryTask(ped)
				DeleteObject(prop)
                break
            end
        end
    end
end)

-- Optionalneeds
function Drunk(level, start)
  
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)
		if start then
			DoScreenFadeOut(800)
			Wait(1000)
		end
		if level == 0 then
			RequestAnimSet("move_m@drunk@slightlydrunk")
      
			while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
				Citizen.Wait(0)
			end
				SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
		elseif level == 1 then
			RequestAnimSet("move_m@drunk@moderatedrunk")
      
			while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
				Citizen.Wait(0)
			end
			SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
		elseif level == 2 then
			RequestAnimSet("move_m@drunk@verydrunk")
      
			while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
				Citizen.Wait(0)
			end
			SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
		end
		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)
		if start then
			DoScreenFadeIn(800)
		end
	end)
end
 
function Reality()
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)
		DoScreenFadeOut(800)
		Wait(1000)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		SetPedIsDrunk(playerPed, false)
		SetPedMotionBlur(playerPed, false)
		DoScreenFadeIn(800)
	end)
end
 
AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', --roxo
		function(status)
			if status.val > 0 then
				return true
			else
				return false
			end
		end,
    function(status)
      status.remove(1500)
    end)
	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			TriggerEvent('esx_status:getStatus', 'drunk', function(status)		
				if status.val > 0 then	
					TriggerEvent('esx_status:setDisplay', 0.5)
					local start = true
					if IsAlreadyDrunk then
						start = false
					end
					local level = 0
					if status.val <= 250000 then
						level = 0
					elseif status.val <= 500000 then
						level = 1
					else
						level = 2
					end
					if level ~= DrunkLevel then
						Drunk(level, start)
					end
					IsAlreadyDrunk = true
					DrunkLevel     = level
				end
				if status.val == 0 then
					if IsAlreadyDrunk then
						Reality()
						TriggerEvent('esx_status:setDisplay', 0.0)
					end
					IsAlreadyDrunk = false
					DrunkLevel     = -1
				end
			end)
		end
 	end)
end)
 
RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  
	local playerPed = GetPlayerPed(-1)
  
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
	Citizen.Wait(1000)
	ClearPedTasks(playerPed)
end) 

----------------------------- STRESS ------------------------------

--[[
Citizen.CreateThread(function() -- Aiming with a weapon
    while true do
        local ped = PlayerPedId()
        local status = GetPedConfigFlag(ped, 78, 1)
		
        if status then
            TriggerServerEvent("stress:add", 5000)
			exports['mythic_notify']:DoHudText("inform", "+ Stress")
            Citizen.Wait(5000)
        else
            Citizen.Wait(10)
        end
    end
end)

Citizen.CreateThread(function() -- Holding a weapon (except melee and explosives category)
    while true do
        local ped = PlayerPedId()
        local status = IsPedArmed(ped, 4)
		
        if status then
            TriggerServerEvent("stress:add", 10000)
			exports['mythic_notify']:DoHudText("inform", "+ Stress")
            Citizen.Wait(15000)
        else
            Citizen.Wait(10)
        end
    end
end)

Citizen.CreateThread(function() -- While shooting
    while true do
        local ped = PlayerPedId()
        local status = IsPedShooting(ped)
        local silenced = IsPedCurrentWeaponSilenced(ped)

        if status and not silenced then
            TriggerServerEvent("stress:add", 5000)
			exports['mythic_notify']:DoHudText("inform", "+ Stress")
            Citizen.Wait(5000)
        else
            Citizen.Wait(10)
        end
    end
end)

Citizen.CreateThread(function() -- Heard gunshot, melee hit etc., seems not to work, since player peds don't act like NPC's ?
    while true do
        local ped = PlayerPedId()
        local status = GetPedAlertness(ped)
		
        if status == 1 then
            TriggerServerEvent("stress:add", 10000)
			exports['mythic_notify']:DoHudText("inform", "+ Stress")
            Citizen.Wait(10000)
        else
            Citizen.Wait(10)
        end
    end
end)

Citizen.CreateThread(function() -- Aiming with a melee, hitting with a melee or getting hit by a melee
    while true do
        local ped = PlayerPedId()
        local status = IsPedInMeleeCombat(ped)
		
        if status then
            TriggerServerEvent("stress:add", 5000)
			exports['mythic_notify']:DoHudText("inform", "+ Stress")
            Citizen.Wait(5000)
        else
            Citizen.Wait(10)
        end
    end
end)

Citizen.CreateThread(function() -- While healt is below 100(half) TEST THIS BEFORE USE, CAN GET PROBLEMATIC
    while true do
        local ped = PlayerPedId()
        local amount = (GetEntityHealth(ped)-100)

        if amount <= 50 then
            TriggerServerEvent("stress:add", 25000)
            exports['mythic_notify']:DoHudText("inform", "+ Stress") --  Example mythic notify
            Citizen.Wait(60000)
        else
            Citizen.Wait(10)
        end
    end
end)
--]]

-- este ja estava desativado
--[[
Citizen.CreateThread(function() --  Staying still or walking
    while true do
        local ped = PlayerPedId()
        local status = IsPedStill(ped)
        local status_w = IsPedArmed(ped, 4)
        local status2 = IsPedWalking(ped)
		local status_v = IsPedInAnyVehicle(ped, false)
		
        if status and not status_w and not status_v and not GetPedStealthMovement(ped) then -- still
            Citizen.Wait(15000)
            TriggerServerEvent("stress:remove", 30000)
			exports['mythic_notify']:DoHudText("inform", "- Stress")
            Citizen.Wait(15000)
        elseif status2 and not status_w and not GetPedStealthMovement(ped) then -- walking
            Citizen.Wait(15000)
            TriggerServerEvent("stress:remove", 10000)
			exports['mythic_notify']:DoHudText("inform", "- Stress")
            Citizen.Wait(15000)
        else
            Citizen.Wait(1)
        end
    end
end)
--]]

--[[
Citizen.CreateThread(function() -- Skydiving with parachute
    while true do
        local ped = PlayerPedId()
        local status = GetPedParachuteState(ped)

        if status == 0 then -- freefall with chute (not falling without it)
            TriggerServerEvent("stress:add", 60000)
			exports['mythic_notify']:DoHudText("inform", "+ Stress")
            Citizen.Wait(5000)
        elseif status == 1 or status == 2 then -- opened chute
            TriggerServerEvent("stress:add", 5000)
			exports['mythic_notify']:DoHudText("inform", "+ Stress")
            Citizen.Wait(5000)
        else
            Citizen.Wait(5000) -- refresh rate is low on this one since it's not so common to skydive in RP servers
        end
    end
end)

Citizen.CreateThread(function() -- Sleeping animation | You can use this as a template if you want to make an animation stressful or stress reliever
    while true do
        local ped = PlayerPedId()
        local status = IsEntityPlayingAnim(ped, "timetable@tracy@sleep@", "idle_c", 3)

        if status then
            Citizen.Wait(20000)
            TriggerServerEvent("stress:remove", 100000)
			exports['mythic_notify']:DoHudText("inform", "- Stress")
        else
            Citizen.Wait(10) -- refresh rate
        end
    end
end)


function AddStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("stress:add", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("stress:add", value/seconds)
            count = count + 1
            Citizen.Wait(1000)
        until count == seconds
    end
end

function RemoveStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("stress:remove", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("stress:remove", value/seconds)
            count = count + 1
            Citizen.Wait(1000)
        until count == seconds
    end
end
--]]