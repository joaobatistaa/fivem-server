-- Don't change this --
ESX = nil
QBCore = nil

-- You can change this --
if Config.Framework == 'ESX' then
	ESX = exports.es_extended:getSharedObject()
elseif Config.Framework == 'QB' then
	QBCore = exports["qb-core"]:GetCoreObject()
end

-- WEBHOOKS --

playerReportWebhookLink = 'https://discord.com/api/webhooks/1102374326486962196/ba5vh3M1VfywlwO2NZ_btcXextTJ8FXbcb30I55JlKRek0d1wbH2kJQMUw6hLLb2doZR' -- Player Report webhook

bugReportWebhookLink = 'https://discord.com/api/webhooks/1102374511476748298/Pa1TX_0Y-u15yJl10SGRjuu3fXCKOELVP-W75oo2_EDU1xdHGCQ8Id04URJXJk4YljZ2' -- Bug Report webhook

questionReportWebhookLink = 'https://discord.com/api/webhooks/1102374607505330226/xWHrhEcdqQqHkEAdcMPqyWg-0TW0amH82DoiKKCTHBqQJWY409UsbzVf8SXvEryqDaRI' -- Question webhook

adminWebhookLink = 'https://discord.com/api/webhooks/1102374810559987743/b4wlbaEYs26XLxMfmzkMcXuGEs80u8MF5F2vCxJplH4EcRkk4OJSo79EuyjU_OWiSNbV' -- Admin related activities webhook (bring/go to/answer/conclude)

playerWebhookLink = 'https://discord.com/api/webhooks/1102374878784524310/nD_FESey_KeslZiJE-nDNB2yVN32h7XvO_NYDnsradCLYNVDP_cKMptBB_QUWaO_0zRs'-- Player related activities webhook (answer/cancel)

RegisterServerEvent('okokReportsV2:OnPlayerCancel')
AddEventHandler('okokReportsV2:OnPlayerCancel', function(source)
	
end)

RegisterServerEvent('okokReportsV2:OnConcluded')
AddEventHandler('okokReportsV2:OnConcluded', function(source, tagetSource)
	
end)

RegisterServerEvent('okokReportsV2:OnBring')
AddEventHandler('okokReportsV2:OnBring', function(source, tagetSource)
	
end)

RegisterServerEvent('okokReportsV2:OnGoTo')
AddEventHandler('okokReportsV2:OnGoTo', function(source, tagetSource)
	
end)

RegisterServerEvent('okokReportsV2:OnAnswer')
AddEventHandler('okokReportsV2:OnAnswer', function(source, tagetSource) -- tagetSource = nil if it's a player responding
	
end)

RegisterServerEvent('okokReportsV2:OnCreateReport')
AddEventHandler('okokReportsV2:OnCreateReport', function(source)
	
end)

function hasPermission(source)
	local staff = false
	
	if Config.Framework == 'ESX' then
		if Config.UseNewStaffCheckMethod then 
			for k,v in ipairs(Config.AdminGroups) do
				if ESX.HasGroup(source, v) then
					staff = true
					break
				end
			end
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer ~= nil then
				local playerGroup = xPlayer.getGroup()

				for k,v in ipairs(Config.AdminGroups) do
					if playerGroup == v then 
						staff = true
						break
					end
				end
			end
		end
	elseif Config.Framework == 'QB' then
		if Config.UseNewStaffCheckMethod then 
			for k,v in ipairs(Config.AdminGroups) do
				if QBCore.Functions.HasPermission(source, v) then
					staff = true
					break
				end
			end
		else
			local playerGroup = QBCore.Functions.GetPermission(source)
			
			if Config.QBPermissionsUpdate then
				for group, value in pairs(playerGroup) do
					if value then
						for k,v in ipairs(Config.AdminGroups) do
							if group == v then
								staff = true
								break
							end
						end
					end
				end
			else
				for k,v in ipairs(Config.AdminGroups) do
					if playerGroup == v then
						staff = true
						break
					end
				end
			end
		end
	else
		for i, a in ipairs(Config.StandaloneStaffIdentifiers) do
			for x, b in ipairs(GetPlayerIdentifiers(source)) do
				if string.lower(b) == string.lower(a) then
					staff = true
				end
			end
		end
	end

	return staff
end

