local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local PlateLetters = 3
local PlateNumbers = 3
local PlateUseSpace = true

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. ' ' .. GetRandomNumber(PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. GetRandomNumber(PlateNumbers))
		end

		ESX.TriggerServerCallback('JAM_VehicleShop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('JAM_VehicleShop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

------------------------------------------------------------------------------------------------------------------------------------

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
	ESX.PlayerData = xPlayer
end)

RegisterCommand('carroempresa', function(source, args)
	local playerPed = PlayerPedId()
	local vehicle  = GetVehiclePedIsIn(playerPed, false)
	local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
	
	if args[1] == 'pessoal' or args[1] == 'empresa' then
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			ESX.TriggerServerCallback('johnny_scripts:adicionarCarroEmpresaBD', function(result)

				if result == 'notchefe' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Apenas o <span style='color:#ff0000'>chefe</span> pode adicionar carros na empresa!", 5000, 'error')
				elseif result == 'notjoballowed' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "A tua empresa não tem <span style='color:#ff0000'>permissão</span> para adicionar carros na garagem da empresa!", 5000, 'error')
				elseif result == 'notdonoveiculo' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Esse veículo <span style='color:#ff0000'>não é teu</span>!", 5000, 'error')
				elseif result == 'notvalidcar' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Esse veículo <span style='color:#ff0000'>não</span> está atribuído a nenhum jogador!", 5000, 'error')
				elseif result then
					exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Veículo <span style='color:#069a19'>adicionado</span> na garagem da empresa!", 5000, 'success')
				else
					exports['Johnny_Notificacoes']:Alert("ERRO", "Ocorreu um <span style='color:#ff0000'>erro</span> ao tentar adicionar na base de dados!", 5000, 'error')
				end

			end, vehicleProps.plate, args[1])
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que estar <span style='color:#ff0000'>dentro</span> de um veículo!", 5000, 'error')
		end
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "OPÇÃO INVÁLIDA: (USA /CARROEMPRESA PESSOAL OU /CARROEMPRESA EMPRESA)", 5000, 'error')
	end
end)

RegisterCommand('retirarcarroempresa', function(source)
	local playerPed = PlayerPedId()
	local vehicle  = GetVehiclePedIsIn(playerPed, false)
	local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
	
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.TriggerServerCallback('johnny_scripts:removerCarroEmpresaBD', function(result)

			if result == 'notchefe' then
				exports['Johnny_Notificacoes']:Alert("ERRO", "Apenas o <span style='color:#ff0000'>chefe</span> pode remover carros da empresa!", 5000, 'error')
			elseif result == 'notjoballowed' then
				exports['Johnny_Notificacoes']:Alert("ERRO", "A tua empresa não tem <span style='color:#ff0000'>permissão</span> para remover carros da garagem empresa!", 5000, 'error')
			elseif result == 'notdonoveiculo' then
				exports['Johnny_Notificacoes']:Alert("ERRO", "Esse veículo <span style='color:#ff0000'>não é teu</span>!", 5000, 'error')
			elseif result == 'notvalidcar' then
				exports['Johnny_Notificacoes']:Alert("ERRO", "Esse veículo <span style='color:#ff0000'>não</span> está atribuído a nenhum jogador!", 5000, 'error')
			elseif result then
				exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Veículo <span style='color:#069a19'>removido</span> da garagem da empresa!", 5000, 'success')
			else
				exports['Johnny_Notificacoes']:Alert("ERRO", "Ocorreu um <span style='color:#ff0000'>erro</span> ao tentar adicionar na base de dados!", 5000, 'error')
			end
	
		end, vehicleProps.plate)
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que estar <span style='color:#ff0000'>dentro</span> de um veículo!", 5000, 'error')
	end
end)

RegisterCommand('carrofundador', function(source, args)
	local playerPed = PlayerPedId()
	local args = args[1]
	local vehicle  = GetVehiclePedIsIn(playerPed, false)
	
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		if args ~= nil then
			
			ESX.TriggerServerCallback('johnny_scripts:adicionarVeiculoBD', function(result)

				if result == 'notfundador' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Não és <span style='color:#ff0000'>fundador</span> do servidor!", 5000, 'error')
				elseif result == 'offline' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Não existe nenhum jogador no servidor com esse <span style='color:#ff0000'>ID</span>!", 5000, 'error')
				elseif result == 'iderror' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Indica um ID válido! Maior que 0!", 5000, 'error')
				elseif result then
					local plate = GeneratePlate()
					
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = plate
					local model = GetEntityModel(vehicle)
					local displaytext = GetDisplayNameFromVehicleModel(model)
					
					TriggerServerEvent("johnny_scripts:addVehicle", args, vehicleProps, displaytext, 'car')
					exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Veículo <span style='color:#069a19'>adicionado</span> na garagem do jogador!", 5000, 'success')
				else
					exports['Johnny_Notificacoes']:Alert("ERRO", "Ocorreu um <span style='color:#ff0000'>erro</span> ao tentar adicionar na base de dados!", 5000, 'error')
				end
		
			end, args)
		
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que indicar o <span style='color:#ff0000'>STEAM ID / ID</span> do jogador que irá receber o carro!", 5000, 'error')
		end
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que estar <span style='color:#ff0000'>dentro</span> de um carro!", 5000, 'error')
	end
end)

