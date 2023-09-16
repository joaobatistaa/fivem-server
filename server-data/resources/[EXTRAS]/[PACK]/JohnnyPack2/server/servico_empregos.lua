ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
   -- local foraservico = 0
	
	if job == 'police' or job == 'ambulance' then
        xPlayer.setJob('off' ..job, grade)
		--TriggerClientEvent('duty:limpar', _source)
        --TriggerClientEvent('esx:showNotification', _source, '~r~Saiste~s~ de serviço, todas as tuas armas foram eliminadas!')
		--TriggerClientEvent('esx:showNotification', _source, '~r~Saiste~s~ de serviço')
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "EMPREGO", "<span style='color:#c7c7c7'><span style='color:#ff0000'>Saíste</span> de serviço!", 3000, 'error')
	elseif job == 'mechanic' then
		xPlayer.setJob('off' ..job, grade)
		--TriggerClientEvent('esx:showNotification', _source, '~r~Saiste~s~ de serviço')
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "EMPREGO", "<span style='color:#c7c7c7'><span style='color:#ff0000'>Saíste</span> de serviço!", 3000, 'error')
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        --TriggerClientEvent('esx:showNotification', _source, '~g~Entraste~s~ em serviço')
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "EMPREGO", "<span style='color:#c7c7c7'><span style='color:#069a19'>Entraste</span> em serviço!", 3000, 'success')
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        --TriggerClientEvent('esx:showNotification', _source, '~g~Entraste~s~ em serviço')
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "EMPREGO", "<span style='color:#c7c7c7'><span style='color:#069a19'>Entraste</span> em serviço!", 3000, 'success')
	elseif job == 'offmechanic' then
        xPlayer.setJob('mechanic', grade)
        --TriggerClientEvent('esx:showNotification', _source, '~g~Entraste~s~ em serviço')
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "EMPREGO", "<span style='color:#c7c7c7'><span style='color:#069a19'>Entraste</span> em serviço!", 3000, 'success')
    end

end)