function MySQLinsert(query, values, func)
	if Config.Database == 'mysql-async' then
		return MySQL.Async.insert(query, values, func)
	elseif Config.Database == 'oxmysql' then
		return MySQL.insert(query, values, func)
	elseif Config.Database == 'ghmattimysql' then
		return exports.ghmattimysql.execute(query, values, func)
	else
		print("[okokReportsV2] ERROR - no mysql callback! Please set a mysql callback in 'sv_utils.lua'")
	end
end

function getName(source)
	local name = nil
	
	if Config.UseSteamNames then
		name = GetPlayerName(source)
	elseif Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
		local identifier = xPlayer.identifier
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(db_name)
			if db_name[1] ~= nil then
				name = db_name[1].firstname.." "..db_name[1].lastname
			else
				name = ""
			end
		end)
		while name == nil do
			Citizen.Wait(2)
		end
	elseif Config.Framework == 'QB' then
		local xPlayer = QBCore.Functions.GetPlayer(source)
		name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
	else
		name = GetPlayerName(source)
	end
	return name
end

RegisterServerEvent('okokReportsV2:conclude')
AddEventHandler('okokReportsV2:conclude', function(report_id)
	local _source = source

	if not hasPermission(_source) then return end

	local admin_identifier = reportsList[report_id].admin_identifier

	if admin_identifier ~= nil and Config.SaveRespondedReports then
		MySQLinsert('INSERT INTO okokreports (admin_identifier) VALUES(@admin_identifier) ON DUPLICATE KEY UPDATE admin_identifier=@admin_identifier, responded_reports=responded_reports+1', {
			['@admin_identifier'] = admin_identifier,
		}, function (result)
		end)
	end

	if reportsList[report_id].bringStartPos ~= nil and Config.TeleportBackAfterConcluding then
		local targetPed = GetPlayerPed(tonumber(reportsList[report_id].source))
		SetEntityCoords(targetPed, reportsList[report_id].bringStartPos)
		reportsList[report_id].bringStartPos = nil
	end

	if reportsList[report_id].adminStartPos ~= nil and Config.TeleportBackAfterConcluding then
		local adminPed = GetPlayerPed(_source)
		SetEntityCoords(adminPed, reportsList[report_id].adminStartPos)
		reportsList[report_id].adminStartPos = nil
	end
	TriggerClientEvent('okokReportsV2:Notification', _source, interp(Config.Notifications['adm_rep_concluded'].text, {id = reportsList[report_id].id}), 'adm_rep_concluded')
	TriggerClientEvent('okokReportsV2:Notification', reportsList[report_id].source, interp(Config.Notifications['rep_concluded'].text, {id = reportsList[report_id].id}), 'rep_concluded')

	if adminWebhookLink ~= '' then
		local identifierlist = ExtractIdentifiers(_source)
		local webhookData = {
			color = Config.adminWebhookColor,
			title = Config.ReportTitle,
			action = Config.WebhookMessages['a_closed_report'].action,
			type = interp(Config.WebhookMessages['a_closed_report'].type, {id = reportsList[report_id].id}),
			name = getName(_source),
			title = nil,
			desc = nil,

			playerid = _source,
			identifier = identifierlist.license:gsub("steam:", ""),
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
		}
		discordWebhook(webhookData, adminWebhookLink)
	end
	TriggerEvent('okokReportsV2:OnConcluded', _source, reportsList[report_id].source)
	reportsList[report_id] = nil
end)

