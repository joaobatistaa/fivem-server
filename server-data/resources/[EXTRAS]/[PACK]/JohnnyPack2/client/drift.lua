local kmh = 3.6
local mph = 2.23693629
local carspeed = 0
-----------------
--   E D I T   --
-----------------
local driftmode = false -- on/off speed
local speed = kmh -- or mph
local drift_speed_limit = 100.0 
local toggle = 118 -- Numpad 9

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

-- Thread
Citizen.CreateThread(function()

	while true do
		
		Citizen.Wait(0)
		local letSleep = true

--[[		if IsControlJustPressed(1, 118) then

			driftmode = not driftmode

			if driftmode then
				TriggerEvent("chatMessage", 'MODO DRIFT', { 255,255,255}, '^2ATIVADO')
			else
				TriggerEvent("chatMessage", 'MODO DRIFT', { 255,255,255}, '^1DESATIVADO')
			end
		end --]]

		if driftmode then
			letSleep = false

			if IsPedInAnyVehicle(GetPed(), false) then

				CarSpeed = GetEntitySpeed(GetCar()) * speed

				if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then

				--	if CarSpeed <= drift_speed_limit then  

						--if IsControlPressed(1, 21) then
		
							SetVehicleReduceGrip(GetCar(), true)
		
						--else
		
							--SetVehicleReduceGrip(GetCar(), false)
		
						--end
				--	end
				end
			end
		end
		if letSleep then
			Citizen.Wait(1000)
		end
	end
end)

RegisterCommand("drift", function(source)
	ESX.TriggerServerCallback('johnny:server:isVip', function(isVIP)
		if isVIP then
			driftmode = not driftmode

			if driftmode then
				TriggerEvent("chatMessage", 'MODO DRIFT', { 255,255,255}, '^2ATIVADO (Shift para fazer drift)')
			else
				TriggerEvent("chatMessage", 'MODO DRIFT', { 255,255,255}, '^1DESATIVADO')
			end
		else
			ESX.ShowNotification("Compra VIP no nosso discord para teres acesso a este comando!")
		end
	end, GetPlayerServerId(PlayerId()))
end)


-- Function
function GetPed() return PlayerPedId() end
function GetCar() return GetVehiclePedIsIn(PlayerPedId(),false) end