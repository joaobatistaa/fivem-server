local CurrentAction		= nil
local PlayerData		= {}
animDict = 'missfbi5ig_0'
animName = 'lyinginpain_loop_steve'
local inBedDicts = "anim@gangops@morgue@table@"
local inBedAnims = "ko_front"
local incar = false

Citizen.CreateThread(function()
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

RegisterCommand('dvcama', function()
	local stretcher = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('v_med_emptybed'))
	local stretcher2 = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('prop_ld_binbag_01'))
	
	if PlayerData.job.name == 'ambulance' then
		if DoesEntityExist(stretcher) then
			DeleteEntity(stretcher)
		elseif DoesEntityExist(stretcher2) then
			DeleteEntity(stretcher2)
		end
	end
end, false)

function VehicleInFront()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

RegisterNetEvent("esx_ambulancejob:macaveiculo")
AddEventHandler("esx_ambulancejob:macaveiculo", function()
	
	local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if IsEntityAttachedToAnyVehicle(closestObject) then
    	incar = true
    elseif IsEntityAttachedToEntity(closestObject, veh) then 
    	incar = true
    end
    if incar == false then 
        StreachertoCar()
        incar = true
    elseif incar == true then
        incar = false
        StretcheroutCar()
    end
end)

function StreachertoCar()
    local veh = VehicleInFront()
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            AttachEntityToEntity(closestObject, veh, 0.0, -0.1, -1.5, 0.3, 0.0, 0.0, 360.0, false, false, true, false, 2, true)
            FreezeEntityPosition(closestObject, true)
			exports['mythic_notify']:DoHudText('success', 'Maca colocada na ambulância!')
        else
			exports['mythic_notify']:DoHudText('error', 'Não estás perto de uma ambulância!')
        end
    else
		exports['mythic_notify']:DoHudText('error', 'Não estás perto de uma maca!')
    end
end

local stretcherObject = nil

RegisterNetEvent("esx_ambulance:client:atualizarPosicaoMaca")
AddEventHandler("esx_ambulance:client:atualizarPosicaoMaca", function(x, y, z)
    if stretcherObject ~= nil and DoesEntityExist(stretcherObject) then
        SetEntityCoords(stretcherObject, x, y, z)
    end
end)

function StretcheroutCar()
    local veh = VehicleInFront()
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            DetachEntity(closestObject, true, true)
            FreezeEntityPosition(closestObject, false)
            local coords = GetEntityCoords(closestObject, false)
			stretcherObject = closestObject
			SetEntityCoords(closestObject, coords.x-3.0,coords.y,coords.z-0.8)
			TriggerServerEvent("esx_ambulance:server:atualizarPosicaoMaca", coords.x-3.0,coords.y,coords.z-0.8)
			exports['mythic_notify']:DoHudText('success', 'Maca retirada da ambulância!')
		--	PlaceObjectOnGroundProperly(closestObject)
        else
            exports['mythic_notify']:DoHudText('error', 'Não estás perto de uma ambulância!')
        end
    else
		exports['mythic_notify']:DoHudText('error', 'Não existe nenhuma maca dentro da ambulância!')
    end
end

