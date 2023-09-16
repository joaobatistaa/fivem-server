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

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local actionDisplayed         = false
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	ESX.TriggerServerCallback('d3x_vehicleshop:getVehicles', function (vehicles)
		Vehicles = vehicles
	end)
	
	Citizen.Wait(1000)
	
	ESX.TriggerServerCallback('d3x_vehicleshop:getCategories', function (categories)
		Categories = categories
	end)
	
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('d3x_vehicleshop:sendCategories')
AddEventHandler('d3x_vehicleshop:sendCategories', function (categories)
	Categories = categories
end)

RegisterNetEvent('d3x_vehicleshop:sendVehicles')
AddEventHandler('d3x_vehicleshop:sendVehicles', function (vehicles)
	Vehicles = vehicles
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

RegisterNetEvent("qs-luckywheel:winCar")
AddEventHandler("qs-luckywheel:winCar", function() 
    
    ESX.Game.SpawnVehicle("chiron17", { x = 933.29 , y = -2.82 , z = 78.76 }, 144.6, function (vehicle)
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)
		
		TriggerServerEvent('d3x_vehicleshop:setVehicleOwned', vehicleProps, 'Bugatti Chiron (JACKPOT CASINO)', 'chiron17', 0)
		--TriggerServerEvent('vehiclekeys:server:givekey', vehicleProps.plate, 'chiron17')
		exports['qs-vehiclekeys']:GiveKeysAuto()
		exports['Johnny_Notificacoes']:Alert("JACKPOT", "<span style='color:#c7c7c7'>Ganhaste um <span style='color:#069a19'><b>Bugatti Chiron</b></span>! PARABÉNS!!!", 5000, 'success')
		
	end)

    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)

function StartShopRestriction()

	Citizen.CreateThread(function()
		while IsInShopMenu do
			Citizen.Wait(1)
	
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)

end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

RegisterNUICallback('TestDrive', function(data, cb) 
	
	startCountDown = true

	local hash = GetHashKey(data.model)

	lastPlayerCoords = GetEntityCoords(PlayerPedId())

	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(10)
		end
	end

	if testDriveEntity ~= nil then
		DeleteEntity(testDriveEntity)
	end

	testDriveEntity = CreateVehicle(hash, -1995.06, 2851.34, 32.81, 56.55, 1, 1)
	SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
	local timeGG = GetGameTimer()

	
   --SetVehicleCustomPrimaryColour(testDriveEntity,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
   --SetVehicleCustomSecondaryColour(testDriveEntity,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))

	--SendNUIMessage(
       -- {
         --   type = "hide"
        --}
   -- )
    SetNuiFocus(false, false)
	IsInShopMenu = false

	while startCountDown do
		local countTime
		Citizen.Wait(1)
		if GetGameTimer() < timeGG+tonumber(1000*Config.TestDriveTime) then
			local secondsLeft = GetGameTimer() - timeGG
			drawTxt(_U('testdrive') .. math.ceil(Config.TestDriveTime - secondsLeft/1000),4,0.5,0.93,0.50,255,255,255,180)
		else
			DeleteEntity(testDriveEntity)
			SetEntityCoords(PlayerPedId(), lastPlayerCoords)
			startCountDown = false
			
			exports['mythic_notify']:DoHudText('inform', "Terminaste o Test-Drive!")
		end
	end     
end)

RegisterNUICallback('BuyVehicle', function(data, cb)
    SetNuiFocus(false, false)

    local modeloCarro = data.model
	local playerPed = PlayerPedId()
	IsInShopMenu = false
	--exports['mythic_notify']:PersistentHudText('START','waiting','vermelho','Aguarde enquanto carregamos o seu veículo!')

    ESX.TriggerServerCallback('d3x_vehicleshop:buyVehicle', function(hasEnoughMoney, valorCarro)
		--exports['mythic_notify']:PersistentHudText('END','waiting')

		if hasEnoughMoney then

			ESX.Game.SpawnVehicle(modeloCarro, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

				local newPlate     = GeneratePlate()
				local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
				vehicleProps.plate = newPlate
				SetVehicleNumberPlateText(vehicle, newPlate)

				if Config.EnableOwnedVehicles then
					for i=1, #Vehicles, 1 do
						if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
							vehicleData = Vehicles[i]
							break
						end
					end
					TriggerServerEvent('d3x_vehicleshop:setVehicleOwned', vehicleProps, vehicleData.name, vehicleData.model, valorCarro)
					exports['qs-vehiclekeys']:GiveKeysAuto()
					--TriggerServerEvent('vehiclekeys:server:givekey', vehicleProps.plate, vehicleData.model)
				end
			end)

		else
			exports['Johnny_Notificacoes']:Alert("STAND", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>dinheiro</span> suficiente no banco!", 5000, 'error')
		end

	end, modeloCarro)
end)

RegisterNUICallback('CloseMenu', function()
    SetNuiFocus(false, false)
    IsInShopMenu = false
end)

RegisterCommand('fecharmenu', function() 
	SetNuiFocus(false, false)
    IsInShopMenu = false

end)

function OpenShopMenu()

	local vehicle = {}

	if not IsInShopMenu then
		IsInShopMenu = true
		SetNuiFocus(true, true)
		
		SendNUIMessage({
            show = true,
			cars = Vehicles,
			categories = Categories
        })
	end

end


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function (job)
	ESX.PlayerData.job = job
end)

