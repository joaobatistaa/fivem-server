local baitUsable = true
local baitTime = Config.CacadorInfo.TimeBetween
local isEntityInWater = false

local acacar = {}

if Config.CacadorInfo.EnableBait then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            if not baitUsable then
                if baitTime == 0 then
                    baitUsable = true
                    baitTime = Config.CacadorInfo.TimeBetween
                else
                    baitTime = baitTime - 1
                end
            end
        end
    end)

    ESX.RegisterUsableItem(Config.CacadorInfo.BaitItemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('fanonx:client:canPlaceBait', source)
        Citizen.Wait(300)
        if not isEntityInWater then
            if baitUsable then
                xPlayer.removeInventoryItem(Config.CacadorInfo.BaitItemName, 1)
                TriggerClientEvent('fanonx:client:bait', source)
                baitUsable = false
				if acacar[source] == nil then acacar[source] = true end
				acacar[source] = true
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.CacadorInfo.Text['between_bait']})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.CacadorInfo.Text['cant_place_bait']})
        end
        
    end)
end

RegisterServerEvent('fanonx-hunting:server:canPlaceBaitS')
AddEventHandler('fanonx-hunting:server:canPlaceBaitS', function(water)
    isEntityInWater = water
end)


RegisterServerEvent('fanonx-hunting:server:giveReward', function(itemName, count)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if acacar[_source] == nil or not acacar[_source] then TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Items") return end 

	if itemName ~= "meat" or itemName ~= "leather_cormorant_bad" or itemName ~= "leather_cormorant_good" or itemName ~= "leather_cormorant_perfect"
	or itemName ~= "leather_coyote_bad" or itemName ~= "leather_coyote_good" or itemName ~= 'leather_coyote_perfect'
	or itemName ~= 'leather_mlion_bad' or itemName ~= 'leather_mlion_good' or itemName ~= 'leather_mlion_perfect'
	or itemName ~= "deer_horn" or itemName ~= "leather_deer_bad" or itemName ~= 'leather_deer_good' or itemName ~= 'leather_deer_perfect'
	or itemName ~= 'leather_boar_bad' or itemName ~= 'leather_boar_good' or itemName ~= 'leather_boar_perfect'
	or itemName ~= 'leather_rabbit_bad' or itemName ~= 'leather_rabbit_good' or itemName ~= 'leather_rabbit_perfect' or itemName ~= "cookedMeat" then
		TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Items") 
		return 
	end


    xPlayer.addInventoryItem(itemName, count)
	acacar[_source] = false
end)

-- Remove x amount of item(s) from inventory:
ESX.RegisterServerCallback('fanonx-hunting:server:temItemsParaVender',function(source, cb, ilegal)
	local xPlayer = ESX.GetPlayerFromId(source)
	local temitems = false
	
	if ilegal then
		for k, v in pairs(Config.CacadorInfo.IlegalPrices) do
			if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
				temItems = true
			end
		end
		if temItems then
			ilegal = true
		end
		cb(temItems)
	else
		for k, v in pairs(Config.CacadorInfo.LegalPrices) do
			if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
				temItems = true
			end
		end
		if temItems then
			ilegal = false
		end
		cb(temItems)
	end
end)

RegisterServerEvent('fanonx-hunting:server:sellAllItems')
AddEventHandler('fanonx-hunting:server:sellAllItems', function(ilegal)
    local xPlayer = ESX.GetPlayerFromId(source)
	local vendido = false
	
	if ilegal then
		for k, v in pairs(Config.CacadorInfo.IlegalPrices) do
			if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
				vendido = true
				local reward = 0
				for i = 1, xPlayer.getInventoryItem(k).count do
					reward = reward + math.random(v[1], v[2])
				end
				xPlayer.addAccountMoney('black_money', reward)
				TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward), 'success')
				xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
				ilegal = false
			end
		end
		if not vendido then
			TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['no_items']), 'error')
			ilegal = false
		end
	else
		for k, v in pairs(Config.CacadorInfo.LegalPrices) do
			if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
				vendido = true
				local reward = 0
				for i = 1, xPlayer.getInventoryItem(k).count do
					reward = reward + math.random(v[1], v[2])
				end
				xPlayer.addAccountMoney('bank', reward)
				TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward), 'success')
				xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
			end
		end
		if not vendido then
			TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['no_items']), 'error')
		end
	end
end)