Citizen.CreateThread(function()
	while true do
		local sleep = 2000

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_emptybed"), false)
        local closestObject2 = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
		--local closestObject3 = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed1"), false)

		if DoesEntityExist(closestObject) then

			local stretcherCoords = GetEntityCoords(closestObject)
			local stretcherForward = GetEntityForwardVector(closestObject)
			local sitCoords = (stretcherCoords + stretcherForward * - 0.5)
			local pickupCoords = (stretcherCoords + stretcherForward * 0.3)
			
			--[[
			if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 1.5 and not IsPedInAnyVehicle(ped) then
				sleep = 5
				DrawText3Ds2(sitCoords, "[G] Deitar", 0.3)

				if IsControlJustPressed(0, 47) then
					Sit(closestObject)
				end
			end
			--]]

			if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 2.5 and not IsPedInAnyVehicle(ped) and PlayerData.job.name == 'ambulance' then
				sleep = 5
				DrawText3Ds2(pickupCoords, "[ALT] Empurrar", 0.3)

				if IsControlJustPressed(0, 19) then
					PickUp(closestObject)
				end
            end
        elseif DoesEntityExist(closestObject2) then

			local stretcherCoords = GetEntityCoords(closestObject2)
			local stretcherForward = GetEntityForwardVector(closestObject2)
			local sitCoords = (stretcherCoords + stretcherForward * - 0.5)
			local pickupCoords = (stretcherCoords + stretcherForward * 0.3)

			if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 and not IsPedInAnyVehicle(ped) then
				sleep = 5
				DrawText3Ds2(sitCoords, "[G] Deitar", 0.3)

				if IsControlJustPressed(0, 47) then
					Sit2(closestObject2)
				end
			end

			if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 2.0 and not IsPedInAnyVehicle(ped) and PlayerData.job.name == 'ambulance' then
				sleep = 5
				DrawText3Ds2(pickupCoords, "[ALT] Empurrar", 0.3)

				if IsControlJustPressed(0, 19) then
					PickUp2(closestObject2)
				end
            end
		--[[elseif DoesEntityExist(closestObject3) then

			local stretcherCoords = GetEntityCoords(closestObject3)
			local stretcherForward = GetEntityForwardVector(closestObject3)
			local sitCoords = (stretcherCoords + stretcherForward * - 0.5)
			local pickupCoords = (stretcherCoords + stretcherForward * 0.3)

			if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 and not IsPedInAnyVehicle(ped) then
				sleep = 5
				DrawText3Ds2(sitCoords, "[G] Deitar", 0.3)

				if IsControlJustPressed(0, 47) then
					Sit(closestObject3)
				end
			end
			--]]
		end

		Citizen.Wait(sleep)
	end
end)

