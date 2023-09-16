playerLenhador = nil
coordsLenhador = {}
local JobBlipsLenhador = {}

Citizen.CreateThread(function()
    while true do
		playerLenhador = PlayerPedId()
		coordsLenhador = GetEntityCoords(playerLenhador)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlipsLenhador()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlipsLenhador()
	refreshBlipsLenhador()
end)

local chopping = false

RegisterNetEvent('tr-lumberjack:getLumberStage')
AddEventHandler('tr-lumberjack:getLumberStage', function(stage, state, k)
    Config.TreeLocations[k][stage] = state
end)

local function axe()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.Axe) do
        if pedWeapon == k then
            return true
        end
    end

	exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..Config.Alerts["error_axe"].."", 5000, 'error')
end

local function ChopLumber(k)
    local animDict = "melee@hatchet@streamed_core"
    local animName = "plyr_rear_takedown_b"
    local trClassic = PlayerPedId()
    local choptime = LumberJob.ChoppingTreeTimer
    chopping = true
    FreezeEntityPosition(trClassic, true)
	loadAnimDict(animDict)
	
	exports['progressbar']:Progress({
		name = "unique_action_name",
		duration = choptime,
		label = Config.Alerts["chopping_tree"],
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "melee@hatchet@streamed_core",
			anim = "plyr_rear_takedown_b",
		},
	}, function(status)
		if not status then
		end
	end)
	Citizen.Wait(choptime)
	TriggerServerEvent('tr-lumberjack:setLumberStage', "isOccupied", false, k)
	TriggerServerEvent('tr-lumberjack:recivelumber')
	TriggerServerEvent('tr-lumberjack:setChoppedTimer')
	chopping = false
	FreezeEntityPosition(trClassic, false)
	ClearPedTasks(trClassic)
end


