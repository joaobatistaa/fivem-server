QS = nil

TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)

function giveKey(playerID, xPlayer, actualMotel, room)
    if Config.Framework == "esx" then
        if not getKey(playerID, xPlayer, room) then
            local info = {}
			local xPlayer = ESX.GetPlayerFromId(playerID)

            info.motel = actualMotel
            info.room = room
            info.renter = xPlayer.identifier
			
			exports['qs-inventory']:AddItem(playerID, "motelkey", 1, nil, info)	
			
            TriggerClientEvent("bit-motels:notifications", playerID, Noti.check, Lang.receivedKey.." "..room, Noti.time)
        else
            TriggerClientEvent("bit-motels:notifications", playerID, Noti.error, Lang.haveKey, Noti.time)
        end
    elseif Config.Framework == "qb" then
        if not getKey(playerID, xPlayer, room) then
            local info = {}
            info.motel = actualMotel
            info.room = room
            info.renter = xPlayer.PlayerData.citizenid
            xPlayer.Functions.AddItem('motelkey', 1, nil, info)
            TriggerClientEvent('inventory:client:ItemBox', playerID, QBCore.Shared.Items['motelkey'], 'add')
            TriggerClientEvent("bit-motels:notifications", playerID, Noti.check, Lang.receivedKey.." "..room, Noti.time)
        else
            TriggerClientEvent("bit-motels:notifications", playerID, Noti.error, Lang.haveKey, Noti.time)
        end
    end
end

function getKey(playerID, xPlayer, roomname)
    if Config.Framework == "esx" then
		local items = exports['qs-inventory']:GetInventory(playerID)
		local hasKey = false
		
        for _, objeto in pairs(items) do
			if objeto.name == 'motelkey' then
				if tostring(objeto.info.room) == tostring(roomname) then
					hasKey = true
				end
			end
		end
		return hasKey
    elseif Config.Framework == "qb" then
        local hasKey = false
        local keys = xPlayer.Functions.GetItemsByName('motelkey')
        if keys then
            for _, key in pairs(keys) do
                if tostring(key.info.room) == tostring(roomname) then
                    hasKey = true
                end
            end
        end
        return hasKey
    end
end

function removeKey(playerID, xPlayer, room, actualMotel)
    if getKey(playerID, xPlayer, room) then
        if Config.Framework == "esx" then
			local items = exports['qs-inventory']:GetInventory(playerID)
			local hasKey = false
			
			for _, objeto in pairs(items) do
				if objeto.name == 'motelkey' then
					if tostring(objeto.info.room) == tostring(room) and tostring(objeto.info.motel) == tostring(actualMotel) then
						exports['qs-inventory']:RemoveItem(playerID, objeto.name, 1, objeto.slot, objeto.info)
					end
				end
			end
        elseif Config.Framework == "qb" then
            local keys = xPlayer.Functions.GetItemsByName('motelkey')
            if keys then
                for _, key in pairs(keys) do
                    if tostring(key.info.room) == tostring(room) and tostring(key.info.motel) == tostring(actualMotel) then
                        xPlayer.Functions.RemoveItem("motelkey", 1)
                    end
                end
            end
        end
    end
end

function billing(xTarget, price)
    --Example:
    TriggerEvent("okokBilling:CreateCustomInvoice", xTarget.source, price, "Quarto Motel", "Motel", "motelsociety", "Empresa Motel" )
end

function MobileNotification(xTarget)
    --Example:
    --exports.high_phone:sendMessageToPlayer(xTarget.source, "Motel", "You have a new invoice from the Motel")
end

RegisterNetEvent("bit-motels:registerStash")
AddEventHandler("bit-motels:registerStash", function(playerID)
    if Config.Framework == "esx" then
        --
    end
end)