Sit = function(stretcherObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missfbi5ig_0', 'lyinginpain_loop_steve', 3) or IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'ko_front', 'anim@gangops@morgue@table@', 3) then
			exports['mythic_notify']:DoHudText('error', 'A cama já está a ser usada!')
			return
		end
	end

	LoadAnim("missfbi5ig_0")

	AttachEntityToEntity(PlayerPedId(), stretcherObject, 0, 0, 0.0, 1.3, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(stretcherObject)

	while IsEntityAttachedToEntity(PlayerPedId(), stretcherObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), 'missfbi5ig_0', 'lyinginpain_loop_steve', 1) then
			
			TaskPlayAnim(PlayerPedId(), 'missfbi5ig_0', 'lyinginpain_loop_steve', 1.0, 2.0, -1, 45, 1.0, 0, 0, 0)
			
			
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(stretcherObject) + GetEntityForwardVector(stretcherObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
		end
	end
end


Sit2 = function(stretcherObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), inBedDicts, inBedAnims, 3) then
			exports['mythic_notify']:DoHudText('error', 'A maca já está a ser usada!')
			return
		end
	end

	LoadAnim(inBedDicts)

	AttachEntityToEntity(PlayerPedId(), stretcherObject, 0, 0, 0.0, 1.1, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(stretcherObject)

	while IsEntityAttachedToEntity(PlayerPedId(), stretcherObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPedId()) then
			DetachEntity(PlayerPedId(), true, true)
		end

		if not IsEntityPlayingAnim(PlayerPedId(), inBedDicts, inBedAnims, 1) then
			
			--TaskPlayAnim(PlayerPedId(), 'missfbi5ig_0', 'lyinginpain_loop_steve', 1.0, 2.0, -1, 45, 1.0, 0, 0, 0)
            TaskPlayAnim(PlayerPedId(), inBedDicts, inBedAnims, 8.0, 8.0, -1, 69, 1, false, false, false)
			
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(PlayerPedId(), true, true)

			local x, y, z = table.unpack(GetEntityCoords(stretcherObject) + GetEntityForwardVector(stretcherObject) * - 0.7)

			SetEntityCoords(PlayerPedId(), x,y,z)
		end
	end
end

PickUp = function(stretcherObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
			exports['mythic_notify']:DoHudText('error', 'A cama já está a ser empurrada!')
			return
		end
	end

	NetworkRequestControlOfEntity(stretcherObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(stretcherObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.0, -1.2, -1.0, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(stretcherObject, PlayerPedId()) do
		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(PlayerPedId()) then
			local playerPed = GetPlayerPed(-1)
			local playerCoords = GetEntityCoords(playerPed)
			local playerHeading = GetEntityHeading(playerPed)
			local forwardVector = GetEntityForwardVector(playerPed)

			DetachEntity(stretcherObject, true, true)

			local offsetX = 1.5 -- ajuste para a posição da maca em relação ao jogador
			local offsetY = 0.0 -- ajuste para a posição da maca em relação ao jogador
			local offsetZ = -0.45 -- ajuste para a posição da maca em relação ao chão
			local newPosition = playerCoords + (forwardVector * offsetX) + (vector3(0, offsetY, offsetZ))

			SetEntityCoords(stretcherObject, newPosition)
			SetEntityRotation(stretcherObject, 0.0, 0.0, playerHeading + 180.0)
		end

		if IsControlJustPressed(0, 73) then
			local playerPed = GetPlayerPed(-1)
			local playerCoords = GetEntityCoords(playerPed)
			local playerHeading = GetEntityHeading(playerPed)
			local forwardVector = GetEntityForwardVector(playerPed)

			DetachEntity(stretcherObject, true, true)

			local offsetX = 1.5 -- ajuste para a posição da maca em relação ao jogador
			local offsetY = 0.0 -- ajuste para a posição da maca em relação ao jogador
			local offsetZ = -0.45 -- ajuste para a posição da maca em relação ao chão
			local newPosition = playerCoords + (forwardVector * offsetX) + (vector3(0, offsetY, offsetZ))

			SetEntityCoords(stretcherObject, newPosition)
			SetEntityRotation(stretcherObject, 0.0, 0.0, playerHeading + 180.0)
		end
	end
end

PickUp2 = function(stretcherObject)
	local closestPlayer, closestPlayerDist = GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
			exports['mythic_notify']:DoHudText('error', 'A maca já está a ser empurrada!')
			return
		end
	end

	NetworkRequestControlOfEntity(stretcherObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(stretcherObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -1.0, -0.45, 15.0, 0.0, 360.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(stretcherObject, PlayerPedId()) do
		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(PlayerPedId()) then
			local playerPed = GetPlayerPed(-1)
			local playerCoords = GetEntityCoords(playerPed)
			local playerHeading = GetEntityHeading(playerPed)
			local forwardVector = GetEntityForwardVector(playerPed)

			DetachEntity(stretcherObject, true, true)

			local offsetX = 1.5 -- ajuste para a posição da maca em relação ao jogador
			local offsetY = 0.0 -- ajuste para a posição da maca em relação ao jogador
			local offsetZ = -0.15 -- ajuste para a posição da maca em relação ao chão
			local newPosition = playerCoords + (forwardVector * offsetX) + (vector3(0, offsetY, offsetZ))

			SetEntityCoords(stretcherObject, newPosition)
			SetEntityRotation(stretcherObject, 0.0, 0.0, playerHeading + 180.0)
		end

		if IsControlJustPressed(0, 73) then
			local playerPed = GetPlayerPed(-1)
			local playerCoords = GetEntityCoords(playerPed)
			local playerHeading = GetEntityHeading(playerPed)
			local forwardVector = GetEntityForwardVector(playerPed)

			DetachEntity(stretcherObject, true, true)

			local offsetX = 1.5 -- ajuste para a posição da maca em relação ao jogador
			local offsetY = 0.0 -- ajuste para a posição da maca em relação ao jogador
			local offsetZ = -0.15 -- ajuste para a posição da maca em relação ao chão
			local newPosition = playerCoords + (forwardVector * offsetX) + (vector3(0, offsetY, offsetZ))

			SetEntityCoords(stretcherObject, newPosition)
			SetEntityRotation(stretcherObject, 0.0, 0.0, playerHeading + 180.0)
		end
	end
end

DrawText3Ds2 = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 370

	DrawRect(_x, _y + 0.010, 0.020 + factor, 0.025, 41, 11, 41, 100)
end

GetPlayers = function()
    local players = {}

	for _,player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)

		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end

    return players
end

GetClosestPlayer = function()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

LoadAnim = function(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		
		Citizen.Wait(1)
	end
end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		
		Citizen.Wait(1)
	end
end

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end