RegisterServerEvent('fanonx-hunting:legal:sellCarne')
AddEventHandler('fanonx-hunting:legal:sellCarne', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local vendido = false
	local totalValor = 0
	local identifierlist = ExtractIdentifiers(source)
	
	for k, v in pairs(Config.CacadorInfo.CarnePrices) do
		if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
			vendido = true
			local reward = 0
			for i = 1, xPlayer.getInventoryItem(k).count do
				reward = reward + math.random(v[1], v[2])
			end
			totalValor = totalValor + reward
			xPlayer.addAccountMoney('money', reward)
			TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward), 'success')
			xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
		end
	end
	if not vendido then
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['no_items']), 'error')
	else
		local dataLog = {
			emprego = 'Caça',
			playerid = source,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(source),
			pagamento = totalValor,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		sendToDiscordEmpregos(dataLog)
	end
end)

RegisterServerEvent('fanonx-hunting:legal:sellCouro')
AddEventHandler('fanonx-hunting:legal:sellCouro', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local vendido = false
	local totalValor = 0
	local identifierlist = ExtractIdentifiers(source)
	
	for k, v in pairs(Config.CacadorInfo.CouroPrices) do
		if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
			vendido = true
			local reward = 0
			for i = 1, xPlayer.getInventoryItem(k).count do
				reward = reward + math.random(v[1], v[2])
			end
			totalValor = totalValor + reward
			xPlayer.addAccountMoney('money', reward)
			TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward), 'success')
			xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
		end
	end
	if not vendido then
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['no_items']), 'error')
	else
		local dataLog = {
			emprego = 'Caça',
			playerid = source,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(source),
			pagamento = totalValor,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		sendToDiscordEmpregos(dataLog)
	end
end)

RegisterServerEvent('fanonx-hunting:legal:sellCouroIlegal')
AddEventHandler('fanonx-hunting:legal:sellCouroIlegal', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local vendido = false
	local totalValor = 0
	local identifierlist = ExtractIdentifiers(source)
	
	for k, v in pairs(Config.CacadorInfo.CourosIlegais) do
		if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
			vendido = true
			local reward = 0
			for i = 1, xPlayer.getInventoryItem(k).count do
				reward = reward + math.random(v[1], v[2])
			end
			totalValor = totalValor + reward
			xPlayer.addAccountMoney('money', reward)
			TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward), 'success')
			xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
		end
	end
	if not vendido then
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['no_items']), 'error')
	else
		local dataLog = {
			emprego = 'Caça',
			playerid = source,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(source),
			pagamento = totalValor,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		sendToDiscordEmpregos(dataLog)
	end
end)

RegisterServerEvent('fanonx-hunting:legal:sellChifreVeado')
AddEventHandler('fanonx-hunting:legal:sellChifreVeado', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local vendido = false
	local totalValor = 0
	local identifierlist = ExtractIdentifiers(source)
	
	for k, v in pairs(Config.CacadorInfo.ChifreVeadoPrices) do
		if xPlayer.getInventoryItem(k) and xPlayer.getInventoryItem(k).count > 0 then
			vendido = true
			local reward = 0
			for i = 1, xPlayer.getInventoryItem(k).count do
				reward = reward + math.random(v[1], v[2])
			end
			totalValor = totalValor + reward
			xPlayer.addAccountMoney('money', reward)
			TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['you_sold']):format(xPlayer.getInventoryItem(k).count, ESX.GetItemLabel(k), reward), 'success')
			xPlayer.removeInventoryItem(k, xPlayer.getInventoryItem(k).count)
		end
	end
	if not vendido then
		TriggerClientEvent('johnny_empregos:ShowNotification', xPlayer.source, (LangHunting['no_items']), 'error')
	else
		local dataLog = {
			emprego = 'Caça',
			playerid = source,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(source),
			pagamento = totalValor,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		sendToDiscordEmpregos(dataLog)
	end
end)


RegisterServerEvent('fanonx-hunting:server:giveMoney')
AddEventHandler('fanonx-hunting:server:giveMoney', function(count, blackMoney)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = Config.CacadorInfo.Text['sold'] })
end)

ESX.RegisterServerCallback('fanonx-hunting:server:cook',function(source, cb, meatName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
	local itemN = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == meatName then
			itemN = item.count
		end
	end

    if itemN >= count then
        xPlayer.removeInventoryItem(meatName, count)
        cb(true)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.CacadorInfo.Text['no_material']})
        cb(false)
    end
end)

ESX.RegisterServerCallback('fanonx-hunting:server:campfire',function(source, cb, coalName, woodName, coalCount, woodCount)
    local xPlayer = ESX.GetPlayerFromId(source)
	local coalN = 0
    local woodN = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == coalName then
			coalN = item.count
        elseif item.name == woodName then
            woodN = item.count
        end
	end
    
    if coalN >= coalCount and woodN >= woodCount then
        xPlayer.removeInventoryItem(coalName, coalCount)
        xPlayer.removeInventoryItem(woodName, woodCount)
        cb(true)
    else 
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.CacadorInfo.Text['no_material'] })
        cb(false)
    end
