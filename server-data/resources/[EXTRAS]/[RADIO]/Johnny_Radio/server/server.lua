ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('radio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('ls-radio:use', source)
end)

RegisterServerEvent('ls-radio:usarServer')
AddEventHandler('ls-radio:usarServer', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local qtd = xPlayer.getInventoryItem('radio').count
	if qtd > 0 then
		TriggerClientEvent('ls-radio:use', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Não tens um Walkie Talkie!'})
	end
end)


-- checking is player have item

--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer ~= nil then
				local qtd = xPlayer.getInventoryItem('radio').count

				if qtd == 0 then
					local source = xPlayers[i]
					TriggerClientEvent('ls-radio:onRadioDrop2', source)
					break
				end
			end
		end
    end
end)
--]]

