local truck,truck_blip,trailer,trailer_blip,rentTruck,route_blip
menuactive = false
empresaAtual = nil
loading = false
cooldown = nil

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
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	deleteBlips()
	refreshBlips()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------	
Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	SetNuiFocus(false,false)
	local timer = 1
	while true do
		timer = 3000
		if PlayerData.job.name == 'camionista' then
			for k,mark in pairs(Config.empresas) do
				local x,y,z = table.unpack(mark.coordenada)
				local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
				if not menuactive and distance <= 20.0 then
					timer = 1
					DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 2.0 then
						DrawText3D2(x,y,z-0.6, Lang[Config.lang]['open'], 0.40)
						if IsControlJustPressed(0,38) then
							empresaAtual = k
							TriggerServerEvent("truck_logistics:getData") 
						end
					end
				end
			end
		end
		Citizen.Wait(timer)
	end
end)

RegisterNetEvent('truck_logistics:open')
AddEventHandler('truck_logistics:open', function(dados,update)
	-- Calcula a distancia e recompensa para cada contrato
	local x1,y1,z1 = table.unpack(GetEntityCoords(PlayerPedId()))
	for k,v in pairs(dados.trucker_available_contracts) do
		local x2,y2,z2 = table.unpack(Config.locais_entrega[v.coords_index])
		-- local distance = CalculateTravelDistanceBetweenPoints(x1,y1,z1, x2, y2, z2)
		-- if distance > 50 then
			distance = #(vector3(x1,y1,z1) - vector3(x2,y2,z2))
		-- end
		dados.trucker_available_contracts[k]['distance'] = tonumber(string.format("%.2f", (distance/1000)))
		dados.trucker_available_contracts[k]['reward'] = tonumber(string.format("%.f", (v.distance * v.price_per_km)))
	end
	
	-- Abre NUI
	SendNUIMessage({ 
		showmenu = true,
		update = update,
		dados = dados
	})
	if update == false then
		menuactive = true
		SetNuiFocus(true,true)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback('startJob', function(data, cb)
	if cooldown == nil then
		cooldown = true
		if not loading then
			TriggerServerEvent('truck_logistics:startContract',data)
		else
			TriggerEvent("Johnny_Trucker:Notify","importante",Lang[Config.lang]['loading_trailer'])
			closeUI()
		end
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('upgradeSkill', function(data, cb)
	TriggerServerEvent('truck_logistics:upgradeSkill',data)
end)

RegisterNUICallback('repairTruck', function(data, cb)
	if truck and not rentTruck then
		TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['store_truck'])
		return
	end
	TriggerServerEvent('truck_logistics:repairTruck',data.id)
end)

RegisterNUICallback('buyTruck', function(data, cb)
	TriggerServerEvent('truck_logistics:buyTruck',data)
end)

RegisterNUICallback('sellTruck', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		if truck and not rentTruck then
			TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['store_truck_2'])
			return
		end
		TriggerServerEvent('truck_logistics:sellTruck',data)
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('fireDriver', function(data, cb)
	TriggerServerEvent('truck_logistics:fireDriver',data.driver_id)
end)

RegisterNUICallback('spawnTruck', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		if not loading then
			TriggerServerEvent('truck_logistics:spawnTruck',data.truck_id)
		else
			TriggerEvent("Johnny_Trucker:Notify","importante",Lang[Config.lang]['loading_truck'])
			closeUI()
		end
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('hireDriver', function(data, cb)
	TriggerServerEvent('truck_logistics:hireDriver',data.driver_id)
end)

RegisterNUICallback('setDriver', function(data, cb)
	TriggerServerEvent('truck_logistics:setDriver',data)
end)

RegisterNUICallback('depositMoney', function(data, cb)
	TriggerServerEvent('truck_logistics:depositMoney',data)
end)

RegisterNUICallback('withdrawMoney', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		TriggerServerEvent('truck_logistics:withdrawMoney')
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('loan', function(data, cb)
	if cooldown == nil then
		cooldown = true
		
		TriggerServerEvent('truck_logistics:loan',data)
		
		SetTimeout(500,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('payLoan', function(data, cb)
	TriggerServerEvent('truck_logistics:payLoan',data)
end)


RegisterNUICallback('close', function(data, cb)
	closeUI()
end)

function closeUI()
	empresaAtual = nil
	menuactive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ hidemenu = true })
	TriggerServerEvent('truck_logistics:closeUI')
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR CAMINHÃO PRÓPRIO
-----------------------------------------------------------------------------------------------------------------------------------------
local updateTruckStatus = 0
local cacheCamiao = nil
RegisterNetEvent('truck_logistics:spawnTruck')
AddEventHandler('truck_logistics:spawnTruck', function(truck_data)
	if not IsEntityAVehicle(truck) then
		DeleteVehicle(truck)
		RemoveBlip(truck_blip)
		truck = nil
		truck_blip = nil
		rentTruck = false
	end
	if truck then
		TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['already_has_truck'])
		return
	end
	
	loading = true
	local garagem = Config.empresas[empresaAtual]['coordenada_garagem']
	local i = #garagem
	local x,y,z,h
	while i > 0 do
		x,y,z,h = table.unpack(garagem[i])
		local checkPos = IsSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
		if checkPos == false then
			if i <= 1 then
				TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['occupied_places'])
				loading = false
				return
			end
		else
			break
		end
		i = i - 1
	end
	
	truck,truck_blip = spawnVehicle(truck_data.truck_name,x,y,z,h,truck_data.body,truck_data.engine,truck_data.transmission,truck_data.wheels,477,26,Lang[Config.lang]['truck_blip'])
	local newPlate = GeneratePlate()
	SetVehicleNumberPlateText(truck, newPlate)
	
	exports['qs-vehiclekeys']:GiveKeysAuto()
	--TriggerServerEvent('vehiclekeys:server:givekey', newPlate, truck_data.truck_name)
	
	
	TriggerEvent("Johnny_Trucker:Notify","sucesso",Lang[Config.lang]['already_is_in_garage'])
	loading = false
	cacheCamiao = truck_data
	local timer = 1
	local engineH = 1000
	while IsEntityAVehicle(truck) do
		timer = 2000
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)
		if veh == truck then
			engineH = GetVehicleEngineHealth(truck)
			for k,v in pairs(Config.empresas) do
				for k,mark in pairs(v.coordenada_garagem) do
					local x,y,z = table.unpack(mark)
					local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
					if distance <= 20.0 then
						timer = 1
						DrawMarker(39,x,y,z,0,0,0,0.0,0,0,2.0,2.0,2.0,255,0,0,50,0,0,0,1)
						if distance <= 5.0 then
							drawTxt(Lang[Config.lang]['press_e_to_store_truck'], 8,0.5,0.90,0.50,255,255,255,180)
							if IsControlJustPressed(0,38) then
								TriggerServerEvent("truck_logistics:updateTruckStatus",truck_data,GetVehicleEngineHealth(truck),GetVehicleBodyHealth(truck))
								exports['qs-vehiclekeys']:RemoveKeysAuto()
								--local plate = ESX.Game.GetVehicleProperties(truck).plate
								--TriggerServerEvent('vehiclekeys:server:removekey', plate, truck_data.truck_name)
								DeleteVehicle(truck)
								RemoveBlip(truck_blip)
								truck = nil
								truck_blip = nil	
							end
						end
					else
						if updateTruckStatus == 0 and engineH ~= GetVehicleEngineHealth(truck) then
							updateTruckStatus = 3
							TriggerServerEvent("truck_logistics:updateTruckStatus",truck_data,GetVehicleEngineHealth(truck),GetVehicleBodyHealth(truck))
							engineH = GetVehicleEngineHealth(truck)
						end
					end
				end
			end
		end
		Citizen.Wait(timer)
	end
	DeleteEntity(truck)
	RemoveBlip(truck_blip)
	truck = nil
	truck_blip = nil
end)

