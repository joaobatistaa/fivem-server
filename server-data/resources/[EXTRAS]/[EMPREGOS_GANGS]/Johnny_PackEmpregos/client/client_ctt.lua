local currentJobCtt = {}
local restockObject = {}
local restockObjectLocation = {}
local onJobCtt = false 
local goPostalVehicle = nil
local currentJobPay = 0
local PackageObject = nil
local currentPackages = 0
local missionblipCtt = nil
local blipCtt = nil 
local blipTraseirasCtt = nil 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	CreateBlipCtt()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	CreateBlipCtt()	
end)

function CreateBlipCtt()
	if PlayerData.job ~= nil and PlayerData.job.name == 'ctt' then
		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(62.82892, 113.5551, 79.089)
			SetBlipSprite(BlipCloakRoom, 541)
			SetBlipDisplay(blipCtt, 4)
			SetBlipScale  (blipCtt, 1.1)
			SetBlipColour(BlipCloakRoom, 46)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('CTT')
			EndTextCommandSetBlipName(BlipCloakRoom)
		end	
	else
		if BlipCloakRoom ~= nil then
			RemoveBlip(BlipCloakRoom)
			BlipCloakRoom = nil
		end
		if missionblipCtt ~= nil then
			RemoveBlip(missionblipCtt)
			missionblipCtt = nil
		end
		if blipTraseirasCtt ~= nil then
			RemoveBlip(blipTraseirasCtt)
			blipTraseirasCtt = nil
		end
	end
end


local encomendanamao = false

