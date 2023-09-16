playerMineiro = nil
coordsMineiro = {}
local JobBlipsMineiro = {}

Citizen.CreateThread(function()
    while true do
		playerMineiro = PlayerPedId()
		coordsMineiro = GetEntityCoords(playerMineiro)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlipsMineiro()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlipsMineiro()
	refreshBlipsMineiro()
end)

function deleteBlipsMineiro()
	for k,v in ipairs(JobBlipsMineiro) do
		RemoveBlip(v)
		JobBlipsMineiro[k] = nil
	end
end

function refreshBlipsMineiro()
	if PlayerData and PlayerData.job.name == 'mineiro' then
		for k,v in pairs(Config.Mining) do
			local bp = v.blip
			if bp.enable then
				local blip = AddBlipForCoord(v.pos[1], v.pos[2], v.pos[3])
				SetBlipSprite(blip, bp.sprite)
				SetBlipDisplay(blip, bp.display)
				SetBlipScale  (blip, bp.scale)
				SetBlipColour (blip, bp.color)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(bp.str)
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlipsMineiro, blip)
			end
		end
		
		for k,v in pairs(Config.Washing) do
			local bp = v.blip
			if bp.enable then
				local blip = AddBlipForCoord(v.pos[1], v.pos[2], v.pos[3])
				SetBlipSprite(blip, bp.sprite)
				SetBlipDisplay(blip, bp.display)
				SetBlipScale  (blip, bp.scale)
				SetBlipColour (blip, bp.color)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(bp.str)
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlipsMineiro, blip)
			end
		end
		
		for k,v in pairs(Config.Smelting) do
			local bp = v.blip
			if bp.enable then
				local blip = AddBlipForCoord(v.pos[1], v.pos[2], v.pos[3])
				SetBlipSprite(blip, bp.sprite)
				SetBlipDisplay(blip, bp.display)
				SetBlipScale  (blip, bp.scale)
				SetBlipColour (blip, bp.color)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(bp.str)
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlipsMineiro, blip)
			end
		end

		for k,v in pairs(Config.SellMineiro) do
			local bp = v.blip
			if bp.enable then
				local blip = AddBlipForCoord(v.pos[1], v.pos[2], v.pos[3])
				SetBlipSprite(blip, bp.sprite)
				SetBlipDisplay(blip, bp.display)
				SetBlipScale  (blip, bp.scale)
				SetBlipColour (blip, bp.color)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(bp.str)
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlipsMineiro, blip)
			end
		end
	end
end

local veiculoMineiro = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true

		if PlayerData and PlayerData.job and PlayerData.job.name == 'mineiro' then
			for k,v in pairs(Config.MineiroVeiculo) do
				local distance = GetDistanceBetweenCoords(coordsMineiro.x, coordsMineiro.y, coordsMineiro.z, v.pos[1], v.pos[2], v.pos[3], false)
				local mk = v.marker
				if distance <= mk.drawDist then
					sleep = false 
					if distance >= 5.0 and mk.enable then 
						DrawMarker(mk.type, v.pos[1], v.pos[2], v.pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 5.0 then
						if DoesEntityExist(veiculoMineiro) then 
							DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], '~b~[E]~s~ Guardar Veículo')
						else
							DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], '~b~[E]~s~ Retirar Veículo')
						end
						
						if IsControlJustPressed(0, v.keybind) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'veiculo_mineiro') then
							if DoesEntityExist(veiculoMineiro) then 
								local model = GetDisplayNameFromVehicleModel(GetEntityModel(veiculoMineiro))
								local plate = GetVehicleNumberPlateText(veiculoMineiro)
								--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
								exports['qs-vehiclekeys']:RemoveKeysAuto()
								DeleteVehicle(veiculoMineiro)
								veiculoMineiro = nil
							else
								VeiculoMineiro()
							end
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

