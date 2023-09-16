ESX = nil

ESX = exports['es_extended']:getSharedObject()

local canAdvertise = true

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			grupo = identity['group'],
			emprego = identity['job'],
		}
	else
		return nil
	end
end

if Config.AllowPlayersToClearTheirChat then
	RegisterCommand(Config.ClearChatCommand, function(source, args, rawCommand)
		TriggerClientEvent('chat:client:ClearChat', source)
		TriggerEvent('DiscordBot:clearchat', source, 0)
	end)
end

if Config.AllowStaffsToClearEveryonesChat then
	RegisterCommand(Config.ClearEveryonesChatCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local time = os.date(Config.DateFormat)

		if isAdmin(xPlayer, source) then
			TriggerClientEvent('chat:client:ClearChat', -1)
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">O chat foi limpo por um Staff!</div></div>',
				args = { time }
			})
			TriggerEvent('DiscordBot:clearchat', source, 1)
		end
	end)
end

if Config.EnableStaffCommand then
	RegisterCommand(Config.StaffCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.StaffCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		--playerName = xPlayer.getName()
		local info = getIdentity(source)
		playerName = info.name
		
		if isAdmin(xPlayer, source) then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message staff"><i class="fas fa-exclamation-triangle"></i> <b><span style="color: #9d0000">[STAFF] {0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
			local mensagem = '/staff ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		end
		
	end)
end

if Config.EnableStaffOnlyCommand then
	RegisterCommand(Config.StaffOnlyCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.StaffOnlyCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		--playerName = xPlayer.getName()
		local info = getIdentity(source)
		playerName = info.name

		if isAdmin(xPlayer, source) then
			showOnlyForAdmins(function(admins)
				TriggerClientEvent('chat:addMessage', admins, {
					template = '<div class="chat-message staffonly"><i class="fas fa-eye-slash"></i> <b><span style="color: #1ebc62">[STAFF CHAT] {0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
					args = { playerName, message, time }
				})
				local mensagem = '/sc ' .. message
				TriggerEvent('DiscordBot:chatgeral', source, mensagem)
			end)
		end
		
	end)
end

if Config.EnableAdvertisementCommand then
	RegisterCommand(Config.AdvertisementCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.AdvertisementCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.getName()
		local bankMoney = xPlayer.getAccount('bank').money

		if canAdvertise then
			if bankMoney >= Config.AdvertisementPrice then
				xPlayer.removeAccountMoney('bank', Config.AdvertisementPrice)
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div class="chat-message advertisement"><i class="fas fa-ad"></i> <b><span style="color: #81db44">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
					args = { playerName, message, time }
				})

				TriggerClientEvent('Johnny_Notificacoes:Alert', source, "WTRP", "Anúncio publicado com sucesso por "..Config.AdvertisementPrice..'€', 10000, 'success')
				local mensagem = '/publicidade ' .. message
				TriggerEvent('DiscordBot:chatgeral', source, mensagem)
				local time = Config.AdvertisementCooldown * 60
				local pastTime = 0
				canAdvertise = false

				while (time > pastTime) do
					Citizen.Wait(1000)
					pastTime = pastTime + 1
					timeLeft = time - pastTime
				end
				canAdvertise = true
			else
				TriggerClientEvent('Johnny_Notificacoes:Alert', source, "WTRP", "Não tens dinheiro suficiente para fazer um anúncio!", 10000, 'error')
			end
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "WTRP", "Fizeste um anúncio recentemente, terás que aguardar para fazer um outra vez!", 10000, 'error')
		end
	end)
end

if Config.EnableTwitchCommand then
	RegisterCommand(Config.TwitchCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.TwitchCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		--playerName = xPlayer.getName()
		local info = getIdentity(source)
		playerName = info.name
		local twitch = twitchPermission(source)
		
		if twitch then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message twitch"><i class="fab fa-twitch"></i> <b><span style="color: #b48bf0">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
			local mensagem = '/streamer ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		end
	end)
end

function twitchPermission(id)
	for i, a in ipairs(Config.TwitchList) do
		for x, b in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(b) == string.lower(a) then
				return true
			end
		end
	end
end

if Config.EnableYoutubeCommand then
	RegisterCommand(Config.YoutubeCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.YoutubeCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		--playerName = xPlayer.getName()
		local info = getIdentity(source)
		playerName = info.name
		local youtube = youtubePermission(source)

		if youtube then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message youtube"><i class="fab fa-youtube"></i> <b><span style="color: #ff0000">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
			local mensagem = '/streamer ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		end
	end)
end

function youtubePermission(id)
	for i, a in ipairs(Config.YoutubeList) do
		for x, b in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(b) == string.lower(a) then
				return true
			end
		end
	end
end

if Config.EnableTwitterCommand then
	RegisterCommand(Config.TwitterCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.TwitterCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		playerName = xPlayer.getName()

		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message twitter"><i class="fab fa-twitter"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { playerName, message, time }
		})
		local mensagem = '/twitter ' .. message
		TriggerEvent('DiscordBot:chatgeral', source, mensagem)
	end)
end

