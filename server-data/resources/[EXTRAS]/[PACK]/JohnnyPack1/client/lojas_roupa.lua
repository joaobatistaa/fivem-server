local GUI, CurrentActionData = {}, {}
GUI.Time = 0
local LastZone, CurrentAction, CurrentActionMsg
local HasPayed, HasLoadCloth, HasAlreadyEnteredMarker = false, false, false

local infoLojaRoupa = {}

infoLojaRoupa.DrawDistance = 30.0
infoLojaRoupa.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
infoLojaRoupa.MarkerColor  = {r = 102, g = 102, b = 204}
infoLojaRoupa.MarkerType   = 1

infoLojaRoupa.Zones = {}

infoLojaRoupa.Shops = {
  {x=72.254,    y=-1399.102, z=28.376},
  {x=-703.776,  y=-152.258,  z=36.415},
  {x=-167.863,  y=-298.969,  z=38.733},
  {x=428.694,   y=-800.106,  z=28.491},
  {x=-829.413,  y=-1073.710, z=10.328},
  {x=-1447.797, y=-242.461,  z=48.820},
  {x=11.632,    y=6514.224,  z=30.877},
  {x=123.646,   y=-219.440,  z=53.557},
  {x=1696.291,  y=4829.312,  z=41.063},
  {x=618.093,   y=2759.629,  z=41.088},
  {x=1190.550,  y=2713.441,  z=37.222},
  {x=-1193.429, y=-772.262,  z=16.324},
  {x=-3172.496, y=1048.133,  z=19.863},
  {x=-1108.441, y=2708.923,  z=18.107},
  {x=4489.35, y=-4453.04,  z=3.37},
}

for i=1, #infoLojaRoupa.Shops, 1 do

	infoLojaRoupa.Zones['Shop_' .. i] = {
	 	Pos   = infoLojaRoupa.Shops[i],
	 	Size  = infoLojaRoupa.MarkerSize,
	 	Color = infoLojaRoupa.MarkerColor,
	 	Type  = infoLojaRoupa.MarkerType
  }

end

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

