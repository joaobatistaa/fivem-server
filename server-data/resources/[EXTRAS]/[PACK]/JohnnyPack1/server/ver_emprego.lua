ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterCommand("emprego", function(source, args)	
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local emprego = xPlayer.job.label
	local emprego2 = xPlayer.job.grade_label
	
	
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'azulclaro', text = 'Emprego: '..emprego..' - '..emprego2, length = 5000, style = { ['background-color'] = '#3F9BBF', ['color'] = '#000000' } })
	
end, false)