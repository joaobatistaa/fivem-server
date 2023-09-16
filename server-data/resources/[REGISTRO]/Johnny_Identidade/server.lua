ESX = nil

ESX = exports['es_extended']:getSharedObject()

local playerIdentity = {}
local alreadyRegistered = {}

-- Player loaded

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	deferrals.defer()
	local playerId, identifier = source
	Citizen.Wait(100)

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'steam:') then
			identifier = v
			break
		end
	end

	if identifier then
		MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			if result[1] then
				if result[1].firstname and result[1].firstname ~= '' and result[1].firstname ~= ' ' then
					playerIdentity[identifier] = {
						firstName = result[1].firstname,
						lastName = result[1].lastname,
						dateOfBirth = result[1].dateofbirth,
						sex = result[1].sex,
						height = result[1].height
					}

					alreadyRegistered[identifier] = true

					deferrals.done()
				else
					playerIdentity[identifier] = nil
					alreadyRegistered[identifier] = false
					deferrals.done()
				end
			else
				playerIdentity[identifier] = nil
				alreadyRegistered[identifier] = false
				deferrals.done()
			end
		end)
	else
		deferrals.done('Não tens um Steam ID!')
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(1000)

		while not ESX do
			Citizen.Wait(10)
		end

		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer then	
				checkIdentity(xPlayer)
			end
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	if alreadyRegistered[xPlayer.identifier] == true then
		local currentIdentity = playerIdentity[xPlayer.identifier]

		xPlayer.setName(('%s %s'):format(currentIdentity.firstName, currentIdentity.lastName))
		xPlayer.set('firstName', currentIdentity.firstName)
		xPlayer.set('lastName', currentIdentity.lastName)
		xPlayer.set('dateofbirth', currentIdentity.dateOfBirth)
		xPlayer.set('sex', currentIdentity.sex)
		xPlayer.set('height', currentIdentity.height)

		if currentIdentity.saveToDatabase then
			saveIdentityToDatabase(xPlayer.identifier, currentIdentity)
		end

		Citizen.Wait(1000)
		TriggerClientEvent('esx_identity:alreadyRegistered', xPlayer.source)

		playerIdentity[xPlayer.identifier] = nil
	else
		TriggerClientEvent('jsfour-register:open', xPlayer.source)
	end
end)

