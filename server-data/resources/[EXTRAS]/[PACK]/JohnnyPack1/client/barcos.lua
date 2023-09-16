isInShopMenuBarcos = false
local spawnedBarcos = {}

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

local HasAlreadyEnteredMarkerBarcos = false
local LastZoneBarcos                = nil

CurrentActionBarcos     = nil
CurrentActionMsgBarcos  = ''
CurrentActionDataBarcos = {}

local LicenseBarcosEnable = true
local LicenseBarcosPrice  = 20000

local MarkerTypeBarcos    = 1
local DrawDistanceBarcos  = 40.0

local MarkerBarcos = {
	r = 100, g = 204, b = 100, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

local StoreMarkerBarcos = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}

local ZonesBarcos = {

	Garages = {

		{ -- Shank St, nearby campaign boat garage
			GaragePos  = vector3(-772.4, -1430.9, 0.5),
			SpawnPoint = vector4(-785.39, -1426.3, 0.0, 146.0),
			StorePos   = vector3(-798.4, -1456.0, 0.0),
			StoreTP    = vector4(-791.4, -1452.5, 1.5, 318.9)
		},

		{ -- Catfish View
			GaragePos  = vector3(3864.9, 4463.9, 1.6),
			SpawnPoint = vector4(3854.4, 4477.2, 0.0, 273.0),
			StorePos   = vector3(3857.0, 4446.9, 0.0),
			StoreTP    = vector4(3854.7, 4458.6, 1.8, 355.3)
		},

		{ -- Great Ocean Highway
			GaragePos  = vector3(-1614.0, 5260.1, 2.8),
			SpawnPoint = vector4(-1622.5, 5247.1, 0.0, 21.0),
			StorePos   = vector3(-1600.3, 5261.9, 0.0),
			StoreTP    = vector4(-1605.7, 5259.0, 2.0, 25.0)
		},

		{ -- North Calafia Way
			GaragePos  = vector3(712.6, 4093.3, 33.7),
			SpawnPoint = vector4(712.8, 4080.2, 29.3, 181.0),
			StorePos   = vector3(705.1, 4110.1, 30.2),
			StoreTP    = vector4(711.9, 4110.5, 31.3, 180.0)
		},

		{ -- Elysian Fields, nearby the airport
			GaragePos  = vector3(23.8, -2806.8, 4.8),
			SpawnPoint = vector4(23.3, -2828.6, 0.8, 181.0),
			StorePos   = vector3(-1.0, -2799.2, 0.5),
			StoreTP    = vector4(12.6, -2793.8, 2.5, 355.2)
		},

		{ -- Barbareno Rd
			GaragePos  = vector3(-3427.3, 956.9, 7.3),
			SpawnPoint = vector4(-3448.9, 953.8, 0.0, 75.0),
			StorePos   = vector3(-3436.5, 946.6, 0.3),
			StoreTP    = vector4(-3427.0, 952.6, 8.3, 0.0)
		},
		
		{ -- Ilha Cayo Perico
			GaragePos  = vector3(4929.89, -5174.33, 1.47),
			SpawnPoint = vector4(4925.91, -5166.82, 0.0, 75.3),
			StorePos   = vector3(4931.3, -5162.09, 0.3),
			StoreTP    = vector4(4931.63, -5175.24, 2.46, 247.32)
		}

	},

	BoatShops = {
		{ -- Shank St, nearby campaign boat garage
			Outside = vector3(-773.7, -1495.2, 1.6),
			Inside = vector4(-798.5, -1503.1, -0.4, 120.0)
		}
	}

}

local Barcos = {
	{model = 'seashark', label = 'Seashark (Random Color)', price = 200000},
	{model = 'suntrap', label = 'Suntrap', price = 300000},
	{model = 'jetmax', label = 'Jetmax', price = 500000},
	{model = 'tropic2', label = 'Tropic', price = 460000},
	{model = 'marquis', label = 'Dinka Marquis', price = 900000},
	{model = 'speeder', label = 'Speeder', price = 650000},
	{model = 'squalo', label = 'Squalo (Random Color)', price = 400000},
	{model = 'toro', label = 'Toro', price = 800000},
	{model = 'submersible', label = 'Submersible', price = 5000000}
}

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentActionBarcos then
			ESX.ShowHelpNotification(CurrentActionMsgBarcos)

			if IsControlJustReleased(0, 38) then
				if CurrentActionBarcos == 'boat_shop' then
					if not LicenseBarcosEnable then
						OpenBoatShop(ZonesBarcos.BoatShops[CurrentActionDataBarcos.zoneNum])
					else -- check for license

						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasBoatLicense)
							if hasBoatLicense then
								OpenBoatShop(ZonesBarcos.BoatShops[CurrentActionDataBarcos.zoneNum])
							else
								MenuLicencaBarco(ZonesBarcos.BoatShops[CurrentActionDataBarcos.zoneNum])
							end
						end, GetPlayerServerId(PlayerId()), 'boat')
					end
				end

				CurrentActionBarcos = nil
			end
		else
			Citizen.Wait(200)
		end
	end
