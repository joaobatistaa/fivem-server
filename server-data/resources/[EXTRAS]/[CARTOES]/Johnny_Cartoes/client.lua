local open = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)


RegisterNetEvent('event:control:idcard')
AddEventHandler('event:control:idcard', function(useID)
	if useID == 0 or useID == nil then
		ShowMenu('idcard')
	elseif useID == 1 then
		ShowMenu('driver')
	elseif useID == 2 then
		ShowMenu('weapon')
	elseif useID == 3 then
		ShowMenu('hunt')
	end
end)

RegisterNetEvent('flashBadge:client:animation')
AddEventHandler('flashBadge:client:animation', function(data, type)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
		local badgeProp = CreateBadgeProp(coords)
        local boneIndex = GetPedBoneIndex(ped, 28422)
        
        AttachEntityToEntity(badgeProp, ped, boneIndex, 0.065, 0.029, -0.035, 80.0, -1.90, 75.0, true, true, false, true, 1, true)
		
		if type == nil or type == 'idcard' then
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
			exports['mythic_notify']:DoHudText('inform', 'Estás a mostrar o cartão ao civil com o ID: '..GetPlayerServerId(closestPlayer))
		else
			--TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), type)
			exports['mythic_notify']:DoHudText('inform', 'Estás a mostrar a licença ao civil com o ID: '..GetPlayerServerId(closestPlayer))
		end
		showCard(data, type)
        ClearPedSecondaryTask(ped)
        DeleteObject(badgeProp)
    end)
end)

function CreateBadgeProp(coords)
    local propHash = GetHashKey('prop_cs_business_card')
    local obj = CreateObject(propHash, coords.x, coords.y, coords.z + 0.2, true, true, true)
    RequestModel(propHash)
    while not HasModelLoaded(propHash) do
        Citizen.Wait(1)
    end
    return obj
end

function showCard(data, type)
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end

function ShowMenu(type)
	local type = type
	
	--[[
	local elements = {}
	local players = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
	
	if players ~= nil then
	
		for i=1, #players, 1 do
			table.insert(elements, {
				label = 'ID:'..GetPlayerServerId(players[i]),
				player = players[i]
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_menu', {
			title = 'Mostrar ao jogador',
			align = 'top-left',
			elements = elements
		}, function(data, menu)
			local player =	GetPlayerServerId(data.current.player)
			menu.close()
			if type == 'idcard' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), player)
			else
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), player, type)
			end

		end, function(data, menu)
			menu.close()
		end)
		
	else
		exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
	end
	--]]
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	
	if closestPlayer == -1 or closestDistance > 3.0 then
		exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
	else
		if type == 'idcard' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
			exports['mythic_notify']:DoHudText('inform', 'Estás a mostrar o cartão ao civil com o ID: '..GetPlayerServerId(closestPlayer))
		else
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), type)
			exports['mythic_notify']:DoHudText('inform', 'Estás a mostrar a licença ao civil com o ID: '..GetPlayerServerId(closestPlayer))
		end
	end
	
end