if Config.EnablePoliceCommand then
	RegisterCommand(Config.PoliceCommand, function(source, args, rawCommand)
		local info = getIdentity(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.PoliceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		titulo = "Anúncio da Polícia"
		playerName = xPlayer.job.grade_label.." "..info.firstname.." "..info.lastname
		local job = xPlayer.job.name

		if job == Config.PoliceJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message police"><i class="fas fa-building"></i> <b><span style="color: #008dff">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { titulo, message.." (por "..playerName..")", time }
			})
			local mensagem = '/policia ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		else 
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span></b><div style="margin-top: 5px; font-weight: 300;">Não tens permissão para executar esse comando!</div></div>',
				args = { time }
			})
		end
	end)
end

if Config.EnableAmbulanceCommand then
	RegisterCommand(Config.AmbulanceCommand, function(source, args, rawCommand)
		local info = getIdentity(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.AmbulanceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		titulo = "Anúncio do INEM"
		playerName = xPlayer.job.grade_label.." "..info.firstname.." "..info.lastname
		local job = xPlayer.job.name

		if job == Config.AmbulanceJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message ambulance"><i class="fas fa-ambulance"></i> <b><span style="color: #e3a71b">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { titulo, message.." (por "..playerName..")", time }
			})
			local mensagem = '/inem ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		else 
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span></b><div style="margin-top: 5px; font-weight: 300;">Não tens permissão para executar esse comando!</div></div>',
				args = { time }
			})
		end
	end)
end

if Config.EnableMechanicCommand then
	RegisterCommand(Config.MechanicCommand, function(source, args, rawCommand)
		local info = getIdentity(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.MechanicCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		titulo = "Anúncio dos Mecânicos"
		playerName = xPlayer.job.grade_label.." "..info.firstname.." "..info.lastname
		local job = xPlayer.job.name

		if job == Config.MechanicJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message mechanic"><i class="fas fa-wrench"></i> <b><span style="color: #9a6e25">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { titulo, message.." (por "..playerName..")", time }
			})
			local mensagem = '/mecanicos ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		else 
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span></b><div style="margin-top: 5px; font-weight: 300;">Não tens permissão para executar esse comando!</div></div>',
				args = { time }
			})
		end
	end)
end

if Config.EnableRedlineCommand then
	RegisterCommand(Config.RedlineCommand, function(source, args, rawCommand)
		local info = getIdentity(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.RedlineCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		titulo = "Anúncio dos Redline"
		playerName = xPlayer.job.grade_label.." "..info.firstname.." "..info.lastname
		local job = xPlayer.job.name

		if job == Config.RedlineJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message redline"><i class="fas fa-wrench"></i> <b><span style="color: #000000">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { titulo, message.." (por "..playerName..")", time }
			})
			local mensagem = '/redline ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		else 
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #ff0000">WTRP SYSTEM</span></b><div style="margin-top: 5px; font-weight: 300;">Não tens permissão para executar esse comando!</div></div>',
				args = { time }
			})
		end
	end)
end

if Config.EnablePearCommand then
	RegisterCommand(Config.PearCommand, function(source, args, rawCommand)
		local info = getIdentity(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.PearCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		titulo = "Anúncio do Pearls"
		playerName = xPlayer.job.grade_label.." "..info.firstname.." "..info.lastname
		local job = xPlayer.job.name

		if job == Config.PearJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message pearls"> <i class="fa-lobster"></i> <b><span style="color: #00ffec">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #FDEEF4;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { titulo, message.." (por "..playerName..")", time }
			})
			local mensagem = '/pearls ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		else 
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #ff0000">WTRP SYSTEM</span></b><div style="margin-top: 5px; font-weight: 300;">Não tens permissão para executar esse comando!</div></div>',
				args = { time }
			})
		end
	end)
end



if Config.EnableTribunalCommand then
	RegisterCommand(Config.TribunalCommand, function(source, args, rawCommand)
		local info = getIdentity(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.TribunalCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		titulo = "Anúncio do Tribunal"
		playerName = xPlayer.job.grade_label.." "..info.firstname.." "..info.lastname
		local job = xPlayer.job.name

		if job == Config.TribunalJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message tribunal"><i class="fas fa-gavel"></i> <b><span style="color: #f9f9f9">{0}</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { titulo, message.." (por "..playerName..")", time }
			})
			local mensagem = '/tribunal ' .. message
			TriggerEvent('DiscordBot:chatgeral', source, mensagem)
		else 
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span></b><div style="margin-top: 5px; font-weight: 300;">Não tens permissão para executar esse comando!</div></div>',
				args = { time }
			})
		end
	end)
end

if Config.EnableOOCCommand then
	RegisterCommand(Config.OOCCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(Config.OOCCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		--playerName = xPlayer.getName()
		local info = getIdentity(source)
		playerName = info.name
		TriggerClientEvent('chat:ooc', -1, source, playerName, message, time)
		local mensagem = '/ooc ' .. message
		TriggerEvent('DiscordBot:chatgeral', source, mensagem)
	end)
end

function isAdmin(xPlayer, id)
	if xPlayer == nil then
		print("xPlayer == NIL | ID = "..id)
		return false
	else
		for k,v in ipairs(Config.StaffGroups) do
			if xPlayer.getGroup() == v then 
				return true 
			end
		end
		return false
	end
end

function showOnlyForAdmins(admins)
	for k,v in ipairs(ESX.GetPlayers()) do
		if isAdmin(ESX.GetPlayerFromId(v), v) then
			admins(v)
		end
	end
end