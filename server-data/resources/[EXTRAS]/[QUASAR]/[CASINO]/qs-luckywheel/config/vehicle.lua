local PlateUseSpace = true
local PlateLetters  = 3
local PlateNumbers  = 3

RegisterNetEvent("casino_luckywheel:winCar")
AddEventHandler("casino_luckywheel:winCar", function() 
    
    ESX.Game.SpawnVehicle(Config.CarModel, { x = 933.29 , y = -2.82 , z = 78.76 }, 144.6, function (vehicle)
        local vehicleData = {}
        vehicleData.model = Config.CarModel
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		local newPlate     = GeneratePlate()
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate

		SetVehicleNumberPlateText(vehicle, newPlate)
		exports['qs-vehiclekeys']:GiveKeysAuto()
		--TriggerServerEvent('vehiclekeys:server:givekey', vehicleProps.plate, vehicleData.model)
        --TriggerServerEvent(Config.esx_vehicleshopsetVehicleOwned, vehicleProps, vehicleData)   
	end)
    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)

----

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
		if PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. ' ' .. GetRandomNumber(PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. GetRandomNumber(PlateNumbers))
		end

		ESX.TriggerServerCallback(Config.esx_vehicleshopisPlateTaken, function (isPlateTaken)
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

	ESX.TriggerServerCallback(Config.esx_vehicleshopisPlateTaken, function(isPlateTaken)
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