ESX.RegisterServerCallback('jsfour-register:register', function(source, cb, data)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer then
		if not alreadyRegistered[xPlayer.identifier] then
			if checkNameFormat(data.firstname, source) and checkNameFormat(data.lastname, source) and checkSexFormat(data.sex, source) and checkDOBFormat(data.dateofbirth, source) and checkHeightFormat(data.height, source) then
				local Keys = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
				local numero_cc = math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. '-' .. math.random(9) .. Keys[math.random(1,#Keys)] .. Keys[math.random(1,#Keys)] .. math.random(9)

	
				playerIdentity[xPlayer.identifier] = {
					firstName = formatName(data.firstname),
					lastName = formatName(data.lastname),
					dateOfBirth = data.dateofbirth,
					sex = data.sex,
					height = data.height,
					numero_cc = numero_cc
				}

				local currentIdentity = playerIdentity[xPlayer.identifier]

				xPlayer.setName(('%s %s'):format(currentIdentity.firstName, currentIdentity.lastName))
				xPlayer.set('firstName', currentIdentity.firstName)
				xPlayer.set('lastName', currentIdentity.lastName)
				xPlayer.set('dateofbirth', currentIdentity.dateOfBirth)
				xPlayer.set('sex', currentIdentity.sex)
				xPlayer.set('height', currentIdentity.height)

				saveIdentityToDatabase(xPlayer.identifier, currentIdentity)
				alreadyRegistered[xPlayer.identifier] = true
				
				info = {
					firstname = currentIdentity.firstName,
					lastname = currentIdentity.lastName,
					gender = currentIdentity.sex,
					dateofbirth = currentIdentity.dateOfBirth,
					height = currentIdentity.height,
					numero_cc = currentIdentity.numero_cc
				}
			
				exports['qs-inventory']:AddItem(source, "cartao_cidadao", 1, nil, info)
				
				playerIdentity[xPlayer.identifier] = nil
				cb(true)
			end
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('jsfour-register:update', function(source, cb, data)
	local source = source

	if checkNameFormat(data.firstname, source) and checkNameFormat(data.lastname, source) and checkSexFormat(data.sex, source) and checkDOBFormat(data.dateofbirth, source) and checkHeightFormat(data.height, source) then
		local Keys = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
		local numero_cc = math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9) .. '-' .. math.random(9) .. Keys[math.random(1,#Keys)] .. Keys[math.random(1,#Keys)] .. math.random(9)
		
		info = {
			firstname = formatName(data.firstname),
			lastname = formatName(data.lastname),
			gender = data.sex,
			dateofbirth = data.dateofbirth,
			height = data.height,
			numero_cc = numero_cc
		}
		
		exports['qs-inventory']:AddItem(source, "cartao_cidadao", 1, nil, info)
					
		cb(true)
	end
end)


function checkIdentity(xPlayer)
	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height, numero_cc FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1] then
			if result[1].firstname and result[1].firstname ~= '' and result[1].firstname ~= ' ' then
				playerIdentity[xPlayer.identifier] = {
					firstName = result[1].firstname,
					lastName = result[1].lastname,
					dateOfBirth = result[1].dateofbirth,
					sex = result[1].sex,
					height = result[1].height,
					numero_cc = result[1].numero_cc
				}

				alreadyRegistered[xPlayer.identifier] = true

				setIdentity(xPlayer)
			else
				playerIdentity[xPlayer.identifier] = nil
				alreadyRegistered[xPlayer.identifier] = false
				TriggerClientEvent('jsfour-register:open', xPlayer.source)
			end
		else
			TriggerClientEvent('jsfour-register:open', xPlayer.source)
		end
	end)
end

function setIdentity(xPlayer)
	if alreadyRegistered[xPlayer.identifier] then
		local currentIdentity = playerIdentity[xPlayer.identifier]

		xPlayer.setName(('%s %s'):format(currentIdentity.firstName, currentIdentity.lastName))
		xPlayer.set('firstName', currentIdentity.firstName)
		xPlayer.set('lastName', currentIdentity.lastName)
		xPlayer.set('dateofbirth', currentIdentity.dateOfBirth)
		xPlayer.set('sex', currentIdentity.sex)
		xPlayer.set('height', currentIdentity.height)

		if currentIdentity.saveToDatabase then
			saveIdentityToDatabase(xPlayer.identifier, currentIdentity)
		end

		playerIdentity[xPlayer.identifier] = nil
	end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

function deleteIdentity(xPlayer)
	if alreadyRegistered[xPlayer.identifier] then
		xPlayer.setName(('%s %s'):format(nil, nil))
		xPlayer.set('firstName', nil)
		xPlayer.set('lastName', nil)
		xPlayer.set('dateofbirth', nil)
		xPlayer.set('sex', nil)
		xPlayer.set('height', nil)

		deleteIdentityFromDatabase(xPlayer)
	end
end

function saveIdentityToDatabase(identifier, identity)
	MySQL.Sync.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height, numero_cc = @numero_cc WHERE identifier = @identifier', {
		['@identifier']  = identifier,
		['@firstname'] = identity.firstName,
		['@lastname'] = identity.lastName,
		['@dateofbirth'] = identity.dateOfBirth,
		['@sex'] = identity.sex,
		['@height'] = identity.height,
		['@numero_cc'] = identity.numero_cc
	})
end

function deleteIdentityFromDatabase(xPlayer)
	MySQL.Sync.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height, numero_cc = @numero_cc, skin = @skin WHERE identifier = @identifier', {
		['@identifier']  = xPlayer.identifier,
		['@firstname'] = NULL,
		['@lastname'] = NULL,
		['@dateofbirth'] = NULL,
		['@sex'] = NULL,
		['@height'] = NULL,
		['@numero_cc'] = NULL,
		['@skin'] = NULL
	})

	MySQL.Sync.execute('UPDATE addon_account_data SET money = 0 WHERE account_name = @account_name AND owner = @owner', {
		['@account_name'] = 'bank_savings',
		['@owner'] = xPlayer.identifier
	})

	MySQL.Sync.execute('UPDATE addon_account_data SET money = 0 WHERE account_name = @account_name AND owner = @owner', {
		['@account_name'] = 'caution',
		['@owner'] = xPlayer.identifier
	})

	MySQL.Sync.execute('UPDATE datastore_data SET data = @data WHERE name = @name AND owner = @owner', {
		['@data'] = '\'{}\'',
		['@name'] = 'user_ears',
		['@owner'] = xPlayer.identifier
	})

	MySQL.Sync.execute('UPDATE datastore_data SET data = @data WHERE name = @name AND owner = @owner', {
		['@data'] = '\'{}\'',
		['@name'] = 'user_glasses',
		['@owner'] = xPlayer.identifier
	})

	MySQL.Sync.execute('UPDATE datastore_data SET data = @data WHERE name = @name AND owner = @owner', {
		['@data'] = '\'{}\'',
		['@name'] = 'user_helmet',
		['@owner'] = xPlayer.identifier
	})

	MySQL.Sync.execute('UPDATE datastore_data SET data = @data WHERE name = @name AND owner = @owner', {
		['@data'] = '\'{}\'',
		['@name'] = 'user_mask',
		['@owner'] = xPlayer.identifier
	})
