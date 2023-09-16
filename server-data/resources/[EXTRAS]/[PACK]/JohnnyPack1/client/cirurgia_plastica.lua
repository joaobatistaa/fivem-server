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

local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasPayed                = false

local cfgOperacaoPlastica = {}

cfgOperacaoPlastica.DrawDistance = 20.0
cfgOperacaoPlastica.MarkerSize   = {x = 1.2, y = 1.2, z = 1.2}
cfgOperacaoPlastica.MarkerColor  = {r = 0, g = 0, b = 255}
cfgOperacaoPlastica.MarkerType   = 27
cfgOperacaoPlastica.Locale = 'br'

cfgOperacaoPlastica.Zones = {}

cfgOperacaoPlastica.Shops = {
  {x = 299.89,  y = -590.4,  z = 42.3}
}

for i=1, #cfgOperacaoPlastica.Shops, 1 do

	cfgOperacaoPlastica.Zones['Shop_' .. i] = {
	 	Pos   = cfgOperacaoPlastica.Shops[i],
	 	Size  = cfgOperacaoPlastica.MarkerSize,
	 	Color = cfgOperacaoPlastica.MarkerColor,
	 	Type  = cfgOperacaoPlastica.MarkerType
  }

end

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

function OpenPlasticSurgery()
	HasPaid = false
	
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
				ESX.TriggerServerCallback('esx_plasticsurgery:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_skin:save', skin)
						end)
						
						TriggerServerEvent('esx_plasticsurgery:pay')
						HasPaid = true
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin) 
						end)
						
						ESX.ShowNotification('~r~Não tens dinheiro suficiente!')
					end
				end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin) 
				end)
			end
			
			CurrentAction     = 'surgery_menu'
			CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para fazer uma cirurgia plástica'
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			
			CurrentAction     = 'surgery_menu'
			CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para fazer uma cirurgia plástica'
			CurrentActionData = {}
		end)
	end, function(data, menu)
		menu.close()
		
		CurrentAction     = 'surgery_menu'
		CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para fazer uma cirurgia plástica'
		CurrentActionData = {}
	end, {
		'sex',
		'face',
		'age_1',
		'age_2',
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
		'ears_1',
		'ears_2',
	})
end

AddEventHandler('esx_plasticsurgery:hasEnteredMarker', function(zone)
	CurrentAction     = 'surgery_menu'
	CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para fazer uma cirurgia plástica'
	CurrentActionData = {}
end)

AddEventHandler('esx_plasticsurgery:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local coords = GetEntityCoords(PlayerPedId())
		local canSleep = true
		
		for k,v in pairs(cfgOperacaoPlastica.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < cfgOperacaoPlastica.DrawDistance) then
				canSleep = false
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
		if canSleep then
			Citizen.Wait(2000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		
		Citizen.Wait(200)	
		
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(cfgOperacaoPlastica.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_plasticsurgery:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_plasticsurgery:hasExitedMarker', LastZone)
		end
		
		if not isInMarker then
			Citizen.Wait(500)
		end
		
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				
				if CurrentAction == 'surgery_menu' then
					OpenPlasticSurgery()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
		
	end
end)