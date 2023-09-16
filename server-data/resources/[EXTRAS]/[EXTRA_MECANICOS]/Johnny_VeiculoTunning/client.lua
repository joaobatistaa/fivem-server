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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local vehicleData = nil
local vehiclesHandlingsOriginal = {}
local vehiclesHandlingsDamaged = {}

-- Global vars to makeAction
local vehicleDataAction = {}
local vehiclesHandlingsDamagedAction = {}

RegisterNetEvent("vehicle_tunning:progress")
AddEventHandler("vehicle_tunning:progress", function(a,b)
	exports['progressbar']:Progress({
		name = "unique_action_name",
		duration = a,
		label = b,
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
	Citizen.Wait(a)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CORE
-----------------------------------------------------------------------------------------------------------------------------------------	

RegisterNetEvent('advanced_vehicles:LixeiroCB')
AddEventHandler('advanced_vehicles:LixeiroCB', function(ret)
	if ret ~= false then
		vehicleData = ret[1]
	else
		vehicleData.loaded = false
	end
end)

RegisterNetEvent('advanced_vehicles:setGlobalVehicleHandling')
AddEventHandler('advanced_vehicles:setGlobalVehicleHandling', function(ret)
	vehiclesHandlingsOriginal = ret
end)

Citizen.CreateThread(function()
	local timer = 3000
	while true do
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped)
		local seat = 0
		if veh ~= 0 then
			seat = GetPedInVehicleSeat(veh, -1)
		else
			seat = 0
		end
		if Config.allVehicles or IsThisModelACar(GetEntityModel(veh)) then
			if seat == ped and vehicleData == nil then
				-- Ped just entered the vehicle
				timer = 1000
				
				vehicleData = {}
				--vehicleData.plate = string.gsub(GetVehicleNumberPlateText(veh), "%s+", "")
				vehicleData.plate = GetVehicleNumberPlateText(veh)
				vehicleData.model = GetEntityModel(veh)
				vehicleData.name = string.lower(GetDisplayNameFromVehicleModel(vehicleData.model))
				vehicleData.veh = veh

				vehicleData.loaded = nil
				-- TODO: fix muitas requisições quando não é veículo próprio
				TriggerServerEvent('advanced_vehicles:getVehicleData',vehicleData)
				while vehicleData.loaded == nil do 
					Wait(10)
				end
				if vehicleData.loaded then
					vehiclesHandlingsDamaged[vehicleData.name] = json.decode(vehicleData.vehicle_handling)
					for k,v in pairs(vehiclesHandlingsDamaged[vehicleData.name]) do
						local handFloat = GetVehicleHandlingFloat(veh, "CHandlingData", k)
						if not vehiclesHandlingsOriginal[vehicleData.name] then vehiclesHandlingsOriginal[vehicleData.name] = {} end
						if not vehiclesHandlingsOriginal[vehicleData.name][k] then vehiclesHandlingsOriginal[vehicleData.name][k] = handFloat end
						SetVehicleHandlingFloat(veh, "CHandlingData", k, v)
					end
					applyVehicleMods(veh,vehicleData.name,vehicleData.upgradesNUI)
					TriggerServerEvent('advanced_vehicles:setGlobalVehicleHandling',vehicleData.name, vehiclesHandlingsOriginal[vehicleData.name])
				end
			elseif seat == ped and vehicleData.loaded then
				-- Ped is in vehicle
				timer = 1000

				if IsVehicleOnAllWheels(veh) then
					local coords = GetEntityCoords(veh)
					if oldpos ~= nil then
						local dist = #(coords - oldpos)
						vehicleData.km = vehicleData.km + dist
						local arr = {}
						if Config.maintenance[vehicleData.name] then
							arr = Config.maintenance[vehicleData.name]
						else
							arr = Config.maintenance['default']
						end
						local oilHealth = 100
						for k,v in pairs(arr) do
							if not vehicleData.services[k] then vehicleData.services[k] = {} end
							local m_to_next_service = vehicleData.km - ((v.lifespan*1000) + ((vehicleData.services[k][1] or 0)*1000))
							if dist > 0.01 and m_to_next_service > 0 then
								if v.damage.type == 'CHandlingData' then
									local handFloat = GetVehicleHandlingFloat(veh, "CHandlingData", v.damage.handId)
									if not vehiclesHandlingsOriginal[vehicleData.name] then vehiclesHandlingsOriginal[vehicleData.name] = {} end
									if not vehiclesHandlingsOriginal[vehicleData.name][v.damage.handId] then
										vehiclesHandlingsOriginal[vehicleData.name][v.damage.handId] = handFloat
										TriggerServerEvent('advanced_vehicles:setGlobalVehicleHandling',vehicleData.name,vehiclesHandlingsOriginal[vehicleData.name])
									end

									local damage_amount = (dist/1000) * (v.damage.amount_per_km * vehiclesHandlingsOriginal[vehicleData.name][v.damage.handId])
									local threshold_amount = (math.ceil(m_to_next_service/(v.damage.km_threshold*1000)))
									local variation = damage_amount * threshold_amount * v.damage.multiplier
									local new_value = handFloat-variation
									
									if new_value < v.damage.min then new_value = v.damage.min end
									SetVehicleHandlingFloat(veh, "CHandlingData", v.damage.handId, new_value)

									if not vehiclesHandlingsDamaged[vehicleData.name] then vehiclesHandlingsDamaged[vehicleData.name] = {} end
									vehiclesHandlingsDamaged[vehicleData.name][v.damage.handId] = new_value
								elseif v.damage.type == 'engine' then
									local damage_amount = (dist/1000) * (v.damage.amount_per_km * 1000)
									local threshold_amount = (math.ceil(m_to_next_service/(v.damage.km_threshold*1000)))
									local variation = damage_amount * threshold_amount * v.damage.multiplier
									local new_value = GetVehicleEngineHealth(veh)-variation
									
									if new_value < v.damage.min then
										if v.damage.destroy_engine then
											new_value = -4000.0
										else
											new_value = v.damage.min
										end
									end
									
									SetVehicleEngineHealth(veh,new_value)
								end
							end

							if k == Config.oil then
								local km_to_next_service = ((m_to_next_service/1000)*-1)
								oilHealth = (km_to_next_service*100)/v.lifespan
							end
						end
						
						SendNUIMessage({
							km = vehicleData.km/1000,
							format = Config.format,
							engineHealth = GetVehicleEngineHealth(veh),
							oilHealth = oilHealth,
							nitroAmount = (vehicleData.nitroAmount*100)/Config.NitroAmount,
							nitroRecharges = vehicleData.nitroRecharges,
						})
					end
					oldpos = coords
				end
			end
		else
			-- Ped is out any vehicle
			timer = 3000
			
			if vehicleData and vehicleData.loaded then
				TriggerServerEvent('advanced_vehicles:setVehicleData',vehicleData,vehiclesHandlingsDamaged[vehicleData.name] or {})
				vehiclesHandlingsDamaged[vehicleData.name] = nil
			end
			SendNUIMessage({km = false})
			vehicleData = nil
		end
		Citizen.Wait(timer)
	end
end)

Citizen.CreateThread(function()
	local timer = 60000
	while true do
		if vehicleData and vehicleData.loaded then
			-- Will save vehicle on DB everytime
			TriggerServerEvent('advanced_vehicles:setVehicleData',vehicleData,vehiclesHandlingsDamaged[vehicleData.name] or {})
		end
		Citizen.Wait(timer)
	end
end)

RegisterNetEvent('advanced_vehicles:repairCar')
AddEventHandler('advanced_vehicles:repairCar', function(repair)
	for k,v in pairs(Config.repair[repair].repair) do
		if v == "engine" then
			SetVehicleEngineHealth(vehicleDataAction.veh,1000.0)
		elseif v == "body" then
			SetVehicleBodyHealth(vehicleDataAction.veh,1000.0)
		else
			if vehiclesHandlingsOriginal[vehicleDataAction.name] and vehiclesHandlingsOriginal[vehicleDataAction.name][v] then
				-- TODO: remover da tabela upgrades os itens resetados
				SetVehicleHandlingFloat(veh, "CHandlingData", v, vehiclesHandlingsOriginal[vehicleDataAction.name][v])
				vehiclesHandlingsDamagedAction[vehicleDataAction.name][v] = nil
				TriggerEvent('advanced_vehicles:showStatusUI')

				TriggerServerEvent('advanced_vehicles:setVehicleData',vehicleDataAction,vehiclesHandlingsDamagedAction[vehicleDataAction.name] or {})
			end
		end
	end
end)

RegisterNetEvent('advanced_vehicles:upgradeCar')
AddEventHandler('advanced_vehicles:upgradeCar', function(upgrade,idname)
	if upgrade.type == "CHandlingData" then
		local handFloat = 0
		if not vehiclesHandlingsOriginal[vehicleDataAction.name] then vehiclesHandlingsOriginal[vehicleDataAction.name] = {} end
		if vehiclesHandlingsOriginal[vehicleDataAction.name] and vehiclesHandlingsOriginal[vehicleDataAction.name][upgrade.handId] then
			handFloat = vehiclesHandlingsOriginal[vehicleDataAction.name][upgrade.handId]
		else
			handFloat = GetVehicleHandlingFloat(vehicleDataAction.veh, "CHandlingData", upgrade.handId)
			vehiclesHandlingsOriginal[vehicleDataAction.name][upgrade.handId] = handFloat
			TriggerServerEvent('advanced_vehicles:setGlobalVehicleHandling',vehicleDataAction.name,vehiclesHandlingsOriginal[vehicleDataAction.name])
		end
		
		if upgrade.fixed_value then
			handFloat = 0
		end
		vehiclesHandlingsDamagedAction[vehicleDataAction.name][upgrade.handId] = (handFloat + upgrade.value)
		SetVehicleHandlingFloat(vehicleDataAction.veh, "CHandlingData", upgrade.handId, vehiclesHandlingsDamagedAction[vehicleDataAction.name][upgrade.handId])
		
		applyVehicleMods(vehicleDataAction.veh,vehicleDataAction.name,{[idname] = true})
	end
	TriggerServerEvent('advanced_vehicles:setVehicleData',vehicleDataAction,vehiclesHandlingsDamagedAction[vehicleDataAction.name] or {})
end)

RegisterNetEvent('advanced_vehicles:removeUpgrade')
AddEventHandler('advanced_vehicles:removeUpgrade', function(upgrade)
	if upgrade.type == "CHandlingData" then
		local handFloat = 0
		if not vehiclesHandlingsOriginal[vehicleDataAction.name] then vehiclesHandlingsOriginal[vehicleDataAction.name] = {} end
		if vehiclesHandlingsOriginal[vehicleDataAction.name] and vehiclesHandlingsOriginal[vehicleDataAction.name][upgrade.handId] then
			handFloat = vehiclesHandlingsOriginal[vehicleDataAction.name][upgrade.handId]
		else
			handFloat = GetVehicleHandlingFloat(vehicleDataAction.veh, "CHandlingData", upgrade.handId)
			vehiclesHandlingsOriginal[vehicleDataAction.name][upgrade.handId] = handFloat
			TriggerServerEvent('advanced_vehicles:setGlobalVehicleHandling',vehicleDataAction.name,vehiclesHandlingsOriginal[vehicleDataAction.name])
		end

		vehiclesHandlingsDamagedAction[vehicleDataAction.name][upgrade.handId] = nil
		SetVehicleHandlingFloat(vehicleDataAction.veh, "CHandlingData", upgrade.handId, handFloat)
		
		applyVehicleMods(vehicleDataAction.veh)
		
		if upgrade.turbo then
			ToggleVehicleMod(vehicleDataAction.veh,18,false)
		end

		if upgrade.powered_wheels then
			for k,v in pairs(vehiclesHandlingsOriginal[vehicleDataAction.name]['powered_wheels']) do
				SetVehicleWheelIsPowered(vehicleDataAction.veh,k-1,v)
			end
		end
	elseif upgrade.type == "nitrous" then
		vehicleDataAction.nitroAmount = 0
		vehicleDataAction.nitroRecharges = 0
	end

	TriggerServerEvent('advanced_vehicles:setVehicleData',vehicleDataAction,vehiclesHandlingsDamagedAction[vehicleDataAction.name] or {})
end)

function applyVehicleMods(veh,name,upgrades)
	-- Do this shit is necessary to apply the HandlingFloat
	SetVehicleModKit(veh,0)
	SetVehicleMod(veh,0,GetVehicleMod(veh,0),false)
	SetVehicleMod(veh,1,GetVehicleMod(veh,1),false)
	SetVehicleMod(veh,2,GetVehicleMod(veh,2),false)
	SetVehicleMod(veh,3,GetVehicleMod(veh,3),false)
	SetVehicleMod(veh,4,GetVehicleMod(veh,4),false)
	SetVehicleMod(veh,5,GetVehicleMod(veh,5),false)
	SetVehicleMod(veh,6,GetVehicleMod(veh,6),false)
	SetVehicleMod(veh,7,GetVehicleMod(veh,7),false)
	SetVehicleMod(veh,8,GetVehicleMod(veh,8),false)
	SetVehicleMod(veh,9,GetVehicleMod(veh,9),false)
	SetVehicleMod(veh,10,GetVehicleMod(veh,10),false)
	SetVehicleMod(veh,11,GetVehicleMod(veh,11),false)
	SetVehicleMod(veh,12,GetVehicleMod(veh,12),false)
	SetVehicleMod(veh,13,GetVehicleMod(veh,13),false)
	SetVehicleMod(veh,15,GetVehicleMod(veh,15),false)
	SetVehicleMod(veh,16,GetVehicleMod(veh,16),false)
	SetVehicleMod(veh,25,GetVehicleMod(veh,25),false)
	SetVehicleMod(veh,27,GetVehicleMod(veh,27),false)
	SetVehicleMod(veh,28,GetVehicleMod(veh,28),false)
	SetVehicleMod(veh,30,GetVehicleMod(veh,30),false)
	SetVehicleMod(veh,33,GetVehicleMod(veh,33),false)
	SetVehicleMod(veh,34,GetVehicleMod(veh,34),false)
	SetVehicleMod(veh,35,GetVehicleMod(veh,35),false)

	if name and upgrades then
		local temp_arr_wheels = {}
		local arr = {}
		if Config.upgrades[name] then
			arr = Config.upgrades[name]
		else
			arr = Config.upgrades['default']
		end
		for k,v in pairs(upgrades) do
			-- Set turbo
			if arr[k].improvements.turbo then
				ToggleVehicleMod(veh,18,true)
			end
			-- Set powered wheels
			if arr[k].improvements.powered_wheels then
				for i = 0, GetVehicleNumberOfWheels(veh)-1 do
					local found = false
					for kk,vv in pairs(arr[k].improvements.powered_wheels) do
						if vv == i then
							found = true
							break
						end
					end
					temp_arr_wheels[i+1] = GetVehicleWheelIsPowered(veh,i)
					SetVehicleWheelIsPowered(veh,i,found)
				end
				if not vehiclesHandlingsOriginal[name]['powered_wheels'] then
					vehiclesHandlingsOriginal[name]['powered_wheels'] = temp_arr_wheels
					TriggerServerEvent('advanced_vehicles:setGlobalVehicleHandling',name,vehiclesHandlingsOriginal[name])
				end
			end
			-- Set nitro
			if arr[k].improvements.type == 'nitrous' then
				if vehicleData and vehicleData.loaded == true and vehicleData.nitroAmount == 0 and vehicleData.nitroRecharges > 0 then
					TriggerEvent('advanced_vehicles:startNitroRecharge')
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN MENU
-----------------------------------------------------------------------------------------------------------------------------------------	

RegisterCommand(Config.command, function()
	TriggerEvent('advanced_vehicles:showStatusUI')
end)

RegisterNetEvent('advanced_vehicles:showStatusUI')
AddEventHandler('advanced_vehicles:showStatusUI', function()
	local ismechanic = false
	for _, jobs in ipairs(Config.Jobs) do
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == jobs) then
			ismechanic = true
		end
	end
	
	if ismechanic then
		if vehicleData ~= nil and vehicleData ~={} and vehicleData.loaded == true then
			local ped = PlayerPedId()
			local veh = GetVehiclePedIsIn(ped)

			local arr = {}
			if Config.maintenance[vehicleData.name] then
				arr = Config.maintenance[vehicleData.name]
			else
				arr = Config.maintenance['default']
			end
			local arr2 = {}
			if Config.upgrades[vehicleData.name] then
				arr2 = Config.upgrades[vehicleData.name]
			else
				arr2 = Config.upgrades['default']
			end

			SetNuiFocus(true,true)
			SendNUIMessage({
				showmenu = true,
				format = Config.format,
				lang = Config.lang,
				repair = Config.repair,
				infoTextsPage = Config.infoTextsPage,
				maintenance = arr,
				upgrade = arr2,
				engineHealth = GetVehicleEngineHealth(veh),
				bodyHealth = GetVehicleBodyHealth(veh),
				vehiclesHandlingsOriginal = vehiclesHandlingsOriginal[vehicleData.name],
				vehiclesHandlingsDamaged = vehiclesHandlingsDamaged[vehicleData.name],
				vehicleData = vehicleData
			})
		else
			exports['mythic_notify']:DoHudText('error', Lang[Config.lang]['invalid_veh'])
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Não tens permissões suficientes!')
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI CALLBACK
-----------------------------------------------------------------------------------------------------------------------------------------	

RegisterNUICallback('makeAction', function(data, cb)
	local ismechanic = false
	for _, jobs in ipairs(Config.Jobs) do
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == jobs) then
			ismechanic = true
		end
	end
		if ismechanic then
		--if Config.permission == false or (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.permission) then
			vehicleDataAction = {}
			vehicleDataAction = deepcopy(vehicleData)
			vehiclesHandlingsDamagedAction = {}
			vehiclesHandlingsDamagedAction = deepcopy(vehiclesHandlingsDamaged)

			TriggerServerEvent('advanced_vehicles:makeAction',vehicleData,data,true)
		else
			TriggerEvent("advanced_vehicles:Notify","error",Lang[Config.lang]['no_permission'])
		end
end)

RegisterNUICallback('repairCar', function(data, cb)
		local ismechanic = false
	for _, jobs in ipairs(Config.Jobs) do
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == jobs) then
			ismechanic = true
		end
	end
		if ismechanic then
		--if Config.permission == false or (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.permission) then
			vehicleDataAction = {}
			vehicleDataAction = deepcopy(vehicleData)
			vehiclesHandlingsDamagedAction = {}
			vehiclesHandlingsDamagedAction = deepcopy(vehiclesHandlingsDamaged)
			TriggerServerEvent('advanced_vehicles:makeAction',vehicleData,data,true)
		else
			TriggerEvent("advanced_vehicles:Notify","error",Lang[Config.lang]['no_permission'])
		end
end)

