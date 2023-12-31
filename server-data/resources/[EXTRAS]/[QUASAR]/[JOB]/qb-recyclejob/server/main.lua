QS = nil

TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)

local ItemTable = {
    "metalscrap",
    "plastic",
    "copper",
    "iron",
    "aluminum",
    "steel",
    "glass",
}

RegisterServerEvent("qb-recycle:server:getItem")
AddEventHandler("qb-recycle:server:getItem", function()
    local src = source
    local Player = QS.GetPlayerFromId(src)
    for i = 1, math.random(1, 5), 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        local amount = math.random(2, 6)
        Player.addItem(randItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QS.Shared.Items[randItem], 'add')
        Citizen.Wait(500)
    end

    local chance = math.random(1, 100)
    if chance < 7 then
        Player.addItem("cryptostick", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QS.Shared.Items["cryptostick"], "add")
    end

    local Luck = math.random(1, 10)
    local Odd = math.random(1, 10)
    if Luck == Odd then
        local random = math.random(1, 3)
        Player.addItem("rubber", random)
        TriggerClientEvent('inventory:client:ItemBox', src, QS.Shared.Items["rubber"], 'add')
    end
end)
