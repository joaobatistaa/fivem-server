ESX.RegisterServerCallback('bb-hud:HasMoney', function(source, cb, count)
	local retval = false
	local Player = ESX.GetPlayerFromId(source)
	if Player ~= nil then 
        if Player.getMoney() >= count then
            Player.removeMoney(count)
			retval = true
		end
	end
	
	cb(retval)
end)