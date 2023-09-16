local VehiclesForSale = 0

ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(source, cb)
	local src = source
	local identifier = ESX.GetPlayerFromId(src)["identifier"]
	
	
    MySQL.Async.fetchAll("SELECT seller, vehicleProps, price FROM vehicles_for_sale", {}, function(result)
        local vehicleTable = {}

        VehiclesForSale = 0

        if result[1] ~= nil then
            for i = 1, #result, 1 do
                VehiclesForSale = VehiclesForSale + 1

				local seller = false
				local numTelemovel = nil

				if result[i]["seller"] == identifier then
					seller = true
				end
				
				local resultNumber = MySQL.Sync.fetchAll("SELECT charinfo FROM `users` WHERE `identifier` = '"..result[i]["seller"].."'", {} )
				if resultNumber and resultNumber[1] then 
					numTelemovel = json.decode(resultNumber[1].charinfo).phone
				end
				if numTelemovel == nil then
					numTelemovel = 0
				end

                table.insert(vehicleTable, { ["price"] = result[i]["price"], ["vehProps"] = json.decode(result[i]["vehicleProps"]), ["owner"] = seller, ["contacto"] = numTelemovel })
            end
        end

        cb(vehicleTable)
    end)
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(source, cb, vehicleProps, price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    
    local plate = vehicleProps["plate"]

	local isFound = false

	RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)

		for id, v in pairs(ownedVehicles) do

			if Trim(plate) == Trim(v.plate) and #Config.VehiclePositions ~= VehiclesForSale then
                
                MySQL.Async.execute("INSERT INTO vehicles_for_sale (seller, vehicleProps, price) VALUES (@sellerIdentifier, @vehProps, @vehPrice)",
                    {
						["@sellerIdentifier"] = xPlayer["identifier"],
                        ["@vehProps"] = json.encode(vehicleProps),
                        ["@vehPrice"] = price
                    }
                )

				MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = plate})

                TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

				isFound = true
				break

			end		

		end

		cb(isFound)

	end)
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:buyVehicle", function(source, cb, vehProps, price, modelName, owner)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    
	local price = price
	local plate = vehProps.plate

	if xPlayer.getAccount("bank")["money"] >= price and not owner then
		xPlayer.removeAccountMoney("bank", price)
		
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, model) VALUES (@owner, @plate, @vehicle, @model)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = plate,
			['@vehicle'] = json.encode(vehProps),
			['@model'] = modelName
		})

		TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

		MySQL.Async.fetchAll('SELECT seller FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {}, function(result)
			if result[1] ~= nil and result[1]["seller"] ~= nil then
				UpdateCash(result[1]["seller"], price)
			else
				print("Something went wrong, there was no car.")
			end
		end)

		MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {})

		cb(true)
	elseif owner then
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, model) VALUES (@owner, @plate, @vehicle, @model)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = plate,
			['@vehicle'] = json.encode(vehProps),
			['@model'] = modelName
		})

		TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)
		
		MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {})
		
		cb(true)
	else
		cb(false, xPlayer.getAccount("bank")["money"])
	end
end)

function RetrievePlayerVehicles(newIdentifier, cb)
	local identifier = newIdentifier

	local yourVehicles = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier", {['@identifier'] = identifier}, function(result) 

		for id, values in pairs(result) do

			local vehicle = json.decode(values.vehicle)
			local plate = values.plate

			table.insert(yourVehicles, { vehicle = vehicle, plate = plate })
		end

		cb(yourVehicles)

	end)
end

function UpdateCash(identifier, cash)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	
	if xPlayer ~= nil then
		xPlayer.addAccountMoney("bank", cash)
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "SUCESSO", "<span style='color:#c7c7c7'>Alguém comprou o teu veículo do stand de usados!\n Foram transferidos <span style='color:#069a19'>"..cash.."€</span> para a tua conta!", 5000, 'success')
	else	
		MySQL.Async.fetchScalar("SELECT accounts FROM users WHERE identifier = @identifier", {
			["@identifier"] = identifier
		}, function(accountsJson)
			if accountsJson ~= nil then
				local accounts = json.decode(accountsJson)
				if accounts ~= nil and accounts["bank"] ~= nil then
					local newBank = accounts["bank"] + cash
					accounts["bank"] = newBank
					local newAccountsJson = json.encode(accounts)
					MySQL.Async.execute("UPDATE users SET accounts = @newAccountsJson WHERE identifier = @identifier", {
						["@newAccountsJson"] = newAccountsJson,
						["@identifier"] = identifier
					}, function(rowsChanged)
						if rowsChanged > 0 then
							print('Nova venda efetuada nos Stands Usados!')
						else
							print('Erro ao atualizar o dinheiro da venda do carro no stand de usados para o vendedor!')
						end
					end)
				end
			end
		end)
		
	end
end

Trim = function(word)
	if word ~= nil then
		return word:match("^%s*(.-)%s*$")
	else
		return nil
	end
end