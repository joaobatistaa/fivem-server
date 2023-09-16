local guiEnabled = false
local Total = 10
local PerMinute = 3
local BaseFare = 10
local taxiFreeze = false
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

DecorRegister("totalCost", 3)
DecorRegister("costPerMinute", 3)
DecorRegister("taxiFreeze", 2)

function openGui()
	guiEnabled = true
	exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Usa o comando /infotaxi para veres outros comandos do Medidor de Táxi!", 10000, 'success')
	SendNUIMessage({openSection = "openTaxiMeter"})
end

function closeGui()
	if guiEnabled then
		SendNUIMessage({openSection = "closeTaxiMeter"})
		guiEnabled = false
		SetPlayerControl(PlayerId(), 1, 0)
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
		if isInVehicle then
			local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if IsPedInAnyTaxi(PlayerPedId()) and guiEnabled then
				PerMinute = DecorGetInt(currentVehicle, 'costPerMinute')
				updateDriverMeter()
			else
				Citizen.Wait(2500)
			end
		else
			closeGui()
			Citizen.Wait(2500)
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		if guiEnabled then
			Citizen.Wait(10000)
			local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if not DecorGetBool(currentVehicle, 'taxiFreeze') then
				local totalFare = DecorGetInt(currentVehicle, 'totalCost')
				local newFare = totalFare + math.ceil(PerMinute / 10)
				DecorSetInt(currentVehicle, 'totalCost', newFare)
				updateDriverMeter()
			end
		else
			Citizen.Wait(5000)
		end
	end
end)


function updateDriverMeter()
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local updateTotal = DecorGetInt(currentVehicle, 'totalCost')

	SendNUIMessage({openSection = "updateTotal", sentnumber = ""..updateTotal..".00€" })
	SendNUIMessage({openSection = "updatePerMinute", sentnumber = ""..PerMinute..".00€" })
	SendNUIMessage({openSection = "updateBaseFare", sentnumber = ""..BaseFare..".00€" })
end

RegisterCommand("medidortaxi", function(source, args)
	if PlayerData.job.name == 'taxi' then
		if IsPedInAnyTaxi(PlayerPedId()) then
			if guiEnabled then
				closeGui()
			else
				openGui()
			end
		end
	end
end)

RegisterCommand("infotaxi", function(source, args)
	if PlayerData.job.name == 'taxi' then
		if IsPedInAnyTaxi(PlayerPedId()) then
			exports['Johnny_Notificacoes']:Alert("INFO TÁXI", "<span style='color:#069a19'>'/custominuto (valor)'<span style='color:#c7c7c7'> - Custo por minuto</span><br><span style='color:#069a19'>'/tarifabase (valor)'<span style='color:#c7c7c7'> - Tarifa Base</span><br><span style='color:#069a19'>'/taxicontagem'<span style='color:#c7c7c7'> - Iniciar/Pausar Contador de Táxi</span><br><span style='color:#069a19'>'/taxiresetar'<span style='color:#c7c7c7'> - Resetar Contador de Táxi</span>", 15000, 'info')
		end
	end
end)

RegisterCommand("custominuto", function(source, args)
	if PlayerData.job.name == 'taxi' then
		if IsPedInAnyTaxi(PlayerPedId()) then
			local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

			if IsPedInAnyTaxi(PlayerPedId()) then
				if tonumber(args[1]) ~= nil then
					DecorSetInt(currentVehicle, 'costPerMinute', tonumber(args[1]))
					exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Custo por minuto definido para <span style='color:#069a19'>"..tonumber(args[1]).."€</span>!", 5000, 'success')
				else
					exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Tens que inserir um número!", 5000, 'error')
				end
			end
		end
	end
end)

RegisterCommand("tarifabase", function(source, args)
	if PlayerData.job.name == 'taxi' then
		if IsPedInAnyTaxi(PlayerPedId()) then
			local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

			if IsPedInAnyTaxi(PlayerPedId()) then
				if tonumber(args[1]) ~= nil then
					BaseFare = tonumber(args[1])
					exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Tarifa base definida para <span style='color:#069a19'>"..tonumber(args[1]).."€</span>!", 5000, 'success')
				else
					exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Tens que inserir um número!", 5000, 'error')
				end
			end
		end
	end
end)

RegisterCommand("taxiresetar", function(source, args)
	if PlayerData.job.name == 'taxi' then
		if IsPedInAnyTaxi(PlayerPedId()) then
			local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			local driverPed = GetPedInVehicleSeat(currentVehicle, -1)
			if IsPedInAnyTaxi(PlayerPedId()) then
				if GetPlayerPed(-1) == driverPed then
					DecorSetInt(currentVehicle, 'totalCost', 0)
					DecorSetInt(currentVehicle, 'costPerMinute', 0)
					DecorSetInt(currentVehicle, 'totalCost', BaseFare)
					exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>O medidor do táxi foi <span style='color:#069a19'>resetado</span>!", 5000, 'success')
				end
			end
		end
	end
end)

RegisterCommand("taxicontagem", function(source, args)
	if PlayerData.job.name == 'taxi' then
		if IsPedInAnyTaxi(PlayerPedId()) then
			local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			local driverPed = GetPedInVehicleSeat(currentVehicle, -1)
			if IsPedInAnyTaxi(PlayerPedId()) then
				if GetPlayerPed(-1) == driverPed then
					taxiFreeze = not DecorGetBool(currentVehicle, 'taxiFreeze')
					DecorSetBool(currentVehicle, 'taxiFreeze', taxiFreeze)
					if taxiFreeze then
						exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Contagem do medidor de táxi <span style='color:#069a19'>pausada</span>!", 5000, 'success')
					else
						exports['Johnny_Notificacoes']:Alert("MEDIDOR TÁXI", "<span style='color:#c7c7c7'>Contagem do medidor de táxi <span style='color:#069a19'>retomada</span>!", 5000, 'success')
					end
				end
			end
		end
	end
end)
