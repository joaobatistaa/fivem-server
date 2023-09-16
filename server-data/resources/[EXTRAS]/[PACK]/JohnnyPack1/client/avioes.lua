isInShopMenuAvioes = false
local spawnedAvioes = {}

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

local HasAlreadyEnteredMarkerAvioes = false
local LastZoneAvioes                = nil

CurrentActionAvioes     = nil
CurrentActionMsgAvioes  = ''
CurrentActionDataAvioes = {}

local LicenseAvioesEnable = true
local LicenseAvioesPrice  = 100000

local MarkerTypeAvioes    = 1
local DrawDistanceAvioes  = 40.0

local MarkerAvioes = {
	r = 100, g = 204, b = 100, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

local StoreMarkerAvioes = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}

local ZonesAvioes = {

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

	AvioesShops = {
		{ -- Shank St, nearby campaign boat garage
			Outside = vector3(-1070.93, -2868.84, 12.951),
			Inside = vector4(-1088.69, -2908.54, 13.946, 237.08236694336)
		}
	}

}

local Avioes = {
	{model = 'maverick', label = 'Maverick', price = 62000000},
	{model = 'vestra', label = 'Vestra', price = 65000000}
}

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentActionAvioes then
			ESX.ShowHelpNotification(CurrentActionMsgAvioes)

			if IsControlJustReleased(0, 38) then
				if CurrentActionAvioes == 'aviao_shop' then
					if not LicenseAvioesEnable then
						OpenAviaoShop(ZonesAvioes.AvioesShops[CurrentActionDataAvioes.zoneNum])
					else -- check for license

						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasBoatLicense)
							if hasBoatLicense then
								OpenAviaoShop(ZonesAvioes.AvioesShops[CurrentActionDataAvioes.zoneNum])
							else
								MenuLicencaAviao(ZonesAvioes.AvioesShops[CurrentActionDataAvioes.zoneNum])
							end
						end, GetPlayerServerId(PlayerId()), 'aviao')
					end
				end

				CurrentActionAvioes = nil
			end
		else
			Citizen.Wait(200)
		end
	end
end)

function MenuLicencaAviao(shop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'aviao_license', {
		title    = 'Licença de Aviões',
		align    = 'top-left',
		elements = {
			{label = 'Comprar Licença de Aviação: <span style="color: green;">'..ESX.Math.GroupDigits(LicenseAvioesPrice)..'€</span>', value = 'yes'},
			{label = 'Não', value = 'no'},
			
	}}, function (data, menu)
		if data.current.value == 'yes' then
			ESX.TriggerServerCallback('esx_aviao:buyAviaoLicense', function (boughtLicense)
				if boughtLicense then
					exports['Johnny_Notificacoes']:Alert("LOJA DE AVIÕES", "<span style='color:#c7c7c7'>Compraste uma Licença de Aviação por <span style='color:#069a19'>"..ESX.Math.GroupDigits(LicenseAvioesPrice).."€</span>!", 5000, 'success')
					menu.close()

					OpenAviaoShop(shop) -- parse current shop
				else
					exports['Johnny_Notificacoes']:Alert("LOJA DE AVIÕES", "<span style='color:#c7c7c7'>Não tens dinheiro suficiente <span style='color:#ff0000'>("..ESX.Math.GroupDigits(LicenseAvioesPrice).."€)</span> para comprar a licença!", 5000, 'error')
				end
			end)
		else
			CurrentActionAvioes    = 'aviao_shop'
			CurrentActionMsgAvioes = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Aviões~s~.'
			menu.close()
		end
	end, function (data, menu)
		CurrentActionAvioes    = 'aviao_shop'
		CurrentActionMsgAvioes = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Aviões~s~.'
		menu.close()
	end)
end

AddEventHandler('esx_aviao:hasEnteredMarker', function(zone, zoneNum)
	if zone == 'aviao_shop' then
		CurrentActionAvioes     = 'aviao_shop'
		CurrentActionMsgAvioes  = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Aviões~s~.'
		CurrentActionDataAvioes = { zoneNum = zoneNum }
	end
end)

