ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('modoadmin:server:TogglePermissao')
AddEventHandler('modoadmin:server:TogglePermissao', function(estado)
	modoadmin = estado
end)

ESX.RegisterCommand('servicocomunitario', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		if args.playerId and GetPlayerName(args.playerId.source) ~= nil and args.actions then
			TriggerEvent('esx_communityservice:sendToCommunityService', args.playerId.source, args.actions)
			TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "SUCESSO", "<span style='color:#c7c7c7'>Jogador enviado para o <span style='color:#069a19'><b>Serviço Comunitário</b></span>!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "ERRO", "<span style='color:#c7c7c7'>O <span style='color:#ff0000'>Id do Jogador ou a Quantidade de Ações</span> não é valido/a!", 5000, 'error')
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = 'Colocar um jogador no serviço comunitário', validate = true, arguments = {
	{name = 'playerId', help = 'Id do Jogador', type = 'player'},
	{name = 'actions', help = 'Quantidade de Ações [sugerido: 10-40]', type = 'number'},
}})

ESX.RegisterCommand('retirarservicocomunitario', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		if args.playerId then
			if GetPlayerName(args.playerId.source) ~= nil then
				TriggerEvent('esx_communityservice:endCommunityServiceCommand', args.playerId.source)
				TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "SUCESSO", "<span style='color:#c7c7c7'>Jogador retirado do <span style='color:#069a19'><b>Serviço Comunitário</b></span>!", 5000, 'success')
			else
				TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "ERRO", "<span style='color:#c7c7c7'>O <span style='color:#ff0000'>Id do Jogador</span> não é valido!", 5000, 'error')
			end
		else
			TriggerEvent('esx_communityservice:endCommunityServiceCommand', xPlayer.source)
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = 'Retirar um jogador do serviço comunitário.', validate = true, arguments = {
	{name = 'playerId', help = 'Id do Jogador', type = 'player'}
}})

RegisterServerEvent('esx_communityservice:endCommunityServiceCommand')
AddEventHandler('esx_communityservice:endCommunityServiceCommand', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)

-- unjail after time served
RegisterServerEvent('esx_communityservice:finishCommunityService')
AddEventHandler('esx_communityservice:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('esx_communityservice:completeService')
AddEventHandler('esx_communityservice:completeService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = actions_remaining - 1 WHERE identifier = @identifier', {
				['@identifier'] = identifier
			})
		else
			print ("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:extendService')
AddEventHandler('esx_communityservice:extendService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)

		if result[1] then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = actions_remaining + @extension_value WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@extension_value'] = Config.ServiceExtensionOnEscape
			})
		else
			print ("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:sendToCommunityService')
AddEventHandler('esx_communityservice:sendToCommunityService', function(target, actions_count)

	local identifier = GetPlayerIdentifiers(target)[1]

	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('UPDATE communityservice SET actions_remaining = @actions_remaining WHERE identifier = @identifier', {
				['@identifier'] = identifier,
				['@actions_remaining'] = actions_count
			})
		else
			MySQL.Async.execute('INSERT INTO communityservice (identifier, actions_remaining) VALUES (@identifier, @actions_remaining)', {
				['@identifier'] = identifier,
				['@actions_remaining'] = actions_count
			})
		end
	end)

	--TriggerClientEvent('chat:addMessage', -1, { args = { 'JUIZ', GetPlayerName(target)..' foi condenado em '..actions_count..' meses de serviço comunitário.' }, color = { 147, 196, 109 } })
	TriggerClientEvent('esx_policejob:unrestrain', target)
	TriggerClientEvent('esx_communityservice:inCommunityService', target, actions_count)
end)

RegisterServerEvent('esx_communityservice:checkIfSentenced')
AddEventHandler('esx_communityservice:checkIfSentenced', function()
	local _source = source -- cannot parse source to client trigger for some weird reason
	local identifier = GetPlayerIdentifiers(_source)[1] -- get steam identifier

	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] ~= nil and result[1].actions_remaining > 0 then
			--TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('jailed_msg', GetPlayerName(_source), ESX.Math.Round(result[1].jail_time / 60)) }, color = { 147, 196, 109 } })
			TriggerClientEvent('esx_communityservice:inCommunityService', _source, tonumber(result[1].actions_remaining))
		end
	end)
end)

function releaseFromCommunityService(target)

	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.Async.fetchAll('SELECT * FROM communityservice WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			MySQL.Async.execute('DELETE from communityservice WHERE identifier = @identifier', {
				['@identifier'] = identifier
			})
		end
	end)

	TriggerClientEvent('esx_communityservice:finishCommunityService', target)
end