function OpenShopRoupasMenu()
  exports['qs-inventory']:setInClothing(true)
  local elements = {}

  table.insert(elements, {label = 'Loja de Roupa',  value = 'shop_clothes'})
  table.insert(elements, {label = 'Roupas Guardadas', value = 'player_dressing'})
  table.insert(elements, {label = 'Apagar roupa guardada', value = 'suppr_cloth'})

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_main', {
      title    = 'Loja de Roupa',
      align    = 'top-left',
      elements = elements,
    }, function(data, menu)
		menu.close()
		exports['qs-inventory']:setInClothing(false)
		if data.current.value == 'shop_clothes' then
			HasPayed = false

			TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
						title = 'Confirmar a compra?',
						align = 'top-left',
						elements = {
							{label = 'Sim', value = 'yes'},
							{label = 'Não', value = 'no'},
						}
					}, function(data, menu)

						menu.close()

						if data.current.value == 'yes' then

							ESX.TriggerServerCallback('esx_eden_clotheshop:checkMoney', function(hasEnoughMoney)

								if hasEnoughMoney then

									TriggerEvent('skinchanger:getSkin', function(skin)
										TriggerServerEvent('esx_skin:save', skin)
									end)

									TriggerServerEvent('esx_eden_clotheshop:pay')

									HasPayed = true

									ESX.TriggerServerCallback('esx_eden_clotheshop:checkPropertyDataStore', function(foundStore)

										if foundStore then

											ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing', {
													title = 'Queres guardar esta roupa?',
													align = 'top-left',
													elements = {
														{label = 'Sim', value = 'yes'},
														{label = 'Não',  value = 'no'},
													}
												}, function(data2, menu2)

													menu2.close()

													if data2.current.value == 'yes' then

														ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
																title = 'Nome da roupa?',
															}, function(data3, menu3)

																menu3.close()

																TriggerEvent('skinchanger:getSkin', function(skin)
																	TriggerServerEvent('esx_eden_clotheshop:saveOutfit', data3.value, skin)
																end)

																--ESX.ShowNotification('~g~Roupa guardada com sucesso!')
																exports['Johnny_Notificacoes']:Alert("GUARDADO", "<span style='color:#c7c7c7'>Roupa guardada com sucesso!", 3000, 'long')

															end, function(data3, menu3)
																menu3.close()
																exports['qs-inventory']:setInClothing(false)
															end)
													end
												end)
										end
									end)

								else

									TriggerEvent('esx_skin:getLastSkin', function(skin)
										TriggerEvent('skinchanger:loadSkin', skin)
									end)

									--ESX.ShowNotification('~r~Não tens dinheiro suficiente')
									exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>dinheiro </span> suficiente!", 3000, 'error')
								end
							end)
						end

						if data.current.value == 'no' then

							TriggerEvent('esx_skin:getLastSkin', function(skin)
								TriggerEvent('skinchanger:loadSkin', skin)
							end)
						end

						CurrentAction     = 'eden_clotheshop'
						CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
						CurrentActionData = {}

					end, function(data, menu)

						menu.close()
						exports['qs-inventory']:setInClothing(false)
						
						CurrentAction     = 'eden_clotheshop'
						CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
						CurrentActionData = {}

					end)
			end, function(data, menu)

					menu.close()
					exports['qs-inventory']:setInClothing(false)

					CurrentAction     = 'eden_clotheshop'
					CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
					CurrentActionData = {}

			end, {
				'tshirt_1',
				'tshirt_2',
				'torso_1',
				'torso_2',
				'decals_1',
				'decals_2',
				'arms',
				'pants_1',
				'pants_2',
				'shoes_1',
				'shoes_2',
				'chain_1',
				'chain_2',
				'helmet_1',
				'helmet_2',
				'glasses_1',
				'glasses_2',
				'bags_1',
				'bags_2',
			})
		end

		if data.current.value == 'player_dressing' then
		
			ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
			  local elements = {}

			  for i=1, #dressing, 1 do
				table.insert(elements, {label = dressing[i], value = i})
			  end

			  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
				  title    = 'Roupas Guardadas',
				  align    = 'top-left',
				  elements = elements,
				}, function(data, menu)

				  TriggerEvent('skinchanger:getSkin', function(skin)

					ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)

					  TriggerEvent('skinchanger:loadClothes', skin, clothes)
					  TriggerEvent('esx_skin:setLastSkin', skin)

					  TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
					  end)
					  
					  --ESX.ShowNotification('~g~Acabaste de te vestir!')
					  exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Roupa <span style='color:#069a19'>carregada</span> com sucesso!", 3000, 'success')
					  HasLoadCloth = true
					end, data.current.value)
				  end)
				end, function(data, menu)
				  menu.close()
				  exports['qs-inventory']:setInClothing(false)
				  
				  CurrentAction     = 'eden_clotheshop'
				  CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
				  CurrentActionData = {}
				end
			  )
			end)
		end
	  
		if data.current.value == 'suppr_cloth' then
			ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {label = dressing[i], value = i})
				end
				
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'supprime_cloth', {
				  title    ='Apagar roupa guardada',
				  align    = 'top-left',
				  elements = elements,
				}, function(data, menu)
				menu.close()
					TriggerServerEvent('esx_eden_clotheshop:deleteOutfit', data.current.value)
					  
					--ESX.ShowNotification('~g~Esta roupa foi apagada com sucesso')
					exports['Johnny_Notificacoes']:Alert("ROUPA ELIMINADA", "<span style='color:#c7c7c7'>Roupa <span style='color:#ff0000'>eliminada</span> com sucesso!", 3000, 'error')

				end, function(data, menu)
				  menu.close()
				  exports['qs-inventory']:setInClothing(false)
				  
				  CurrentAction     = 'eden_clotheshop'
				  CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
				  CurrentActionData = {}
				end)
			end)
		end
    end, function(data, menu)

		menu.close()
		exports['qs-inventory']:setInClothing(false)

		CurrentAction     = 'room_menu'
		CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
		CurrentActionData = {}
    end)
end

AddEventHandler('esx_eden_clotheshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'eden_clotheshop'
	CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
	CurrentActionData = {}
end)

AddEventHandler('esx_eden_clotheshop:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	exports['qs-inventory']:setInClothing(false)
	CurrentAction = nil

	if not HasPayed then
		if not HasLoadCloth then 

			TriggerEvent('esx_skin:getLastSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()

	for i=1, #infoLojaRoupa.Shops, 1 do

		local blip = AddBlipForCoord(infoLojaRoupa.Shops[i].x, infoLojaRoupa.Shops[i].y, infoLojaRoupa.Shops[i].z)

		SetBlipSprite (blip, 73)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 47)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Loja de Roupa')
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		local sleep = 1000

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(infoLojaRoupa.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < infoLojaRoupa.DrawDistance) then
				sleep = 5
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		local sleep = 500

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(infoLojaRoupa.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				sleep = 5
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_eden_clotheshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_eden_clotheshop:hasExitedMarker', LastZone)
		end
		Citizen.Wait(sleep)
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		
		local sleep = 500
		if CurrentAction ~= nil then
			sleep = 5
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  38) and (GetGameTimer() - GUI.Time) > 300 then

				if CurrentAction == 'eden_clotheshop' then
					OpenShopRoupasMenu()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('casa:roupas')
AddEventHandler('casa:roupas', function()
	OpenShopRoupasMenu()
end)
