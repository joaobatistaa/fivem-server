AddEventHandler('casino_luckywheel:getLucky', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local ticket = xPlayer.getInventoryItem(Config.CasinoTicket).count
    if not isRoll then
        if xPlayer ~= nil then
            if ticket >= 1 then
                -- Spin the wheel.
                xPlayer.removeInventoryItem(Config.CasinoTicket, 1)
                isRoll = true
                local randomNumber = math.random(1,100)
                TriggerClientEvent("casino_luckywheel:doRoll", -1, randomNumber)

				SetTimeout(2000, function()
                    isRoll = false
                    if randomNumber == 1 then -- WIN VEHICLE

                        TriggerClientEvent("casino_luckywheel:winCar", _source)
                        TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("PRIZE_CAR"), 'success')

                    elseif randomNumber > 1 and randomNumber <= 5 then 

                        xPlayer.addInventoryItem("casino_chips", 70000)
                        xPlayer.addInventoryItem("casino_ticket", 1)
                        TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("PRIZE_1"), 'success')

                    elseif randomNumber > 5 and randomNumber <= 10 then

                        xPlayer.addInventoryItem("casino_chips", 100000)
                        TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("PRIZE_2"), 'success')

                    elseif randomNumber > 10 and randomNumber <= 15 then

                        xPlayer.addInventoryItem("casino_chips", 140000)
                        TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("PRIZE_3"), 'success')

                    elseif randomNumber > 15 and randomNumber <= 20 then

                        xPlayer.addInventoryItem("casino_chips", 200000)
                        TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("PRIZE_4"), 'success')

                    elseif randomNumber > 20 and randomNumber <= 25 then

                        xPlayer.addInventoryItem("casino_chips", 300000)
                        TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("PRIZE_5"), 'success')

                    elseif randomNumber > 25 then

                        TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("TRY_AGAIN"), 'error')

                    end
                    TriggerClientEvent("casino_luckywheel:rollFinished", -1)
                end)                
            else
                TriggerClientEvent("casino_luckywheel:rollFinished", -1)
				TriggerClientEvent("qs-luckywheel:sendMessage", _source, Lang("NO_TICKETS"), 'error')
            end
        end
    end
end)