Citizen.CreateThread(function()
	while true do
		timer = 2500
		if updateTruckStatus > 0 then
			updateTruckStatus = updateTruckStatus - 1
		end
		Citizen.Wait(timer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('cancelarentrega', function()
	if PlayerData.job.name == 'camionista' then
		if trailer then
			DeleteVehicle(trailer)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			trailer = nil
			trailer_blip = nil
			route_blip = nil
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Entrega cancelada!</span>", 5000, 'success')
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens nenhuma entrega a decorrer!</span>", 5000, 'error')
		end
	end
end)

RegisterCommand('guardarcamiao', function()
	if PlayerData.job.name == 'camionista' then
		if cacheCamiao then
			TriggerServerEvent("truck_logistics:updateTruckStatus",cacheCamiao,GetVehicleEngineHealth(truck),GetVehicleBodyHealth(truck))
			exports['qs-vehiclekeys']:RemoveKeysAuto()
			--local plate = ESX.Game.GetVehicleProperties(truck).plate
			--TriggerServerEvent('vehiclekeys:server:removekey', plate, cacheCamiao.truck_name)
			DeleteVehicle(truck)
			RemoveBlip(truck_blip)
			truck = nil
			truck_blip = nil
			cacheCamiao = nil
			
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Camião guardado!</span>", 5000, 'success')
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens nenhum camião cá fora!</span>", 5000, 'error')
		end
	end
end)

RegisterNetEvent('truck_logistics:startContract')
AddEventHandler('truck_logistics:startContract', function(data,job_distance,reward,truck_data)
	local key = empresaAtual
	if not IsEntityAVehicle(trailer) then
		DeleteVehicle(trailer)
		RemoveBlip(trailer_blip)
		RemoveBlip(route_blip)
		trailer = nil
		trailer_blip = nil
		route_blip = nil
		rentTruck = false
	end
	if trailer or rentTruck then
		TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['already_has_cargo'])
		return
	end

	if not IsEntityAVehicle(truck) then
		DeleteVehicle(truck)
		RemoveBlip(truck_blip)
		RemoveBlip(route_blip)
		truck = nil
		truck_blip = nil
		route_blip = nil
		rentTruck = false
	end
	if truck and data.contract_type == 0 then
		TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['must_store_truck'])
		return
	end

	Citizen.CreateThreadNow(function()
		resetLoading()
	end)

	loading = true
	local x,y,z,h
	if data.contract_type == 0 then
		local garagem = Config.empresas[key]['coordenada_garagem']
		local i = #garagem
		while i > 0 do
			x,y,z,h = table.unpack(garagem[i])
			local checkPos = IsSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
			if checkPos == false then
				if i <= 1 then
					TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['occupied_places'])
					loading = false
					return
				end
			else
				break
			end
			i = i - 1
		end
		truck,truck_blip = spawnVehicle(data.truck,x,y,z,h,1000,1000,1000,1000,477,26,Lang[Config.lang]['rented_truck_blip'])
		rentTruck = true
	end
	
	local cargas = Config.empresas[key]['coordenada_cargas']
	i = #cargas
	while i > 0 do
		x,y,z,h = table.unpack(cargas[i])
		local checkPos = IsSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
		if checkPos == false then
			if i <= 1 then
				if rentTruck then
					DeleteVehicle(truck)
					RemoveBlip(truck_blip)
					truck = nil
					truck_blip = nil
					rentTruck = false
				end
				TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['occupied_places'])
				loading = false
				return
			end
		else
			break
		end
		i = i - 1
	end
	print(data.trailer)
	trailer,trailer_blip = spawnVehicle(data.trailer,x,y,z,h,1000,1000,1000,1000,479,26,Lang[Config.lang]['cargo_blip'])
	TriggerEvent("Johnny_Trucker:Notify","sucesso",Lang[Config.lang]['started_job'])
	loading = false


	TriggerServerEvent('truck_logistics:deleteContract',data.contract_id)
	local timer = 1
	x,y,z,h = table.unpack(Config.locais_entrega[data.coords_index])

	route_blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(route_blip,1)
	SetBlipColour(route_blip,5)
	SetBlipAsShortRange(route_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Lang[Config.lang]['destination_blip'])
	EndTextCommandSetBlipName(route_blip)
	SetBlipRoute(route_blip,true)
	closeUI()
	while IsEntityAVehicle(trailer) do 
		timer = 2000
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)
		local distance = #(GetEntityCoords(ped) - vector3(x,y,z))

		if distance <= 50.0 then
			timer = 1
			if distance <= 4.0 and veh == truck and GetEntityHeading(truck) + 10 >= h and GetEntityHeading(truck) - 10 <= h and GetEntityHeading(trailer) + 10 >= h and GetEntityHeading(trailer) - 10 <= h and IsEntityAttachedToEntity(truck,trailer) then
				DrawMarker(30,x,y,z-0.6,0,0,0,90.0,h,0.0,3.0,1.0,10.0,0,255,0,50,0,0,0,0)
				drawTxt(Lang[Config.lang]['press_e_to_park'], 8,0.5,0.90,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then
					BringVehicleToHalt(truck, 2.5, 1, false)
					Citizen.Wait(10)
					DoScreenFadeOut(500)
					Citizen.Wait(500)
					DeleteVehicle(trailer)
					RemoveBlip(trailer_blip)
					RemoveBlip(route_blip)
					PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
					Citizen.CreateThreadNow(function()
						showScaleform(Lang[Config.lang]['success'], Lang[Config.lang]['finished_job'], 3)
					end)
					trailer = nil
					trailer_blip = nil
					route_blip = nil
					TriggerServerEvent("truck_logistics:finishJob",data,job_distance,reward,truck_data,GetVehicleEngineHealth(truck),GetVehicleBodyHealth(truck),GetVehicleBodyHealth(trailer))
					break
				end
			else
				drawTxt(Lang[Config.lang]['park_your_truck'], 8,0.5,0.90,0.50,255,255,255,180)
				DrawMarker(30,x,y,z-0.6,0,0,0,90.0,h,0.0,3.0,1.0,10.0,255,0,0,50,0,0,0,0)
			end
		end
		
		local bodyhealth = GetVehicleBodyHealth(trailer)
		if bodyhealth <= 150 then
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
			TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['failed'])
			
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			DeleteVehicle(trailer)
			trailer = nil
			trailer_blip = nil
			route_blip = nil
			break
		end

		if IsControlPressed(0,Config.contratos['cancel_contrato']) then
			DeleteVehicle(trailer)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			trailer = nil
			trailer_blip = nil
			route_blip = nil
			rentTruck = false
			if data.contract_type == 0 then
				DeleteVehicle(truck)
				RemoveBlip(truck_blip)
				truck = nil
				truck_blip = nil
			end
			break
		end
		Wait(timer)
	end

	while IsEntityAVehicle(truck) and data.contract_type == 0 do 
		timer = 2000
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)
		for k,v in pairs(Config.empresas) do
			for k,mark in pairs(v.coordenada_garagem) do
				local x,y,z = table.unpack(mark)
				local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
				timer = 1
				if veh == truck and distance <= 20.0 then
					DrawMarker(39,x,y,z,0,0,0,0.0,0,0,2.0,2.0,2.0,255,0,0,50,0,0,0,1)
					if distance <= 5.0 then
						drawTxt(Lang[Config.lang]['press_e_to_store_truck'], 8,0.5,0.90,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							DeleteVehicle(truck)
							RemoveBlip(truck_blip)
							RemoveBlip(route_blip)
							truck = nil
							truck_blip = nil
							route_blip = nil
							rentTruck = false
						end
					end
				else
					drawTxt(Lang[Config.lang]['bring_back'], 8,0.5,0.90,0.50,255,255,255,180)
				end
			end
		end
		Wait(timer)
	end

	DeleteVehicle(trailer)
	RemoveBlip(trailer_blip)
	RemoveBlip(route_blip)
	trailer = nil
	trailer_blip = nil
	route_blip = nil
	rentTruck = false
	if data.contract_type == 0 then
		DeleteVehicle(truck)
		RemoveBlip(truck_blip)
		truck = nil
		truck_blip = nil
	end
end)

