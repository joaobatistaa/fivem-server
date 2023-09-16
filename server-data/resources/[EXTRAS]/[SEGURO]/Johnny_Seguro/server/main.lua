Vehicles = {}
VehicleCategories = {}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

MySQL.ready(
    function()
        MySQL.Async.fetchAll(
            "SELECT * FROM vehicles WHERE 1 ",
            {},
            function(data)
                for _, v in ipairs(data) do
                    Vehicles[v.model] = v
                end
            end
        )
        MySQL.Async.fetchAll(
            "SELECT * FROM vehicle_categories WHERE 1 ",
            {},
            function(data)
                for _, v in ipairs(data) do
                    VehicleCategories[v.name] = v.label
                end
            end
        )
    end
)

ESX.RegisterServerCallback(
    "core_insurance:getOwnedVehicles",
    function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        MySQL.Async.fetchAll(
            "SELECT * FROM owned_vehicles WHERE owner = @identifier ",
            {["@identifier"] = xPlayer.identifier},
            function(data)
                if data then
                    local vehicles = {}

                    for _, v in ipairs(data) do
                        v.vehicle = json.decode(v.vehicle)

                        table.insert(vehicles, v)
                    end

                    cb(vehicles, Vehicles, VehicleCategories, os.time())
                end
            end
        )
    end
)

ESX.RegisterServerCallback(
    "core_insurance:payCredits",
    function(source, cb, credits)
        local xPlayer = ESX.GetPlayerFromId(source)

        MySQL.Async.fetchScalar(
            "SELECT `credits` FROM users WHERE identifier = @identifier",
            {["@identifier"] = xPlayer.identifier},
            function(amount)
                if tonumber(amount) >= credits then
                    MySQL.Async.execute(
                        "UPDATE `users` SET `credits`= `credits` - @credits WHERE `identifier` = @identifier",
                        {["@credits"] = credits, ["@identifier"] = xPlayer.identifier},
                        function()
                            TriggerClientEvent("core_insurance:SendTextMessage", source, Config.Text["credits_updated"], 'info')
                            cb(true)
                        end
                    )
                else
                    TriggerClientEvent("core_insurance:SendTextMessage", source, Config.Text["not_enough_credits"], 'error')
                    cb(false)
                end
            end
        )
    end
)

ESX.RegisterServerCallback(
    "core_insurance:payFranchise",
    function(source, cb, franchise)
        local xPlayer = ESX.GetPlayerFromId(source)

        if franchise > 0 then
            if xPlayer.getAccount("bank").money >= franchise then
                xPlayer.removeAccountMoney("bank", franchise)
                cb(true)
            else
                TriggerClientEvent("core_insurance:SendTextMessage", source, Config.Text["not_enough_money"], 'error')
                cb(false)
            end
        else
            cb(true)
        end
    end
)

ESX.RegisterServerCallback(
    "core_insurance:payInsurance",
    function(source, cb, price)
        local xPlayer = ESX.GetPlayerFromId(source)

        if price > 0 then
            if xPlayer.getAccount("bank").money >= price then
                xPlayer.removeAccountMoney("bank", price)
                cb(true)
            else
                TriggerClientEvent("core_insurance:SendTextMessage", source, Config.Text["inverval_payment_error"], 'error')

                cb(false)
            end
        else
            cb(true)
        end
    end
)

RegisterServerEvent("core_insurance:removePlan")
AddEventHandler(
    "core_insurance:removePlan",
    function(plate)
        local src = source

        MySQL.Async.execute(
            "UPDATE `owned_vehicles` SET `insurance`= @plan WHERE `plate` = @plate",
            {["@plan"] = "none", ["@plate"] = plate},
            function()
            end
        )
    end
)

RegisterServerEvent("core_insurance:changePlan")
AddEventHandler(
    "core_insurance:changePlan",
    function(plate, plan)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        local planInfo = Config.InsurancePlans[plan]

        if planInfo.oneTimePrice > 0 then
            if xPlayer.getAccount("bank").money < planInfo.oneTimePrice then
                TriggerClientEvent("core_insurance:SendTextMessage", src, Config.Text["not_enough_money"], 'error')
                return
            else
                xPlayer.removeAccountMoney("bank", planInfo.oneTimePrice)
            end
        end

        MySQL.Async.execute(
            "UPDATE `owned_vehicles` SET `insurance`= @plan WHERE `plate` = @plate",
            {["@plan"] = plan, ["@plate"] = plate},
            function()
                TriggerClientEvent("core_insurance:SendTextMessage", src, Config.Text["plan_changed"], 'success')
            end
        )
    end
)

RegisterServerEvent("core_insurance:setCooldown")
AddEventHandler(
    "core_insurance:setCooldown",
    function(plate, time)
        local cooldown = os.time() + time

        MySQL.Async.execute(
            "UPDATE `owned_vehicles` SET `cooldown`= @cooldown WHERE `plate` = @plate",
            {["@cooldown"] = cooldown, ["@plate"] = plate},
            function()
            end
        )
    end
)