RegisterNetEvent('tr-lumberjack:StartChopping')
AddEventHandler('tr-lumberjack:StartChopping', function()
    for k, v in pairs(Config.TreeLocations) do
        if not Config.TreeLocations[k]["isChopped"] then
            if axe() then
                ChopLumber(k)
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true
		
		
		if PlayerData and PlayerData.job and PlayerData.job.name == 'lenhador' then
			for k,v in pairs(Config.TreeLocations) do
				local distance = GetDistanceBetweenCoords(coordsLenhador.x, coordsLenhador.y, coordsLenhador.z, v.coords["x"], v.coords["y"], v.coords["z"], false)
				if distance <= 50 and not v["isChopped"] and not v["isOccupied"] then
					sleep = false 
					if distance >= 2.5 then 
						DrawMarker(1, v.coords["x"], v.coords["y"], v.coords["z"]-0.8, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.1, 2.1, 0.7, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					elseif distance < 2.5 then
						DrawText3Ds(v.coords["x"], v.coords["y"], v.coords["z"]-0.1, Config.Alerts["Tree_label"])
						if IsControlJustPressed(0, 38) then
							if axe() then
								ChopLumber(k)
							end
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(2000) end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true
		if PlayerData and PlayerData.job and PlayerData.job.name == 'lenhador' then
			local distance = GetDistanceBetweenCoords(coordsLenhador.x, coordsLenhador.y, coordsLenhador.z, LumberDepo.targetZone.x, LumberDepo.targetZone.y, LumberDepo.targetZone.z, false)
			if distance <= 20 then
				sleep = false 
				if distance < 3.0 then
					DrawText3Ds(LumberDepo.targetZone.x, LumberDepo.targetZone.y, LumberDepo.targetZone.z+1.2, Config.Alerts["depo_label"])
					if IsControlJustPressed(0, 38) then
						TriggerEvent("tr-lumberjack:bossmenu")
					end
				end
			end
		end
		if sleep then Citizen.Wait(2000) end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true
		if PlayerData and PlayerData.job and PlayerData.job.name == 'lenhador' then
			local distance = GetDistanceBetweenCoords(coordsLenhador.x, coordsLenhador.y, coordsLenhador.z, LumberProcessor.targetZone.x, LumberProcessor.targetZone.y, LumberProcessor.targetZone.z, false)
			if distance <= 20 then
				sleep = false 
				if distance < 3.0 then
					DrawText3Ds(LumberProcessor.targetZone.x, LumberProcessor.targetZone.y, LumberProcessor.targetZone.z+1.2, Config.Alerts["mill_label"])
					if IsControlJustPressed(0, 38) then
						TriggerEvent("tr-lumberjack:processormenu")
					end
				end
			end
		end
		if sleep then Citizen.Wait(2000) end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true
		if PlayerData and PlayerData.job and PlayerData.job.name == 'lenhador' then	
			local distance = GetDistanceBetweenCoords(coordsLenhador.x, coordsLenhador.y, coordsLenhador.z, LumberSeller.targetZone.x, LumberSeller.targetZone.y, LumberSeller.targetZone.z, false)
			if distance <= 20 then
				sleep = false 
				if distance >= 1.0 then 
					DrawMarker(2, LumberSeller.targetZone.x, LumberSeller.targetZone.y, LumberSeller.targetZone.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
				elseif distance < 1.0 then
					DrawText3Ds(LumberSeller.targetZone.x, LumberSeller.targetZone.y, LumberSeller.targetZone.z+0.9, Config.Alerts["Lumber_Seller"])
					if IsControlJustPressed(0, 38) then
						TriggerServerEvent("tr-lumberjack:sellItems")
					end
				end
			end
		end
		if sleep then Citizen.Wait(2000) end
	end
end)


RegisterNetEvent('tr-lumberjack:vehicle')
AddEventHandler('tr-lumberjack:vehicle', function()
    local vehicle = LumberDepo.Vehicle
    local coords = LumberDepo.VehicleCoords
    local TR = PlayerPedId()
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(0)
    end
    if not IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local JobVehicle = CreateVehicle(vehicle, coords, 45.0, true, false)
        SetVehicleHasBeenOwnedByPlayer(JobVehicle,  true)
        SetEntityAsMissionEntity(JobVehicle,  true,  true)
        exports['Johnny_Combustivel']:SetFuel(JobVehicle, 100.0)
        local id = NetworkGetNetworkIdFromEntity(JobVehicle)
        DoScreenFadeOut(1500)
        Wait(1500)
        SetNetworkIdCanMigrate(id, true)
        TaskWarpPedIntoVehicle(TR, JobVehicle, -1)
        --TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(JobVehicle))
        DoScreenFadeIn(1500)
        Wait(2000)
		exports['Johnny_Notificacoes']:Alert("LENHADOR", "<span style='color:#c7c7c7'>"..Config.Alerts["phone_message"].."</span>", 10000, 'info')
    else
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..Config.Alerts["depo_blocked"].."</span>", 5000, 'error')
    end
end)

RegisterNetEvent('tr-lumberjack:removevehicle')
AddEventHandler('tr-lumberjack:removevehicle', function()
    local TR92 = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(TR92,true)
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
	local plate = GetVehicleNumberPlateText(vehicle)
	--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
	exports['qs-vehiclekeys']:RemoveKeysAuto()
    DeleteVehicle(vehicle)
	exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..Config.Alerts["depo_stored"].."</span>", 5000, 'success')
end)

RegisterNetEvent('tr-lumberjack:getaxe')
AddEventHandler('tr-lumberjack:getaxe', function()
    TriggerServerEvent('tr-lumberjack:BuyAxe')
end)

