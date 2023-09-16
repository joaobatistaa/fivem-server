local HasAlreadyEnteredMarkerMecanico, LastZoneMecanico = false, nil
local CurrentActionMecanico, CurrentActionMsgMecanico, CurrentActionDataMecanico = nil, '', {}
local isBusyMecanico = false
local editModeMecanico = false

function MenuGestaoNorauto()
	local elements = {
		{label = '🚗 Garagem Norauto',   value = 'vehicle_list'},
		--{label = '👕 Roupa Normal',       value = 'cloakroom2'},
		{label = '👕 Roupas Guardadas',      value = 'cloakroom'},
		--{label = '🔧 Ferramentas', value = 'menu_ferramentas'},
		{label = '🔒 Cofre', value = 'cofre'},
		--{label = '🧰 Kit de Reparação', value = 'get_kit'}
	}

	if PlayerData.job and PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = '💼 Gestão da Empresa', value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = '🔧 Menu Norauto',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then

				local elements = {
					{label = 'Peugeot Carrinha Norauto',  value = 'norauto'},
					{label = 'Mercedes-Benz 4Matic', value = 'trans_mbxclass'},
					{label = 'Mercedes Sprinter', value = 'rumpo'},
					{label = 'Carrinha Ford', value = 'norauto_transit'},
					{label = 'Carrinha Ford 2', value = 'ftpv'},
					{label = 'Reboque', value = 'flatbedm2'},
				}
				
				if PlayerData.job and PlayerData.job.grade_name == 'boss' then
					table.insert(elements, {label = 'SlamVan', value = 'slamvan'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = 'Garagem Norauto',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					ESX.Game.SpawnVehicle(data2.current.value, Config.MechanicBlips.VehicleSpawnPoint.Pos, 182.02, function(vehicle)
						local playerPed = PlayerPedId()
						exports["Johnny_Combustivel"]:SetFuel(vehicle, 100)
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					end)

					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
		elseif data.current.value == 'cloakroom' then
			menu.close()
			ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
				  local elements = {}

				  for i=1, #dressing, 1 do
					table.insert(elements, {label = dressing[i], value = i})
				  end

				  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
					  title    = 'Roupas Guardadas',
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
						  
								exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Roupa <span style='color:#069a19'>carregada</span> com sucesso!", 3000, 'success')

							end, data.current.value)
						end)
					end, function(data, menu)
					  menu.close()
					end)
				end)
		elseif data.current.value == 'menu_ferramentas' then
			OpenMenuMechTools()
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'cofre' then
			TriggerServerEvent("inventory:server:OpenInventory", "stash", "norauto")
			TriggerEvent("inventory:client:SetCurrentStash", "norauto")
			menu.close()
		elseif data.current.value == 'get_kit' then
			DarKitsReparacao()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function DarKitsReparacao()
	local player = GetPlayerPed(-1)
    local item = 'fixtool'

	TriggerServerEvent('esx_mechanicjob:darItem', item, 1)
end

function setUniformNorauto(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.MechanicUniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.MechanicUniforms[job].male)
			else
				exports['mythic_notify']:DoHudText('error', 'Roupa de trabalho masculina não configurada!')
			end
		else
			if Config.MechanicUniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.MechanicUniforms[job].female)
			else
				exports['mythic_notify']:DoHudText('error', 'Roupa de trabalho feminina não configurada!')
			end

		end
	end)
end

