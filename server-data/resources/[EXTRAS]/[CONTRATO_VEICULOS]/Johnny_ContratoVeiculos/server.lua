local Webhook = 'https://discord.com/api/webhooks/1078123711623856258/ZY-VnL7PYSblugBdQGWAVR-6ZWVumBxLV-TpN9GM0rfFr5Ha9WljEh_6J7a-RtO742Py'

ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('okokContract:changeVehicleOwner')
AddEventHandler('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	})

	if Config.RemoveMoneyOnSign then
		local bankMoney = tPlayer.getAccount('bank').money

		if result[1] ~= nil  then
			if bankMoney >= vehicle_price then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = tPlayer.identifier,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then	
						tPlayer.removeAccountMoney('bank', vehicle_price)
						xPlayer.addAccountMoney('bank', vehicle_price)
						
						TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste o teu <span style='color:#069a19'><b>"..model.."</b></span> com a matrícula <span style='color:#069a19'><b>"..plate.."</b></span>", 10000, 'success')
						TriggerClientEvent('Johnny_Notificacoes:Alert', target, "SUCESSO", "Compraste um <span style='color:#069a19'><b>"..model.."</b></span> com a matrícula <span style='color:#069a19'><b>"..plate.."</b></span>", 10000, 'success')
						
						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "ERRO", "O jogador "..target_name.." não tem <span style='color:#ff0000'>dinheiro suficiente</span>!", 10000, 'error')
				TriggerClientEvent('Johnny_Notificacoes:Alert', target, "ERRO", "Não tens <span style='color:#ff0000'>dinheiro suficiente</span> para comprar o veículo de "..source_name.."!", 10000, 'error')
			end
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "ERRO", "O veículo com a matrícula <b>"..plate.."</b> <span style='color:#ff0000'>não é teu</span>!", 10000, 'error')
			TriggerClientEvent('Johnny_Notificacoes:Alert', target, "ERRO", "O jogador "..source_name.." tentou vender um veículo que <span style='color:#ff0000'>não lhe pertence</span>!", 10000, 'error')
		end
	else
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
				['@owner'] = xPlayer.identifier,
				['@target'] = tPlayer.identifier,
				['@plate'] = plate
			}, function (result2)
				if result2 ~= 0 then
					TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste o teu <span style='color:#069a19'><b>"..model.."</b></span> com a matrícula <span style='color:#069a19'><b>"..plate.."</b></span>", 10000, 'success')
					TriggerClientEvent('Johnny_Notificacoes:Alert', target, "SUCESSO", "Compraste um <span style='color:#069a19'><b>"..model.."</b></span> com a matrícula <span style='color:#069a19'><b>"..plate.."</b></span>", 10000, 'success')
					if Webhook ~= '' then
						sellVehicleWebhook(webhookData)
					end
				end
			end)
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "ERRO", "O veículo com a matrícula <b>"..plate.."</b> <span style='color:#ff0000'>não é teu</span>!", 10000, 'error')
			TriggerClientEvent('Johnny_Notificacoes:Alert', target, "ERRO", "O jogador "..source_name.." tentou vender um veículo que <span style='color:#ff0000'>não lhe pertence</span>!", 10000, 'error')
		end
	end
end)

ESX.RegisterServerCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = ESX.GetPlayerFromId(targetid)
	local targetname = target.getName()

	cb(targetname)
end)

RegisterServerEvent('okokContract:SendVehicleInfo')
AddEventHandler('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:GetVehicleInfo', _source, xPlayer.getName(), os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer')
AddEventHandler('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
	TriggerClientEvent('okokContract:startContractAnimation', data.targetID)

	if Config.RemoveContractAfterUse then
		xPlayer.removeInventoryItem('contract', 1)
	end
end)

ESX.RegisterUsableItem('contract', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:OpenContractInfo', _source)
	TriggerClientEvent('okokContract:startContractAnimation', _source)
end)

-------------------------- SELL VEHICLE WEBHOOK

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'TRANSFERÊNCIA DE VEÍCULO',
			["description"] = '**Veículo: **'..data.model..'**\nMatrícula: **'..data.plate..'**\nNome do Comprador: **'..data.target_name..'**\nNome do Vendedor: **'..data.source_name..'**\nPreço: **'..data.vehicle_price..'€',

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end