Citizen.CreateThread(function()
	Wait(1000)
	TriggerServerEvent("okokReports:FetchFeedbackTable")
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

-------------------------- VARS

local oneSync = false
local staff = false
local modoadmin = false
local FeedbackTable = {}
local canFeedback = true
local timeLeft = Config.FeedbackCooldown
local pos_before_assist = nil

-------------------------- MENU

RegisterNetEvent('okokReports:FeedbackMenu')
AddEventHandler('okokReports:FeedbackMenu', function(showAdminMenu)
	SetNuiFocus(true, true)
	if showAdminMenu then
		SendNUIMessage({
			action = "updateFeedback",
			FeedbackTable = FeedbackTable
		})
		SendNUIMessage({
			action = "OpenAdminFeedback",
		})
	else
		--if canFeedback then
			SendNUIMessage({
				action = "ClientFeedback",
			})
		--else
			--exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>Tens um <span style='color:#ff0000'>report</span> aberto ou fizeste <span style='color:#ff0000'>report</span> à pouco tempo!", 5000, 'error')
		--end
	end
end)

-------------------------- EVENTS

RegisterNetEvent('okokReports:NewFeedback')
AddEventHandler('okokReports:NewFeedback', function(newFeedback)
	if staff then
		FeedbackTable[#FeedbackTable+1] = newFeedback
		
		if modoadmin then
			exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>Um novo <span style='color:#ffc107'>report</span> foi aberto!", 10000, 'warning')
		end
		
		SendNUIMessage({
			action = "updateFeedback",
			FeedbackTable = FeedbackTable
		})
	end
end)

RegisterNetEvent('okokReports:FetchFeedbackTable')
AddEventHandler('okokReports:FetchFeedbackTable', function(feedback, admin, oneS)
	FeedbackTable = feedback
	staff = admin
	oneSync = oneS
end)

AddEventHandler('modoadmin:client:TogglePermissao', function(estado)
	modoadmin = estado
end)

RegisterNetEvent('okokReports:FeedbackConclude')
AddEventHandler('okokReports:FeedbackConclude', function(feedbackID, info, feedback)
	FeedbackTable = feedback
	local feedbackid = FeedbackTable[feedbackID]
	print('ID DO REPORT PASSADO PELO SERVER SIDE')
	print(feedbackID)
	print('----------------------')
	print('REPORTS DO CLIENT')
	
	for k,v in pairs(FeedbackTable) do
		print('----------------------')
		print('ID do Report: '..v.feedbackid)
		print('ID do Criador do Report: '..v.playerid)
		print('Steam Id do Criador do Report: '..v.identifier)
		print('Nome do Jogador do Criador do Report: '..v.playername)
		print('Concluído:')
		print(v.concluded)
		print('Steam ID Staff:')
		print(v.staffIdentifier)
		print('----------------------')
	end
	if feedbackid ~= nil then
		feedbackid.concluded = info
		
		SendNUIMessage({
			action = "updateFeedback",
			FeedbackTable = FeedbackTable
		})
	end
end)


-------------------------- ACTIONS

RegisterNUICallback("action", function(data)
	if data.action ~= "concludeFeedback" then
		SetNuiFocus(false, false)
	end

	if data.action == "newFeedback" then
		exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>O teu <span style='color:#069a19'>Report</span> foi enviado à STAFF!", 5000, 'success')
		
		local feedbackInfo = {subject = data.subject, information = data.information, category = data.category}
		TriggerServerEvent("okokReports:NewFeedback", feedbackInfo)

		local time = Config.FeedbackCooldown * 60
		local pastTime = 0
		canFeedback = false

		while (time > pastTime) do
			Citizen.Wait(1000)
			pastTime = pastTime + 1
			timeLeft = time - pastTime
		end
		canFeedback = true
	elseif data.action == "assistFeedback" then
		if FeedbackTable[data.feedbackid] then
			if oneSync then
				TriggerServerEvent("okokReports:AssistFeedback", data.feedbackid, true)
			else
				local playerFeedbackID = FeedbackTable[data.feedbackid].playerid

				ESX.TriggerServerCallback('okokReports:canAtenderReport', function(canAtenderReport)
					if canAtenderReport == 'top' then
						--SetEntityCoords(ped, GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerFeedbackID))))
						TriggerServerEvent("okokReports:AssistFeedback", data.feedbackid, true)
					elseif canAtenderReport == 'proprioReport' then
						exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>Não podes atender o <span style='color:#ff0000'>teu próprio</span> Report!", 5000, 'error')
					elseif canAtenderReport == 'offline' then
						exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>Esse <span style='color:#ff0000'>Jogador</span> já não está no servidor!", 5000, 'error')
					else
						print('outro erro')
					end

				end, playerFeedbackID)
			end
		end
	elseif data.action == "concludeFeedback" then
		local feedbackID = data.feedbackid
		local playerFeedbackID = FeedbackTable[feedbackID].playerid
		
		local staffSteamId = FeedbackTable[feedbackID].staffIdentifier
		--for k,v in pairs(FeedbackTable[feedbackID]) do
			--print(k)
			--print(v)
		--end
		local canConclude = data.canConclude
		local feedbackInfo = FeedbackTable[feedbackID]
		if feedbackInfo then
			if feedbackInfo.concluded ~= true or canConclude then
				ESX.TriggerServerCallback('okokReports:canFecharReport', function(canFecharReport)
					if canFecharReport == 'top' then
						TriggerServerEvent("okokReports:FeedbackConclude", feedbackID, canConclude)
						exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>O <span style='color:#069a19'>Report #"..feedbackID.."</span> foi concluído!", 5000, 'success')
					elseif canFecharReport == 'proprioReport' then
						exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>Não podes fechar o <span style='color:#ff0000'>teu próprio</span> Report!", 5000, 'error')
					elseif canFecharReport == 'steamid_diferente' then
						exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>Não podes <span style='color:#ff0000'>fechar</span> um report que não atendeste!", 5000, 'error')
					elseif canFecharReport == 'offline' then
						exports['Johnny_Notificacoes']:Alert("WTRP REPORTS", "<span style='color:#c7c7c7'>Esse <span style='color:#ff0000'>Jogador</span> já não está no servidor!", 5000, 'error')
					else
						print('outro erro')
					end
				end, playerFeedbackID, staffSteamId)
			end
		end
	end
end)