end)

QS = nil
TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)

RegisterServerEvent('fanonx-hunting:server:giveLicense')
AddEventHandler('fanonx-hunting:server:giveLicense', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(id)
	
	local dadosLicencas = {}
	local temLicencaCaca = false

	if xPlayer then
		local identifier = xPlayer.identifier
		local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth

		info = {
			name = firstname,
			lastname = lastname,
			gender = sex,
			dateofbirth = dob
		}  
		
		TriggerEvent('esx_license:getLicenses', id, function(licenses)
			dadosLicencas = licenses
			
			for i=1, #dadosLicencas, 1 do
				if dadosLicencas[i].label ~= nil and dadosLicencas[i].type ~= nil then
					if dadosLicencas[i].type == 'hunt' then
						temLicencaCaca = true
					end
				end
			end
		
			if not temLicencaCaca and xPlayer.getInventoryItem('licenca_caca').count == 0 then
				if xPlayer.getInventoryItem('licenca_caca').count == 0 then
					TriggerEvent('esx_license:addLicense', id, 'hunt')
					
					exports['qs-inventory']:AddItem(id, "licenca_caca", 1, nil, info)
					TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = 'inform', text = 'Recebeste a Licença de Caça.' })
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Emitiste uma Licença de Caça.' })
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'O jogador já tem uma licença de caça no inventário!' })
				end
			elseif not temLicencaCaca and xPlayer.getInventoryItem('licenca_caca').count > 0 then
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'O jogador possui uma licença de caça com ele mas não tem licença na base de dados!' })
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'O jogador já possui essa licença registada na base de dados!' })
			end
		end)
		
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não existe nenhum jogador no servidor com esse ID!' })
	end
end)

RegisterServerEvent('fanonx-hunting:server:leatherInInventory')
AddEventHandler('fanonx-hunting:server:leatherInInventory', function(illegalMarket)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	--for i=1, #xPlayer.inventory, 1 do
		
		--local item = xPlayer.inventory[i]
        for i, animal in pairs(Config.CacadorInfo.Animals) do
			--print(animal.good)
			
			local item1 = xPlayer.getInventoryItem(animal.bad)
			local item2 = xPlayer.getInventoryItem(animal.good)
			local item3 = xPlayer.getInventoryItem(animal.perfect)
			local item4 = xPlayer.getInventoryItem(animal.specialItem)
			
            if not animal.isIllegal and not illegalMarket then
                if item1.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item1.label, item = item1.name, type = 'slider', min = 1, max = item1.count, value = 1, price = animal.badCost}, false)
                elseif item2.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item2.label, item = item2.name, type = 'slider', min = 1, max = item2.count, value = 1, price = animal.goodCost}, false)
                elseif item3.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item3.label, item = item3.name, type = 'slider', min = 1, max = item3.count, value = 1, price = animal.perfectCost}, false)
                elseif item4.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item4.label, item = item4.name, type = 'slider', min = 1, max = item4.count, value = 1, price = animal.specialItemCost}, false)
                end
            elseif animal.isIllegal and illegalMarket then
				local item1 = xPlayer.getInventoryItem(animal.bad)
				local item2 = xPlayer.getInventoryItem(animal.good)
				local item3 = xPlayer.getInventoryItem(animal.perfect)
				local item4 = xPlayer.getInventoryItem(animal.specialItem)
                if item1.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item1.label, item = item1.name, type = 'slider', min = 1, max = item1.count, value = 1, price = animal.illegalBadCost}, true)
                elseif item2.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item2.label, item = item2.name, type = 'slider', min = 1, max = item2.count, value = 1, price = animal.illegalGoodCost}, true)
                elseif item3.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item3.label, item = item3.name, type = 'slider', min = 1, max = item3.count, value = 1, price = animal.illegalPerfectCost}, true)
                elseif item4.count > 0 then
                    TriggerClientEvent('fanonx:client:addElement', _source, {label = item4.label, item = item4.name, type = 'slider', min = 1, max = item4.count, value = 1, price = animal.specialItemCost}, true)
                end
            end 
        end
		local item5 = xPlayer.getInventoryItem(Config.CacadorInfo.MeatName)
        if item5.count > 0 then
            TriggerClientEvent('fanonx:client:addElement', _source, {label = item5.label, item = item5.name, type = 'slider', min = 1, max = item5.count, value = 1, price = Config.CacadorInfo.MeatCost}, false)
        end
	--end
end)