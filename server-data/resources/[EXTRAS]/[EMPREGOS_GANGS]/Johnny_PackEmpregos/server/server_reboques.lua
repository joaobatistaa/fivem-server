TriggerEvent('esx_society:registerSociety', 'reboques', 'reboques', 'society_reboques', 'society_reboques', 'society_reboques', {type = 'private'})


RegisterServerEvent('esx_reboquesjob:worldtugarp:pagamento')
AddEventHandler('esx_reboquesjob:worldtugarp:pagamento', function(towing)
	if towing then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local identifierlist = ExtractIdentifiers(_source)
		
		if xPlayer.job.name == 'reboques' then
			xPlayer.addAccountMoney('bank', Config.ReboquesSalario)
			
			local dataLog = {
				emprego = 'Reboques',
				playerid = _source,
				identifier = identifierlist.steam:gsub("steam:", ""),
				playername = GetPlayerName(_source),
				pagamento = Config.ReboquesSalario,
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
			}
			
			sendToDiscordEmpregos(dataLog)
		end
	end
end)