RegisterNUICallback('notifyOil', function(data, cb)
	TriggerEvent("advanced_vehicles:Notify","importante",Lang[Config.lang]['services_notify'])
end)

RegisterNUICallback('close', function(data, cb)
	closeUI()
end)

function closeUI()
	SetNuiFocus(false,false)
	SendNUIMessage({ 
		showmenu = false
	})
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR JACK
-----------------------------------------------------------------------------------------------------------------------------------------

local aReparar = false

RegisterNetEvent('advanced_vehicles:useTheJackFunction')
AddEventHandler('advanced_vehicles:useTheJackFunction', function(data,firstStep)
	if firstStep and not Config.UseT1gerMechanic then
		closeUI()
		local ped = PlayerPedId()
		local playerCoords = GetEntityCoords(ped)
		local veh = GetVehiclePedIsIn(PlayerPedId())
		--local veh = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 5.0, 0, 70)
		local vehCoords = {}

		while veh ~= 0 do
			vehCoords = GetEntityCoords(veh)
			DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z + 0.6, "~y~Saía do Veículo!")
			
			veh = GetVehiclePedIsIn(ped)
			Citizen.Wait(5)
		end

		local distance = #(GetEntityCoords(ped) - vector3(vehCoords.x, vehCoords.y, vehCoords.z))
		while veh == 0 and distance < 3.0 do
			local vehCoords = GetEntityCoords(vehicleDataAction.veh)
			DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z + 0.6, "Pressiona ~g~[E]~w~ para iniciar | ~r~[G]~w~ para cancelar")
			if IsControlJustPressed(0, 38) then
				local done = UseTheJackFunction(vehicleDataAction.veh,firstStep)
				if done then
					TriggerServerEvent('advanced_vehicles:makeAction',vehicleDataAction,data,false)

					local pedPos = GetEntityCoords(ped)
					local x = vehCoords.x - pedPos.x
					local y = vehCoords.y - pedPos.y
					TaskTurnPedToFaceCoord(ped, vehCoords.x-(x*2), vehCoords.y-(y*2), vehCoords.z, 1000)
					Wait(1100)
					TaskStartScenarioInPlace(ped,"WORLD_HUMAN_VEHICLE_MECHANIC", 0, true)
				end
				break
			end
			
			if IsControlJustPressed(0, 47) then
				break
			end

			veh = GetVehiclePedIsIn(ped)
			distance = #(GetEntityCoords(ped) - vector3(vehCoords.x, vehCoords.y, vehCoords.z))
			Citizen.Wait(5)
		end
	else
		UseTheJackFunction(vehicleDataAction.veh,firstStep)
	end
