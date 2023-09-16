function getPlayerChips(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        return xPlayer.getInventoryItem("casino_chips") and xPlayer.getInventoryItem("casino_chips").count or 0
    else
        return 0
    end
end

function giveChips(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addInventoryItem("casino_chips", amount)
        updatePlayerChips(source)
    end
end

function removeChips(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.removeInventoryItem("casino_chips", amount)
        updatePlayerChips(source)
    end
end