function MenuF6Norauto()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
		title    = '🔧 Menu Norauto',
		align    = 'top-left',
		elements = {
			--{label = '📝 Faturamento',       value = 'billing'},
			{label = '💻 Menu Revisão',        value = 'revisao_vehicle'},
			{label = '🔨 Arrombar',        value = 'hijack_vehicle'},
			{label = '🧰 Reparar',        value = 'fix_vehicle'},
			{label = '🧽 Limpar',         value = 'clean_vehicle'},
			{label = '⚠️ Apreender Veículo',       value = 'del_vehicle'},
			{label = '⚓ Rebocar (Mercedes Prancha)', value = 'rebocar_vehicle'},
			{label = '📦 Objetos de trabalho', value = 'object_spawner'},
			{label = '🔧 Ferramentas', value = 'menu_ferramentas'}
	}}, function(data, menu)
		if isBusyMecanico then return end

		if data.current.value == 'billing' then
			ESX.UI.Menu.CloseAll()
			local razaoFatura
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'razao_fatura', { title = "Introduza a razão da fatura:" }, function(data, menu)
				razaoFatura = data.value
				if razaoFatura == nil then
					ESX.ShowNotification("Razão Inválida!")
				else
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'preco_fatura', { title = "Introduza o valor da fatura:" }, function(data2, menu2)
						local preco = tonumber(data2.value)
						if preco == nil or preco < 0 or preco == 0 then
							ESX.ShowNotification("Montante Inválido!")
						else
							--TriggerServerEvent("okokBilling:createInvoicePlayer", data)
							TriggerServerEvent("okokBilling:CreateCustomInvoice", GetPlayerServerId(closestPlayer), preco, razaoFatura, 'Norauto', 'society_mechanic', '🔧 Norauto')
							exports['mythic_notify']:DoHudText('inform', 'Fatura enviada com sucesso!')
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
		elseif data.current.value == 'revisao_vehicle' then
			ExecuteCommand('menutunning')
			menu.close()
		elseif data.current.value == 'hijack_vehicle' then
			menu.close()
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoHudText('error', 'Tens que sair do veículo!')
				return
			end

			if DoesEntityExist(vehicle) then
				isBusyMecanico = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				exports['progressbar']:Progress({
					name = "destrancar_vehicle",
					duration = 15000,
					label = "A destrancar veículo...",
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
						SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
						
						isBusyMecanico = false
						
						exports['mythic_notify']:DoHudText('success', 'Veículo destrancado!')
						ClearPedTasks(playerPed)
					else
						exports['mythic_notify']:DoHudText('inform', 'Cancelaste a ação!')
					end
				end)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há veículos por perto!')
			end
		elseif data.current.value == 'fix_vehicle' then
			menu.close()
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoHudText('error', 'Tens que sair do veículo!')
				return
			end

			if DoesEntityExist(vehicle) then
				isBusyMecanico = true
				ExecuteCommand('e mecanico')
				exports['progressbar']:Progress({
					name = "fix_vehicle",
					duration = 20000,
					label = "A reparar veículo...",
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
						SetVehicleFixed(vehicle)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleUndriveable(vehicle, false)
						SetVehicleEngineOn(vehicle, true, true)
						
						isBusyMecanico = false
						
						exports['mythic_notify']:DoHudText('success', 'Veículo reparado!')
						ClearPedTasks(playerPed)
					else
						exports['mythic_notify']:DoHudText('inform', 'Cancelaste a reparação!')
					end
				end)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há veículos por perto!')
			end
		elseif data.current.value == 'clean_vehicle' then
			menu.close()
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoHudText('error', 'Tens que sair do veículo!')
				return
			end

			if DoesEntityExist(vehicle) then
				isBusyMecanico = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				exports['progressbar']:Progress({
					name = "clean_vehicle",
					duration = 10000,
					label = "A limpar veículo...",
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
						SetVehicleDirtLevel(vehicle, 0)
						
						isBusyMecanico = false
					
						exports['mythic_notify']:DoHudText('success', 'Veículo limpo!')
						ClearPedTasks(playerPed)
					else
						exports['mythic_notify']:DoHudText('inform', 'Cancelaste a limpeza!')
					end
				end)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há veículos por perto!')
			end
		elseif data.current.value == 'del_vehicle' then
			menu.close()
			local playerPed = PlayerPedId()

			local vehicle = ESX.Game.GetVehicleInDirection()
			
			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoHudText('error', 'Tens que sair do veículo!')
				return
			end
			
			if DoesEntityExist(vehicle) then
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				exports['progressbar']:Progress({
					name = "apreender_vehicle",
					duration = 15000,
					label = "A apreender veículo...",
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
						ESX.Game.DeleteVehicle(vehicle)		
						isBusyMecanico = false
						exports['mythic_notify']:DoHudText('success', 'Veículo apreendido!')
						ClearPedTasks(playerPed)
					else
						exports['mythic_notify']:DoHudText('inform', 'Cancelaste a apreensão!')
					end
				end)	
			else
				exports['mythic_notify']:DoHudText('error', 'Não há veículos por perto!')
			end
		elseif data.current.value == 'rebocar_vehicle' then
			menu.close()
			ExecuteCommand('rebocar')
		elseif data.current.value == 'menu_ferramentas' then
			OpenMenuMechTools()
		elseif data.current.value == 'object_spawner' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				exports['mythic_notify']:DoHudText('error', 'Tens que sair do veículo!')
				return
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions_spawn', {
				title    = '📦 Objetos de trabalho',
				align    = 'top-left',
				elements = {	
					{label = '❌ Remover Objeto',		value = 'remover'},
					{label = '🧰 Caixa de ferramentas',  value = 'prop_toolchest_01'},
					{label = '🚧 Cone', value = 'prop_roadcone02a'}
			}}, function(data2, menu2)
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
		'prop_toolchest_01',
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

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'MechanicActions' then
		CurrentActionMecanico     = 'mechanic_actions_menu'
		CurrentActionMsgMecanico  = ''
		CurrentActionDataMecanico = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentActionMecanico     = 'delete_vehicle'
			CurrentActionMsgMecanico  = ''
			CurrentActionDataMecanico = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	CurrentActionMecanico = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(940.3556, -969.496, 39.499)

	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Mecânicos')
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(0)
		
		local canSleep = true
		
		if PlayerData.job and PlayerData.job.name == 'mechanic' then
			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(Config.MechanicBlips) do
				
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 3 then
					if k == 'MechanicActions' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Menu Norauto')
					end
					if k == 'VehicleDeleter' then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.2, '~b~E~s~ - Guardar Veículo')
					end
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 50 then
					canSleep = false
					if k ~= 'VehicleSpawnPoint' then
						DrawMarker(2, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
			end
			
			if canSleep then
				Citizen.Wait(2000)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(100)

		if PlayerData.job and PlayerData.job.name == 'mechanic' then
			
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.MechanicBlips) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if isInMarker or (isInMarker and LastZoneMecanico ~= currentZone) then
				HasAlreadyEnteredMarkerMecanico = true
				LastZoneMecanico                = currentZone
				TriggerEvent('esx_mechanicjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarkerMecanico then
				HasAlreadyEnteredMarkerMecanico = false
				TriggerEvent('esx_mechanicjob:hasExitedMarker', LastZoneMecanico)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(0)
		
		if PlayerData.job and PlayerData.job.name == 'mechanic' then
			if CurrentActionMecanico then
				if IsControlJustReleased(0, 38) then

					if CurrentActionMecanico == 'mechanic_actions_menu' then
						MenuGestaoNorauto()
					elseif CurrentActionMecanico == 'delete_vehicle' then
						ESX.Game.DeleteVehicle(CurrentActionDataMecanico.vehicle)
					end

					CurrentActionMecanico = nil
				end
			end

			if IsControlJustReleased(0, 167) and not isDead and PlayerData.job and PlayerData.job.name == 'mechanic' then
				MenuF6Norauto()
			end
		else
			Citizen.Wait(5000)
		end

	end
end)

----------------------------------------------------- MECHANIC TOOLS ------------------------------------------------------

local hoistSet = false
local engineHoist = nil
local toolboxSet = false
local toolbox = nil
local carliftSet = false
local carlift = nil
local carliftfrozen = false

local cfgScriptMechTools = {}

cfgScriptMechTools.MenuCommand = 'mechanic-tools'
cfgScriptMechTools.UseMenu = true -- If set to false, each item will use a command

-- Engine Hoist
cfgScriptMechTools.EngineHoistCommand = 'engine-hoist'
cfgScriptMechTools.HoistHash = 1742634574

-- Toolbox
cfgScriptMechTools.ToolboxCommand = 'toolbox'
cfgScriptMechTools.ToolboxHash = -573669520

-- Car Lift
cfgScriptMechTools.CarLiftCommand = 'car-lift'
cfgScriptMechTools.CarLiftHash = 1420515116

-- Engine Hoist
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		if hoistSet then
			local playerPed = PlayerPedId()
			while #(GetEntityCoords(engineHoist) - GetEntityCoords(PlayerPedId())) < 2.0 and editModeMecanico do
				Citizen.Wait(0)
				local hoistCoords = GetEntityCoords(engineHoist)
				ESX.Game.Utils.DrawText3D(hoistCoords, "Pressiona ~y~[NUMPAD 7 & 9]~s~ para rodar o guincho de motor ~n~Usa ~b~[SETAS]~s~ para mover o guincho de motor", 0.6)
				if IsControlPressed(0, 172) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, 0.0, 0.01, 0.0))
				end
				if IsControlPressed(0, 173) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, 0.0, -0.01, 0.0))
				end
				if IsControlPressed(0, 174) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, -0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 175) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, 0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 117) then
					SetEntityHeading(engineHoist, GetEntityHeading(engineHoist) + 0.5)
				end
				if IsControlPressed(0, 118) then
					SetEntityHeading(engineHoist, GetEntityHeading(engineHoist) - 0.5)
				end
			end
		else
			Wait(1000)
		end
	end
