QS = nil

TriggerEvent('qs-core:getSharedObject', function(library) QS = library end)

ESX = nil

ESX = exports['es_extended']:getSharedObject()

local beds = {
	{ x = 324.15, y = -583.02, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 322.73, y = -586.7, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 317.72, y = -585.14, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 314.5, y = -584.16, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 311.18, y = -582.71, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 307.78, y = -581.63, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 309.3, y = -577.6, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 313.83, y = -579.35, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
}

local bedsTaken = {}

RegisterServerEvent('CUSTOM_esx_ambulance:requestCPR')
AddEventHandler('CUSTOM_esx_ambulance:requestCPR', function(target, playerheading, playerCoords, playerlocation)
    TriggerClientEvent("CUSTOM_esx_ambulance:playCPR", target, playerheading, playerCoords, playerlocation)
end)

RegisterServerEvent('CUSTOM_esx_ambulance:requestHeal')
AddEventHandler('CUSTOM_esx_ambulance:requestHeal', function(target, playerheading, playerCoords, playerlocation)
    TriggerClientEvent("CUSTOM_esx_ambulance:playHeal", target, playerheading, playerCoords, playerlocation)
end)

RegisterServerEvent("esx_ambulance:server:atualizarPosicaoMaca")
AddEventHandler("esx_ambulance:server:atualizarPosicaoMaca", function(x,y,z)
    TriggerClientEvent("esx_ambulance:client:atualizarPosicaoMaca", -1, x,y,z)
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não há camas disponíveis' })
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
	local totalBill = 5000
	local data = {
		society = 'society_ambulance',
		society_name = 'INEM',
		target = src,
		targetName = -1,
		invoice_value = totalBill,
		author_name = 'INEM',
		invoice_item = 'Tratamento no Hospital',
		invoice_notes = 'Foste tratado no Hospital e a fatura ficou no valor de '..	totalBill .. '€'				
	}
	
	TriggerEvent("okokBilling:CreateCustomInvoice", src, totalBill, 'Tratamento no Hospital', 'Tratamento', 'society_ambulance', 'INEM')
	
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'INEM', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('wtrp_inem:checkin', function(source, cb, preco)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getMoney() >= preco then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_ambulancejob:revLoureivero')
AddEventHandler('esx_ambulancejob:revLoureivero', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--xPlayer.addMoney(Config.ReviveReward)
	TriggerClientEvent('esx_ambulancejob:revLoureivero', target)
	TriggerClientEvent('esx_ambulancejob:revLoureivero_1', target)
	TriggerClientEvent('codem-deathscreen:revive', target)
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	TriggerClientEvent('esx_ambulancejob:heal', target, type)
	TriggerClientEvent('esx_ambulancejob:Bandage', target)
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
end)

RegisterServerEvent('esx_ambulancejob:OutVehicle')
AddEventHandler('esx_ambulancejob:OutVehicle', function(target)
	TriggerClientEvent('esx_ambulancejob:OutVehicle', target)
end)

RegisterCommand("togglestr", function(source, args, raw)
	local player = source 
	local xPlayer = ESX.GetPlayerFromId(player)
	if (player > 0) and xPlayer.job.name == 'ambulance' then
		TriggerClientEvent("esx_ambulancejob:macaveiculo", source)
		CancelEvent()
	end
end, false)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() > 0 then
		xPlayer.removeMoney(xPlayer.getMoney(), "Death")
	end

	if xPlayer.getAccount('black_money').money > 0 then
		xPlayer.setAccountMoney('black_money', 0, "Death")
	end

	local saveItems = {
		'cartao_cidadao', -- Add here the items that you do NOT want to be deleted
	}
	exports['qs-inventory']:ClearInventory(source, saveItems)

	local weapons = exports['qs-inventory']:GetWeaponList()
	for k,v in pairs(weapons) do
		xPlayer.removeInventoryItem(v.name, 1 )
	end

    cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)
	
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalanceSeguro', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		if (bankBalance >= 100) then
			xPlayer.removeAccountMoney('bank', 100)
			cb(true)
		else
			cb(false)
		end
	end)
	
	ESX.RegisterServerCallback('esx_ambulancejob:verificadinheiro', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local dinheirojogador = xPlayer.getMoney()
		
		if dinheirojogador >= 2500 then
			xPlayer.removeMoney(2500)
			cb(true)
		else
			cb(false)
		end
	end)
	
	RegisterServerEvent('esx_ambulancejob:pagarAtendimentoMedico')
	AddEventHandler('esx_ambulancejob:pagarAtendimentoMedico', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local dinheirojogador = xPlayer.getAccount('money').money
		local bankBalance = xPlayer.getAccount('bank').money
		
		if bankBalance >= 10000 then
			xPlayer.removeAccountMoney('bank', 10000)
			TriggerEvent('esx_society:getSociety', 'ambulance', function(society) 
				TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
					account.addMoney(10000)
				end)
			end)
		elseif dinheirojogador >= 10000 then
			xPlayer.removeMoney(10000)
			TriggerEvent('esx_society:getSociety', 'ambulance', function(society) 
				TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
					account.addMoney(10000)
				end)
			end)
		else
			xPlayer.removeAccountMoney('bank', 10000)
			TriggerEvent('esx_society:getSociety', 'ambulance', function(society) 
				TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
					account.addMoney(10000)
				end)
			end)
		end
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
	
	RegisterServerEvent('esx_ambulancejob:payFine2')
	AddEventHandler('esx_ambulancejob:payFine2', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeAccountMoney('bank', 500)
	end)
	
	RegisterServerEvent('esx_ambulancejob:payFine3')
	AddEventHandler('esx_ambulancejob:payFine3', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeMoney(15000)
		TriggerEvent('esx_society:getSociety', 'ambulance', function(society) 
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				account.addMoney(15000)
			end)
		end)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count
	if quantity > 0 then
		cb(quantity)
	else
		cb(0)
	end
end)

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)
end)

--[[
ESX.RegisterUsableItem('medikit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('medikit', 1)
	TriggerClientEvent('esx_ambulancejob:heal', _source, 'big')
end)

ESX.RegisterUsableItem('bandage', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('bandage', 1)
	TriggerClientEvent('esx_ambulancejob:heal', _source, 'small')
end)
--]]

RegisterServerEvent('esx_ambulancejob:firstSpawn')
AddEventHandler('esx_ambulancejob:firstSpawn', function()
	local _source    = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier=@identifier',
	{
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print('esx_ambulancejob: ' .. GetPlayerName(_source) .. ' (' .. identifier .. ') attempted combat logging!')
			TriggerEvent('DiscordBot:combatlog', _source, identifier)
			TriggerClientEvent('esx_ambulancejob:requestDeath', _source)
		end
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local _source = source
	MySQL.Sync.execute("UPDATE users SET isDead=@isDead WHERE identifier=@identifier",
	{
		['@identifier'] = GetPlayerIdentifiers(_source)[1],
		['@isDead'] = isDead
	})
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_ambulancejob:spawned')
AddEventHandler('esx_ambulancejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_ambulancejob:forceBlip')
AddEventHandler('esx_ambulancejob:forceBlip', function()
	TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:hasLocator', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	local item = xPlayer.getInventoryItem('locator').count
	cb(item)
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.job.name
	if job == "ambulance" and item.name == "locator" then
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)


AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.job.name
	if job == "ambulance" and item.name == "locator" then
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)