end)

local isJackRaised
local carJackObj
function UseTheJackFunction(vehicle,firstStep)
	local player = PlayerPedId()
	
	TaskTurnPedToFaceEntity(player, vehicle, 1000)
	Citizen.Wait(4000)
	FreezeEntityPosition(vehicle, true)
	local vehPos = GetEntityCoords(vehicle)

	if not isJackRaised then 
		SpawnJackProp(vehicle)
		Citizen.Wait(250)
	else
		if DoesEntityExist(carJackObj) then
			GetControlOfEntity(carJackObj)
			SetEntityAsMissionEntity(carJackObj)
		else
			carJackObj = GetClosestObjectOfType(vehPos.x, vehPos.y, vehPos.z, 1.2, GetHashKey("prop_carjack"), false, false, false)
			GetControlOfEntity(carJackObj)
			SetEntityAsMissionEntity(carJackObj)
		end
	end

	local objPos = GetEntityCoords(carJackObj)
	
	local anim_dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
	local anim_lib	= "weed_crouch_checkingleaves_idle_02_inspector"
	LoadAnim(anim_dict)

	if firstStep then
		TaskPlayAnim(player, anim_dict, anim_lib, 2.0, -3.5, -1, 1, false, false, false, false)
	end
	Citizen.Wait(1000)
	local count = 5
	while true do
		Citizen.Wait(1)
		vehPos = GetEntityCoords(vehicle)
		objPos = GetEntityCoords(carJackObj)
		if count > 0 then 
			Citizen.Wait(1000)
			if not isJackRaised then
				SetEntityCoordsNoOffset(vehicle, vehPos.x, vehPos.y, (vehPos.z+0.10), true, false, false, true)
				SetEntityCoordsNoOffset(carJackObj, objPos.x, objPos.y, (objPos.z+0.10), true, false, false, true)
			else
				SetEntityCoordsNoOffset(vehicle, vehPos.x, vehPos.y, (vehPos.z-0.10), true, false, false, true)
				SetEntityCoordsNoOffset(carJackObj, objPos.x, objPos.y, (objPos.z-0.10), true, false, false, true)
			end
			FreezeEntityPosition(vehicle, true)
			FreezeEntityPosition(carJackObj, true)
			count = count - 1
		end
		if count <= 0 then 
			if isJackRaised then
				FreezeEntityPosition(vehicle, false)
				if DoesEntityExist(carJackObj) then 
					DeleteEntity(carJackObj)
					DeleteObject(carJackObj)
				end
				carJackObj = nil
				isJackRaised = false
			else
				isJackRaised = true
			end
			break
		end
	end
	ClearPedTasks(player)
	return true
