ESX.RegisterUsableItem('turtlebait', function(source)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('vg_fishing:setbait', _source, "turtle")

		xPlayer.removeInventoryItem('turtlebait', 1)
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Meteste o isco para tartarugas na cana de pesca", 'success')
	else
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Tens que ter uma cana de pesca pra usar isto", 'error')
	end

end)

ESX.RegisterUsableItem('fishbait', function(source)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('vg_fishing:setbait', _source, "fish")

		xPlayer.removeInventoryItem('fishbait', 1)
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Meteste o isco na cana para pescar", 'success')

	else
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Tens que ter uma cana de pesca pra usar isto", 'error')
	end

end)

ESX.RegisterUsableItem('turtle', function(source)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('vg_fishing:setbait', _source, "shark")

		xPlayer.removeInventoryItem('turtle', 1)
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Meteste uma tartaruga como isco", 'success')
	else
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Tens que ter uma cana de pesca pra usar isto", 'error')
	end

end)

ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	TriggerClientEvent('vg_fishing:fishstart', _source)
end)

ESX.RegisterUsableItem('anchor', function(source)
	local _source = source
	TriggerClientEvent('vg_fishing:anchor', _source)
end)

RegisterServerEvent('vg_fishing:removeItem')
AddEventHandler('vg_fishing:removeItem', function(item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local ItemQuantity = xPlayer.getInventoryItem(item).count

	if ItemQuantity <= 0 then
		TriggerClientEvent('johnny_empregos:ShowNotification', source, 'Não tens o suficiente de ' .. item, 'error')
	else
		xPlayer.removeInventoryItem(item, count)
	end
end)

RegisterNetEvent('vg_fishing:catch')
AddEventHandler('vg_fishing:catch', function(bait)

	local _source = source
	local weight = 2
	local rnd = math.random(1,100)
	xPlayer = ESX.GetPlayerFromId(_source)
	local itemTurtle = xPlayer.getInventoryItem('turtle')
	local itemShark = xPlayer.getInventoryItem('shark')
	local itemFish = xPlayer.getInventoryItem('fish')

	if xPlayer.getInventoryItem('fishingrod').count == 0 then
		TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Peixes - Pescador")
        return
	end

	if bait == "turtle" then
		if rnd >= 78 then
			if rnd >= 94 then
				TriggerClientEvent('vg_fishing:setbait', _source, "none")
				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_reelin")
				Citizen.CreateThread(function()
					Citizen.Wait(13000)
					TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Era muito grande e partiu a tua cana..", 'info')
					TriggerClientEvent('vg_fishing:break', _source)
					xPlayer.removeInventoryItem('fishingrod', 1)
				end)
			else
				TriggerClientEvent('vg_fishing:setbait', _source, "none")
				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_reelin")
				Citizen.CreateThread(function()
					Citizen.Wait(13000)
					TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")

					TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste uma tartaruga!", 'success')
					xPlayer.addInventoryItem('turtle', 1)
					Citizen.CreateThread(function()
						Citizen.Wait(6000)
						TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
					end)

				end)
			end
		else
			if rnd >= 75 then
				weight = math.random(4,9)

				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")
				
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um peixe com: " .. weight .. "kg", 'success')
				xPlayer.addInventoryItem('fish', weight)
				Citizen.CreateThread(function()
					Citizen.Wait(6000)
					TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
				end)
			else
				weight = math.random(2,6)

				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")
				
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um peixe com: " .. weight .. "kg", 'success')
				xPlayer.addInventoryItem('fish', weight)
				Citizen.CreateThread(function()
					Citizen.Wait(6000)
					TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
				end)
			end
		end
	else
		if bait == "fish" then
			if rnd >= 75 then
				TriggerClientEvent('vg_fishing:setbait', _source, "none")
				weight = math.random(4,11)

				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")
				
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um peixe com: " .. weight .. "kg", 'success')
				xPlayer.addInventoryItem('fish', weight)
				Citizen.CreateThread(function()
					Citizen.Wait(6000)
					TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
				end)

			else
				weight = math.random(1,6)

				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")
				
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um peixe com: " .. weight .. "kg", 'success')
				xPlayer.addInventoryItem('fish', weight)
				Citizen.CreateThread(function()
				Citizen.Wait(6000)
				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
				end)
			end
		end
		if bait == "none" then
			if rnd >= 70 then
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Não estás a usar iscas para pescar", 'info')
				weight = math.random(2,4)

				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um peixe com: " .. weight .. "kg", 'success')
				xPlayer.addInventoryItem('fish', weight)
				Citizen.CreateThread(function()
				Citizen.Wait(6000)
				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
				end)
			else
				weight = math.random(1,2)
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Não estás a usar iscas para pescar", 'info')

				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")
				
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um peixe com: " .. weight .. "kg", 'success')
				xPlayer.addInventoryItem('fish', weight)
				Citizen.CreateThread(function()
					Citizen.Wait(6000)
					TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
				end)

			end
		end
		if bait == "shark" then
			if rnd >= 70 then
				if rnd >= 91 then
					TriggerClientEvent('vg_fishing:setbait', _source, "none")
					Citizen.CreateThread(function()
						TriggerClientEvent('vg_fishing:playSound', _source, "fishing_reelin")
						Citizen.Wait(13000)
						TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Era muito grande e partiu-te a cana...", 'info')
						TriggerClientEvent('vg_fishing:break', _source)
						xPlayer.removeInventoryItem('fishingrod', 1)
					end)
				else

					Citizen.CreateThread(function()
						TriggerClientEvent('vg_fishing:playSound', _source, "fishing_reelin")
						Citizen.Wait(13000)
						TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")
						TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um tubarão, é ilegal apanhar tubarões!", 'success')
						TriggerClientEvent('vg_fishing:spawnPed', _source)
						xPlayer.addInventoryItem('shark', 1)
						Citizen.Wait(6000)
						TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
					end)
				end
			else
				weight = math.random(4,8)

				TriggerClientEvent('johnny_empregos:ShowNotification', _source, "Apanhaste um peixe com: " .. weight .. "kg", 'success')
				xPlayer.addInventoryItem('fish', weight)
				Citizen.CreateThread(function()
				Citizen.Wait(6000)
				TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
				end)

			end
		end
	end
end)

RegisterServerEvent("vg_fishing:lowmoney")
AddEventHandler("vg_fishing:lowmoney", function(money)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

RegisterServerEvent('vg_fishing:startSelling')
AddEventHandler('vg_fishing:startSelling', function(item)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local FishQuantity = xPlayer.getInventoryItem('fish')
	local TurtleQuantity = xPlayer.getInventoryItem('turtle').count
	local SharkQuantity = xPlayer.getInventoryItem('shark').count

	if item == "fish" then
		if not FishQuantity or (FishQuantity.count <= 9) then
			TriggerClientEvent('johnny_empregos:ShowNotification', source, 'Não tens peixes suficientes (Mín. 10)!', 'error')
		else
			xPlayer.removeInventoryItem('fish', 10)
			local payment = Config.PescadorInfo.FishPrice.a
			payment = (math.random(Config.PescadorInfo.FishPrice.a, Config.PescadorInfo.FishPrice.b) * 10)
			xPlayer.addMoney(payment)
		
			local identifierlist = ExtractIdentifiers(_source)
			local dataLog = {
				emprego = 'Pescador',
				playerid = _source,
				identifier = identifierlist.steam:gsub("steam:", ""),
				playername = GetPlayerName(_source),
				pagamento = payment,
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
			}
		
			sendToDiscordEmpregos(dataLog)
		end
	end

	if item == "turtle" then
		if TurtleQuantity == 0 then
			TriggerClientEvent('johnny_empregos:ShowNotification', source, 'Não tens tartarugas suficientes!', 'error')
		else
			xPlayer.removeInventoryItem('turtle', TurtleQuantity)
			local payment = Config.PescadorInfo.TurtlePrice.a
			payment = (math.random(Config.PescadorInfo.TurtlePrice.a, Config.PescadorInfo.TurtlePrice.b) * TurtleQuantity)
			xPlayer.addMoney(payment)
			
			local identifierlist = ExtractIdentifiers(_source)
			local dataLog = {
				emprego = 'Pescador',
				playerid = _source,
				identifier = identifierlist.steam:gsub("steam:", ""),
				playername = GetPlayerName(_source),
				pagamento = payment,
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
			}
			
			sendToDiscordEmpregos(dataLog)
		end
	end

	if item == "shark" then
		if SharkQuantity == 0 then
			TriggerClientEvent('johnny_empregos:ShowNotification', source, 'Não tens tubarões suficientes!', 'error')
		else
			xPlayer.removeInventoryItem('shark', SharkQuantity)
			local payment = Config.PescadorInfo.SharkPrice.a
			payment = (math.random(Config.PescadorInfo.SharkPrice.a, Config.PescadorInfo.SharkPrice.b) * SharkQuantity)
			xPlayer.addMoney(payment)
			
			local identifierlist = ExtractIdentifiers(_source)
			local dataLog = {
				emprego = 'Pescador',
				playerid = _source,
				identifier = identifierlist.steam:gsub("steam:", ""),
				playername = GetPlayerName(_source),
				pagamento = payment,
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
			}
			
			sendToDiscordEmpregos(dataLog)
		end
	end
end)