AddEventHandler('esx_aviao:hasExitedMarker', function()
	if not isInShopMenuAvioes then
		ESX.UI.Menu.CloseAll()
	end

	CurrentActionAvioes = nil
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local isInMarker, hasExited, letSleep = false, false, true
		local currentZone, currentZoneNum

		for i=1, #ZonesAvioes.AvioesShops, 1 do
			local distance = GetDistanceBetweenCoords(coords, ZonesAvioes.AvioesShops[i].Outside, true)

			if distance < DrawDistanceAvioes then
				DrawMarker(MarkerTypeAvioes, ZonesAvioes.AvioesShops[i].Outside, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, MarkerAvioes.x, MarkerAvioes.y, MarkerAvioes.z, MarkerAvioes.r, MarkerAvioes.g, MarkerAvioes.b, 100, false, true, 2, false, nil, nil, false)
				letSleep = false
			end

			if distance < MarkerAvioes.x then
				isInMarker     = true
				currentZone    = 'aviao_shop'
				currentZoneNum = i
			end
		end

		if isInMarker or (isInMarker and (LastZoneAvioes ~= currentZone or LastZoneNum ~= currentZoneNum)) then
			if
				(LastZoneAvioes ~= nil and LastZoneNum ~= nil) and
				(LastZoneAvioes ~= currentZone or LastZoneNum ~= currentZoneNum)
			then
				TriggerEvent('esx_aviao:hasExitedMarker', LastZoneAvioes)
				hasExited = true
			end

			HasAlreadyEnteredMarkerAvioes = true
			LastZoneAvioes = currentZone
			LastZoneNum = currentZoneNum

			TriggerEvent('esx_aviao:hasEnteredMarker', currentZone, currentZoneNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarkerAvioes then
			HasAlreadyEnteredMarkerAvioes = false
			TriggerEvent('esx_aviao:hasExitedMarker')
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Blips
Citizen.CreateThread(function()
	local blipList = {}

	for i=1, #ZonesAvioes.AvioesShops, 1 do
		table.insert(blipList, {
			coords = ZonesAvioes.AvioesShops[i].Outside,
			text   = 'Loja de Aviões',
			sprite = 43,
			color  = 3,
			scale  = 0.7
		})
	end

	for i=1, #blipList, 1 do
		CreateBlipAvioes(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end
end)

function CreateBlipAvioes(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(coords.x, coords.y)

	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end

function OpenAviaoShop(shop)
	isInShopMenuAvioes = true

	local playerPed = PlayerPedId()
	local elements  = {}

	for k,v in ipairs(Avioes) do
		table.insert(elements, {
			label = ('%s - <span style="color:green;">%s€</span>'):format(v.label, ESX.Math.GroupDigits(v.price)),
			name  = v.label,
			model = v.model,
			price = v.price,
			props = v.props or nil
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'aviao_shop', {
		title    = 'Loja de Aviões',
		align    = 'top-left',
		elements = elements
	}, function (data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'aviao_shop_confirm', {
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

				ESX.TriggerServerCallback('esx_aviao:buyAviao', function(bought)
					if bought then
						exports['Johnny_Notificacoes']:Alert("LOJA DE AVIÕES", "<span style='color:#c7c7c7'>Compraste um avião (<span style='color:#069a19'>"..data.current.name.."</span>) por <span style='color:#069a19'>"..ESX.Math.GroupDigits(data.current.price).."€</span>!", 5000, 'success')

						DeleteSpawnedAvioes()
						isInShopMenuAvioes = false
						ESX.UI.Menu.CloseAll()

						CurrentActionAvioes    = 'aviao_shop'
						CurrentActionMsgAvioes = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Aviões~s~.'

						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
						SetEntityCoords(playerPed, shop.Outside.x, shop.Outside.y, shop.Outside.z)
					else
						exports['Johnny_Notificacoes']:Alert("LOJA DE AVIÕES", "<span style='color:#c7c7c7'>Não tens dinheiro suficiente <span style='color:#ff0000'>("..ESX.Math.GroupDigits(data.current.price).."€)</span> para comprar este avião!", 5000, 'error')
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
		isInShopMenuAvioes = false
		DeleteSpawnedAvioes()

		CurrentActionAvioes    = 'aviao_shop'
		CurrentActionMsgAvioes = 'Pressiona ~INPUT_CONTEXT~ para ver a ~y~Loja de Aviões~s~.'

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, shop.Outside.x, shop.Outside.y, shop.Outside.z)
	end, function (data, menu)
		DeleteSpawnedAvioes()

		ESX.Game.SpawnLocalVehicle(data.current.model, shop.Inside, shop.Inside.w, function (vehicle)
			table.insert(spawnedAvioes, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)

			if data.current.props then
				ESX.Game.SetVehicleProperties(vehicle, data.current.props)
			end
		end)
	end)

	-- spawn first vehicle
	DeleteSpawnedAvioes()

	ESX.Game.SpawnLocalVehicle(Avioes[1].model, shop.Inside, shop.Inside.w, function (vehicle)
		table.insert(spawnedAvioes, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)

		if Avioes[1].props then
			ESX.Game.SetVehicleProperties(vehicle, Avioes[1].props)
		end
	end)
end

function DeleteSpawnedAvioes()
	while #spawnedAvioes > 0 do
		local vehicle = spawnedAvioes[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedAvioes, 1)
	end
end

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenuAvioes then
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