end

function SpawnJackProp(vehicle)
	local heading = GetEntityHeading(vehicle)
	local objPos = GetEntityCoords(vehicle)
	carJackObj = CreateObject(GetHashKey("prop_carjack"), objPos.x, objPos.y, objPos.z-0.95, true, true, true)
	SetEntityHeading(carJackObj, heading)
	FreezeEntityPosition(carJackObj, true)
end

function LoadAnim(animDict)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function GetControlOfEntity(entity)
	local netTime = 15
	NetworkRequestControlOfEntity(entity)
	while not NetworkHasControlOfEntity(entity) and netTime > 0 do
		NetworkRequestControlOfEntity(entity)
		Citizen.Wait(100)
		netTime = netTime -1
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('advanced_vehicles:startNitroRecharge')
AddEventHandler('advanced_vehicles:startNitroRecharge', function()
	local timer = Config.NitroRechargeTime
	TriggerEvent("advanced_vehicles:Notify","info",Lang[Config.lang]['nitro_recharging'])
	local tempveh = vehicleData.veh
	
	Wait(Config.NitroRechargeTime*1000)
	
	if vehicleData and vehicleData.loaded and vehicleData.veh == tempveh and vehicleData.nitroAmount == 0 and vehicleData.nitroRecharges > 0 then
		vehicleData.nitroAmount = Config.NitroAmount
		vehicleData.nitroRecharges = vehicleData.nitroRecharges - 1
		TriggerEvent("advanced_vehicles:Notify","info",Lang[Config.lang]['nitro_ready'])
	end
end)

