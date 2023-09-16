-- Get Inventory Item & Count:
ESX.RegisterServerCallback('t1ger_minerjob:getInventoryItem',function(source, cb, item, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(item).count >= amount then cb(true) else cb(false) end
end)

-- Remove x amount of item(s) from inventory:
ESX.RegisterServerCallback('t1ger_minerjob:removeItem',function(source, cb, item, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(item).count >= amount then
		xPlayer.removeInventoryItem(item, amount)
		cb(true)
	else
		cb(false)
	end
end)

-- Mine Spot State:
RegisterServerEvent('t1ger_minerjob:mineSpotStateSV')
AddEventHandler('t1ger_minerjob:mineSpotStateSV', function(id, state)
	Config.Mining[id].inUse = state
    TriggerClientEvent('t1ger_minerjob:mineSpotStateCL', -1, id, state)
end)

local miningloc = {
	vector3(2972.12, 2841.38, 46.02),
	vector3(2973.16, 2837.92, 45.69),
	vector3(2974.26, 2834.10, 45.74),
	vector3(2958.47, 2851.04, 47.44),
	vector3(2977.588, 2831.150, 46.228),
	vector3(2979.696, 2825.716, 45.727),
}

-- Mining Reward:
RegisterServerEvent('t1ger_minerjob:miningReward')
AddEventHandler('t1ger_minerjob:miningReward', function(item, amount)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local invItem = xPlayer.getInventoryItem(item)
	local arr = {canCarry = false, limit = 0}

	if not ESX.playerInsideLocation(source, miningloc, 10.0) then
		TriggerEvent("WorldTuga:BanThisCheater", source, "Tentativa de Spawnar Dinheiro")
		return
	end
	

	if Config.ItemWeightSystem then
		if xPlayer.canCarryItem(item, amount) then
			arr.canCarry = true
			arr.limit = invItem.weight
		end
	else
		if invItem ~= -1 and (invItem.count + amount) <= invItem.limit then
			arr.canCarry = true
			arr.limit = invItem.limit
		end
	end
	if arr.canCarry then 
		xPlayer.addInventoryItem(item, amount)
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['stone_mined']):format(amount, invItem.label), 'success')
	else
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['item_limit_exceed']), 'error')
	end
end)

local washingloc = {
	vector3(1966.86, 536.98, 159.92),
	vector3(1994.04, 562.95, 160.38),
	vector3(1976.528, 524.8822, 160.56),
	vector3(1962.670, 482.8681, 159.78),
}

-- Washing Reward:
RegisterServerEvent('t1ger_minerjob:washingReward')
AddEventHandler('t1ger_minerjob:washingReward', function(item, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local invItem = xPlayer.getInventoryItem(item)
	local arr = {canCarry = false, limit = 0}

	if not ESX.playerInsideLocation(source, washingloc, 10.0) then
		TriggerEvent("WorldTuga:BanThisCheater", source, "Tentativa de Spawnar Dinheiro")
		return
	end

	if Config.ItemWeightSystem then
		if xPlayer.canCarryItem(item, amount) then
			arr.canCarry = true
			arr.limit = invItem.weight
		end
	else
		if invItem ~= -1 and (invItem.count + amount) <= invItem.limit then
			arr.canCarry = true
			arr.limit = invItem.limit
		end
	end
	if arr.canCarry then 
		xPlayer.addInventoryItem(item, amount)
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['stone_washed']):format(amount, invItem.label), 'success')
	else
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['item_limit_exceed']):format(invItem.label, arr.limit), 'error')
	end
end)

local smeltingLoc = {
	vector3(1088.08, -2001.52, 30.87),
	vector3(1088.51, -2005.12, 31.15),
	vector3(1084.61, -2001.91, 239.11),
}

-- Smelting Reward:
RegisterServerEvent('t1ger_minerjob:smeltingReward')
AddEventHandler('t1ger_minerjob:smeltingReward', function(table)
	local xPlayer = ESX.GetPlayerFromId(source)

	if not ESX.playerInsideLocation(source, smeltingLoc, 10.0) then
		TriggerEvent("WorldTuga:BanThisCheater", source, "Tentativa de Spawnar Dinheiro")
		return
	end

	for k,v in pairs(Config.SmeltingSettings.reward) do 
		math.randomseed(GetGameTimer())
		local chance = math.random(0,100)
		if chance <= v.chance then
			Citizen.Wait(250)
			math.randomseed(GetGameTimer())
			local count = math.random(v.amount.min, v.amount.max)
			-- add item:
			local invItem = xPlayer.getInventoryItem(v.item)
			local arr = {canCarry = false, limit = 0}
			if Config.ItemWeightSystem then
				if xPlayer.canCarryItem(v.item, count) then
					arr.canCarry = true
					arr.limit = invItem.weight
				end
			else
				if invItem ~= -1 and (invItem.count + count) <= invItem.limit then
					arr.canCarry = true
					arr.limit = invItem.limit
				end
			end
			if arr.canCarry then 
				xPlayer.addInventoryItem(v.item, count)
				TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['smelt_reward']):format(count, invItem.label), 'success')
			else
				TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['item_limit_exceed']):format(invItem.label, arr.limit), 'error')
			end
		end
		Citizen.Wait(250)
	end
end)

-- Remove x amount of item(s) from inventory:
ESX.RegisterServerCallback('t1ger_minerjob:temItemsParaVender',function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local temitems = false
	
	for k, v in pairs(Config.PricesMineiro) do
		if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
			temItems = true
		end
	end
	cb(temItems)
end)

RegisterServerEvent('t1ger_minerjob:vendaItensMineracao')
AddEventHandler('t1ger_minerjob:vendaItensMineracao', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local vendido = false
	local totalValor = 0
	local identifierlist = ExtractIdentifiers(source)
	
    for k, v in pairs(Config.PricesMineiro) do
        if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
			vendido = true
            local reward = 0
            for i = 1, xPlayer.getInventoryItem(k).count do
                reward = reward + math.random(v[1], v[2])
            end
			totalValor = totalValor + reward
			xPlayer.addAccountMoney('money', reward)
            TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward), 'success')
            xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
        end
    end
	if not vendido then
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangMineiro['no_items']), 'error')
	else
		local dataLog = {
			emprego = 'Mineiro',
			playerid = source,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(source),
			pagamento = totalValor,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		sendToDiscordEmpregos(dataLog)
	end
end)