function resetLoading()
	Citizen.Wait(50000)
	if loading == true then
		TriggerEvent("Johnny_Trucker:Notify","negado",Lang[Config.lang]['loading_fail'])
		loading = false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

function showScaleform(title, desc, sec)
	function Initialize(scaleform)
		local scaleform = RequestScaleformMovie(scaleform)

		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieFunctionParameterString(title)
		PushScaleformMovieFunctionParameterString(desc)
		PopScaleformMovieFunctionVoid()
		return scaleform
	end
	scaleform = Initialize("mp_big_message_freemode")
	while sec > 0 do
		sec = sec - 0.02
		Citizen.Wait(0)
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
	end
	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

local JobBlips = {}

function addBlip(x,y,z,idtype,idcolor,text,scale,route)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,idtype)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip,scale)

	if route then
		SetBlipRoute(blip,true)
	end

	if text then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

function refreshBlips()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	if PlayerData.job.name == 'camionista' then
		for k,v in pairs(Config.blips) do
			local blip = addBlip(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8])
			table.insert(JobBlips, blip)
		end
	end
end

function deleteBlips()
	for k,v in ipairs(JobBlips) do
		RemoveBlip(v)
		JobBlips[k] = nil
	end
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

GetVehiclesInArea = function(coords, maxDistance) return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance) end
IsSpawnPointClear = function(coords, maxDistance) return #GetVehiclesInArea(coords, maxDistance) == 0 end