end)

function MenuLicencaBarco(shop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_license', {
		title    = 'Licença de Barcos',
		align    = 'top-left',
		elements = {
			{label = 'Comprar Licença de Barcos: <span style="color: green;">'..ESX.Math.GroupDigits(LicenseBarcosPrice)..'€</span>', value = 'yes'},
			{label = 'Não', value = 'no'},
			
	}}, function (data, menu)
		if data.current.value == 'yes' then
			ESX.TriggerServerCallback('esx_boat:buyBoatLicense', function (boughtLicense)
				if boughtLicense then
					exports['Johnny_Notificacoes']:Alert("LOJA DE BARCOS", "<span style='color:#c7c7c7'>Compraste uma licença de navegação por <span style='color:#069a19'>"..ESX.Math.GroupDigits(LicenseBarcosPrice).."€</span>!", 5000, 'success')
					menu.close()

					OpenBoatShop(shop) -- parse current shop
				else
					exports['Johnny_Notificacoes']:Alert("LOJA DE BARCOS", "<span style='color:#c7c7c7'>Não tens dinheiro suficiente <span style='color:#ff0000'>("..ESX.Math.GroupDigits(LicenseBarcosPrice).."€)</span> para comprar a licença!", 5000, 'error')
				end
			end)
		else
			CurrentActionBarcos    = 'boat_shop'
			CurrentActionMsgBarcos = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Barcos~s~.'
			menu.close()
		end
	end, function (data, menu)
		CurrentActionBarcos    = 'boat_shop'
		CurrentActionMsgBarcos = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Barcos~s~.'
		menu.close()
	end)
end

AddEventHandler('esx_boat:hasEnteredMarker', function(zone, zoneNum)
	if zone == 'boat_shop' then
		CurrentActionBarcos     = 'boat_shop'
		CurrentActionMsgBarcos  = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Barcos~s~.'
		CurrentActionDataBarcos = { zoneNum = zoneNum }
	end
end)

