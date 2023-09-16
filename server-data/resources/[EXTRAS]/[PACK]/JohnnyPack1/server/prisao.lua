ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterCommand("prender", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "sheriff" then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if GetPlayerName(jailPlayer) ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)

				TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " está preso por " .. jailTime .. " minutos!")
				
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
					fal = Firstname .. " " .. Lastname .. " está agora na prisão por: " .. jailReason

					TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 7px;"> {0} {1} </div>',
					args = { "^*^5TRIBUNAL^r", fal}})
					
				--	TriggerClientEvent('chat:addMessage', -1, { args = { "TRIBUNAL",  Firstname .. " " .. Lastname .. " está agora na prisão por: " .. args[3] }, color = { 249, 166, 0 } })
					end)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "Coloca um tempo válido!")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "Não há nenhum jogador online com este ID!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Não pertences a nenhuma força policial!")
	end
end)

RegisterCommand("soltar", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "sheriff" then

		local jailPlayer = args[1]

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
		else
			TriggerClientEvent("esx:showNotification", src, "Não há nenhum jogador online com este ID!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Não pertences a nenhuma força policial!")
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPndscfhwechtnbuoiwperylayer")
AddEventHandler("esx-qalle-jail:jailPndscfhwechtnbuoiwperylayer", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)
	local nome = GetPlayerName(targetSrc)

	JailPlayer(targetSrc, jailTime)

	--GetRPName(targetSrc, function(Firstname, Lastname)
	
	fal = nome.. " está agora na prisão por: " .. jailReason
	
	TriggerClientEvent('chat:addMessage', source, {
	template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 7px;"> {0} {1} </div>',
	args = { "^5TRIBUNAL^0", fal}})
	
	--TriggerClientEvent('chat:addMessage', -1, { args = { "TRIBUNAL",  Firstname .. " " .. Lastname .. " está agora na prisão por: " .. jailReason }, color = { 249, 166, 0 } })
	--end)

	TriggerClientEvent("esx:showNotification", targetSrc, "Foste preso por " .. jailTime .. " minutos!")
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("esx:showNotification", src, "Foste libertado da prisão!")
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	local db = MySQL.Sync.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier})

	if db and db[1] then
		if db[1].jail == 0 then
			TriggerEvent("WorldTuga:BanThisCheater", src, "Tentativa de Spawnar Dinheiro") 
			return
		end
	end

	xPlayer.addMoney(math.random(1, 5))

	TriggerClientEvent("esx:showNotification", src, "Obrigado, tens aqui algum dinheiro para comprar comida!")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPndscfhwechtnbuoiwperylayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)