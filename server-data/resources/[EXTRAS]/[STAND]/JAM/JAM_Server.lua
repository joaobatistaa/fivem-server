ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('JAM:GetAceGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do
		Citizen.Wait(100)
		xPlayer = ESX.GetPlayerFromId(source)
	end
	local perms = xPlayer.getGroup()
	cb(perms)
end)