function VeiculoMineiro()

	local elements = {
		{label = 'Veiculo Empresa', value = 'rubble'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'veiculo_mineiro',
    {
      title    = 'Garagem Empresa',
	  align    = 'top-left',
      elements = elements
    },
    function(data, menu)  
		menu.close()
		SpawnMineiroVeiculo(data.current.value)
    end,
    function(data, menu)
		menu.close()
    end)
end

function SpawnMineiroVeiculo(model)
	local vehicleHash = GetHashKey(model)
	RequestModel(vehicleHash)
	while not HasModelLoaded(vehicleHash) do
		Citizen.Wait(0)
	end
	
	local ped = PlayerPedId()
	veiculoMineiro = CreateVehicle(vehicleHash, 2828.049, 2797.435, 57.641, 176.79083251953, true, false)
	local id = NetworkGetNetworkIdFromEntity(veiculoMineiro)
	SetNetworkIdCanMigrate(id, true)
	SetNetworkIdExistsOnAllMachines(id, true)
	SetVehicleDirtLevel(veiculoMineiro, 0)
	SetVehicleHasBeenOwnedByPlayer(veiculoMineiro, true)
	SetEntityAsMissionEntity(veiculoMineiro, true, true)
	SetVehicleEngineOn(veiculoMineiro, true)
	local plate = 'MINE' .. math.random(100, 900)
	SetVehicleNumberPlateText(veiculoMineiro, plate)
	exports["Johnny_Combustivel"]:SetFuel(veiculoMineiro, 100)
	exports['qs-vehiclekeys']:GiveKeysAuto()
	--TriggerServerEvent('vehiclekeys:server:givekey', plate, model)
	TaskWarpPedIntoVehicle(ped, veiculoMineiro, -1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true

		if PlayerData and PlayerData.job and PlayerData.job.name == 'mineiro' then
			for k,v in pairs(Config.MineiroVestiario) do
				local distance = GetDistanceBetweenCoords(coordsMineiro.x, coordsMineiro.y, coordsMineiro.z, v.pos[1], v.pos[2], v.pos[3], false)
				local mk = v.marker
				if distance <= mk.drawDist then
					sleep = false 
					if distance >= 2.0 and mk.enable then 
						DrawMarker(mk.type, v.pos[1], v.pos[2], v.pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 2.0 then
						DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], v.drawText)
						if IsControlJustPressed(0, v.keybind) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'roupeiro_mineiro') then
							VestiarioMineiro()
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

function VestiarioMineiro()

	local elements = {
		{label = 'Roupa Normal', value = 'cloakroom2'},
		{label = 'Roupa de Mineiro', value = 'cloakroom'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'roupeiro_mineiro',
    {
      title    = 'Vestiário',
	  align    = 'top-left',
      elements = elements
    },
    function(data, menu)  
		if data.current.value == 'cloakroom' then
			menu.close()
			setUniformMineiro(data.current.value)
		end

		if data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end
    end,
    function(data, menu)
		menu.close()
    end)
end

function setUniformMineiro(job)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.MineiroUniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.MineiroUniforms[job].male)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		else
			if Config.MineiroUniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.MineiroUniforms[job].female)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		end
	end)
end

local plyMining = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true

		if PlayerData and PlayerData.job and PlayerData.job.name == 'mineiro' then
			for k,v in pairs(Config.Mining) do
				local distance = GetDistanceBetweenCoords(coordsMineiro.x, coordsMineiro.y, coordsMineiro.z, v.pos[1], v.pos[2], v.pos[3], false)
				local mk = v.marker
				if distance <= mk.drawDist and not plyMining and not v.inUse then
					sleep = false 
					if distance >= 1.0 and mk.enable then 
						DrawMarker(mk.type, v.pos[1], v.pos[2], v.pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 1.0 then
						DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], v.drawText)
						if IsControlJustPressed(0, v.keybind) then
							plyMining = true
							OpenMiningFunction(k,v)
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

