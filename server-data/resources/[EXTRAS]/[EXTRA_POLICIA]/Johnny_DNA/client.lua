local killer 			= nil
local weapon 			= nil
local killername 	= nil
local deadname 		= nil
local dna 				= {}
local weapons = {
	[-1569615261] = {name = 'WEAPON_UNARMED', hash = 2725352035, text = 'Murro'},
	[-1716189206] = {name = 'WEAPON_KNIFE', hash = 2578778090, text = 'Faca'},
	[1737195953]  = {name = 'WEAPON_NIGHTSTICK', hash = 1737195953, text = 'Lanterna'},
	[2508868239]  = {name = 'WEAPON_BAT', hash = 2508868239, text = 'Bastão'},
	[1317494643]  = {name = 'WEAPON_HAMMER', hash = 1317494643, text = 'Martelo'},
	[1141786504]  = {name = 'WEAPON_GOLFCLUB', hash =1141786504, text = 'Taco de Golfe'},
	[2227010557]  = {name = 'WEAPON_CROWBAR', hash =2227010557, text = 'Pé de Cabra'},
	[2460120199]  = {name = 'WEAPON_DAGGER', hash =2460120199, text = 'Faca'},
	[3638508604]  = {name = 'WEAPON_KNUCKLE', hash =3638508604, text = 'Soco Inglês'},
	[4191993645]  = {name = 'WEAPON_HATCHET', hash =4191993645, text = 'Maxado'},
	[3713923289]  = {name = 'WEAPON_MACHETE', hash =3713923289, text = 'Machete'},
	[3756226112]  = {name = 'WEAPON_SWITCHBLADE', hash =3756226112, text = 'Canivete'},
	[3441901897]  = {name = 'WEAPON_BATTLEAXE', hash =3441901897, text = 'Machado'},
	[2484171525]  = {name = 'WEAPON_POOLCUE', hash =2484171525, text = 'Taco de Snooker'},
	[419712736]   = {name = 'WEAPON_WRENCH', hash =419712736, text = 'Chave Inglesa'}
}
local inMarker = false
local PlayerData = {}
local dnaOpen = false

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 28, 28, 28, 240)
end

-- Display marker, Enter/Exit events
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local canSleep = true
		if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and (PlayerData.job.name == "police" or PlayerData.job.name == "sheriff") then
			v = Config.Computer
			if( v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos.x, v.Pos.y, v.Pos.z, true) < 20 ) then
				canSleep = false
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z+0.6, 0, 0, 0, 0, 0, 55.0, 0.5, 0.5, 0.3, 0, 0, 240, 155, 0, 0, 2, 1, 0, 0, 0)
			end
			if( v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos2.x, v.Pos2.y, v.Pos2.z, true) < 20 ) then
				canSleep = false
				DrawMarker(v.Type, v.Pos2.x, v.Pos2.y, v.Pos2.z+0.6, 0, 0, 0, 0, 0, 55.0, 0.5, 0.5, 0.3, 0, 0, 240, 155, 0, 0, 2, 1, 0, 0, 0)
			end
			if( v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos.x, v.Pos.y, v.Pos.z, true) < 3 ) then
				canSleep = false
				DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z+0.9, 'Pressiona [~r~E~s~] para acederes à base de dados de ADN', 0.3)
				--DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
			if( v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos2.x, v.Pos2.y, v.Pos2.z, true) < 3 ) then
				canSleep = false
				DrawText3Ds(v.Pos2.x, v.Pos2.y, v.Pos2.z+0.9, 'Pressiona [~r~E~s~] para acederes à base de dados de ADN', 0.3)
				--DrawMarker(v.Type, v.Pos2.x, v.Pos2.y, v.Pos2.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
			if (v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) or (v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos2.x, v.Pos2.y, v.Pos2.z, true) < v.Size.x ) then
				inMarker = true	
			else
				inMarker = false
			end
		end
		if canSleep then
			Citizen.Wait(1000)
		end
	end
end)

-- Key events
Citizen.CreateThread(function ()
  while true do
    Wait(0)
		if inMarker and IsControlJustReleased(0, 38) then
			SetNuiFocus(true, true)
			dnaOpen = true
			SendNUIMessage({
			  action = "open"
			})
		end
	end
end)

-- Remove DNA (empty the array)
RegisterNetEvent('jsfour-dna:remove')
AddEventHandler('jsfour-dna:remove', function()
	dna = {}
end)

-- Grab DNA from a player
RegisterNetEvent('jsfour-dna:get')
AddEventHandler('jsfour-dna:get', function( player )
	if dna.p == nil then
		local ped = GetPlayerPed(player)

		if IsPedFatallyInjured(ped) then
			killerped = GetPedSourceOfDeath(ped)
			killerid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killerped))
			killername = GetPlayerName(NetworkGetPlayerIndexFromPed(killerped))

			deadname = GetPlayerName(player)
			_weapon = GetPedCauseOfDeath(GetPlayerPed(player))

			for k, v in pairs(weapons) do
				if k == _weapon then
					weapon = v.text
				end
			end

			Citizen.Wait(1000)

			if weapon ~= nil then
				dna = {k = killername, d = GetPlayerServerId(player), w = weapon, p = killerid}
				ESX.ShowNotification('Retiraste uma amostra de ADN do corpo')
			else
				ESX.ShowNotification("Não encontraste ADN no corpo")
			end
		else
			dna = {k = nil, d = nil, w = nil, p = GetPlayerServerId(player)}
			ESX.ShowNotification('Retiraste uma amostra de ADN')
		end
	else
		ESX.ShowNotification('Já tens uma amostra de ADN contigo, por favor entrega-a no laboratório')
	end
end)

-- Freeze ped if dna menu is open
Citizen.CreateThread(function()
  while true do
    if dnaOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisableControlAction(0, 24, active) -- Attack
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
    else
		Citizen.Wait(1000)
	end
    Citizen.Wait(0)
  end
end)

-- Server callback
RegisterNetEvent('jsfour-dna:callback')
AddEventHandler('jsfour-dna:callback', function(_type, data, _type1, val)
	SendNUIMessage({
		action = _type,
		array = data,
		atype  = _type1,
		value = val
	})
	if data == 'upload-failed' then
		dna = {}
	end
end)

-- Javascript callbacks
-- Upload DNA
RegisterNUICallback('upload', function(data, cb)
	if dna.p ~= nil then
		TriggerServerEvent('jsfour-dna:save', dna)
		dna = {}
		cb('ok')
	else
		SendNUIMessage({
			action = "callback",
			array = 'upload-fail'
		})
		cb('error')
	end
end)

-- Fetch DNA
RegisterNUICallback('fetch', function(data, cb)
	TriggerServerEvent('jsfour-dna:fetch', data.type)
	cb('ok')
end)

-- Remove DNA
RegisterNUICallback('remove', function(data, cb)
	if data.name ~= nil then
		TriggerServerEvent('jsfour-dna:remove', 'name', data.name)
	elseif data.id ~= nil then
		TriggerServerEvent('jsfour-dna:remove', 'id', data.id)
	elseif data.match ~= nil then
		TriggerServerEvent('jsfour-dna:remove', 'match', data.match)
	end
	cb('ok')
end)

-- Try to match DNA
RegisterNUICallback('match', function(data, cb)
	TriggerServerEvent('jsfour-dna:match', data.id)
	cb('ok')
end)

-- Close DNA menu
RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
	dnaOpen = false
	cb('ok')
end)