end)

-- Toolbox
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		if toolboxSet then
			local playerPed = PlayerPedId()
			while #(GetEntityCoords(toolbox) - GetEntityCoords(PlayerPedId())) < 2.0 and editModeMecanico do
				Citizen.Wait(0)
				local hoistCoords = GetEntityCoords(toolbox)
				ESX.Game.Utils.DrawText3D(hoistCoords, "Pressiona ~y~[NUMPAD 7 & 9]~s~ para rodar a caixa de ferramentas ~n~Usa ~b~[SETAS]~s~ para mover a caixa de ferramentas", 0.6)
				if IsControlPressed(0, 172) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, 0.0, 0.01, 0.0))
				end
				if IsControlPressed(0, 173) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, 0.0, -0.01, 0.0))
				end
				if IsControlPressed(0, 174) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, -0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 175) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, 0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 117) then
					SetEntityHeading(toolbox, GetEntityHeading(toolbox) + 0.5)
				end
				if IsControlPressed(0, 118) then
					SetEntityHeading(toolbox, GetEntityHeading(toolbox) - 0.5)
				end
			end
		else
			Wait(1000)
		end
	end
end)

-- Car Lift
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		if carliftSet then
			local playerPed = PlayerPedId()
			while #(GetEntityCoords(carlift) - GetEntityCoords(PlayerPedId())) < 15.0 and editModeMecanico do
				Citizen.Wait(0)
				local hoistCoords = GetEntityCoords(carlift)
				ESX.Game.Utils.DrawText3D(hoistCoords, "Pressiona ~y~[NUMPAD 5, 7, 8 & 9]~s~ para controlar o elevador ~n~Usa ~b~[SETAS]~s~ para mover o elevador", 0.6)
				if IsControlPressed(0, 111) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, 0.0, 0.01))
				end
				if IsControlPressed(0, 110) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, 0.0, -0.01))
				end
				if IsControlPressed(0, 172) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, 0.01, 0.0))
				end
				if IsControlPressed(0, 173) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, -0.01, 0.0))
				end
				if IsControlPressed(0, 174) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, -0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 175) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 117) then
					SetEntityHeading(carlift, GetEntityHeading(carlift) + 0.5)
				end
				if IsControlPressed(0, 118) then
					SetEntityHeading(carlift, GetEntityHeading(carlift) - 0.5)
				end
			end
		else
			Wait(1000)
		end
	end