Citizen.CreateThread(function()
	while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(0)
		CreateBlipCtt()
		local canSleep = true
		if PlayerData.job ~= nil and PlayerData.job.name == 'ctt' then
			canSleep = false
			local ped = PlayerPedId()
			if(GetDistanceBetweenCoords(GetEntityCoords(ped), 78.75800, 111.8961, 81.168, true) < 15) then
				DrawMarker(2, 78.75800, 111.8961, 81.168, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
				--DrawMarker(23, -402.732, 6172.939, 31.532-0.9, 0, 0, 0, 0.0, 0, 0, 3.0, 3.0, 0.5001, 255, 255, 255, 255, 0, 0, 0, 0)
				if(GetDistanceBetweenCoords(GetEntityCoords(ped), 78.75800, 111.8961, 81.168, true) < 1.5) then
					DrawText3D(78.75800, 111.8961, 81.168+0.3, "~g~E~w~ - Trocar de Roupa")
					if IsControlJustPressed(0, 38) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'roupeiro_carteiro') then 
						VestiarioCarteiro()
					end
				end
			end
			if(GetDistanceBetweenCoords(GetEntityCoords(ped), 65.06771, 124.0876, 79.077, true) < 15) then
				DrawMarker(2, 65.06771, 124.0876, 79.077, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
				--DrawMarker(23, -402.732, 6172.939, 31.532-0.9, 0, 0, 0, 0.0, 0, 0, 3.0, 3.0, 0.5001, 255, 255, 255, 255, 0, 0, 0, 0)
				if(GetDistanceBetweenCoords(GetEntityCoords(ped), 65.06771, 124.0876, 79.077, true) < 1.5) then
					if DoesEntityExist(goPostalVehicle) then 
						DrawText3D(65.06771, 124.0876, 79.077+0.3, "~g~E~w~ - Terminar Trabalho")
					else
						DrawText3D(65.06771, 124.0876, 79.077+0.3, "~g~E~w~ - Iniciar Trabalho")
					end
					if IsControlJustPressed(0, 38) then 
						if DoesEntityExist(goPostalVehicle) then 
							onJobCtt = false
							local model = GetDisplayNameFromVehicleModel(GetEntityModel(goPostalVehicle))
							local plate = GetVehicleNumberPlateText(goPostalVehicle)
							--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
							exports['qs-vehiclekeys']:RemoveKeysAuto()
							DeleteVehicle(goPostalVehicle)
							RemoveJobCttBlip()
						else
							local freespot, v = getParkingPositionCtt(Config.CarteiroInfo.vehicleSpawnLocations)
							if freespot then 
								SpawnGoPostal(v.x, v.y, v.z, v.h) 
								newShiftCtt()
								onJobCtt = true
								exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Veículo carregado, podes começar agora a entregar as encomendas!", 5000, 'success')
							else
								exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Os spawnpoints estão todos ocupados!", 5000, 'error')
							end
						end
					end
				end
			end
			--[[
			if(GetDistanceBetweenCoords(GetEntityCoords(ped), -441.282, 6142.714, 31.478, true) < 40) and IsVehicleModel(GetVehiclePedIsIn(ped, true), GetHashKey("pony")) and DoesEntityExist(goPostalVehicle) then
				DrawMarker(23, -441.282, 6142.714, 31.478-0.95, 0, 0, 0, 0.0, 0, 0, 3.0, 3.0, 0.5001, 255, 255, 255, 255, 0, 0, 0, 0)
				if(GetDistanceBetweenCoords(GetEntityCoords(ped), -441.282, 6142.714, 31.478, true) < 4) then
					RemoveBlipTraseirasCtt()
					if not onJobCtt then 
						DrawText3D(-441.282, 6142.714, 31.478+0.5, "~w~Pressiona ~r~[E]~w~ para carregar o veículo", 200)
		
						if IsControlJustPressed(0, 38) then
							if goPostalVehicle ~= nil and goPostalVehicle ~= 0 and goPostalVehicle ~= 1 then
								--if GetVehicleDoorAngleRatio(goPostalVehicle, 2) > 0 and GetVehicleDoorAngleRatio(goPostalVehicle, 3) > 0 then
									restockVan()
									
								--else
									--exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>Tens que abrir as portas da bagageira para colocar as caixas!", 10000, 'info')
								--end
							end	
						end
					end
				end
			end
			--]]
			
			if(GetDistanceBetweenCoords(GetEntityCoords(ped), currentJobCtt[1], currentJobCtt[2], currentJobCtt[3], true) < 20) and onJobCtt then
				DrawMarker(0, currentJobCtt[1], currentJobCtt[2], currentJobCtt[3], 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 112, 100,210, true, true, 0,0)
				if(GetDistanceBetweenCoords(GetEntityCoords(ped), currentJobCtt[1], currentJobCtt[2], currentJobCtt[3], true) < 1.5) then
					if encomendanamao then
						drawTxt('~w~Pressiona ~r~[E]~w~ para entregar a encomenda')

						if IsControlJustPressed(0, 38) then
							encomendanamao = false
							DeleteObject(PackageObject)
							ClearPedTasks(ped)
							PackageObject = nil 
							TriggerServerEvent('gopostal:caasdfjasjlfsash', currentJobPay, onJobCtt)
		  
							newShiftCtt()
						end
					end
				end
			end
			
			if onJobCtt and not IsPedInAnyVehicle(ped) and GetDistanceBetweenCoords(GetEntityCoords(ped), currentJobCtt[1], currentJobCtt[2], currentJobCtt[3], true) < 20 then 
				--local bootPos = GetEntityCoords(goPostalVehicle)
				local playerpos = GetEntityCoords(ped, 1)
				local trunkpos = GetWorldPositionOfEntityBone(goPostalVehicle, GetEntityBoneIndexByName(goPostalVehicle, "reversinglight_l"))
				local distanceToTrunk = GetDistanceBetweenCoords(trunkpos, playerpos, 1)
				
				if distanceToTrunk < 1.6 and PackageObject == nil then 
					drawTxt('~w~Pressiona ~r~[E]~w~ para pegar na encomenda')
					if IsControlJustPressed(0, 38) then
						--if GetVehicleDoorAngleRatio(goPostalVehicle, 2) > 0 and GetVehicleDoorAngleRatio(goPostalVehicle, 3) > 0 then
							SetVehicleDoorOpen(goPostalVehicle, 2, false)
							SetVehicleDoorOpen(goPostalVehicle, 3, false)
							Citizen.Wait(1500)
							encomendanamao = true
							loadModel("prop_cs_cardbox_01")
							local pos = GetEntityCoords(GetPlayerPed(-1), false)
							PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), pos.x, pos.y, pos.z, true, true, true)
							AttachEntityToEntity(PackageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
							loadAnimDict("anim@heists@box_carry@")
							TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
							Citizen.Wait(1000)
							SetVehicleDoorShut(goPostalVehicle, 2, false)
							SetVehicleDoorShut(goPostalVehicle, 3, false)
						--else
							--exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>Tens que abrir as portas da bagageira para retirar a encomenda!", 10000, 'info')
						--end
					end
				end 
			end
		end
		if canSleep then
			Citizen.Wait(2000)
		end
	end
end)