local mining = false
function OpenMiningFunction(id,val)
	local ped = PlayerPedId()
	ESX.TriggerServerCallback('t1ger_minerjob:getInventoryItem', function(hasItem) 
		if hasItem then
			-- update spot state:
			TriggerServerEvent('t1ger_minerjob:mineSpotStateSV', id, true)

			-- prepare for mining:
			FreezeEntityPosition(playerMineiro, true)
			SetCurrentPedWeapon(playerMineiro, GetHashKey('WEAPON_UNARMED'))
			Citizen.Wait(200)

			-- Load pickaxe:
			local pickaxeObj = GetHashKey('prop_tool_pickaxe')
			loadModel(pickaxeObj)
			
			-- Create obj and attach to player:
			local object = CreateObject(pickaxeObj, coordsMineiro.x, coordsMineiro.y, coordsMineiro.z, true, false, false)
			AttachEntityToEntity(object, playerMineiro, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
			
			mining = true
			SetEntityCoords(playerMineiro, val.pos[1], val.pos[2], val.pos[3] - 0.975)
			SetEntityHeading(ped,  val.pos[4])
			local anim = {dict = 'melee@hatchet@streamed_core_fps', lib = 'plyr_front_takedown'}
			
			while mining do
				Wait(0)
				ShowHelpNotification(LangMineiro['mining_info'])
				DisableControlAction(0, 24, true)
				if IsDisabledControlJustReleased(0, 24) then
					local dict = loadAnimDict(anim.dict)
					TaskPlayAnim(playerMineiro, anim.dict, anim.lib, 8.0, -8.0, -1, 2, 0, false, false, false)

					local timer = GetGameTimer() + 800
					while GetGameTimer() <= timer do Wait(0) DisableControlAction(0, 24, true) end
					local amount = math.random(Config.MiningReward.min, Config.MiningReward.max)
					TriggerServerEvent('t1ger_minerjob:miningReward', Config.DatabaseItemsMineiro['stone'], amount)
				elseif IsControlJustReleased(0, 194) then
					break
				end
			end
			mining = false
			DeleteObject(object)
			FreezeEntityPosition(playerMineiro, false)
			ClearPedTasks(playerMineiro)
			TriggerServerEvent('t1ger_minerjob:mineSpotStateSV', id, false)
			plyMining = false
		else
			ShowNotification(LangMineiro['no_pickaxe'], 'error')
			plyMining = false
		end
	end, Config.DatabaseItemsMineiro['pickaxe'], 1)
end

-- Mining Spot State:
RegisterNetEvent('t1ger_minerjob:mineSpotStateCL')
AddEventHandler('t1ger_minerjob:mineSpotStateCL', function(id, state)
	Config.Mining[id].inUse = state
end)

local plyWashing = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true

		if PlayerData and PlayerData.job and PlayerData.job.name == 'mineiro' then
			for k,v in pairs(Config.Washing) do
				local distance = GetDistanceBetweenCoords(coordsMineiro.x, coordsMineiro.y, coordsMineiro.z, v.pos[1], v.pos[2], v.pos[3], false)
				local mk = v.marker
				if distance <= mk.drawDist and not plyWashing then
					sleep = false 
					if distance >= 2.1 and mk.enable then 
						DrawMarker(mk.type, v.pos[1], v.pos[2], v.pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 2.1 then
						DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], v.drawText)
						if IsControlJustPressed(0, v.keybind) then
							plyWashing = true
							OpenWashingFunction(k,v)
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

-- Function to wash stone:
function OpenWashingFunction(id,val)
	ESX.TriggerServerCallback('t1ger_minerjob:removeItem', function(itemRemoved)

		-- prepare for washing:
		FreezeEntityPosition(playerMineiro, true)
		SetCurrentPedWeapon(playerMineiro, GetHashKey('WEAPON_UNARMED'))
		Citizen.Wait(200)

		if itemRemoved then
			if Config.ProgressBars then
				exports['progressbar']:Progress({
					name = "unique_action_name",
					duration = 10000,
					label = LangMineiro['pb_washing'],
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
						
					end
				end)
			end
			TaskStartScenarioInPlace(playerMineiro, "PROP_HUMAN_BUM_BIN", 0, true)
			Citizen.Wait(10000)
			-- Reward:
			local amount = math.random(Config.WashSettings.output.min, Config.WashSettings.output.max)
			TriggerServerEvent('t1ger_minerjob:washingReward', Config.DatabaseItemsMineiro['washed_stone'], amount)
		else
			ShowNotification(LangMineiro['not_enough_stone'], 'error')
		end

		-- Clean Up:
		ClearPedTasks(playerMineiro)
		FreezeEntityPosition(playerMineiro, false)
		plyWashing = false

	end, Config.DatabaseItemsMineiro['stone'], Config.WashSettings.input)
end

local plySmelting = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true

		if PlayerData and PlayerData.job and PlayerData.job.name == 'mineiro' then
			for k,v in pairs(Config.Smelting) do
				local distance = GetDistanceBetweenCoords(coordsMineiro.x, coordsMineiro.y, coordsMineiro.z, v.pos[1], v.pos[2], v.pos[3], false)
				local mk = v.marker
				if distance <= mk.drawDist and not plySmelting then
					sleep = false 
					if distance >= 1.25 and mk.enable then 
						DrawMarker(mk.type, v.pos[1], v.pos[2], v.pos[3] - 0.975, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 1.25 then
						DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], v.drawText)
						if IsControlJustPressed(0, v.keybind) then
							plySmelting = true
							OpenSmeltingFunction(k,v)
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

