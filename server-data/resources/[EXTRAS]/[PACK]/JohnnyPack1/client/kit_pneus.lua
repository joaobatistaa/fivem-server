function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {["wheel_lf"] = 0, ["wheel_rf"] = 1, ["wheel_lm1"] = 2, ["wheel_rm1"] = 3, ["wheel_lm2"] = 45,["wheel_rm2"] = 47, ["wheel_lm3"] = 46, ["wheel_rm3"] = 48, ["wheel_lr"] = 4, ["wheel_rr"] = 5,}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.0
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end

local busy = false

RegisterNetEvent('tyrekit:onUse')
AddEventHandler('tyrekit:onUse', function()
	print(busy)
	if not busy then
		busy = true
		print(busy)
		local playerPed		= GetPlayerPed(-1)
		local coords		= GetEntityCoords(playerPed)
		local closestTire 	= GetClosestVehicleTire(vehicle)
		
		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) and closestTire == nil then
			local vehicle = nil
				--ESX.ShowNotification(_U('not_near_tyre'))
				exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não existem <span style='color:#ff0000'>pneus</span> que necessitem de reparação por perto!", 5000, 'error')
				busy = false
			elseif IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			else
				--ESX.ShowNotification(_U('no_vehicle_nearby'))
				exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não existem <span style='color:#ff0000'>veículos</span> por perto!", 5000, 'error')
				busy = false
			end	

			if IsPedInAnyVehicle(playerPed, false) then
				vehicle = GetVehiclePedIsIn(playerPed, false)
			else
				vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			end

			if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) and IsPedOnFoot(playerPed) and closestTire ~= nil then
				TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
					-- WORLD_HUMAN_WELDING

				Citizen.CreateThread(function()
					ThreadID2 = GetIdOfThisThread()
					CurrentAction = 'repair'
					isReparing = not isReparing
					--SetTextComponentFormat('STRING')
					--AddTextComponentString('Pressiona ~INPUT_VEH_DUCK~ para cancelar')
					--DisplayHelpTextFromStringLabel(0, 0, 1, -1)

					--exports['progressBars']:startUI(Config.TyreKitTime * 1000, _U('ReparingTyre'))
					
					exports['progressbar']:Progress({
						name = "unique_action_name",
						duration = 20000,
						label = "A trocar pneus...",
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
					Citizen.Wait(20000)

					
					if CurrentAction ~= nil then
						SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
						SetVehicleWheelHealth(vehicle, closestTire.tireIndex, 100)
						ClearPedTasks(playerPed)
						TriggerServerEvent('esx_repairkit:removeTyreKit')
						--ESX.ShowNotification(_U('finished_tyre_repair'))
						exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Pneus <span style='color:#069a19'>trocados</span> com sucesso!", 5000, 'success')
						TriggerServerEvent('esx_repairkit:SetTyreSync', vehicle, closestTire.tireIndex)
						if isReparing then
							isReparing = not isReparing
						end
						busy = false
						CurrentAction = nil
						TerminateThisThread()
					end
				end)
			--[[
			Citizen.CreateThread(function()
				while true do
				Citizen.Wait(0)
				
				if IsControlJustPressed(0, Keys["X"]) and isReparing then
					ClearPedTasks(playerPed)
					TerminateThread(ThreadID2)
					--if Config.EnableProgressBar then
						--exports['progressBars']:startUI(300, _U('Cancelling'))
						exports['progressbar']:Progress({
							name = "unique_action_name",
							duration = 4000,
							label = "A arrumar kit...",
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
						Citizen.Wait(4000)
						--else
						--end
						--ESX.ShowNotification(_U('aborted_tyre_repair'))
						exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Troca de pneus <span style='color:#069a19'>cancelada</span> com sucesso!", 5000, 'success')
						isReparing = not isReparing
						CurrentAction = nil
					end
				end
			
			end)
			--]]
		end
	end
end)

RegisterNetEvent("TyreSync")
AddEventHandler("TyreSync", function(veh, tyre)
	SetVehicleTyreFixed(veh, tyre)
	SetVehicleWheelHealth(veh, tyre, 100)
end)