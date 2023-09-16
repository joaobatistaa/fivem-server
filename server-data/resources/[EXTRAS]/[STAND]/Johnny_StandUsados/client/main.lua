PlayerData = {}

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

Citizen.CreateThread(function()

    if ESX.IsPlayerLoaded() then
		PlayerData = ESX.GetPlayerData()

		RemoveVehicles()

		Citizen.Wait(500)

		LoadSellPlace()

		SpawnVehicles()
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	PlayerData = response
	
	LoadSellPlace()

	SpawnVehicles()
end)

RegisterNetEvent("esx-qalle-sellvehicles:refreshVehicles")
AddEventHandler("esx-qalle-sellvehicles:refreshVehicles", function()
	RemoveVehicles()

	Citizen.Wait(500)

	SpawnVehicles()
end)

function LoadSellPlace()
	Citizen.CreateThread(function()

		local SellPos = Config.SellPosition

		local Blip = AddBlipForCoord(SellPos["x"], SellPos["y"], SellPos["z"])
		SetBlipSprite (Blip, 147)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 0.8)
		SetBlipColour (Blip, 52)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Stand de Usados")
		EndTextCommandSetBlipName(Blip)

		while true do
			local sleepThread = 500

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, SellPos["x"], SellPos["y"], SellPos["z"], true)

			if dstCheck <= 20.0 then
				sleepThread = 5

				if dstCheck <= 15 then
					ESX.Game.Utils.DrawText3D(SellPos, "[E] Stand Usados", 0.8)
					if IsControlJustPressed(0, 38) then
						if IsPedInAnyVehicle(ped, false) then
							OpenSellMenu(GetVehiclePedIsUsing(ped))
						else
							exports['Johnny_Notificacoes']:Alert("STAND USADOS", "<span style='color:#c7c7c7'>Tens que estar dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
						end
					end
				end
			end

			for i = 1, #Config.VehiclePositions, 1 do
				if Config.VehiclePositions[i]["entityId"] ~= nil then
					local pedCoords = GetEntityCoords(ped)
					local vehCoords = GetEntityCoords(Config.VehiclePositions[i]["entityId"])

					local dstCheck = GetDistanceBetweenCoords(pedCoords, vehCoords, true)

					if dstCheck <= 2.5 then
						sleepThread = 5

						ESX.Game.Utils.DrawText3D(vehCoords, "[E] Comprar por " .. Config.VehiclePositions[i]["price"] .. "€ | Contacto Vendedor: ".. Config.VehiclePositions[i]["contacto"], 0.4)

						if IsControlJustPressed(0, 38) then
							if IsPedInVehicle(ped, Config.VehiclePositions[i]["entityId"], false) then
								OpenSellMenu(Config.VehiclePositions[i]["entityId"], Config.VehiclePositions[i]["price"], true, Config.VehiclePositions[i]["owner"])
							else
								exports['Johnny_Notificacoes']:Alert("STAND USADOS", "<span style='color:#c7c7c7'>Tens que estar dentro do <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
							end
						end
					end
				end
			end

			Citizen.Wait(sleepThread)
		end
	end)
end

function OpenSellMenu(veh, price, buyVehicle, owner)
	local elements = {}

	if not buyVehicle then
		if price ~= nil then
			table.insert(elements, { ["label"] = "Alterar Preço - " .. price .. "€", ["value"] = "price" })
			table.insert(elements, { ["label"] = "Colocar à Venda", ["value"] = "sell" })
		else
			table.insert(elements, { ["label"] = "Definir Preço", ["value"] = "price" })
		end
	else
		if owner then
			table.insert(elements, { ["label"] = "Remover Veículo", ["value"] = "remove" })
		else
			table.insert(elements, { ["label"] = "Comprar por " .. price .. "€", ["value"] = "buy" })
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_veh',
		{
			title    = "Stand de Usados",
			align    = 'top-left',
			elements = elements
		},
	function(data, menu)
		local action = data.current.value

		if action == "price" then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_veh_price',
				{
					title = "Preço do Veículo"
				},
			function(data2, menu2)

				local vehPrice = tonumber(data2.value)

				menu2.close()
				menu.close()

				OpenSellMenu(veh, vehPrice)
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "sell" then
			local vehProps = ESX.Game.GetVehicleProperties(veh)

			ESX.TriggerServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(valid)

				if valid then
					DeleteVehicle(veh)
					exports['Johnny_Notificacoes']:Alert("STAND USADOS", "<span style='color:#c7c7c7'>Colocaste o teu veículo à venda por <span style='color:#069a19'>"..price.."€</span>!", 5000, 'success')
					menu.close()
				else
					exports['Johnny_Notificacoes']:Alert("STAND USADOS", "<span style='color:#c7c7c7'>Não és o <span style='color:#ff0000'>dono</span> deste veículo ou o stand de usados já está <span style='color:#ff0000'>cheio</span>!", 5000, 'error')
				end
	
			end, vehProps, price)
		elseif action == "buy" then
			local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable, totalMoney)
				if isPurchasable then
					DeleteVehicle(veh)
					ESX.Game.SpawnVehicle(vehProps.model, vector3(-52.8506, -1669.84, 29.289), 48.5, function(cbVeh)
						Citizen.Wait(10)
						SetEntityCoords(cbVeh, vector3(-52.8506, -1669.84, 29.289), 0.0, 0.0, 0.0, true)
						SetEntityHeading(cbVeh, 48.5)
						SetVehicleOnGroundProperly(cbVeh)
						SetVehicleNumberPlateText(cbVeh, vehProps.plate)

						Citizen.Wait(10)
						TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
						exports["Johnny_Combustivel"]:SetFuel(cbVeh, 100)
					end)
					exports['Johnny_Notificacoes']:Alert("STAND USADOS", "<span style='color:#c7c7c7'>Compraste o veículo por <span style='color:#069a19'>"..price.."€</span>!", 5000, 'success')
					menu.close()
				else
					exports['Johnny_Notificacoes']:Alert("STAND USADOS", "<span style='color:#c7c7c7'>Não tens dinheiro <span style='color:#ff0000'>suficiente</span>, necessitas de mais <span style='color:#ff0000'>" .. price - totalMoney .. "€</span>!", 5000, 'error')
				end
			end, vehProps, price, modelName, false)
		elseif action == "remove" then
			local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable, totalMoney)
				if isPurchasable then
					DeleteVehicle(veh)
					ESX.Game.SpawnVehicle(vehProps.model, vector3(-52.8506, -1669.84, 29.289), 48.5, function(cbVeh)
						Citizen.Wait(10)
						SetEntityCoords(cbVeh, vector3(-52.8506, -1669.84, 29.289), 0.0, 0.0, 0.0, true)
						SetEntityHeading(cbVeh, 48.5)
						SetVehicleOnGroundProperly(cbVeh)
						SetVehicleNumberPlateText(cbVeh, vehProps.plate)

						Citizen.Wait(10)
						TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
						exports["Johnny_Combustivel"]:SetFuel(cbVeh, 100)
					end)
					exports['Johnny_Notificacoes']:Alert("STAND USADOS", "<span style='color:#c7c7c7'>Removeste o teu veículo do <span style='color:#069a19'>stand usados</span>!", 5000, 'success')
					menu.close()
				end
			end, ESX.Game.GetVehicleProperties(veh), 0, modelName, true)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function RemoveVehicles()
	local VehPos = Config.VehiclePositions

	for i = 1, #VehPos, 1 do
		local veh, distance = ESX.Game.GetClosestVehicle(VehPos[i])

		if DoesEntityExist(veh) and distance <= 1.0 then
			DeleteEntity(veh)
		end
	end
end

function SpawnVehicles()
	local VehPos = Config.VehiclePositions

	ESX.TriggerServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(vehicles)
		for i = 1, #vehicles, 1 do

			local vehicleProps = vehicles[i]["vehProps"]

			LoadModel(vehicleProps["model"])

			VehPos[i]["entityId"] = CreateVehicle(vehicleProps["model"], VehPos[i]["x"], VehPos[i]["y"], VehPos[i]["z"] - 0.975, VehPos[i]["h"], false)
			VehPos[i]["price"] = vehicles[i]["price"]
			VehPos[i]["contacto"] = vehicles[i]["contacto"]
			VehPos[i]["owner"] = vehicles[i]["owner"]

			ESX.Game.SetVehicleProperties(VehPos[i]["entityId"], vehicleProps)

			FreezeEntityPosition(VehPos[i]["entityId"], true)

			SetEntityAsMissionEntity(VehPos[i]["entityId"], true, true)
			SetModelAsNoLongerNeeded(vehicleProps["model"])
		end
	end)

end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end
