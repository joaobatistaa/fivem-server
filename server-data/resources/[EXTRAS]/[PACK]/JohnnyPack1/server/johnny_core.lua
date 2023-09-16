ESX = nil

ESX = exports['es_extended']:getSharedObject()

AddEventHandler('esx:playerLoaded', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local grupo = xPlayer.getGroup()
	TriggerClientEvent('johnny_core:setGroup', _source, grupo)
end)

ESX.RegisterServerCallback('johnny:server:getGrupo', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer then
		local grupo = xPlayer.getGroup()
	
		cb(grupo)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('johnny:server:isVip', function(source, cb, idPlayer)
	local xPlayer = ESX.GetPlayerFromId(idPlayer)
	local vip = xPlayer.vip
	
	if vip ~= 0 then
		cb(true)
	else
		cb(false)
	end
end)