RegisterCommand('barcofundador', function(source, args)
	local playerPed = PlayerPedId()
	local args = args[1]
	local vehicle  = GetVehiclePedIsIn(playerPed, false)
	
	if IsPedInAnyVehicle(PlayerPedId(), false) then
	
		if args ~= nil then
			
			ESX.TriggerServerCallback('johnny_scripts:adicionarVeiculoBD', function(result)
	
				if result == 'notfundador' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Não és <span style='color:#ff0000'>fundador</span> do servidor!", 5000, 'error')
				elseif result == 'offline' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Não existe nenhum jogador no servidor com esse <span style='color:#ff0000'>ID</span>!", 5000, 'error')
				elseif result == 'iderror' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Indica um ID válido! Maior que 0!", 5000, 'error')
				elseif result then
					local plate = GeneratePlate()
					
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = plate
					local model = GetEntityModel(vehicle)
					local displaytext = GetDisplayNameFromVehicleModel(model)
					SetVehicleNumberPlateText(vehicle, plate)
					
					TriggerServerEvent("johnny_scripts:addVehicle", args, vehicleProps, displaytext, 'boat')
					exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Barco <span style='color:#069a19'>adicionado</span> na garagem do jogador!", 5000, 'success')
				else
					exports['Johnny_Notificacoes']:Alert("ERRO", "Ocorreu um <span style='color:#ff0000'>erro</span> ao tentar adicionar na base de dados!", 5000, 'error')
				end
		
			end, args)
		
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que indicar o <span style='color:#ff0000'>STEAM ID / ID</span> do jogador que irá receber o barco!", 5000, 'error')
		end
	
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que estar <span style='color:#ff0000'>dentro</span> de um barco!", 5000, 'error')
	end
	
end)

RegisterCommand('aviaofundador', function(source, args)
	local playerPed = PlayerPedId()
	local args = args[1]
	local vehicle  = GetVehiclePedIsIn(playerPed, false)
	
	if IsPedInAnyVehicle(PlayerPedId(), false) then
	
		if args ~= nil then
			
			ESX.TriggerServerCallback('johnny_scripts:adicionarVeiculoBD', function(result)
	
				if result == 'notfundador' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Não és <span style='color:#ff0000'>fundador</span> do servidor!", 5000, 'error')
				elseif result == 'offline' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Não existe nenhum jogador no servidor com esse <span style='color:#ff0000'>ID</span>!", 5000, 'error')
				elseif result == 'iderror' then
					exports['Johnny_Notificacoes']:Alert("ERRO", "Indica um ID válido! Maior que 0!", 5000, 'error')
				elseif result then
					local plate = GeneratePlate()
					
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = plate
					local model = GetEntityModel(vehicle)
					local displaytext = GetDisplayNameFromVehicleModel(model)
					SetVehicleNumberPlateText(vehicle, plate)
					
					TriggerServerEvent("johnny_scripts:addVehicle", args, vehicleProps, displaytext, 'airplane')
					
					exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Avião <span style='color:#069a19'>adicionado</span> na garagem do jogador!", 5000, 'success')
				else
					exports['Johnny_Notificacoes']:Alert("ERRO", "Ocorreu um <span style='color:#ff0000'>erro</span> ao tentar adicionar na base de dados!", 5000, 'error')
				end
		
			end, args)
		
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que indicar o <span style='color:#ff0000'>STEAM ID / ID</span> do jogador que irá receber o carro!", 5000, 'error')
		end
	
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "Tens que estar <span style='color:#ff0000'>dentro</span> de um avião!", 5000, 'error')
	end
	
end)

RegisterCommand('steamid', function(source, args)
	local nomeJogador = tostring(args[1])
	
	if nomeJogador ~= nil then
		
		ESX.TriggerServerCallback('johnnyscripts:getSteamID', function(result)
	
			if result then	
				
				--if iddasteam ~= false then	
					print(result)
					exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>O <span style='color:#069a19'>STEAM ID</span> desse jogador está na tua consola", 5000, 'success')
				--else
					--exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não há nenhum <span style='color:#ff0000'>jogador</span> online com esse id!", 5000, 'error')
				--end
			elseif result == 'nao_encontrado' then
				exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Nenhum STEAM ID encontrado associado a esse <span style='color:#ff0000'>NOME</span>!", 5000, 'error')
			else
				exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>permissões</span> suficientes!", 5000, 'error')
			end
		
		end, nomeJogador)
		
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Tens que indicar o <span style='color:#ff0000'>nome da steam</span> do jogador!", 5000, 'error')
	end
	
end)