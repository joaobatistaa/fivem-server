ESX = nil

ESX = exports['es_extended']:getSharedObject()

local caixaporabrir = {}


Citizen.CreateThread(function()
	for k, v in pairs(Config["lootbox"]) do
		ESX.RegisterUsableItem(k, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem(k, 1)
			TriggerClientEvent('lootbox:openGacha', source,k)
			if caixaporabrir[source] == nil then caixaporabrir[source] = true end
			caixaporabrir[source] = true
		end)
	end
end)

RegisterServerEvent('lootbox:giveReward')
AddEventHandler('lootbox:giveReward', function (t, data, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if caixaporabrir[_source] == nil or not caixaporabrir[_source] then TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Dinheiro") return end
	
	if t == "money" then
		if data > 100000 then
			TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Dinheiro") 
			return 
		end
	end
		

	if t == "item" then
		xPlayer.addInventoryItem(data, amount)
		caixaporabrir[_source] = false
	elseif t == "weapon" then
		xPlayer.addWeapon(data, 1)
		caixaporabrir[_source] = false
	elseif t == "money" then
		xPlayer.addAccountMoney('money', data)
		caixaporabrir[_source] = false
	elseif t == "black_money" then
		xPlayer.addAccountMoney('black_money', data)
		caixaporabrir[_source] = false
	end
	
end)

RegisterServerEvent("lootbox:boradcast")
AddEventHandler("lootbox:boradcast", function(tier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if Config["broadcast"] then
        tier = tonumber(tier)
        if Config["broadcast_tier"][tier] == true then
			local time = os.date('%H:%M')
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message advertisement"><i class="fas fa-box"></i> <b><span style="color: #81db44">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { " CAIXA MISTÉRIO", "O Jogador "..GetPlayerName(_source).." abriu uma caixa mistério e recebeu "..Config["chance"][tier].name, time}
			})
        -- elseif tier == 2 and Config["broadcast_tier"][2] == true then
        --     TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^3Lootbox: ' .. GetPlayerName(source) .. ' opened lootbox and got '..Config["tier_name"][2]) 
        -- elseif tier == 3 and Config["broadcast_tier"][3] == true then
        --     TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^4Lootbox: ' .. GetPlayerName(source) .. ' opened lootbox and got '..Config["tier_name"][3]) 
        -- elseif tier == 4 and Config["broadcast_tier"][4] == true then
        --     TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^5Lootbox: ' .. GetPlayerName(source) .. ' opened lootbox and got '..Config["tier_name"][4]) 
        -- elseif tier == 5 and Config["broadcast_tier"][5] == true then
        --     TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^6Lootbox: ' .. GetPlayerName(source) .. ' opened lootbox and got '..Config["tier_name"][5]) 
        end
    end
end)