RegisterNetEvent('tr-lumberjack:bossmenu')
AddEventHandler('tr-lumberjack:bossmenu', function()
	local content = {
        {label = Config.Alerts["vehicle_get"], value = 'get_vehicle'},
        {label = Config.Alerts["vehicle_remove"], value = 'remove_vehicle'},
        {label = Config.Alerts["battleaxe_label"], value = 'get_axe'},
        {label = 'Roupa Normal', value = 'cloakroom2'},
		{label = 'Roupa de Trabalho', value = 'cloakroom'},
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'bossmenu',
	{
		title    = Config.Alerts["vehicle_header"],
		align    = 'top-left',
		elements = content,
	},
	function(data, menu)
		if data.current.value == 'get_vehicle' then
			TriggerEvent('tr-lumberjack:vehicle')
		end
		
		if data.current.value == 'remove_vehicle' then
			TriggerEvent('tr-lumberjack:removevehicle')
		end
		
		if data.current.value == 'get_axe' then
			TriggerEvent('tr-lumberjack:getaxe')
		end
		
		if data.current.value == 'cloakroom' then
			menu.close()
			setUniformLenhador(data.current.value)
		end
		
		if data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end

		menu.close()
	end,
	function(data, menu)
		menu.close()
	end)
end)

function setUniformLenhador(job)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.LenhadorUniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.LenhadorUniforms[job].male)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		else
			if Config.LenhadorUniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.LenhadorUniforms[job].female)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		end
	end)
end

RegisterNetEvent('tr-lumberjack:processormenu')
AddEventHandler('tr-lumberjack:processormenu', function()
    local content = {
        {label = Config.Alerts["lumber_header"], value = 'processor'},
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'processormenu',
	{
		title    = Config.Alerts["lumber_mill"],
		align    = 'top-left',
		elements = content,
	},
	function(data, menu)
		if data.current.value == 'processor' then
			TriggerEvent('tr-lumberjack:processor')
		end

		menu.close()
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('tr-lumberjack:processor')
AddEventHandler('tr-lumberjack:processor', function()
    ESX.TriggerServerCallback('tr-lumberjack:lumber', function(lumber)
		if lumber then
			ExecuteCommand('e clipboard')
			
			exports['progressbar']:Progress({
				name = "unique_action_name",
				duration = LumberJob.ProcessingTime,
				label = Config.Alerts["lumber_progressbar"],
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
			}, function(status)
				if status then
					exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..Config.Alerts["cancel"].."</span>", 5000, 'error')
				end
			end)
			Citizen.Wait(LumberJob.ProcessingTime)
			TriggerServerEvent("tr-lumberjack:lumberprocessed")
			ClearPedTasks(PlayerPedId())
			for _, v in pairs(GetGamePool('CObject')) do
                if IsEntityAttachedToEntity(PlayerPedId(), v) then
                    print(v)
					SetEntityAsMissionEntity(v, true, true)
                    DeleteObject(v)
                end
            end
		elseif not lumber then
			exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..Config.Alerts["error_lumber"].."</span>", 5000, 'error')
		end
    end)
end)

local ClassicMan = LumberDepo.coords
local LumberTR = LumberProcessor.coords
local sellClassic = LumberSeller.coords
local ClassicPed = LumberJob.LumberModel
local ClassicHash = LumberJob.LumberHash

CreateThread(function()
    RequestModel( GetHashKey( ClassicPed ) )
    while ( not HasModelLoaded( GetHashKey( ClassicPed ) ) ) do
        Wait(1)
    end
    lumberjack1 = CreatePed(1, ClassicHash, ClassicMan, false, true)
    lumberjack2 = CreatePed(1, ClassicHash, LumberTR, false, true)
    lumberjack3 = CreatePed(1, ClassicHash, sellClassic, false, true)
    SetEntityInvincible(lumberjack1, true)
    SetBlockingOfNonTemporaryEvents(lumberjack1, true)
    FreezeEntityPosition(lumberjack1, true)
    SetEntityInvincible(lumberjack2, true)
    SetBlockingOfNonTemporaryEvents(lumberjack2, true)
    FreezeEntityPosition(lumberjack2, true)
    SetEntityInvincible(lumberjack3, true)
    SetBlockingOfNonTemporaryEvents(lumberjack3, true)
    FreezeEntityPosition(lumberjack3, true)
end)