function VestiarioCarteiro()

	local elements = {
		{label = 'Roupa Normal', value = 'cloakroom2'},
		{label = 'Roupa de Carteiro', value = 'cloakroom'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'roupeiro_carteiro',
    {
      title    = 'Vestiário',
	  align    = 'top-left',
      elements = elements
    },
    function(data, menu)  
		if data.current.value == 'cloakroom' then
			menu.close()
			setUniformCarteiro(data.current.value)
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

function setUniformCarteiro(job)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.CarteiroInfo.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.CarteiroInfo.Uniforms[job].male)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		else
			if Config.CarteiroInfo.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.CarteiroInfo.Uniforms[job].female)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		end
	end)
end

function restockVan()
	local ped = PlayerPedId()
	local restockPackages = 8
	local restockVan = true
	local carryingPackage = {status = false, id = nil}
	for id,v in pairs(Config.CarteiroInfo.restockLocations) do 
		restockObject[id] = CreateObject(GetHashKey("prop_cs_cardbox_01"), v[1],v[2],v[3]-0.95, true, true, true)
		restockObjectLocation[id] = v 
		PlaceObjectOnGroundProperly(restockObject[id])
	end
	while restockVan do 
		Wait(1)
		for id,v in pairs(restockObjectLocation) do 
			DrawMarker(2, v[1],v[2],v[3], 0,0,0,0,0,0,0.5,0.5,0.5,255,255,0,165,0,0,0,0)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1],v[2],v[3], true) < 1.0 then
				drawTxt('~w~Pressiona ~r~[E]~w~ para pegar na encomenda')
				if IsControlJustPressed(0, 38) then 
					AttachEntityToEntity(restockObject[id], PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
					loadAnimDict("anim@heists@box_carry@")
					TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
					carryingPackage.status = true
					carryingPackage.id = id
				end
			end
		end
		if carryingPackage.status then 
			local playerpos = GetEntityCoords(ped, 1)
			local trunkpos = GetWorldPositionOfEntityBone(goPostalVehicle, GetEntityBoneIndexByName(goPostalVehicle, "reversinglight_l"))
			local distanceToTrunk = GetDistanceBetweenCoords(trunkpos, playerpos, 1)
			
			if distanceToTrunk < 1.6 then 
				drawTxt('~w~Pressiona ~r~[E]~w~ para colocar a encomenda no veículo')
				if IsControlJustPressed(0, 38) then 
					SetVehicleDoorOpen(goPostalVehicle, 2, false)
					SetVehicleDoorOpen(goPostalVehicle, 3, false)
					Citizen.Wait(1500)
					DeleteObject(restockObject[carryingPackage.id])
					ClearPedTasks(ped)
					carryingPackage.status = false
					restockObjectLocation[carryingPackage.id] = {}
					restockObject[carryingPackage.id] = nil
					restockPackages = restockPackages-1
					Citizen.Wait(1000)
					SetVehicleDoorShut(goPostalVehicle, 2, false)
					SetVehicleDoorShut(goPostalVehicle, 3, false)
					if restockPackages == 0 then 
						restockVan = false
						newShiftCtt()
						onJobCtt = true
						exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Veículo carregado, podes começar agora a entregar as encomendas!", 5000, 'success')
					end
				end
			end
		end
	end
end

function newShiftCtt()
	local id = math.random(1,3)
	if id == 1 then 
		local jobLocation = Config.CarteiroInfo.locations['Grapeseed'][math.random(1, Config.CarteiroInfo.locations['Grapeseed']['Max'])] 
		SetJobCttBlip(jobLocation[1],jobLocation[2],jobLocation[3])
		currentJobCtt = jobLocation
	elseif id == 2 then 
		local jobLocation = Config.CarteiroInfo.locations['Sandy Shores'][math.random(1, Config.CarteiroInfo.locations['Sandy Shores']['Max'])]
		SetJobCttBlip(jobLocation[1],jobLocation[2],jobLocation[3])
		currentJobCtt = jobLocation
	elseif id == 3 then 
		local jobLocation = Config.CarteiroInfo.locations['Paleto Bay'][math.random(1, Config.CarteiroInfo.locations['Paleto Bay']['Max'])]
		SetJobCttBlip(jobLocation[1],jobLocation[2],jobLocation[3])
		currentJobCtt = jobLocation
	end
--currentJobPay = CalculateTravelDistanceBetweenPoints(GetEntityCoords(GetPlayerPed(-1)), currentJobCtt[1],currentJobCtt[2],currentJobCtt[3])/2/4
--if currentJobPay > 60 then 
	currentJobPay = Config.CarteiroInfo.Salario  ---- CONFIGURAÇÃO DO DINHEIRO QUE VAI RECEBER POR ENCOMENDA QUE ENTREGA
--end
end

function SpawnGoPostal(x,y,z,h)
	local vehicleHash = GetHashKey('pony')
	RequestModel(vehicleHash)
	while not HasModelLoaded(vehicleHash) do
		Citizen.Wait(0)
	end
	
	local ped = PlayerPedId()
	goPostalVehicle = CreateVehicle(vehicleHash, x, y, z, h, true, false)
	local id = NetworkGetNetworkIdFromEntity(goPostalVehicle)
	SetNetworkIdCanMigrate(id, true)
	SetNetworkIdExistsOnAllMachines(id, true)
	SetVehicleDirtLevel(goPostalVehicle, 0)
	SetVehicleHasBeenOwnedByPlayer(goPostalVehicle, true)
	SetEntityAsMissionEntity(goPostalVehicle, true, true)
	SetVehicleEngineOn(goPostalVehicle, true)
	local plate = 'CTT' .. math.random(100, 900)
	SetVehicleNumberPlateText(goPostalVehicle, plate)
	exports["Johnny_Combustivel"]:SetFuel(goPostalVehicle, 100)
	exports['qs-vehiclekeys']:GiveKeysAuto()
	--TriggerServerEvent('vehiclekeys:server:givekey', plate, 'pony')
	TaskWarpPedIntoVehicle(ped, goPostalVehicle, -1)
end

function getParkingPositionCtt(spots)
	for id,v in pairs(spots) do 
		if GetClosestVehicle(v.x, v.y, v.z, 3.0, 0, 70) == 0 then  
			return true, v
		end
	end 
	exports['Johnny_Notificacoes']:Alert("PARQUE CHEIO", "<span style='color:#c7c7c7'> O parque de estacionamento está cheio, por favor aguarda!", 5000, 'warning')
end

function SetJobCttBlip(x,y,z)
	if DoesBlipExist(missionblipCtt) then RemoveBlip(missionblipCtt) end
	missionblipCtt = AddBlipForCoord(x,y,z)
	SetBlipSprite(missionblipCtt, 164)
	SetBlipColour(missionblipCtt, 27)
	SetBlipRoute(missionblipCtt, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Destino")
	EndTextCommandSetBlipName(missionblipCtt)
end

function RemoveJobCttBlip()
	if DoesBlipExist(missionblipCtt) then RemoveBlip(missionblipCtt) end
end

function SetBlipTraseiras(x,y,z)
	if DoesBlipExist(blipTraseirasCtt) then RemoveBlip(blipTraseirasCtt) end
	blipTraseirasCtt = AddBlipForCoord(x,y,z)
	SetBlipSprite(blipTraseirasCtt, 164)
	SetBlipColour(blipTraseirasCtt, 27)
	SetBlipRoute(blipTraseirasCtt, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Traseiras Ctt")
	EndTextCommandSetBlipName(blipTraseirasCtt)
end

function RemoveBlipTraseirasCtt()
	if DoesBlipExist(blipTraseirasCtt) then RemoveBlip(blipTraseirasCtt) end
end