ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('es_better_carwash:checkmoney')
AddEventHandler('es_better_carwash:checkmoney', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = 1000
	
    if price < xPlayer.getAccount('bank').money then
        TriggerClientEvent('es_better_carwash:success', _source, 100)
        xPlayer.removeAccountMoney('bank', price)
    elseif price < xPlayer.getMoney() then
        TriggerClientEvent('es_better_carwash:success', _source, 100)
        xPlayer.removeMoney(price)
    elseif price < xPlayer.getAccount('bank').money + xPlayer.getMoney() then
        TriggerClientEvent('es_better_carwash:success', _source, 100)
        local bankPrice = xPlayer.getAccount('bank').money
        xPlayer.removeAccountMoney('bank', bankPrice)
        local cashPrice = price - bankPrice
        xPlayer.removeMoney(cashPrice)
    else
		TriggerClientEvent('es_better_carwash:notenoughmoney', _source)
    end
	
end)