end

function checkNameFormat(name, source)
	--if not checkAlphanumeric(name) then
		if not checkForNumbers(name) then
			local stringLength = string.len(name)
			if stringLength > 0 and stringLength < 30 then
				return true
			else
				TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Nome <span style='color:#ff0000'>inválido</span>! O nome ultrapassa o tamanho máximo de caracteres de 30!", 5000, 'error')
				return false
			end
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Nome <span style='color:#ff0000'>inválido</span>! O nome não pode conter números!", 5000, 'error')
			return false
		end
	--else
		--TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Nome <span style='color:#ff0000'>inválido</span>! Verifica todos os caracteres!", 5000, 'error')
		--return false
	--end
end

function checkDOBFormat(dob, source)
	local date = tostring(dob)
	local check = checkDate(date)

	if check == true then
		return true
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Data <span style='color:#ff0000'>inválida</span>! Ano Mínimo: 1920 | Ano Máximo: 2022", 5000, 'error')
		return false
	end
end

function checkSexFormat(sex, source)
	if sex == "m" or sex == "M" or sex == "f" or sex == "F" then
		return true
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Género <span style='color:#ff0000'>inválidp</span>!", 5000, 'error')
		return false
	end
end

function checkHeightFormat(height, source)
	local numHeight = tonumber(height)
	if numHeight < 100 or numHeight > 250 then
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Altura <span style='color:#ff0000'>inválida</span>! Mínimo: 100cm | Máximo: 250cm", 5000, 'error')
		return false
	else
		return true
	end
end

function formatName(name, source)
	local loweredName = convertToLowerCase(name)
	local formattedName = convertFirstLetterToUpper(loweredName)
	return formattedName
end

function convertToLowerCase(str)
	return string.lower(str)
end

function convertFirstLetterToUpper(str)
	return str:gsub("^%l", string.upper)
end

function checkAlphanumeric(str)
	return (string.match(str, "%W"))
end

function checkForNumbers(str)
	return (string.match(str,"%d"))
end

function checkDate(str)
	if string.match(str, '(%d%d)/(%d%d)/(%d%d%d%d)') ~= nil then
		local m, d, y = string.match(str, '(%d+)/(%d+)/(%d+)')
		m = tonumber(m)
		d = tonumber(d)
		y = tonumber(y)
		if ((d <= 0) or (d > 31)) or ((m <= 0) or (m > 12)) or ((y < 1920) or (y > 2022)) then
			return false
		elseif m == 4 or m == 6 or m == 9 or m == 11 then
			if d > 30 then
				return false
			else
				return true
			end
		elseif m == 2 then
			if y%400 == 0 or (y%100 ~= 0 and y%4 == 0) then
				if d > 29 then
					return false
				else
					return true
				end
			else
				if d > 28 then
					return false
				else
					return true
				end
			end
		else
			if d > 31 then
				return false
			else
				return true
			end
		end
	elseif string.match(str, '(%d%d)-(%d%d)-(%d%d%d%d)') ~= nil then
		local m, d, y = string.match(str, '(%d+)-(%d+)-(%d+)')
		m = tonumber(m)
		d = tonumber(d)
		y = tonumber(y)
		
		if (y < 1920) or (y > 2022) then
			return false
		elseif m == 4 or m == 6 or m == 9 or m == 11 then
			if d > 30 then
				return false
			else
				return true
			end
		elseif m == 2 then
			if y%400 == 0 or (y%100 ~= 0 and y%4 == 0) then
				if d > 29 then
					return false
				else
					return true
				end
			else
				if d > 28 then
					return false
				else
					return true
				end
			end
		else
			if d > 31 then
				return false
			else
				return true
			end
		end
	else
		return false
	end
end

ESX.RegisterCommand('chardel', 'user', function(xPlayer, args, showError)
	if xPlayer and xPlayer.getName() then
		deleteIdentity(xPlayer)
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "SUCESSO", "<span style='color:#c7c7c7'>A tua personagem foi <span style='color:#069a19'>eliminada</span> com sucesso!", 5000, 'success')
		playerIdentity[xPlayer.identifier] = nil
		alreadyRegistered[xPlayer.identifier] = false
		TriggerClientEvent('jsfour-register:open', xPlayer.source)
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Erro ao <span style='color:#ff0000'>eliminar</span> a personagem!", 5000, 'error')
	end
end, false, {help = 'Apagar a personagem'})