function refreshBlipsLenhador()
	if PlayerData and PlayerData.job.name == 'lenhador' then
        LDBlip = AddBlipForCoord(LumberDepo.coords)
        SetBlipSprite (LDBlip, LumberDepo.SetBlipSprite)
        SetBlipDisplay(LDBlip, LumberDepo.SetBlipDisplay)
        SetBlipScale  (LDBlip, LumberDepo.SetBlipScale)
        SetBlipAsShortRange(LDBlip, true)
        SetBlipColour(LDBlip, LumberDepo.SetBlipColour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(LumberDepo.BlipLabel)
        EndTextCommandSetBlipName(LDBlip)
		table.insert(JobBlipsLenhador, LDBlip)
        
        LJPBlip = AddBlipForCoord(LumberProcessor.coords)
        SetBlipSprite (LJPBlip, LumberProcessor.SetBlipSprite)
        SetBlipDisplay(LJPBlip, LumberProcessor.SetBlipDisplay)
        SetBlipScale  (LJPBlip, LumberProcessor.SetBlipScale)
        SetBlipAsShortRange(LJPBlip, true)
        SetBlipColour(LJPBlip, LumberProcessor.SetBlipColour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(LumberProcessor.BlipLabel)
        EndTextCommandSetBlipName(LJPBlip)
		table.insert(JobBlipsLenhador, LJPBlip)

        LJSBlip = AddBlipForCoord(LumberSeller.coords)
        SetBlipSprite (LJSBlip, LumberSeller.SetBlipSprite)
        SetBlipDisplay(LJSBlip, LumberSeller.SetBlipDisplay)
        SetBlipScale  (LJSBlip, LumberSeller.SetBlipScale)
        SetBlipAsShortRange(LJSBlip, true)
        SetBlipColour(LJSBlip, LumberSeller.SetBlipColour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(LumberSeller.BlipLabel)
        EndTextCommandSetBlipName(LJSBlip)
		table.insert(JobBlipsLenhador, LJSBlip)

        LJTR = AddBlipForCoord(vector3(-516.4, 5405.45, 73.95))
        SetBlipSprite (LJTR, 79)
        SetBlipDisplay(LJTR, 6)
        SetBlipScale  (LJTR, 0.65)
        SetBlipAsShortRange(LJTR, true)
        SetBlipColour(LJTR, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Campo de Árvores")
        EndTextCommandSetBlipName(LJTR)
		table.insert(JobBlipsLenhador, LJTR)

        LJTR2 = AddBlipForCoord(vector3(-626.4, 5395.08, 52.16))
        SetBlipSprite (LJTR2, 79)
        SetBlipDisplay(LJTR2, 6)
        SetBlipScale  (LJTR2, 0.65)
        SetBlipAsShortRange(LJTR2, true)
        SetBlipColour(LJTR2, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Campo de Árvores")
        EndTextCommandSetBlipName(LJTR2)
		table.insert(JobBlipsLenhador, LJTR2)

        LJTR3 = AddBlipForCoord(vector3(-645.9, 5275.29, 72.41))
        SetBlipSprite (LJTR3, 79)
        SetBlipDisplay(LJTR3, 6)
        SetBlipScale  (LJTR3, 0.65)
        SetBlipAsShortRange(LJTR3, true)
        SetBlipColour(LJTR3, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Campo de Árvores")
        EndTextCommandSetBlipName(LJTR3)
		table.insert(JobBlipsLenhador, LJTR3)

        LJTR4 = AddBlipForCoord(vector3(-544.46, 5227.5, 75.55))
        SetBlipSprite (LJTR4, 79)
        SetBlipDisplay(LJTR4, 6)
        SetBlipScale  (LJTR4, 0.65)
        SetBlipAsShortRange(LJTR4, true)
        SetBlipColour(LJTR4, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Campo de Árvores")
        EndTextCommandSetBlipName(LJTR4)
		table.insert(JobBlipsLenhador, LJTR4)
    end
end

function deleteBlipsLenhador()
	for k,v in ipairs(JobBlipsLenhador) do
		RemoveBlip(v)
		JobBlipsLenhador[k] = nil
	end
end