local INPUT_VEH_ACCELERATE = 71

local function IsNitroControlPressed()
  return (IsControlPressed(0, Config.NitroKey1) or IsControlPressed(0, Config.NitroKey2))
end

local function IsDrivingControlPressed()
  return IsControlPressed(0, INPUT_VEH_ACCELERATE)
end

local function NitroLoop(lastVehicle)
  local timer = 3000
  local player = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(player)
  local driver = GetPedInVehicleSeat(vehicle, -1)

	if lastVehicle ~= 0 and lastVehicle ~= vehicle then
		SetVehicleNitroBoostEnabled(lastVehicle, false)
		SetVehicleLightTrailEnabled(lastVehicle, false)
		SetVehicleNitroPurgeEnabled(lastVehicle, false)
		TriggerServerEvent('advanced_vehicles:__sync', false, false, true)
	end

	if vehicle == 0 or driver ~= player then
		Wait(timer)
		return 0
	end

	local model = GetEntityModel(vehicle)

	if not IsThisModelACar(model) or IsVehicleElectric(vehicle) then
		Wait(timer)
		return 0
	end

  local isEnabled = IsNitroControlPressed()
  local isDriving = IsDrivingControlPressed()
  local isRunning = GetIsVehicleEngineRunning(vehicle)
  local isBoosting = IsVehicleNitroBoostEnabled(vehicle)
  local isPurging = IsVehicleNitroPurgeEnabled(vehicle)

  if vehicleData and vehicleData.loaded and vehicleData.nitroAmount > 0 then
	timer = 1
	if isRunning and isEnabled and vehicleData.loaded and vehicleData.nitroAmount > 0 then
		if isDriving then
			vehicleData.nitroAmount = vehicleData.nitroAmount - 1
			if vehicleData.nitroAmount == 0 then
				if vehicleData.nitroRecharges > 0 then
					TriggerEvent('advanced_vehicles:startNitroRecharge')
				else
					TriggerServerEvent('advanced_vehicles:removeNitroUpgrade',vehicleData)
					TriggerEvent("advanced_vehicles:Notify", "error", Lang[Config.lang]['nitro_empty'])
				end
			end
			if not isBoosting then
				SetVehicleNitroBoostEnabled(vehicle, true)
				SetVehicleLightTrailEnabled(vehicle, true)
				SetVehicleNitroPurgeEnabled(vehicle, false)
				TriggerServerEvent('advanced_vehicles:__sync', true, false, false)
			end
		else
			if not isPurging then
				SetVehicleNitroBoostEnabled(vehicle, false)
				SetVehicleLightTrailEnabled(vehicle, false)
				SetVehicleNitroPurgeEnabled(vehicle, true)
				TriggerServerEvent('advanced_vehicles:__sync', false, true, false)
			end
		end
	elseif isBoosting or isPurging then
		SetVehicleNitroBoostEnabled(vehicle, false)
		SetVehicleLightTrailEnabled(vehicle, false)
		SetVehicleNitroPurgeEnabled(vehicle, false)
		TriggerServerEvent('advanced_vehicles:__sync', false, false, false)
	end
  elseif isBoosting or isPurging then
	SetVehicleNitroBoostEnabled(vehicle, false)
	SetVehicleLightTrailEnabled(vehicle, false)
	SetVehicleNitroPurgeEnabled(vehicle, false)
	TriggerServerEvent('advanced_vehicles:__sync', false, false, false)
  end
  Wait(timer)
  return vehicle