AddEventHandler('d3x_vehicleshop:hasEnteredMarker', function (zone)
	if zone == 'ShopEntering' or zone == 'Shop2' or zone == 'Shop3'  then

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}
		actionDisplayed = true

	elseif zone == 'ResellVehicle' then
		local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then

			local vehicle     = GetVehiclePedIsIn(playerPed, false)
			local vehicleData, model, resellPrice, plate

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				for i=1, #Vehicles, 1 do
					if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
						vehicleData = Vehicles[i]
						break
					end
				end
				if vehicleData ~= nil then
					resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.ResellPercentage)
					model = GetEntityModel(vehicle)
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
		
					CurrentAction     = 'resell_vehicle'
					CurrentActionMsg  = 'Pressiona ~g~[E]~w~ para vender por ' .. ESX.Math.GroupDigits(resellPrice)
					ESX.ShowHelpNotification('Pressiona ~g~[E]~w~ para vender por ' .. ESX.Math.GroupDigits(resellPrice)..'€' )
		
					CurrentActionData = {
						vehicle = vehicle,
						label = vehicleData.name,
						price = resellPrice,
						model = model,
						plate = plate
					}
				end
			end

		end

	end
end)

AddEventHandler('d3x_vehicleshop:hasExitedMarker', function (zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()

			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Zones.Shop3.Pos.x, Config.Zones.Shop3.Pos.y, Config.Zones.Shop3.Pos.z)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function ()
	local blip = AddBlipForCoord(Config.Zones.Shop3.Pos.x, Config.Zones.Shop3.Pos.y, Config.Zones.Shop3.Pos.z)

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Concessionária")
	EndTextCommandSetBlipName(blip)
end)

function Draw3DText(x,y,z,text,scale)
	local onScreen, _x, _y = World3dToScreen2d(x,y,z)
	local pX,pY,pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255, 255, 255, 255)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len( text )) / 700
	DrawRect(_x, _y + 0.0150, 0.06 +factor, 0.03, 0, 0, 0, 200)
end

-- Display markers
--[[
Citizen.CreateThread(function ()
	
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())

		if(Config.Zones.ResellVehicle.Type ~= -1 and GetDistanceBetweenCoords(coords, Config.Zones.ResellVehicle.Pos.x, Config.Zones.ResellVehicle.Pos.y, Config.Zones.ResellVehicle.Pos.z, true) < Config.DrawDistance) then
			DrawMarker(Config.Zones.ResellVehicle.Type, Config.Zones.ResellVehicle.Pos.x, Config.Zones.ResellVehicle.Pos.y, Config.Zones.ResellVehicle.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Zones.ResellVehicle.Size.x, Config.Zones.ResellVehicle.Size.y, Config.Zones.ResellVehicle.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
		end
	end
end) --]]

--[[
Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(0)
		local coords      = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			if v.Type == 36 then
				if Vdist(coords.x,coords.y,coords.z, v.Pos.x,v.Pos.y,v.Pos.z) <= 8 then
					Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z, "~g~[E]~w~ Ver catálogo",0.4)
				end			
			end
			if(Config.Zones.ResellVehicle.Type ~= -1 and GetDistanceBetweenCoords(coords, Config.Zones.ResellVehicle.Pos.x, Config.Zones.ResellVehicle.Pos.y, Config.Zones.ResellVehicle.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(Config.Zones.ResellVehicle.Type, Config.Zones.ResellVehicle.Pos.x, Config.Zones.ResellVehicle.Pos.y, Config.Zones.ResellVehicle.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Zones.ResellVehicle.Size.x, Config.Zones.ResellVehicle.Size.y, Config.Zones.ResellVehicle.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
		
	end
	
end)
--]]


-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do
		
		local sleep = 1000
		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if v.Type == 36 then
				if Vdist(coords.x,coords.y,coords.z, v.Pos.x,v.Pos.y,v.Pos.z) <= 8 then
					Draw3DText(v.Pos.x, v.Pos.y, v.Pos.z, "~g~[E]~w~ Ver catálogo",0.4)
				end			
			end
			--if(Config.Zones.ResellVehicle.Type ~= -1 and GetDistanceBetweenCoords(coords, Config.Zones.ResellVehicle.Pos.x, Config.Zones.ResellVehicle.Pos.y, Config.Zones.ResellVehicle.Pos.z, true) < Config.DrawDistance) then
			--sleep = 5
			--	DrawMarker(Config.Zones.ResellVehicle.Type, Config.Zones.ResellVehicle.Pos.x, Config.Zones.ResellVehicle.Pos.y, Config.Zones.ResellVehicle.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Zones.ResellVehicle.Size.x, Config.Zones.ResellVehicle.Size.y, Config.Zones.ResellVehicle.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			--end
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 3.5) then
				sleep = 5
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker  then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('d3x_vehicleshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('d3x_vehicleshop:hasExitedMarker', LastZone)
		end
		Citizen.Wait(sleep)
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction == nil then
			Citizen.Wait(1000)
		else

			-- ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para ver o catálogo!')
			
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				elseif CurrentAction == 'resell_vehicle' then
					TriggerEvent("d3x_vehicleshop:sellCar")
					CurrentAction = nil
					Citizen.Wait(5000)
				end

				CurrentAction = nil
			end
		end
	end
end)

RegisterNetEvent('d3x_vehicleshop:sellCar')
AddEventHandler('d3x_vehicleshop:sellCar', function ()
	ESX.TriggerServerCallback('d3x_vehicleshop:resellVehicle', function(vehicleSold)
		if vehicleSold then
			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
			--TriggerServerEvent('vehiclekeys:server:removekey', CurrentActionData.plate, CurrentActionData.model)
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Vendeste o teu veículo <span style='color:#069a19'>("..CurrentActionData.label..")</span> por <span style='color:#069a19'>"..ESX.Math.GroupDigits(CurrentActionData.price).."</span>!", 5000, 'success')
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não és o <span style='color:#ff0000'>proprietário</span> deste veículo!", 5000, 'error')
		end
	end, CurrentActionData.plate, CurrentActionData.model, CurrentActionData.label)
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)