local anims = {}

function playAnim(upper, seq, looping)
    stopAnim(upper)

    local flags = 0
    if upper then flags = flags+48 end
    if looping then flags = flags+1 end

    Citizen.CreateThread(function()
      for k,v in pairs(seq) do
        local dict = v[1]
        local name = v[2]
        local loops = v[3] or 1

        for i=1,loops do
            local first = (k == 1 and i == 1)
            local last = (k == #seq and i == loops)

            -- request anim dict
            RequestAnimDict(dict)
            local i = 0
            while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
              Citizen.Wait(10)
              RequestAnimDict(dict)
              i = i+1
            end

            -- play anim
            if HasAnimDictLoaded(dict)then
              local inspeed = 8.0001
              local outspeed = -8.0001
              if not first then inspeed = 2.0001 end
              if not last then outspeed = 2.0001 end

              TaskPlayAnim(GetPlayerPed(-1),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
            end

            Citizen.Wait(0)
            while GetEntityAnimCurrentTime(GetPlayerPed(-1),dict,name) <= 0.95 and IsEntityPlayingAnim(GetPlayerPed(-1),dict,name,3) and anims[id] do
              Citizen.Wait(0)
            end
          end
      end
    end)
end
function stopAnim(upper)
	anims = {} -- stop all sequences
	if upper then
	  	ClearPedSecondaryTask(GetPlayerPed(-1))
	else
	  	ClearPedTasks(GetPlayerPed(-1))
	end
end

function print_table(node)
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
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))

		ESX.TriggerServerCallback('JAM_VehicleShop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('JAM_VehicleShop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end