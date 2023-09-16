local Users         = {}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('cuffSendscfhwechtnbuoiwperyrver')
AddEventHandler('cuffSendscfhwechtnbuoiwperyrver', function(closestID)
	TriggerClientEvent('cuffClient', closestID)
end)

RegisterServerEvent('unCuffServer')
AddEventHandler('unCuffServer', function(closestID)
	TriggerClientEvent('unCuffClient', closestID)
end)

RegisterServerEvent('dragServer')
AddEventHandler('dragServer', function(target)
  local _source = source
  TriggerClientEvent('cuffscript:drag', target, _source)
end)

---- END MENU


ESX.RegisterServerCallback('esx_thief:getValue', function(source, cb, targetSID)
    if Users[targetSID] then
        cb(Users[targetSID])
    else
        cb({value = false, time = 0})
    end
end)

ESX.RegisterServerCallback('esx_thief:getOtherPlayerData', function(source, cb, target)

    local xPlayer = ESX.GetPlayerFromId(target)

    local data = {
      name        = GetPlayerName(target),
      inventory   = xPlayer.inventory,
      accounts    = xPlayer.accounts,
      money       = xPlayer.get('money'),
      weapons     = xPlayer.loadout

    }

      cb(data)

end)

RegisterServerEvent("esx_thief:update")
AddEventHandler("esx_thief:update", function(bool)
	local source = source
	Users[source] = {value = bool, time = os.time()}
end)

RegisterServerEvent("esx_thief:getValue")
AddEventHandler("esx_thief:getValue", function(targetSID)
    local source = source
	if Users[targetSID] then
		TriggerClientEvent("esx_thief:returnValue", source, Users[targetSID])
	else
		TriggerClientEvent("esx_thief:returnValue", source, Users[targetSID])
	end
end)


---- HANDCUFFS + ROPE ----

ESX.RegisterServerCallback('esx_thief:getItemQ', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
    cb(quantity)
end)