local script_active = true
ESX = nil
local draw = {}

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

RegisterNUICallback('lootbox:NUIoff', function(data, cb)
	SetNuiFocus(false,false)
    SendNUIMessage({
        type = "off"
    })
end)

RegisterNetEvent("lootbox:openGacha")
AddEventHandler("lootbox:openGacha", function(data)
    if Config.CloseInventoryHudTrigger ~= '' and Config.CloseInventoryHudTrigger ~= nil then
        TriggerEvent(Config.CloseInventoryHudTrigger)
    end
    
	local sum = 0
	draw = {}
	for k, v in pairs(Config["lootbox"][data].list) do
		local rate = Config["chance"][v.tier].rate * 100
		for i=1,rate do 
			if v.item then
				if v.amount then
					table.insert(draw, {item = v.item ,amount = v.amount, tier = v.tier})
				else
					table.insert(draw, {item = v.item ,amount = 1, tier = v.tier})
				end
			elseif v.weapon then
				table.insert(draw, {weapon = v.weapon , tier = v.tier})
			elseif v.vehicle then
				table.insert(draw, {vehicle = v.vehicle, tier = v.tier})
			elseif v.money then
				table.insert(draw, {money = v.money, tier = v.tier})
			elseif v.black_money then
				table.insert(draw, {black_money = v.black_money, tier = v.tier})
			end
			i = i + 1
		end
		sum = sum + rate
	end
	local random = math.random(1,sum)
	SetNuiFocus(true,true)
	SendNUIMessage({
        type = "ui",
		data = Config["lootbox"][data].list,
		img = Config["image_source"],
		win = draw[random]
    })
	Wait(9000)
	if draw[random].item then
		TriggerServerEvent('lootbox:giveReward', 'item',draw[random].item,draw[random].amount)
	elseif draw[random].weapon then
		TriggerServerEvent('lootbox:giveReward', 'weapon',draw[random].weapon)
	elseif draw[random].vehicle then
		TriggerEvent('lootbox:RewardVehicle', draw[random].vehicle)
	elseif draw[random].money then
		TriggerServerEvent('lootbox:giveReward', 'money',draw[random].money)
	elseif draw[random].black_money then
		TriggerServerEvent('lootbox:giveReward', 'black_money',draw[random].black_money)
	end

    if Config["broadcast"] then
        TriggerServerEvent("lootbox:boradcast", draw[random].tier)
    end
end)

--ESX_VEHICLE 

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
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomNumber(2) .. ' ' .. GetRandomLetter(2) .. ' ' ..  GetRandomNumber(2))
		else
			generatedPlate = string.upper(GetRandomNumber(2) .. ' ' .. GetRandomLetter(2) .. ' ' ..  GetRandomNumber(2))
		end

		ESX.TriggerServerCallback('d3x_vehicleshop:isPlateTaken', function (isPlateTaken)
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

	ESX.TriggerServerCallback('d3x_vehicleshop:isPlateTaken', function(isPlateTaken)
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


RegisterNetEvent('lootbox:RewardVehicle')
AddEventHandler('lootbox:RewardVehicle', function(model)
        -- local playerPed  = GetPlayerPed(-1)
        -- local coords     = GetEntityCoords(playerPed)
        -- local Px, Py, Pz = table.unpack(coords)

        ESX.Game.SpawnVehicle(model, { x = 0, y = 0, z = 0 }, 180, function (vehicle)
            -- TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

            local newPlate     = GeneratePlate()
            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
            vehicleProps.plate = newPlate
            SetVehicleNumberPlateText(vehicle, newPlate)
			
			TriggerServerEvent('d3x_vehicleshop:setVehicleOwned', vehicleProps, 'Bugatti Chiron (JACKPOT CASINO)', 'chiron17', 0)
			TriggerEvent("vehiclekeys:client:SetOwner", vehicleProps.plate)
			TriggerServerEvent("johnny:server:darChaves", vehicleProps.plate, 'chiron17')
                                           
        end)
end)