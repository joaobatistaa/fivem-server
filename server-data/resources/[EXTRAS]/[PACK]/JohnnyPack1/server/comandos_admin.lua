ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterCommand("fix", function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup()=='superadmin' or xPlayer.getGroup()=='admin' then
		TriggerClientEvent('wtrp:fix', source)
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens permissões suficientes!", 5000, 'error')
	end
    
end, false)

RegisterCommand("clean", function(source, args)	
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getGroup()=='superadmin' or xPlayer.getGroup()=='admin' then
		TriggerClientEvent('wtrp:clean', source)
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens permissões suficientes!", 5000, 'error')
	end
    
end, false)

RegisterCommand("idgun", function(source, args)	
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getGroup()=='superadmin' then
		TriggerClientEvent('wtrp:idgun', source)
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens permissões suficientes!", 5000, 'error')
	end
    
end, false)