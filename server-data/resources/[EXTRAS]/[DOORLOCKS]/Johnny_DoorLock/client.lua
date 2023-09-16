ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

local loaded = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	loaded = true
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


Citizen.CreateThread(function() 
    while true do
        Wait(10000)
        if loaded then
            PlayerData = ESX.GetPlayerData()
        end
    end
end)

RegisterNetEvent('kk-doorlock:client:updateState')
AddEventHandler('kk-doorlock:client:updateState', function(doorId, state, forced)
    Config.Doors[doorId].locked = state
    if Config.Doors[doorId].doors ~= nil then
        local doorsId = doorId*1000
	if forced then
		if state then
			DoorSystemSetDoorState(doorsId+1, 4, 0, true)
			DoorSystemSetDoorState(doorsId+2, 4, 0, true)
		end
	else
		DoorSystemSetDoorState(doorsId+1, state and 1 or 0, forced)
		DoorSystemSetDoorState(doorsId+2, state and 1 or 0, forced)
	end
    else
	if forced then
		if state then
			DoorSystemSetDoorState(doorId, 4, 0, true)
		end
	else
		DoorSystemSetDoorState(doorId, state and 1 or 0)
	end
    end
end)

local teste = 0

RegisterNetEvent('kk-doorlock:initialize')
AddEventHandler('kk-doorlock:initialize', function(allDoors)
    for doorId, door in pairs(allDoors) do
        if door.doors ~= nil then
            local doorsId = doorId*1000
		if type(door.doors[1].objHash) == "number" then
			AddDoorToSystem(doorsId+1, door.doors[1].objHash, door.doors[1].objCoords)
		else
			AddDoorToSystem(doorsId+1, GetHashKey(door.doors[1].objHash), door.doors[1].objCoords)
		end

		if type(door.doors[2].objHash) == "number" then
			AddDoorToSystem(doorsId+2, door.doors[2].objHash, door.doors[2].objCoords)
		else
			AddDoorToSystem(doorsId+2, GetHashKey(door.doors[2].objHash), door.doors[2].objCoords)
		end
            DoorSystemSetDoorState(doorsId+1, door.locked and 1 or 0)
            DoorSystemSetDoorState(doorsId+2, door.locked and 1 or 0)
        else
		if type(door.objHash) == "number" then
			AddDoorToSystem(doorId, door.objHash, door.objCoords)
		else
			AddDoorToSystem(doorId, GetHashKey(door.objHash), door.objCoords)
		end
            DoorSystemSetDoorState(doorId, door.locked and 1 or 0)
        end
    end

    while true do
		Citizen.Wait(0)
		local playerCoords, awayFromDoors = GetEntityCoords(PlayerPedId()), true

		for k,doorID in ipairs(Config.Doors) do
			local distance

			if doorID.doors then
				distance = #(playerCoords - doorID.doors[1].objCoords)
			else
				distance = #(playerCoords - doorID.objCoords)
			end
            
			if distance < doorID.maxDistance then
				awayFromDoors = false
				teste = 1
				local isAuthorized = IsAuthorized(doorID)
				if isAuthorized then
					if doorID.locked then
						--displayText = "~w~E~w~ - ~r~Locked"
						exports['okokTextUI']:Open('[E] - Fechado', 'darkred', 'left')
					elseif not doorID.locked then
						--displayText = "~w~E~w~ - ~g~Unlocked"
						exports['okokTextUI']:Open('[E] - Aberto', 'darkgreen', 'left')
					end
				elseif not isAuthorized then
					if doorID.locked then
						--displayText = "~r~Locked"
						exports['okokTextUI']:Open('Fechado', 'darkred', 'left')
					elseif not doorID.locked then
						--displayText = "~g~Unlocked"
						exports['okokTextUI']:Open('Aberto', 'darkgreen', 'left')
					end
				end
				
				--[[
				if doorID.locking then
					if doorID.locked then
						--displayText = "Opening.."
						exports['okokTextUI']:Open('A ABRIR...', 'darkred', 'left')
					else
						--displayText = "Locking.."
						exports['okokTextUI']:Open('A FECHAR...', 'darkred', 'left')
					end
				end
				--]]

				if doorID.objCoords == nil then
					doorID.objCoords = doorID.textCoords
				end

				--DrawText3Ds(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, displayText)

				if IsControlJustReleased(0, 38) then
					if isAuthorized then
						setDoorLocking(doorID, k)
					end
				end
			end
		end

		if awayFromDoors then
			if teste == 1 then
				exports['okokTextUI']:Close()
				teste = 0
			end
			Citizen.Wait(1000)
		end
	end
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

function setDoorLocking(doorId, key)
	--doorId.locking = true
	openDoorAnim()
    SetTimeout(400, function()
        --doorId.locking = false
		TriggerServerEvent('kk-doorlock:server:updateState', key)
		if Config.AutoCloseDoors then
			SetTimeout(Config.DurationBeforeClosing, function()
				if Config.Doors[key].doors ~= nil then
					if DoorSystemGetDoorState(key*1000+1) == 0 then
						TriggerServerEvent('kk-doorlock:server:updateState', key, Config.ForceAutoCloseDoors or false)
					end
				else
					if DoorSystemGetDoorState(key) == 0 then
						TriggerServerEvent('kk-doorlock:server:updateState', key, Config.ForceAutoCloseDoors or false)
					end
				end
			end)
		end
	end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end

end

local PlayerData = nil

function IsAuthorized(doorID)
    if PlayerData == nil then
        PlayerData = ESX.GetPlayerData()
    end

    if not doorID.IsAuthorized then
		if #doorID.authorizedJobs > 1 then
			for i = 1, #doorID.authorizedJobs, 1 do
				if doorID.authorizedJobs[i] == PlayerData.job.name then
					doorID.IsAuthorized = true
					return true
				end
			end
		else
			for _,job in pairs(doorID.authorizedJobs) do
				if job == PlayerData.job.name then
					doorID.IsAuthorized = true
					return true
				end
			end
		end
    else
        return true
    end
	
	return false
end

function openDoorAnim()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
	SetTimeout(400, function()
		ClearPedTasks(PlayerPedId())
	end)
end
