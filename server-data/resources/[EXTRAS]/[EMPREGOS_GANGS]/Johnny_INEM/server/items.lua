ESX.RegisterUsableItem('bandage', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bandage', 1)
	TriggerClientEvent('mythic_hospital:items:bandage', source)
end)

ESX.RegisterUsableItem('medkit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('medkit', 1)
	TriggerClientEvent('mythic_hospital:items:medkit', source)
end)


---------------------------------------------------------------------------------

ESX.RegisterUsableItem('xanax', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('xanax', 1)
	
	TriggerClientEvent('mythic_hospital:items:xanax', _source)
end)

ESX.RegisterUsableItem('weed', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_drugeffects:onMarijuana', _source)
end)

ESX.RegisterUsableItem('opium', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 249000)
	TriggerClientEvent('esx_drugeffects:onOpium', _source)
end)

ESX.RegisterUsableItem('meth', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('esx_drugeffects:onMeth', _source)
end)

ESX.RegisterUsableItem('cocaine', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('cocaine', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 499000)
	TriggerClientEvent('esx_drugeffects:onCoke', _source)
end)
