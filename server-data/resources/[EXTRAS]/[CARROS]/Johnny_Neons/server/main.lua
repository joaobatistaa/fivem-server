ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('wtrp_neons:getVip', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local result = MySQL.Sync.fetchAll('SELECT vip FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
	
	if result[1] ~= nil then
		vip = result[1].vip
		if vip == 0 then
			cb(false)
		else
			cb(true)
		end
	else
		cb(false)
	end
end)