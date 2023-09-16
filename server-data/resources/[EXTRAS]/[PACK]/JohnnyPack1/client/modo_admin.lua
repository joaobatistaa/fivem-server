local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 20
local displayIDHeight = 1.8 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255
local group
local IsAdminMod = false
local godmode = false
local teleporte = false
local PlayerData = {}
local reiDistoTudo = false

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
	TriggerServerEvent("modoadmin:ifJohnny")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('johnny_core:setGroup')
AddEventHandler('johnny_core:setGroup', function(g)
	group = g
end)

RegisterNetEvent('modoadmin:permissoesALL"')
AddEventHandler('modoadmin:permissoesALL"', function()
	TriggerEvent('modoadmin:client:TogglePermissao', true)
end)

RegisterNetEvent('modoadmin:toggleadmin')
AddEventHandler('modoadmin:toggleadmin', function()
	local player = PlayerId()
	
	if IsAdminMod then
		ExecuteCommand('sairadmin')
	else
		ExecuteCommand('entraradmin')
	end
end)	

RegisterNetEvent('entraradmin')
AddEventHandler('entraradmin', function(id)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
  
	if pid == myId then
		if not IsAdminMod then
			IsAdminMod = true
			godmode = true
			
			TriggerEvent('modoadmin:client:TogglePermissao', true)
			
			exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'><span style='color:#069a19'>Entraste</span> no modo ADMIN!", 5000, 'success')
			SetEntityInvincible(PlayerPedId(), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(PlayerPedId(), false)
			ClearPedBloodDamage(PlayerPedId())
			ResetPedVisibleDamage(PlayerPedId())
			ClearPedLastWeaponDamage(PlayerPedId())
			SetEntityProofs(PlayerPedId(), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(PlayerPedId(), false)
		end
	end
end)

RegisterNetEvent('sairadmin')
AddEventHandler('sairadmin', function(id)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
  
	if pid == myId then
		if IsAdminMod then
			
			godmode = false
			IsAdminMod = false
			
			TriggerEvent('modoadmin:client:TogglePermissao', false)

			exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'><span style='color:#ff0000'>Saíste</span> do modo ADMIN!", 5000, 'error')
			SetEntityInvincible(PlayerPedId(), false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(PlayerPedId(), true)
			ClearPedLastWeaponDamage(PlayerPedId())
			SetEntityProofs(PlayerPedId(), false, false, false, false, false, false, false, false)
			SetEntityCanBeDamaged(PlayerPedId(), true)
		end
	end
end)


local visualcoords = false

RegisterNetEvent('modoadmin:coords')
AddEventHandler('modoadmin:coords', function()
	--if (group ~= "user" and group ~= "mod" and group ~= "admin") and IsAdminMod == true then
		visualcoords = not visualcoords
	--end
end)

Citizen.CreateThread(function()
    while true do
    	local sleep=true
		if IsAdminMod == true and visualcoords == true then
			sleep=false
    		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    		roundx = tonumber(string.format("%.2f", x))
    		roundy = tonumber(string.format("%.2f", y))
    		roundz = tonumber(string.format("%.2f", z))
        	SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.45)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~X:~s~ "..roundx)
			DrawText(0.01, 0.42)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.45)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Y:~s~ "..roundy)
			DrawText(0.01, 0.46)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.45)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Z:~s~ "..roundz)
			DrawText(0.01, 0.50)
			heading = GetEntityHeading(GetPlayerPed(-1))
			roundh = tonumber(string.format("%.2f", heading))
        	SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.40)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Virado para:~s~ "..roundh)
			DrawText(0.01, 0.54)
			speed = GetEntitySpeed(PlayerPedId())
			rounds = tonumber(string.format("%.2f", speed)) 
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.40)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Velocidade: ~s~"..rounds)
			health = GetEntityHealth(PlayerPedId())
			DrawText(0.01, 0.60)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.40)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Vida: ~s~"..health)
			DrawText(0.01, 0.64)
			veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
			vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
			if IsPedInAnyVehicle(PlayerPedId(), 1) then
			 	vehenground = tonumber(string.format("%.2f", veheng))
				vehbodround = tonumber(string.format("%.2f", vehbody))
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.40)
				SetTextDropshadow(1, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString("~r~Vida do Motor: ~s~"..vehenground)
				DrawText(0.01, 0.68)
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.40)
				SetTextDropshadow(1, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString("~r~Vida da carroçaria: ~s~"..vehbodround)
				DrawText(0.01, 0.72) --hehe
			end
	    end
		if sleep==true then
			Citizen.Wait(500)
		end
        Citizen.Wait(1)
	end
end)

