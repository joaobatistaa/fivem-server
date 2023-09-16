function getPlayerChips(source)
	local xPlayer = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemcount = xPlayer.getInventoryItem("casino_chips").count
    return itemcount
end

function giveChips(source, amount)
	local xPlayer = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem("casino_chips", amount)
end

function removeChips(source, amount)
	local xPlayer = source
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("casino_chips", amount)
end

function isPlayerExist(source)
    if GetPlayerName(source) ~= nil then
        return true
    else
        return false
    end
end