end)

-- Menu Options
local mechanictooloptions = {
	{label = "Ativar/Desativar Modo Edição", value = 'toggle_edit'},
	{label = "Colocar/Retirar Guinho de Motor", value = 'engine_hoist'},
	{label = "Colocar/Retirar Caixa de Ferramentas", value = 'toolbox'},
	{label = "Colocar/Retirar Elevador de Veículos", value = 'car_lift'}
}

function OpenMenuMechTools()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
		title = "Ferramentas",
		align = "top-left",
		elements = mechanictooloptions
	}, function(data, menu)		
		
		if data.current.value == 'engine_hoist' then
			SetEngineHoist()
		elseif data.current.value == 'toolbox' then
			SetToolBox()
		elseif data.current.value == 'car_lift' then
			SetCarLift()
		elseif data.current.value == 'toggle_edit' then
			if editModeMecanico then
				exports['mythic_notify']:DoHudText('error', 'Modo de Edição Desativado')
				editModeMecanico = false
			else
				exports['mythic_notify']:DoHudText('inform', 'Modo de Edição Ativado')
				editModeMecanico = true
				menu.close()
			end
		end

	end,
	function(data, menu)
		menu.close()
	end)
end

function SetEngineHoist()
	if hoistSet then
		DeleteEntity(engineHoist)
		exports['mythic_notify']:DoHudText('inform', 'Guincho de Motor removido!')
		hoistSet = false
	else
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local playerHeading = GetEntityHeading(playerPed)
		engineHoist = CreateObject(cfgScriptMechTools.HoistHash, playerCoords.x, playerCoords.y, playerCoords.z - 0.9, true, true, false)
		SetEntityHeading(engineHoist, playerHeading)
		exports['mythic_notify']:DoHudText('inform', 'Guincho de Motor colocado!')
		hoistSet = true
	end
end

function SetToolBox()
	if toolboxSet then
		DeleteEntity(toolbox)
		exports['mythic_notify']:DoHudText('inform', 'Caixa de Ferramentas removida!')
		toolboxSet = false
	else
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local playerHeading = GetEntityHeading(playerPed)
		toolbox = CreateObject(cfgScriptMechTools.ToolboxHash, playerCoords.x, playerCoords.y, playerCoords.z - 0.9, true, true, false)
		SetEntityHeading(toolbox, playerHeading)
		exports['mythic_notify']:DoHudText('inform', 'Caixa de Ferramentas colocada!')
		toolboxSet = true
	end
end

function SetCarLift()
	if carliftSet then
		DeleteEntity(carlift)
		exports['mythic_notify']:DoHudText('inform', 'Elevador removido!')
		carliftSet = false
	else
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local playerHeading = GetEntityHeading(playerPed)
		carlift = CreateObject(cfgScriptMechTools.CarLiftHash, playerCoords.x, playerCoords.y, playerCoords.z - 0.9, true, true, false)
		FreezeEntityPosition(carlift, true)
		SetEntityHeading(carlift, playerHeading)
		exports['mythic_notify']:DoHudText('inform', 'Elevador colocado!')
		carliftSet = true
	end
end