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

local HasAlreadyEnteredMarker_redline = false
local LastStation_redline     = nil
local LastPart                = nil
local LastPartNum_redline     = nil
local CurrentAction_redline           = nil
local CurrentActionMsg_redline        = ''
local CurrentActionData_redline       = {}
local isDead_redline                  = false

PlayerData              = {}

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

function Garagem_Redline(station, partNum)		
	local foundSpawnPoint, spawnPoint = GetAvailable_SpawnPoint_Redline(station, partNum)
	if foundSpawnPoint then
		TriggerEvent("johnny_garagens:carroempresa", spawnPoint, 'redline')
	end 
end

function GetAvailable_SpawnPoint_Redline(station, partNum)
	local spawnPoints = Config.redlineStations[station].Veiculos[partNum].SpawnPoints
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
		exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Está um veículo a bloquear o <span style='color:#ff0000'>SpawnPoint</span>!", 5000, 'error')
		return false
	end
end

function MenuF6_Redline()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'redline_actions',
	{
		title    = '🔥 Menu Redline',
		align    = 'top-left',
		elements = {
			{label = '👨 Interagir com o cidadão',	value = 'citizen_interaction'},
			{label = '🧰 Menu Mecânicos',      value = 'menu_mecanicos'},
		}
	}, function(data, menu)
		
		if data.current.value == 'menu_mecanicos' then
			local elements = {
				{label = '💻 Menu Revisão',        value = 'revisao_vehicle'},
				{label = '🔨 Arrombar',        value = 'hijack_vehicle'},
				{label = '🧰 Reparar',        value = 'fix_vehicle'},
				{label = '🧽 Limpar',         value = 'clean_vehicle'},
				{label = '⚠️ Apreender Veículo',       value = 'del_vehicle'},
				{label = '⚓ Rebocar (Mercedes Prancha)', value = 'rebocar_vehicle'},
				{label = '📦 Objetos de trabalho', value = 'object_spawner'},
				{label = '🔧 Ferramentas', value = 'menu_ferramentas'}
			}
		
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'menu_mecanicos',
			{
				title    = '🧰 Menu Mecânicos',
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				if data2.current.value == 'revisao_vehicle' then
					ExecuteCommand('menutunning')
					menu.close()
				elseif data2.current.value == 'hijack_vehicle' then
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
				elseif data2.current.value == 'fix_vehicle' then
					menu.close()
					local playerPed = PlayerPedId()
					local vehicle   = ESX.Game.GetVehicleInDirection()

					if IsPedSittingInAnyVehicle(playerPed) then
						exports['mythic_notify']:DoHudText('error', 'Tens que sair do veículo!')
						return
					end

					if DoesEntityExist(vehicle) then
						isBusyMecanico = true
						ExecuteCommand('e mechanic')
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
				elseif data2.current.value == 'clean_vehicle' then
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
				elseif data2.current.value == 'del_vehicle' then
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
				elseif data2.current.value == 'rebocar_vehicle' then
					menu.close()
					ExecuteCommand('rebocar')
				elseif data2.current.value == 'menu_ferramentas' then
					OpenMenuMechTools()
				elseif data2.current.value == 'object_spawner' then
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
					}}, function(data3, menu3)
						if data3.current.value == 'remover' then
							DeleteOBJ()
						else
							SpawnObject(data3.current.value)
						end
					end, function(data3, menu3)
						menu3.close()
					end)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'citizen_interaction' then
			local elements = {
				{label = '🤵 Cartão de Cidadão',			value = 'identity_card'},
				{label = '🔍 Revistar',			value = 'body_search'},
				{label = '🔒 Algemar / Desalgemar',		value = 'handcuff'},
				{label = '🧑‍🤝‍🧑 Arrastar',			value = 'drag'},
				{label = '🚗 Colocar no veículo',	value = 'put_in_vehicle'},
				{label = '🚗 Retirar do Veículo',	value = 'out_the_vehicle'},
			}
		
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = '👨 Interagir com o cidadão',
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'identity_card' then
						MenuVerIdentidade(closestPlayer)
					elseif action == 'body_search' then
						TriggerServerEvent('esx_gangsjob:message', GetPlayerServerId(closestPlayer), 'Estás a ser revistado!')
						TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", GetPlayerServerId(closestPlayer))
					elseif action == 'handcuff' then
						TriggerServerEvent('esx_gangsjob:handcuff', GetPlayerServerId(closestPlayer))
					elseif action == 'drag' then
						TriggerServerEvent('esx_gangsjob:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_gangsjob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_gangsjob:OutVehicle', GetPlayerServerId(closestPlayer))
					end

				else
					exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

