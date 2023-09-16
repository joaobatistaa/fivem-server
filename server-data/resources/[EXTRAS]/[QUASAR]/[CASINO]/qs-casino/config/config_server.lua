-- sell chips
RegisterServerEvent('qs-casino:deposit')
AddEventHandler('qs-casino:deposit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local itemCount = xPlayer.getInventoryItem("casino_chips").count
	local amount = tonumber(amount)

	if amount and amount > 0 then 
		if Config.Account and (Config.Account == 'cash' or Config.Account == 'money') then 
			if itemCount >= amount then
				xPlayer.removeInventoryItem("casino_chips", amount)
				xPlayer.addMoney(amount)
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("SELL_CHIPS").. " x" ..amount, "success")
			else 
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("NO_CHIPS"), "error")
			end
		else 
			if itemCount >= amount then
				xPlayer.removeInventoryItem("casino_chips", amount)
				xPlayer.addAccountMoney(Config.Account, amount)
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("SELL_CHIPS").. " x" .. amount, "success")
			else
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("NO_CHIPS"), "error")
			end
		end
	end
end)

-- buy chips
RegisterServerEvent('qs-casino:withdraw')
AddEventHandler('qs-casino:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local amount = tonumber(amount)
	if amount and amount > 0 then 
		if Config.Account and (Config.Account == 'cash' or Config.Account == 'money') then 
			local funds = xPlayer.getMoney()
			if funds >= amount then
				xPlayer.addInventoryItem("casino_chips", amount)
				xPlayer.removeAccountMoney(Config.Account, amount)
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("BUY_CHIPS").. " x" ..amount, "success")
			else
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("NO_MONEY"), "error")
			end
		else
			local funds = xPlayer.getAccount(Config.Account).money
			if funds >= amount then
				xPlayer.addInventoryItem("casino_chips", amount)
				xPlayer.removeAccountMoney(Config.Account, amount)
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("BUY_CHIPS").. " x" ..amount, "success")
			else 
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("NO_MONEY"), "error")
			end
		end
	end
end)

-- buy ticket
RegisterServerEvent('qs-casino:ticket')
AddEventHandler('qs-casino:ticket', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local funds = 0
	local tickets = tonumber(amount)
	
	if amount and amount > 0 then
		local ticket_cost = (tickets * Config.Ticket)
		
		if Config.Account and (Config.Account == 'cash' or Config.Account == 'money') then 
			local funds = tonumber(xPlayer.getMoney()) 
			if funds then
				if funds >= ticket_cost then
					xPlayer.addInventoryItem("casino_ticket", amount)
					xPlayer.removeMoney(ticket_cost)
					TriggerClientEvent("qs-casino:sendMessage", source, Lang("BUY_TICKETS").. " x" .. amount, "success")
				else
					TriggerClientEvent("qs-casino:sendMessage", source, Lang("NO_MONEY"), "error")
				end
			end
		else 
			local funds = xPlayer.getAccount(Config.Account).money
			if funds >= ticket_cost then
				xPlayer.addInventoryItem("casino_ticket", amount)
				xPlayer.removeAccountMoney(Config.Account, ticket_cost)
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("BUY_TICKETS").. " x" .. amount, "success")
			else
				TriggerClientEvent("qs-casino:sendMessage", source, Lang("NO_MONEY"), "error")
			end
		end
	end
end)

RegisterServerEvent('qs-casino:balance')
AddEventHandler('qs-casino:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then 
		local balance = xPlayer.getInventoryItem("casino_chips")
		if balance then 
			TriggerClientEvent('chips_currentbalance1', _source, balance.count)
		end
	end
end)

function SetExports()
    exports["qs-blackjack"]:SetGetChipsCallback(function(source)
        local itemcount = 0
		
		local xPlayer = source
		local xPlayer = ESX.GetPlayerFromId(source) 
		itemcount = xPlayer.getInventoryItem("casino_chips").count
        return itemcount or 0
    end)

    exports["qs-blackjack"]:SetTakeChipsCallback(function(source, amount)
		local xPlayer = source
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem("casino_chips", amount)
    end)

    exports["qs-blackjack"]:SetGiveChipsCallback(function(source, amount)
		local xPlayer = source
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.addInventoryItem("casino_chips", amount)
    end)
end

AddEventHandler("onResourceStart", function(resourceName)
	if ("qs-blackjack" == resourceName) then
        Citizen.Wait(1000)
        SetExports()
    end
end)

SetExports()