end

Citizen.CreateThread(function ()
  local lastVehicle = 0

  while true do
    Citizen.Wait(0)
    lastVehicle = NitroLoop(lastVehicle)
  end
end)

RegisterNetEvent('advanced_vehicles:__update')
AddEventHandler('advanced_vehicles:__update', function (playerServerId, boostEnabled, purgeEnabled, lastVehicle)
  local playerId = GetPlayerFromServerId(playerServerId)
  if not NetworkIsPlayerConnected(playerId) then
    return
  end

  local player = GetPlayerPed(playerId)
  local vehicle = GetVehiclePedIsIn(player, lastVehicle)
  local driver = GetPedInVehicleSeat(vehicle, -1)

  SetVehicleNitroBoostEnabled(vehicle, boostEnabled)
  SetVehicleLightTrailEnabled(vehicle, boostEnabled)
  SetVehicleNitroPurgeEnabled(vehicle, purgeEnabled)
end)

local vehicles = {}

function SetNitroBoostScreenEffectsEnabled(enabled)
  if enabled then
    StopScreenEffect('RaceTurbo')
    StartScreenEffect('RaceTurbo', 0, false)
    SetTimecycleModifier('rply_motionblur')
    ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
  else
    StopGameplayCamShaking(true)
    SetTransitionTimecycleModifier('default', 0.35)
  end
