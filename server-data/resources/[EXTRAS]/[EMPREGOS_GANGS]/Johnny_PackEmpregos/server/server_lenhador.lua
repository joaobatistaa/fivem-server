ESX = nil

ESX = exports['es_extended']:getSharedObject()

local Chopped = false

RegisterServerEvent('tr-lumberjack:sellItems')
AddEventHandler('tr-lumberjack:sellItems', function()
	local price = 0
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventory() ~= nil and next(xPlayer.getInventory()) ~= nil then
		for k, v in pairs(Config.SellLenhador) do
			local item = xPlayer.getInventoryItem(k)
			local count = item.count
			if xPlayer.getInventoryItem(k) and count > 0 then
				price = price + (Config.SellLenhador[k].price * count)
				xPlayer.removeInventoryItem(k, count)
				TriggerClientEvent('johnny_empregos:ShowNotification', _source, Config.Alerts["successfully_sold"], 'success')
			end
		end
		xPlayer.addAccountMoney('money', price)
		
		local identifierlist = ExtractIdentifiers(_source)
		
		local dataLog = {
			emprego = 'Lenhador',
			playerid = _source,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(_source),
			pagamento = price,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		--sendToDiscordEmpregos(dataLog)
	else
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, Config.Alerts["error_sold"], 'error')
	end
end)

RegisterServerEvent('tr-lumberjack:BuyAxe')
AddEventHandler('tr-lumberjack:BuyAxe', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local TRAxeClassicPrice = LumberJob.AxePrice
    local axe = xPlayer.getInventoryItem('weapon_battleaxe')
    if axe.count == 0 then
        xPlayer.addInventoryItem('weapon_battleaxe', 1)
        xPlayer.removeAccountMoney('bank', TRAxeClassicPrice)
		TriggerClientEvent('johnny_empregos:ShowNotification', _source, Config.Alerts["axe_bought"], 'success')
    else
        TriggerClientEvent('johnny_empregos:ShowNotification', _source, Config.Alerts["axe_check"], 'error')
    end
end)

ESX.RegisterServerCallback('tr-lumberjack:axe', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		if xPlayer.getInventoryItem('weapon_battleaxe').count > 0 then
			cb(true)
		else
			cb(false)
		end
	end
end)

RegisterServerEvent('tr-lumberjack:setLumberStage')
AddEventHandler('tr-lumberjack:setLumberStage', function(stage, state, k)
    Config.TreeLocations[k][stage] = state
    TriggerClientEvent('tr-lumberjack:getLumberStage', -1, stage, state, k)
end)

RegisterServerEvent('tr-lumberjack:setChoppedTimer')
AddEventHandler('tr-lumberjack:setChoppedTimer', function()
    if not Chopped then
        Chopped = true
        CreateThread(function()
            Wait(Config.TimeoutLenhador)
            for k, v in pairs(Config.TreeLocations) do
                Config.TreeLocations[k]["isChopped"] = false
                TriggerClientEvent('tr-lumberjack:getLumberStage', -1, 'isChopped', false, k)
            end
            Chopped = false
        end)
    end
end)

RegisterServerEvent('tr-lumberjack:recivelumber')
AddEventHandler('tr-lumberjack:recivelumber', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local lumber = math.random(LumberJob.LumberAmount_Min, LumberJob.LumberAmount_Max)
    local bark = math.random(LumberJob.TreeBarkAmount_Min, LumberJob.TreeBarkAmount_Max)
    xPlayer.addInventoryItem('tree_lumber', lumber)
    xPlayer.addInventoryItem('tree_bark', bark)
end)

ESX.RegisterServerCallback('tr-lumberjack:lumber', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Player ~= nil then
		if xPlayer.getInventoryItem('tree_lumber').count > 0 then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('tr-lumberjack:lumberprocessed')
AddEventHandler('tr-lumberjack:lumberprocessed', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local lumber = xPlayer.getInventoryItem('tree_lumber')
    local TradeAmount = math.random(LumberJob.TradeAmount_Min, LumberJob.TradeAmount_Max)
    local TradeRecevied = math.random(LumberJob.TradeRecevied_Min, LumberJob.TradeRecevied_Max)
    if lumber.count == 0 then 
        TriggerClientEvent('johnny_empregos:ShowNotification', _source, Config.Alerts['error_lumber'], 'error')
        return false
    end

    local amount = lumber.count
    if amount >= 1 then
        amount = TradeAmount
    else
      return false
    end

    if lumber.count < amount then
        TriggerClientEvent('johnny_empregos:ShowNotification', _source, Config.Alerts['itemamount'], 'error')
        return false 
    end
	
	xPlayer.removeInventoryItem('tree_lumber', amount)
    TriggerClientEvent('johnny_empregos:ShowNotification', _source, Config.Alerts["lumber_processed_trade"] ..TradeAmount.. Config.Alerts["lumber_processed_lumberamount"] ..TradeRecevied.. Config.Alerts["lumber_processed_received"], 'success')
    Wait(750)
    xPlayer.addInventoryItem('wood_plank', TradeRecevied)
end)
