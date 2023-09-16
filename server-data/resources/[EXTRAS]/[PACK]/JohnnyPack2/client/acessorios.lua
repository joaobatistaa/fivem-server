PlayerData = {}
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local isDead					= false

--------------- ACESSORIOS -----------------

local infoAcessories = {}

infoAcessories.EnableControls = true

infoAcessories.ShopsBlips = {
	Ears = {
		Pos = nil,
		Blip = nil
	},
	Mask = {
		Pos = { 
			{ x = -1125.58, y = -1438.77, z = 5.23 },
		},
		Blip = { sprite = 362, color = 2 }
	},
	Helmet = {
		Pos = nil,
		Blip = nil
	},
	Glasses = {
		Pos = nil,
		Blip = nil
	}
}

infoAcessories.Zones2 = {
	Ears = {
		Pos = {
			{x= 80.374,		y= -1389.493,	z= 29.406},
			{x= -709.426,   y= -153.829,	z= 37.535},
			{x= -163.093,   y= -302.038,	z= 39.853},
			{x= 420.787,	y= -809.654,	z= 29.611},
			{x= -817.070,	y= -1075.96,	z= 11.448},
			{x= -1451.300,  y= -238.254,	z= 49.929},
			{x= -0.756,		y= 6513.685,	z= 31.997},
			{x= 123.431,	y= -208.060,	z= 54.677},
			{x= 1687.318,   y= 4827.685,	z= 42.183},
			{x= 622.806,	y= 2749.221,	z= 42.208},
			{x= 1200.085,   y= 2705.428,	z= 38.342},
			{x= -1199.959,  y= -782.534,	z= 17.452},
			{x= -3171.867,  y= 1059.632,	z= 20.983},
			{x= -1095.670,  y= 2709.245,	z= 19.227},
			{x= 4500.58, 	y=-4456.48,		z= 4.37},
		}
		
	},
	
	Mask = {
		Pos = {
			{ x = -1125.58, y = -1438.77, 	z = 5.23 },
		}
	},
	
	Helmet = {
		Pos = {
			{x= 81.576,		y= -1400.602,	z= 29.406},
			{x= -705.845,   y= -159.015,	 z= 37.535},
			{x= -161.349,   y= -295.774,	 z= 39.853},
			{x= 419.319,	y= -800.647,	 z= 29.611},
			{x= -824.362,   y= -1081.741,	z= 11.448},
			{x= -1454.888,  y= -242.911,	 z= 49.931},
			{x= 4.770,		y= 6520.935,	 z= 31.997},
			{x= 121.071,	y= -223.266,	 z= 54.377},
			{x= 1689.648,   y= 4818.805,	 z= 42.183},
			{x= 613.971,	y= 2749.978,	 z= 42.208},
			{x= 1189.513,   y= 2703.947,	 z= 38.342},
			{x= -1204.025,  y= -774.439,	 z= 17.452},
			{x= -3164.280,  y= 1054.705,	 z= 20.983},
			{x= -1103.125,  y= 2700.599,	 z= 19.227},
			{x= 4491.59,  	y= -4461.78,	 z= 4.37},
		}
	},
	
	Glasses = {
		Pos = {
			{x= 75.287,		y= -1391.131,	z= 29.406},
			{x= -713.102,   y= -160.116,	 z= 37.535},
			{x= -156.171,   y= -300.547,	 z= 39.853},
			{x= 425.478,	y= -807.866,	 z= 29.611},
			{x= -820.853,   y= -1072.940,	z= 11.448},
			{x= -1458.052,  y= -236.783,	 z= 49.918},
			{x= 3.587,		y= 6511.585,	 z= 31.997},
			{x= 131.335,	y= -212.336,	 z= 54.677},
			{x= 1694.936,   y= 4820.837,	 z= 42.183},
			{x= 613.972,	y= 2768.814,	 z= 42.208},
			{x= 1198.678,   y= 2711.011,	 z= 38.342},
			{x= -1188.227,  y= -764.594,	 z= 17.452},
			{x= -3173.192,  y= 1038.228,	 z= 20.983},
			{x= -1100.494,  y= 2712.481,	 z= 19.227},
			{x= 4497.22,   y= -4453.76,	 	 z= 4.37},
		}
	}
}

------------------ FIM ACESSORIOS -------------------

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)

function OpenAccessoryMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
	{
		title = 'Colocar / Remover',
		align = 'top-left',
		elements = {
			{label = 'Capacete / Chapéu', value = 'Helmet'},
			{label = 'Acessórios de Orelha', value = 'Ears'},
			{label = 'Máscara', value = 'Mask'},
			{label = 'Óculos', value = 'Glasses'}
		}
	}, function(data, menu)
		menu.close()
		SetUnsetAccessory(data.current.value)

	end, function(data, menu)
		menu.close()
	end)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			if _acessory == 'helmet' then
				ESX.ShowNotification('Não tens nenhum capacete/chapéu')
			elseif _acessory == 'mask' then
				ESX.ShowNotification('Não tens máscara')
			elseif _acessory == 'ears' then
				ESX.ShowNotification('Não tens acessórios de orelha')
			else
				ESX.ShowNotification('Não tens óculos')
			end
			
		end

	end, accessory)
end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}
	exports['qs-inventory']:setInClothing(true)
	restrict = { _accessory .. '_1', _accessory .. '_2' }
	
	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
		{
			title = 'Validar Compra',
			align = 'top-left',
			elements = {
				{label = 'Não', value = 'no'},
				{label = 'Sim (25€)', value = 'yes'}
			}
		}, function(data, menu)
			menu.close()
			exports['qs-inventory']:setInClothing(false)
			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('esx_accessories:pay')
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_accessories:save', skin, accessory)
						end)
					else
						TriggerEvent('esx_skin:getLastSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						--ESX.ShowNotification('~r~Não tens dinheiro suficiente')
						exports['Johnny_Notificacoes']:Alert("LOJA", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>dinheiro</span> suficiente!", 5000, 'error')
					end
				end)
			end

			if data.current.value == 'no' then
				local player = PlayerPedId()
				TriggerEvent('esx_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			end
			
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			exports['qs-inventory']:setInClothing(false)
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
			CurrentActionData = {}

		end)
	end, function(data, menu)
		menu.close()
		exports['qs-inventory']:setInClothing(false)
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
		CurrentActionData = {}
	end, restrict)
end

AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = 'Pressiona ~INPUT_CONTEXT~ para abrir o menu'
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	exports['qs-inventory']:setInClothing(false)
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(infoAcessories.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.8)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Loja de Máscaras')
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers

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


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local letSleep = true
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		
		for k,v in pairs(infoAcessories.Zones2) do
			for i = 1, #v.Pos, 1 do
				if(infoAcessories.Type3 ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 20) then
					letSleep = false
					DrawMarker(2, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 3 and k == 'Ears' then
					DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.2, '~b~E~s~ - Acessórios Orelha', 0.3)
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 3 and k == 'Glasses' then
					DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.2, '~b~E~s~ - Óculos', 0.3)
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 3 and k == 'Helmet' then
					DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.2, '~b~E~s~ - Chapéu', 0.3)
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 3 and k == 'Mask' then
					DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.2, '~b~E~s~ - Máscara', 0.3)
				end
				
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 3 then
					isInMarker  = true
					currentZone = k
				end
			end
		end
		
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
		end
		
		if CurrentAction then
			if IsControlJustReleased(0, 38) and CurrentActionData.accessory then
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		end
		
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)
--[[

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, 311) and IsInputDisabled(0) then
                OpenAccessoryMenu()
            end
        end
    end
) --]]
