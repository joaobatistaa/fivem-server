local localConfig = {
	Price = 500,
	ReviveTime = 20000,
	MedicosAtivos = 0
}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('hhfw:docOnline' , function(source, cb)
	local src = source
	local Ply = ESX.GetPlayerFromId(src)
	local xPlayers = ESX.GetPlayers()
	local doctor = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			doctor = doctor + 1
		end
	end

	cb(doctor)
end)



RegisterServerEvent('hhfw:charge')
AddEventHandler('hhfw:charge', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getMoney()>= localConfig.Price then
		xPlayer.removeMoney(localConfig.Price)
	else
		xPlayer.removeAccountMoney('bank', localConfig.Price)
	end
end)