AddEventHandler('empresa_redline:hasEnteredMarker', function(station, part, partNum)

	if part == 'Vestiarios' then
	
		CurrentAction_redline     = 'menu_vestiario'
		
	elseif part == 'Cofres' then
	
		CurrentAction_redline     = 'menu_cofre'
		CurrentActionData_redline = {station = station}
		
	elseif part == 'VeiculosSpawner' then

		CurrentAction_redline     = 'retirar_veiculo'
		CurrentActionData_redline = {station = station, partNum = partNum}

	elseif part == 'GuardarVeiculos' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction_redline     = 'guardar_veiculo'
				CurrentActionData_redline = {vehicle = vehicle}
			end
		end

	elseif part == 'GestaoEmpresa' then
	
		CurrentAction_redline     = 'menu_gestao_empresa'
		
	end

end)

AddEventHandler('empresa_redline:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction_redline = nil
end)

local mostrado1 = false
local mostrado2 = false

-- Display markers
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(100)
	end
	while true do

		local sleep = 500

		if PlayerData.job ~= nil and PlayerData.job.name == 'redline' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			for k,v in pairs(Config.redlineStations) do

				for i=1, #v.Vestiarios, 1 do
					if GetDistanceBetweenCoords(coords, v.Vestiarios[i].x, v.Vestiarios[i].y, v.Vestiarios[i].z, true) < 3 then
						DrawText3Ds(v.Vestiarios[i].x, v.Vestiarios[i].y, v.Vestiarios[i].z + 0.2, '~b~E~s~ - Vestiário', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Vestiarios[i].x, v.Vestiarios[i].y, v.Vestiarios[i].z, true) < 50 then
						sleep = 1
						DrawMarker(2, v.Vestiarios[i].x, v.Vestiarios[i].y, v.Vestiarios[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				for i=1, #v.Cofres, 1 do
					if GetDistanceBetweenCoords(coords, v.Cofres[i].x, v.Cofres[i].y, v.Cofres[i].z, true) < 3 then
						DrawText3Ds(v.Cofres[i].x, v.Cofres[i].y, v.Cofres[i].z + 0.2, '~b~E~s~ - Cofre', 0.3)
					end
					
					if GetDistanceBetweenCoords(coords, v.Cofres[i].x, v.Cofres[i].y, v.Cofres[i].z, true) < 50 then
						sleep = 1
						DrawMarker(2, v.Cofres[i].x, v.Cofres[i].y, v.Cofres[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				
				--[[
				for i=1, #v.Veiculos, 1 do
					if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 2 and not mostrado1 then
							--DrawText3Ds(v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z + 0.2, '~b~E~s~ - Retirar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Retirar Veículo', 'darkgreen', 'left')
							mostrado1 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) > 2 and mostrado1 then
							exports['okokTextUI']:Close()
							mostrado1 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 50 then
						sleep = 1
						DrawMarker(2, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end

				for i=1, #v.GuardarVeiculos, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarVeiculos[i].x, v.GuardarVeiculos[i].y, v.GuardarVeiculos[i].z, true) < 5 then
						if GetDistanceBetweenCoords(coords, v.GuardarVeiculos[i].x, v.GuardarVeiculos[i].y, v.GuardarVeiculos[i].z, true) < 3 and not mostrado2 then
							--DrawText3Ds(v.GuardarVeiculos[i].x, v.GuardarVeiculos[i].y, v.GuardarVeiculos[i].z + 0.2, '~b~E~s~ - Guardar Veículo', 0.3)
							exports['okokTextUI']:Open('[E] - Guardar Veículo', 'darkgreen', 'left')
							mostrado2 = true
						end
						
						if GetDistanceBetweenCoords(coords, v.GuardarVeiculos[i].x, v.GuardarVeiculos[i].y, v.GuardarVeiculos[i].z, true) > 3 and mostrado2 then
							exports['okokTextUI']:Close()
							mostrado2 = false
						end
					end
					
					if GetDistanceBetweenCoords(coords, v.GuardarVeiculos[i].x, v.GuardarVeiculos[i].y, v.GuardarVeiculos[i].z, true) < 50 then
						sleep = 1
						DrawMarker(2, v.GuardarVeiculos[i].x, v.GuardarVeiculos[i].y, v.GuardarVeiculos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
					end
				end
				--]]

				if PlayerData.job.grade_name == 'boss' then
					for i=1, #v.GestaoEmpresa, 1 do
						if GetDistanceBetweenCoords(coords, v.GestaoEmpresa[i].x, v.GestaoEmpresa[i].y, v.GestaoEmpresa[i].z, true) < 3 then
							DrawText3Ds(v.GestaoEmpresa[i].x, v.GestaoEmpresa[i].y, v.GestaoEmpresa[i].z + 0.2, '~b~E~s~ - Gerir Empresa', 0.3)
						end
						
						if GetDistanceBetweenCoords(coords, v.GestaoEmpresa[i].x, v.GestaoEmpresa[i].y, v.GestaoEmpresa[i].z, true) < 50 then
							sleep = 1
							DrawMarker(2, v.GestaoEmpresa[i].x, v.GestaoEmpresa[i].y, v.GestaoEmpresa[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
						end
					end
				end

			end

			Citizen.Wait(sleep)
		else
			Citizen.Wait(5000)
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(100)
	end
	while true do

		local sleep = 100

		if PlayerData.job ~= nil and PlayerData.job.name == 'redline' then

			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local isInMarker     = false
			local currentStation = nil
			local currentPart    = nil
			local currentPartNum = nil

			for k,v in pairs(Config.redlineStations) do

				for i=1, #v.Vestiarios, 1 do
					if GetDistanceBetweenCoords(coords, v.Vestiarios[i].x, v.Vestiarios[i].y, v.Vestiarios[i].z, true) < 2 then
						sleep = 1
						isInMarker     = true
						currentStation = k
						currentPart    = 'Vestiarios'
						currentPartNum = i
					end
				end

				for i=1, #v.Cofres, 1 do
					if GetDistanceBetweenCoords(coords, v.Cofres[i].x, v.Cofres[i].y, v.Cofres[i].z, true) < 2 then
						sleep = 1
						isInMarker     = true
						currentStation = k
						currentPart    = 'Cofres'
						currentPartNum = i
					end
				end
				
				--[[
				for i=1, #v.Veiculos, 1 do
					if GetDistanceBetweenCoords(coords, v.Veiculos[i].Spawner.x, v.Veiculos[i].Spawner.y, v.Veiculos[i].Spawner.z, true) < 2 then
						sleep = 1
						isInMarker     = true
						currentStation = k
						currentPart    = 'VeiculosSpawner'
						currentPartNum = i
					end
				end

				for i=1, #v.GuardarVeiculos, 1 do
					if GetDistanceBetweenCoords(coords, v.GuardarVeiculos[i].x, v.GuardarVeiculos[i].y, v.GuardarVeiculos[i].z, true) < 3 then
						sleep = 1
						isInMarker     = true
						currentStation = k
						currentPart    = 'GuardarVeiculos'
						currentPartNum = i
					end
				end
				--]]

				if PlayerData.job.grade_name == 'boss' then
					for i=1, #v.GestaoEmpresa, 1 do
						if GetDistanceBetweenCoords(coords, v.GestaoEmpresa[i].x, v.GestaoEmpresa[i].y, v.GestaoEmpresa[i].z, true) < 2 then
							sleep = 1
							isInMarker     = true
							currentStation = k
							currentPart    = 'GestaoEmpresa'
							currentPartNum = i
						end
					end
				end

			end

			local hasExited = false

			if isInMarker or (isInMarker and (LastStation_redline ~= currentStation or LastPart_redline ~= currentPart or LastPartNum_redline ~= currentPartNum)) then
				sleep = 1
				if
					(LastStation_redline ~= nil and LastPart_redline ~= nil and LastPartNum_redline ~= nil) and
					(LastStation_redline ~= currentStation or LastPart_redline ~= currentPart or LastPartNum_redline ~= currentPartNum)
				then
					TriggerEvent('empresa_redline:hasExitedMarker', LastStation_redline, LastPart_redline, LastPartNum_redline)
					hasExited = true
				end

				HasAlreadyEnteredMarker_redline = true
				LastStation_redline             = currentStation
				LastPart_redline                = currentPart
				LastPartNum_redline             = currentPartNum

				TriggerEvent('empresa_redline:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker_redline then
				sleep = 1
				HasAlreadyEnteredMarker_redline = false
				TriggerEvent('empresa_redline:hasExitedMarker', LastStation_redline, LastPart_redline, LastPartNum_redline)
			end

			Citizen.Wait(sleep)
		else
			Citizen.Wait(5000)
		end

	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(100)
	end
	while true do

		Citizen.Wait(0)
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'redline' and not isDead_redline then
			local playerPed      = PlayerPedId()
			local carro = IsPedInAnyVehicle(playerPed,  false)
			
			if CurrentAction_redline ~= nil then

				if IsControlJustReleased(0, Keys['E']) then

					if CurrentAction_redline == 'menu_vestiario' then
					
						MenuRoupa()
						
					elseif CurrentAction_redline == 'menu_cofre' then
					
						local other = {}
						other.maxweight = 999999999 -- Custom weight statsh.
						other.slots = 200 -- Custom slots spaces.
						TriggerServerEvent("inventory:server:OpenInventory", "stash", "redline", other)
						TriggerEvent("inventory:client:SetCurrentStash", "redline")
						
					elseif CurrentAction_redline == 'retirar_veiculo' then
					
						if carro then
							exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Não podes fazer isso dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						else
							Garagem_Redline(CurrentActionData_redline.station, CurrentActionData_redline.partNum)
						end
						
					elseif CurrentAction_redline == 'guardar_veiculo' then
				
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData_redline.vehicle)
					
						ESX.TriggerServerCallback('johnny_garagens:getCarrosEmpresa',function(valid)	
							if (valid) then
								TriggerServerEvent('codem-garage:saveProps', vehicleProps.plate, vehicleProps)
								TaskLeaveVehicle(playerPed, CurrentActionData_redline.vehicle, 0)
								Citizen.Wait(2500)
								ESX.Game.DeleteVehicle(CurrentActionData_redline.vehicle)
								TriggerServerEvent('codem-garage:stored', vehicleProps.plate, 1)
								exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Veículo <span style='color:#069a19'>guardado</span> na garagem da empresa!", 5000, 'success')
							else
								exports['Johnny_Notificacoes']:Alert("GARAGEM", "<span style='color:#c7c7c7'>Este veículo <span style='color:#ff0000'>não pertence</span> à tua empresa!", 5000, 'error')
							end
						end, vehicleProps.plate)
						
					elseif CurrentAction_redline == 'menu_gestao_empresa' then
					
						ESX.UI.Menu.CloseAll()
						TriggerEvent('esx_society:openBossMenu', 'redline', function(data, menu)
							menu.close()
							CurrentAction_redline     = 'menu_gestao_empresa'
						end, { wash = false }) -- disable washing money
						
					end
					
					CurrentAction_redline = nil
				end
			end
		
			if IsControlJustReleased(0, Keys['F6']) and not isDead_redline and PlayerData.job ~= nil and PlayerData.job.name == 'redline' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'redline_actions') then
				MenuF6_Redline()
			end
		
		else
			Citizen.Wait(5000)
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead_redline = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead_redline = false
end)