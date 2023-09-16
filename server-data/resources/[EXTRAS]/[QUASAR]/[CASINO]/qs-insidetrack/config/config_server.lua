RegisterServerEvent("qs-insidetrack:server:winnings")
AddEventHandler("qs-insidetrack:server:winnings", function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer ~= nil then
        xPlayer.addInventoryItem("casino_chips", amount)
    end
end)

RegisterServerEvent("qs-insidetrack:server:placebet")
AddEventHandler("qs-insidetrack:server:placebet", function(bet)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if Player ~= nil then
        xPlayer.removeInventoryItem("casino_chips", bet)
    end
end)

ESX.RegisterServerCallback("qs-insidetrack:server:getbalance", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer ~= nil then
        chips = xPlayer.getInventoryItem("casino_chips") and xPlayer.getInventoryItem("casino_chips").count or 0
        if chips ~= nil then
            cb(chips)
        else
            cb(0)
        end
    else
        cb(0)
    end
end)