end

function IsVehicleNitroBoostEnabled(vehicle)
  return vehicles[vehicle] == true
end

function SetVehicleNitroBoostEnabled(vehicle, enabled)
  if IsVehicleNitroBoostEnabled(vehicle) == enabled then
    return
  end

  if IsPedInVehicle(PlayerPedId(), vehicle) or not enabled then
    SetNitroBoostScreenEffectsEnabled(enabled)
  end

  SetVehicleBoostActive(vehicle, enabled)
  vehicles[vehicle] = enabled or nil
end

Citizen.CreateThread(function ()
  local function BackfireLoop()
    -- TODO: Only do this for nearby vehicles.
	local timer = 500
    for vehicle in pairs(vehicles) do
	  timer = 1
      CreateVehicleExhaustBackfire(vehicle, 1.25)
    end
	return timer
  end

  while true do
    Citizen.Wait(BackfireLoop())
  end
end)

Citizen.CreateThread(function ()
  local function BoostLoop()
	local timer = 500
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local enabled = IsVehicleNitroBoostEnabled(vehicle)

    if vehicle == 0 or driver ~= player or not enabled then
      return 500
    end

    -- TODO: Use better math. The effect of nitro is quite extreme for cars with
    -- custom handling, while slow cars have almost no effect from this at all.
    -- Also, maybe torque is not the correct setting to change.
    if not IsVehicleStopped(vehicle) then
      local vehicleModel = GetEntityModel(vehicle)
      local currentSpeed = GetEntitySpeed(vehicle)
      local maximumSpeed = GetVehicleModelMaxSpeed(vehicleModel)
      local multiplier = 1.5 * maximumSpeed / currentSpeed

      SetVehicleEngineTorqueMultiplier(vehicle, multiplier)
    end
	return 1
  end

  while true do
    Citizen.Wait(BoostLoop())
  end
end)

-- TODO: Get actual exhaust positions and rotations. This is based on bone
-- positions, but custom exhausts can have different positions or rotations.
function CreateVehicleExhaustBackfire(vehicle, scale)
	local exhaustNames = {
	  "exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
	  "exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
	  "exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
	  "exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
	}
  
	for _, exhaustName in ipairs(exhaustNames) do
	  local boneIndex = GetEntityBoneIndexByName(vehicle, exhaustName)
  
	  if boneIndex ~= -1 then
		local pos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
		local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
  
		UseParticleFxAssetNextCall('core')
		StartParticleFxNonLoopedOnEntity('veh_backfire', vehicle, off.x, off.y, off.z, 0.0, 0.0, 0.0, scale, false, false, false)
	  end
	end
  end
  
  function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
	UseParticleFxAssetNextCall('core')
	return StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
  end
  
  function CreateVehicleLightTrail(vehicle, bone, scale)
	UseParticleFxAssetNextCall('core')
	local ptfx = StartParticleFxLoopedOnEntityBone('veh_light_red_trail', vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone, scale, false, false, false)
	SetParticleFxLoopedEvolution(ptfx, "speed", 1.0, false)
	return ptfx
  end
  
  function StopVehicleLightTrail(ptfx, duration)
	Citizen.CreateThread(function()
	  local startTime = GetGameTimer()
	  local endTime = GetGameTimer() + duration
	  while GetGameTimer() < endTime do 
		Citizen.Wait(0)
		local now = GetGameTimer()
		local scale = (endTime - now) / duration
		SetParticleFxLoopedScale(ptfx, scale)
		SetParticleFxLoopedAlpha(ptfx, scale)
	  end
	  StopParticleFxLooped(ptfx)
	end)
  end

local purge_vehicles = {}
local particles = {}

function IsVehicleNitroPurgeEnabled(vehicle)
  return purge_vehicles[vehicle] == true
end

