ESX.RegisterServerCallback('qb-garbagejob:server:HasMoney', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)

    if Player.getAccount('bank').money >= Config.LixeiroValorCaucao then
        Player.removeAccountMoney('bank', Config.LixeiroValorCaucao)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('qb-garbagejob:server:CheckBail', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)

    if Player ~= nil then
        Player.addAccountMoney('bank', Config.LixeiroValorCaucao)
        cb(true)
    else
        cb(false)
    end
end)

local Materials = {
    "metalscrap",
    "electronics",
    "copper",
    "iron",
    "aluminium",
    "steel",
    "glass",
}

local lixeiropay = {
	vector3(-348.9, -1569.4, 25.22),
}

RegisterServerEvent('qb-garbagejob:server:PayafafsasShit')
AddEventHandler('qb-garbagejob:server:PayafafsasShit', function(amount, location)
    local src = source
    local Player = ESX.GetPlayerFromId(source)
	local identifierlist = ExtractIdentifiers(src)

    if not ESX.playerInsideLocation(src, lixeiropay, 10.0) then
		TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Dinheiro")
		return
	end

    
	
    if amount > 0 and Player.job.name == 'lixeiro' then
        Player.addAccountMoney('bank', amount)
		local dataLog = {
			emprego = 'Lixeiro',
			playerid = src,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(src),
			pagamento = amount,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		sendToDiscordEmpregos(dataLog)
		
        if location == #Config.Locations["vuilnisbakken"] then
            for i = 1, math.random(3, 5), 1 do
                local item = Materials[math.random(1, #Materials)]
                Player.addInventoryItem(item, math.random(20, 40))
                Citizen.Wait(500)
            end
        end
    else
    end
end)