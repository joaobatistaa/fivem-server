ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('esx_spectate:getPlayerData', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer ~= nil then
        cb(xPlayer)
    end
end)

ESX.RegisterServerCallback('esx_spectate:getAllJogadores', function(source, cb, id)
    local players = GetPlayers()
    local sortedPlayers = {}
	
    for i=1, #players, 1 do
        table.insert(sortedPlayers, tonumber(players[i]))
    end

    table.sort(sortedPlayers)

    local data = {}
    for i=1, #sortedPlayers, 1 do
        local _data = {
            id = sortedPlayers[i],
            name = GetPlayerName(sortedPlayers[i])
        }
        table.insert(data, _data)
    end

    cb(data)
end)

ESX.RegisterServerCallback("esx_spectate:requestPlayerCoords", function(source, cb, serverId)
	local xSource = ESX.GetPlayerFromId(source)

	if not xSource then
		return cb(false)
	end

	local targetPed = GetPlayerPed(serverId)
	if targetPed <= 0 or (xSource.getGroup() ~= 'superadmin' and xSource.getGroup() ~= 'admin' and xSource.getGroup() ~= 'mod') then
		return cb(false)
	end

	cb(GetEntityCoords(targetPed))
end)

RegisterServerEvent('esx_spectate:kick')
AddEventHandler('esx_spectate:kick', function(target, msg)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() ~= 'user' then
		if msg == nil then
			msg = 'Não Indicada'
		end
		DropPlayer(target, ("Expulso do servidor.\nRazão: %s\nStaff: %s"):format(msg, GetPlayerName(source)))
	else
		print(('esx_spectate: %s attempted to kick a player!'):format(xPlayer.identifier))
		DropPlayer(source, "esx_spectate: you're not authorized to kick people dummy.")
	end
end)

ESX.RegisterServerCallback('esx_spectate:getOtherPlayerData', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    })
    
    local user = result[1]
    local firstname = user['firstname']
    local lastname = user['lastname']
    local sex = user['sex']
    local dob = user['dateofbirth']
    local height = user['height'] .. " cm"
    local money = user['money']
    local bank = user['bank']
    
    local data = {
        name = GetPlayerName(target),
        job = xPlayer.job,
        inventory = xPlayer.inventory,
        accounts = xPlayer.accounts,
        weapons = xPlayer.loadout,
        firstname = firstname,
        lastname = lastname,
        sex = sex,
        dob = dob,
        height = height,
        money = money,
        bank = bank
    }
    
    TriggerEvent('esx_license:getLicenses', target, function(licenses)
        data.licenses = licenses
    end)
    cb(data)
end)

GetLicense = function (src, type)
    -- Types: steam, license, ip
    for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len(type)) == string.lower(type) then
            return string.sub(v, 9, string.len(v))
        end
    end
    return false
end