function SetVehicleNitroPurgeEnabled(vehicle, enabled)
  if IsVehicleNitroPurgeEnabled(vehicle) == enabled then
    return
  end

  if enabled then
    local bone = GetEntityBoneIndexByName(vehicle, 'bonnet')
    local pos = GetWorldPositionOfEntityBone(vehicle, bone)
    local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
    local ptfxs = {}

    for i=0,3 do
      local leftPurge = CreateVehiclePurgeSpray(vehicle, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.5)
      local rightPurge = CreateVehiclePurgeSpray(vehicle, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.5)

      table.insert(ptfxs, leftPurge)
      table.insert(ptfxs, rightPurge)
    end

    purge_vehicles[vehicle] = true
    particles[vehicle] = ptfxs
  else
    if particles[vehicle] and #particles[vehicle] > 0 then
      for _, particleId in ipairs(particles[vehicle]) do
        StopParticleFxLooped(particleId)
      end
    end

    purge_vehicles[vehicle] = nil
    particles[vehicle] = nil
  end
end


local trail_vehicles = {}
local trail_particles = {}

function IsVehicleLightTrailEnabled(vehicle)
  return trail_vehicles[vehicle] == true
end

function SetVehicleLightTrailEnabled(vehicle, enabled)
  if IsVehicleLightTrailEnabled(vehicle) == enabled then
    return
  end
  
  if enabled then
    local ptfxs = {}
    
    local leftTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_l"), 1.0)
    local rightTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_r"), 1.0)
    
    table.insert(ptfxs, leftTrail)
    table.insert(ptfxs, rightTrail)

    trail_vehicles[vehicle] = true
    trail_particles[vehicle] = ptfxs
  else
    if trail_particles[vehicle] and #trail_particles[vehicle] > 0 then
      for _, particleId in ipairs(trail_particles[vehicle]) do
        StopVehicleLightTrail(particleId, 500)
      end
    end

    trail_vehicles[vehicle] = nil
    trail_particles[vehicle] = nil
  end
end

local ELECTRIC_VEHICLES = {
	[GetHashKey('AIRTUG')] = true,
	[GetHashKey('CYCLONE')] = true,
	[GetHashKey('CADDY')] = true,
	[GetHashKey('CADDY2')] = true,
	[GetHashKey('CADDY3')] = true,
	[GetHashKey('DILETTANTE')] = true,
	[GetHashKey('IMORGON')] = true,
	[GetHashKey('KHAMEL')] = true,
	[GetHashKey('NEON')] = true,
	[GetHashKey('RAIDEN')] = true,
	[GetHashKey('SURGE')] = true,
	[GetHashKey('VOLTIC')] = true,
	[GetHashKey('TEZERACT')] = true
  }
  
  -- TODO: Replace with `FLAG_IS_ELECTRIC` from vehicles.meta:
  -- https://gtamods.com/wiki/Vehicles.meta
function IsVehicleElectric(vehicle)
	local model = GetEntityModel(vehicle)
	return ELECTRIC_VEHICLES[model] or false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILS
-----------------------------------------------------------------------------------------------------------------------------------------

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function print_table(node)
	if type(node) == 'table' then
		-- to make output beautiful
		local function tab(amt)
			local str = ""
			for i=1,amt do
				str = str .. "\t"
			end
			return str
		end

		local cache, stack, output = {},{},{}
		local depth = 1
		local output_str = "{\n"

		while true do
			local size = 0
			for k,v in pairs(node) do
				size = size + 1
			end

			local cur_index = 1
			for k,v in pairs(node) do
				if (cache[node] == nil) or (cur_index >= cache[node]) then
				
					if (string.find(output_str,"}",output_str:len())) then
						output_str = output_str .. ",\n"
					elseif not (string.find(output_str,"\n",output_str:len())) then
						output_str = output_str .. "\n"
					end

					-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
					table.insert(output,output_str)
					output_str = ""
				
					local key
					if (type(k) == "number" or type(k) == "boolean") then
						key = "["..tostring(k).."]"
					else
						key = "['"..tostring(k).."']"
					end

					if (type(v) == "number" or type(v) == "boolean") then
						output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
					elseif (type(v) == "table") then
						output_str = output_str .. tab(depth) .. key .. " = {\n"
						table.insert(stack,node)
						table.insert(stack,v)
						cache[node] = cur_index+1
						break
					else
						output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
					end

					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					else
						output_str = output_str .. ","
					end
				else
					-- close the table
					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					end
				end

				cur_index = cur_index + 1
			end

			if (#stack > 0) then
				node = stack[#stack]
				stack[#stack] = nil
				depth = cache[node] == nil and depth + 1 or depth - 1
			else
				break
			end
		end

		-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
		table.insert(output,output_str)
		output_str = table.concat(output)

		print(output_str)
	else
		print(node)
	end
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

--export for is vehicle on lift
function IsOnLift()
	local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	local plate = GetVehicleNumberPlateText(vehicle):gsub("^%s*(.-)%s*$", "%1")
	if vehOnLift[plate] ~= nil then
		IsOnLift = true
	else
		IsOnLift = false
	end
   return IsOnLift
end
--export end