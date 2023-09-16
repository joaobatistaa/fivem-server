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

PlayerData              = {}

local IsHandcuffed            = false
local HandcuffTimer           = {}
local DragStatus              = {}
DragStatus.IsDragged          = false

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
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

function MenuRoupa()
	ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
		local elements = {}

		for i=1, #dressing, 1 do
			table.insert(elements, {label = dressing[i], value = i})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
			title    = 'Vestiário',
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
		
			TriggerEvent('skinchanger:getSkin', function(skin)

				ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)

					TriggerEvent('skinchanger:loadClothes', skin, clothes)
					TriggerEvent('esx_skin:setLastSkin', skin)

					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
					end)
			  
					HasLoadCloth = true
				end, data.current.value)
			end)
			
		end, function(data, menu)
			menu.close()
			
			CurrentAction = 'menu_cloakroom'
		end)
	end)
end

function MenuRevistar(player)
	TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", GetPlayerServerId(player))
end

function MenuVerIdentidade(player)
	ESX.TriggerServerCallback('esx_gangsjob:getOtherPlayerData', function(data)

		local elements    = {}
		
		local nameLabel   = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
		
	
		nameLabel = 'Nome: ' ..data.firstname .. ' ' .. data.lastname

		if data.sex ~= nil then
			if string.lower(data.sex) == 'm' then
				sexLabel = 'Sexo: Masculino'
			else
				sexLabel = 'Sexo: Feminino'
			end
		else
			sexLabel = 'Sexo: Desconhecido'
		end

		if data.dob ~= nil then
			dobLabel = 'Data Nasc: ' ..data.dob
		else
			dobLabel = 'Data Nasc: Desconhecida'
		end

		if data.height ~= nil then
			heightLabel = 'Altura: ' ..data.height
		else
			heightLabel = 'Altura: Desconhecida'
		end

	
		local elements = {
			{label = nameLabel, value = nil},
		}
	
		table.insert(elements, {label = sexLabel, value = nil})
		table.insert(elements, {label = dobLabel, value = nil})
		table.insert(elements, {label = heightLabel, value = nil})
	
		if data.drunk ~= nil then
			table.insert(elements, {label = 'Taxa de Álcool: '.. data.drunk, value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = '--------- Licenças --------', value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = '🤵 Cartão de Cidadão',
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))
end

RegisterNetEvent('esx_gangsjob:handcuff')
AddEventHandler('esx_gangsjob:handcuff', function()

    ped = PlayerPedId()
    
    RequestAnimDict(dict)
    

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    if IsHandcuffed then

        ClearPedTasks(ped)
		
        SetEnableHandcuffs(ped, false)
        

        UncuffPed(ped)

        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
			
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end
        
		ESX.ClearTimeout(HandcuffTimer.task)
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
		
		if HandcuffTimer.active then
			ESX.ClearTimeout(HandcuffTimer.task)
		end

		StartHandcuffTimer()
        
    end

    IsHandcuffed = not IsHandcuffed

    changed = true
end)

function StartHandcuffTimer()
	if HandcuffTimer.active then
		ESX.ClearTimeout(HandcuffTimer.task)
	end

	HandcuffTimer.active = true

	HandcuffTimer.task = ESX.SetTimeout(30 * 60000, function()
		exports['mythic_notify']:DoHudText('error', 'As tuas algemas foram removidas, para prevenir abusos, pois estás algemado à 30m. Caso estejas em RP, deves simular que estás algemado!')
		TriggerEvent('esx_gangsjob:unrestrain')
		HandcuffTimer.active = false
	end)
end

RegisterNetEvent('esx_gangsjob:unrestrain')
AddEventHandler('esx_gangsjob:unrestrain', function()
	ped = PlayerPedId()
    
    RequestAnimDict(dict)
    

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    if IsHandcuffed then

        ClearPedTasks(ped)
		
        SetEnableHandcuffs(ped, false)
        

        UncuffPed(ped)

        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
			
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end
		
		-- end timer
		if HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
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

RegisterNetEvent('esx_gangsjob:drag')
AddEventHandler('esx_gangsjob:drag', function(copID)
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

RegisterNetEvent('esx_gangsjob:putInVehicle')
AddEventHandler('esx_gangsjob:putInVehicle', function()
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

RegisterNetEvent('esx_gangsjob:OutVehicle')
AddEventHandler('esx_gangsjob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

Citizen.CreateThread(function()
    while true do
       
        Citizen.Wait(0)
        
        ped = PlayerPedId()
        
        if IsHandcuffed then
            
            DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
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
            
            if IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
            
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

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_gangsjob:unrestrain')

		if HandcuffTimer.active then
			ESX.ClearTimeout(HandcuffTimer.task)
		end
	end
end)