AddEventHandler('esx_boat:hasExitedMarker', function()
	if not isInShopMenuBarcos then
		ESX.UI.Menu.CloseAll()
	end

	CurrentActionBarcos = nil
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local isInMarker, hasExited, letSleep = false, false, true
		local currentZone, currentZoneNum

		for i=1, #ZonesBarcos.BoatShops, 1 do
			local distance = GetDistanceBetweenCoords(coords, ZonesBarcos.BoatShops[i].Outside, true)

			if distance < DrawDistanceBarcos then
				DrawMarker(MarkerTypeBarcos, ZonesBarcos.BoatShops[i].Outside, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, MarkerBarcos.x, MarkerBarcos.y, MarkerBarcos.z, MarkerBarcos.r, MarkerBarcos.g, MarkerBarcos.b, 100, false, true, 2, false, nil, nil, false)
				letSleep = false
			end

			if distance < MarkerBarcos.x then
				isInMarker     = true
				currentZone    = 'boat_shop'
				currentZoneNum = i
			end
		end

		if isInMarker or (isInMarker and (LastZoneBarcos ~= currentZone or LastZoneNum ~= currentZoneNum)) then
			if
				(LastZoneBarcos ~= nil and LastZoneNum ~= nil) and
				(LastZoneBarcos ~= currentZone or LastZoneNum ~= currentZoneNum)
			then
				TriggerEvent('esx_boat:hasExitedMarker', LastZoneBarcos)
				hasExited = true
			end

			HasAlreadyEnteredMarkerBarcos = true
			LastZoneBarcos = currentZone
			LastZoneNum = currentZoneNum

			TriggerEvent('esx_boat:hasEnteredMarker', currentZone, currentZoneNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarkerBarcos then
			HasAlreadyEnteredMarkerBarcos = false
			TriggerEvent('esx_boat:hasExitedMarker')
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Blips
Citizen.CreateThread(function()
	local blipList = {}

	for i=1, #ZonesBarcos.BoatShops, 1 do
		table.insert(blipList, {
			coords = ZonesBarcos.BoatShops[i].Outside,
			text   = 'Loja de Barcos',
			sprite = 427,
			color  = 3,
			scale  = 0.7
		})
	end

	for i=1, #blipList, 1 do
		CreateBlipBarcos(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end
end)

function CreateBlipBarcos(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(coords.x, coords.y)

	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end

function OpenBoatShop(shop)
	isInShopMenuBarcos = true

	local playerPed = PlayerPedId()
	local elements  = {}

	for k,v in ipairs(Barcos) do
		table.insert(elements, {
			label = ('%s - <span style="color:green;">%s€</span>'):format(v.label, ESX.Math.GroupDigits(v.price)),
			name  = v.label,
			model = v.model,
			price = v.price,
			props = v.props or nil
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_shop', {
		title    = 'Loja de Barcos',
		align    = 'top-left',
		elements = elements
	}, function (data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_shop_confirm', {
			title    = 'Comprar <span style="color: yellow;">'..data.current.name..'</span> por <span style="color: orange;">'..ESX.Math.GroupDigits(data.current.price)..'€</span>?',
			align    = 'top-left',
			elements = {
				{label = 'Não', value = 'no'},
				{label = 'Sim', value = 'yes'}
		}}, function (data2, menu2)
			if data2.current.value == 'yes' then
				local plate = GeneratePlate()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local props = ESX.Game.GetVehicleProperties(vehicle)
				props.plate = plate

				ESX.TriggerServerCallback('esx_boat:buyBoat', function(bought)
					if bought then
						exports['Johnny_Notificacoes']:Alert("LOJA DE BARCOS", "<span style='color:#c7c7c7'>Compraste um barco (<span style='color:#069a19'>"..data.current.name.."</span>) por <span style='color:#069a19'>"..ESX.Math.GroupDigits(data.current.price).."€</span>!", 5000, 'success')

						DeleteSpawnedBarcos()
						isInShopMenuBarcos = false
						ESX.UI.Menu.CloseAll()

						CurrentActionBarcos    = 'boat_shop'
						CurrentActionMsgBarcos = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Barcos~s~.'

						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
						SetEntityCoords(playerPed, shop.Outside.x, shop.Outside.y, shop.Outside.z)
					else
						exports['Johnny_Notificacoes']:Alert("LOJA DE BARCOS", "<span style='color:#c7c7c7'>Não tens dinheiro suficiente <span style='color:#ff0000'>("..ESX.Math.GroupDigits(data.current.price).."€)</span> para comprar este barco!", 5000, 'error')
						menu2.close()
					end
				end, props)
			else
				menu2.close()
			end
		end, function (data2, menu2)
			menu2.close()
		end)
	end, function (data, menu)
		menu.close()
		isInShopMenuBarcos = false
		DeleteSpawnedBarcos()

		CurrentActionBarcos    = 'boat_shop'
		CurrentActionMsgBarcos = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Barcos~s~.'

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, shop.Outside.x, shop.Outside.y, shop.Outside.z)
	end, function (data, menu)
		DeleteSpawnedBarcos()

		ESX.Game.SpawnLocalVehicle(data.current.model, shop.Inside, shop.Inside.w, function (vehicle)
			table.insert(spawnedBarcos, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)

			if data.current.props then
				ESX.Game.SetVehicleProperties(vehicle, data.current.props)
			end
		end)
	end)

	-- spawn first vehicle
	DeleteSpawnedBarcos()

	ESX.Game.SpawnLocalVehicle(Barcos[1].model, shop.Inside, shop.Inside.w, function (vehicle)
		table.insert(spawnedBarcos, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)

		if Barcos[1].props then
			ESX.Game.SetVehicleProperties(vehicle, Barcos[1].props)
		end
	end)
end

function DeleteSpawnedBarcos()
	while #spawnedBarcos > 0 do
		local vehicle = spawnedBarcos[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedBarcos, 1)
	end
end

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenuBarcos then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

------------------------------------------------------------------------
----------------------------- GERAR MATRICULA --------------------------
------------------------------------------------------------------------

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
		ESX.TriggerServerCallback('JAM_VehicleShop:isPlateTaken', function(isPlateTaken)
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
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
