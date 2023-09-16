local cruiseON = false

local cruise = 0
local firstTime = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(ped, false)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and (GetVehicleClass(vehicle)~= 14 and GetVehicleClass(vehicle)~= 15 and GetVehicleClass(vehicle)~= 16) then
			if IsControlJustPressed(1, 246) then
				firstTime = true
				TriggerEvent('pv:setCruiseSpeed')
				--Citizen.Wait(200)
			end
		else
			Citizen.Wait(100)
		end
	end
end)

AddEventHandler('pv:setCruiseSpeed', function()
	if cruise == 0 and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		if GetEntitySpeedVector(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)['y'] > 0 then
			--cruise = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
			local ped = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(ped, false)
			cruise = GetEntitySpeed(vehicle)
			local cruiseKm = math.floor(cruise * 3.6 + 0.5)
			local cruiseMph = math.floor(cruise * 2.23694 + 0.5)
			if firstTime then
				TriggerEvent("hud:updateCruiseControl", true)
				exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>VELOCIDADE <span style='color:#069a19'>ATIVADO</span>", 3000, 'success')
				firstTime = false
			end
			
			--if cruiseON == false then
				--exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#069a19'>ATIVADO</span>", 3000, 'success')
				--else
					--exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#ff0000'>DESATIVADO</span>", 3000, 'error')
			--end
			--NotificationMessage("CruiseControl: ~g~ Ativado~w~")
			--if cruiseON == false then
				--exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#069a19'>ATIVADO</span>", 3000, 'success')
			--else
				--exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#ff0000'>DESATIVADO</span>", 3000, 'error')
			--end
			
			Citizen.CreateThread(function()
				while cruise > 0 and GetPedInVehicleSeat(vehicle, -1) == ped do
					local cruiseVeh = vehicle
					if IsVehicleOnAllWheels(cruiseVeh) and cruise > (cruise - 2.0) then
						SetVehicleForwardSpeed(vehicle, cruise)
					else
						cruise = 0
						--NotificationMessage("Cruise Control: ~r~ Desativado")
						exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#ff0000'>DESATIVADO</span>", 3000, 'error')
						TriggerEvent("hud:updateCruiseControl", false)
						break
					end
					if IsControlPressed(1, 8) then
						cruise = 0
						--NotificationMessage("Cruise Control: ~r~ Desativado")
						exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#ff0000'>DESATIVADO</span>", 3000, 'error')
						TriggerEvent("hud:updateCruiseControl", false)
					end
					if IsControlPressed(1, 32) then
						cruise = 0
						TriggerEvent('pv:setNewSpeed')
					end
					if cruise > 44 then
						cruise = 0
						--NotificationMessage("Não foi possível ativar o Cruise Control pois estás a alta velocidade!")
						exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'><span style='color:#ff0000'>Não foi possível</span> ativar o Cruise Control pois estás a alta velocidade!", 3000, 'error')
						break
					end
					Wait(200)
				end
				cruise = 0
			end)
		else
			cruise = 0
			cruiseON = false
			--NotificationMessage("CruiseControl: ~r~Desativado")
			TriggerEvent("hud:updateCruiseControl", false)
			exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#ff0000'>DESATIVADO</span>", 3000, 'error')
		end
	else
		if cruise > 0 then
			--NotificationMessage("CruiseControl: ~r~Desativado")
			exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>Cruise Control: <span style='color:#ff0000'>DESATIVADO</span>", 3000, 'error')
		end
		cruise = 0
		cruiseON = false
		TriggerEvent("hud:updateCruiseControl", false)
	end
end)

AddEventHandler('pv:setNewSpeed', function()
	Citizen.CreateThread(function()
		while IsControlPressed(1, 32) do
			Wait(1)
		end
		TriggerEvent('pv:setCruiseSpeed')
		--exports['Johnny_Notificacoes']:Alert("CRUISE CONTROL", "<span style='color:#c7c7c7'>VELOCIDADE <span style='color:#069a19'>ATUALIZADA</span>", 3000, 'success')
	end)
end)

function NotificationMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end