RegisterServerEvent('okokReportsV2:addMyReportAnswer')
AddEventHandler('okokReportsV2:addMyReportAnswer', function(msg, selectedWindow, reportSelected)
	local _source = source
	if selectedWindow == "clientWithReport" then

		local name = getName(_source)
		
		table.insert(reportsList["rep_".._source].msgs, '<span class="chat-name">'..name..'</span>: '..msg..' <br>')
		
		TriggerClientEvent('okokReportsV2:updateAnswers', _source, reportsList["rep_".._source].msgs)
		
		if reportsList["rep_".._source].admin_source ~= nil then
			TriggerClientEvent('okokReportsV2:updateAnswers', reportsList["rep_".._source].admin_source, reportsList["rep_".._source].msgs)
			TriggerClientEvent('okokReportsV2:Notification', reportsList["rep_".._source].admin_source, interp(Config.Notifications['player_answered'].text, {name = name, id = reportsList["rep_".._source].id}), 'player_answered')
		end
		if playerWebhookLink ~= '' then
			local identifierlist = ExtractIdentifiers(_source)
			local webhookData = {
				color = Config.playerWebhookColor,
				title = Config.ReportTitle,
				action = Config.WebhookMessages['p_answer_report'].action,
				type = interp(Config.WebhookMessages['p_answer_report'].type, {id = reportsList["rep_".._source].id}),
				name = getName(_source),
				title = nil,
				desc = nil,
				answer = msg,

				playerid = _source,
				identifier = identifierlist.license:gsub("stean:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
			}
			discordWebhook(webhookData, playerWebhookLink)
		end
		TriggerEvent('okokReportsV2:OnAnswer', _source, nil)
	else

		if not hasPermission(_source) then return end
		
		local name = getName(_source)
		
		table.insert(reportsList[reportSelected].msgs, '<span class="chat-name being-attended">'..name..'</span>: '..msg..' <br>')
		reportsList[reportSelected].admin_name = name
		reportsList[reportSelected].admin_source = _source
		reportsList[reportSelected].admin_identifier = ExtractIdentifiers(_source).license:gsub("steam:", "")
		if reportsList[reportSelected].isBeingHelped == nil then
			reportsList[reportSelected].isBeingHelped = true
		end
		if reportsList[reportSelected].isAdminAssisting == nil then
			reportsList[reportSelected].isAdminAssisting = true
		end
		TriggerClientEvent('okokReportsV2:updateAnswers', _source, reportsList[reportSelected].msgs)
		TriggerClientEvent('okokReportsV2:updateAnswers', reportsList[reportSelected].source, reportsList[reportSelected].msgs)
		TriggerClientEvent('okokReportsV2:Notification', reportsList[reportSelected].source, Config.Notifications['adm_answered'].text, 'adm_answered')
		if adminWebhookLink ~= '' then
			local identifierlist = ExtractIdentifiers(_source)
			local webhookData = {
				color = Config.adminWebhookColor,
				title = Config.ReportTitle,
				action = Config.WebhookMessages['p_answer_report'].action,
				type = interp(Config.WebhookMessages['p_answer_report'].type, {id = reportsList[reportSelected].id}),
				name = getName(_source),
				title = nil,
				desc = nil,
				answer = msg,

				playerid = _source,
				identifier = identifierlist.license:gsub("steam:", ""),
				discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
			}
			discordWebhook(webhookData, adminWebhookLink)
		end
		TriggerEvent('okokReportsV2:OnAnswer', _source, reportsList[reportSelected].source)
	end
end)

-- WEBHOOKS

function discordWebhook(data, url)
	local information = {}
	local description = ''

	if data.title ~= nil or data.desc ~= nil then
		description = '**Ação:** '..data.action..'\n**Tipo:** '..data.type..'\n**Nome:** '..data.name..'\n**Título:** '..data.title..'\n**Descrição:** '..data.desc..'\n\n**ID:** '..data.playerid..'\n**Steam Id:** '..data.identifier..'\n**Discord:** '..data.discord
	elseif data.answer ~= nil then
		description = '**Ação:** '..data.action..'\n**Tipo:** '..data.type..'\n**Nome:** '..data.name..'\n**Pergunta:** '..data.answer..'\n\n**ID:** '..data.playerid..'\n**Steam Id:** '..data.identifier..'\n**Discord:** '..data.discord
	else
		description = '**Ação:** '..data.action..'\n**Tipo:** '..data.type..'\n**Nome:** '..data.name..'\n\n**ID:** '..data.playerid..'\n**Identificador:** '..data.identifier..'\n**Discord:** '..data.discord
	end

	information = {
		{
			["color"] = data.color,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = Config.ReportTitle,
			["description"] = description,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	


	PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end

function ExtractIdentifiers(id)
	local identifiers = {
		steam = "",
		ip = "",
		discord = "",
		license = "",
		xbl = "",
		live = ""
	}

	for i = 0, GetNumPlayerIdentifiers(id) - 1 do
		local playerID = GetPlayerIdentifier(id, i)

		if string.find(playerID, "steam") then
			identifiers.steam = playerID
		elseif string.find(playerID, "ip") then
			identifiers.ip = playerID
		elseif string.find(playerID, "discord") then
			identifiers.discord = playerID
		elseif string.find(playerID, "license") then
			identifiers.license = playerID
		elseif string.find(playerID, "xbl") then
			identifiers.xbl = playerID
		elseif string.find(playerID, "live") then
			identifiers.live = playerID
		end
	end

	return identifiers
end