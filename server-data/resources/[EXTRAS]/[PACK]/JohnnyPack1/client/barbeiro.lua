local hasAlreadyEnteredMarker, lastZone, currentAction, currentActionMsg, hasPaid

local infoBarber = {}

infoBarber.Price = 100

infoBarber.DrawDistance = 20.0
infoBarber.MarkerSize   = vector3(1.5, 1.5, 1.0)
infoBarber.MarkerColor  = {r = 102, g = 102, b = 204}
infoBarber.MarkerType   = 1

infoBarber.Shops = {
	vector3(-814.3, -183.8, 36.6),
	vector3(136.8, -1708.4, 28.3),
	vector3(-1282.6, -1116.8, 6.0),
	vector3(1931.5, 3729.7, 31.8),
	vector3(1212.8, -472.9, 65.2),
	vector3(-32.9, -152.3, 56.1),
	vector3(-278.1, 6228.5, 30.7)
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

function OpenShopMenu()
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = 'Confirmar a compra?',
			align = 'top-left',
			elements = {
				{label = 'Não',  value = 'no'},
				{label = 'Sim', value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_barbershop:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_skin:save', skin)
						end)

						TriggerServerEvent('esx_barbershop:pay')
						hasPaid = true
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin) 
						end)

						--ESX.ShowNotification('~r~Não tens dinheiro suficiente')
						exports['Johnny_Notificacoes']:Alert("BARBEARIA", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>dinheiro</span> suficiente!", 5000, 'error')
					end
				end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin) 
				end)
			end

			currentAction = 'shop_menu'
			currentActionMsg = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
		end, function(data, menu)
			menu.close()
			currentAction = 'shop_menu'
			currentActionMsg = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
		end)
	end, function(data, menu)
		menu.close()

		currentAction    = 'shop_menu'
		currentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
	end, {
		'beard_1',
		'beard_2',
		'beard_3',
		'beard_4',
		'hair_1',
		'hair_2',
		'hair_color_1',
		'hair_color_2',
		'eyebrows_1',
		'eyebrows_2',
		'eyebrows_3',
		'eyebrows_4',
		'makeup_1',
		'makeup_2',
		'makeup_3',
		'makeup_4',
		'lipstick_1',
		'lipstick_2',
		'lipstick_3',
		'lipstick_4',
		'ears_1',
		'ears_2',
	})
end

AddEventHandler('esx_barbershop:hasEnteredMarker', function(zone)
	currentAction = 'shop_menu'
	currentActionMsg = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
end)

AddEventHandler('esx_barbershop:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	currentAction = nil

	if not hasPaid then
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in ipairs(infoBarber.Shops) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 71)
		SetBlipScale(blip, 0.7)
		SetBlipColour (blip, 51)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Barbearia')
		EndTextCommandSetBlipName(blip)
	end
end)

-- Enter / Exit marker events and draw marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(PlayerPedId()), nil, nil, true

		for k,v in ipairs(infoBarber.Shops) do
			local distance = #(playerCoords - v)

			if distance < infoBarber.DrawDistance then
				letSleep = false
				DrawMarker(infoBarber.MarkerType, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, infoBarber.MarkerSize, infoBarber.MarkerColor.r, infoBarber.MarkerColor.g, infoBarber.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)

				if distance < 1.5 then
					isInMarker, currentZone = true, k
				end
			end
		end

		if (isInMarker and not hasAlreadyEnteredMarker) or (isInMarker and lastZone ~= currentZone) then
			hasAlreadyEnteredMarker, lastZone = true, currentZone
			TriggerEvent('esx_barbershop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_barbershop:hasExitedMarker', lastZone)
		end

		if letSleep then
			Citizen.Wait(1000)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if currentAction then
			ESX.ShowHelpNotification(currentActionMsg)

			if IsControlJustReleased(0, 38) then
				if currentAction == 'shop_menu' then
					OpenShopMenu()
				end

				currentAction = nil
			end
		else
			Citizen.Wait(600)
		end
	end
end)