-- Function to smelth wash stone:
function OpenSmeltingFunction(id,val)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance >= 0.7 then

		ESX.TriggerServerCallback('t1ger_minerjob:removeItem', function(itemRemoved)
			-- prepare for smelting:
			FreezeEntityPosition(playerMineiro, true)
			SetEntityHeading(PlayerPedId(),  val.pos[4])
			SetCurrentPedWeapon(playerMineiro, GetHashKey('WEAPON_UNARMED'))
			Citizen.Wait(200)
			if itemRemoved then
				if Config.ProgressBars then 
					exports['progressbar']:Progress({
						name = "unique_action_name",
						duration = 10000,
						label = LangMineiro['pb_smelting'],
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
							
						end
					end)
				end
				Citizen.Wait(10000)
				-- Reward:
				TriggerServerEvent('t1ger_minerjob:smeltingReward')
			else
				ShowNotification(LangMineiro['not_enough_washed_stone'], 'error')
			end
			-- Clean Up:
			ClearPedTasks(playerMineiro)
			FreezeEntityPosition(playerMineiro, false)
			plySmelting = false
		end, Config.DatabaseItemsMineiro['washed_stone'], Config.SmeltingSettings.input)

	else
		ShowNotification(LangMineiro['player_too_close'], 'error')
		plySmelting = false
	end	
end

local plySellingMineiro = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local sleep = true

		if PlayerData and PlayerData.job and PlayerData.job.name == 'mineiro' then	
			for k,v in pairs(Config.SellMineiro) do
				local distance = GetDistanceBetweenCoords(coordsMineiro.x, coordsMineiro.y, coordsMineiro.z, v.pos[1], v.pos[2], v.pos[3], false)
				local mk = v.marker
				if distance <= mk.drawDist and not plySellingMineiro then
					sleep = false 
					if distance >= 1.25 and mk.enable then 
						DrawMarker(mk.type, v.pos[1], v.pos[2], v.pos[3] - 0.975, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 1.25 then
						DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], v.drawText)
						if IsControlJustPressed(0, v.keybind) then
							plySellingMineiro = true
							OpenSellMineiroFunction(k,v)
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

-- Function to smelth wash stone:
function OpenSellMineiroFunction(id,val)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance >= 0.7 then
		ESX.TriggerServerCallback('t1ger_minerjob:temItemsParaVender', function(itemsParaVender)
			Citizen.Wait(200)
			if itemsParaVender then
				-- prepare for smelting:
				FreezeEntityPosition(playerMineiro, true)
				SetEntityHeading(PlayerPedId(),  val.pos[4])
				SetCurrentPedWeapon(playerMineiro, GetHashKey('WEAPON_UNARMED'))
				
				if Config.ProgressBars then 
					exports['progressbar']:Progress({
						name = "unique_action_name",
						duration = 10000,
						label = LangMineiro['pb_selling'],
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
							
						end
					end)
				end
				Citizen.Wait(10000)
				-- Reward:
				TriggerServerEvent('t1ger_minerjob:vendaItensMineracao')
			else
				ShowNotification(LangMineiro['not_enough_minerios'], 'error')
			end
			-- Clean Up:
			ClearPedTasks(playerMineiro)
			FreezeEntityPosition(playerMineiro, false)
			plySellingMineiro = false
		end)

	else
		ShowNotification(LangMineiro['player_too_close'], 'error')
		plySellingMineiro = false
	end	
end