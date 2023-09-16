RegisterNetEvent("okokDelVehicles:delete")
AddEventHandler("okokDelVehicles:delete", function()
	local minuteCalculation = 60000
	local minutesPassed = 0
	local minutesLeft = 5 -- TEMPO PARA DEFINIR QUANTOS MINUTOS PARA APAGAR OS CARROS
	local minutosParaApagar = 5 -- TEMPO PARA DEFINIR QUANTOS MINUTOS PARA APAGAR OS CARROS
	
	exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'> Todos os carros do servidor sem condutor irão ser removidos em <span style='color:#ffc107'>"..math.floor(minutesLeft).."</span> minutos!", 5000, 'warning')
	
	while minutesPassed < minutosParaApagar do
		Citizen.Wait(1*minuteCalculation)
		minutesPassed = minutesPassed + 1
		minutesLeft = minutesLeft - 1
		if minutesLeft == 0 then
			exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'> Todos os carros do servidor sem condutor foram <span style='color:#ffc107'>removidos</span>!", 5000, 'warning')
		elseif minutesLeft == 1 then
			exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'> Todos os carros do servidor sem condutor irão ser removidos em <span style='color:#ffc107'>"..math.floor(minutesLeft).."</span> minuto!", 5000, 'warning')
		else
			exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'> Todos os carros do servidor sem condutor irão ser removidos em <span style='color:#ffc107'>"..math.floor(minutesLeft).."</span> minutos!", 5000, 'warning')
		end
	end
	for vehicle in EnumerateVehicles() do
		local carCoords = GetEntityCoords(vehicle)

		if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then
			SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
			SetEntityAsMissionEntity(vehicle, false, false) 
			DeleteVehicle(vehicle)
			if (DoesEntityExist(vehicle)) then 
				DeleteVehicle(vehicle) 
			end
		end
	end
	TriggerEvent('vehicleshop:spawnStandVehicles')
end)

local entityEnumerator = {
	__gc = function(enum)
	if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
	end
	enum.destructor = nil
	enum.handle = nil
end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end