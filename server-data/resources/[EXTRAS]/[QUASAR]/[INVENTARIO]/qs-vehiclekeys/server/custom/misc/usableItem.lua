if Config.InventoryScript == 'ox' then
    return
end

RegisterUsableItem(Config.LockpickItem, function(source)
    local src = source
    TriggerClientEvent(Config.Eventprefix..":client:useLockpick", src, false)
end)

RegisterUsableItem(Config.AdvancedLockpickItem, function(source)
    local src = source
    TriggerClientEvent(Config.Eventprefix..":client:useLockpick", src, true)
end)

RegisterUsableItem(Config.VehicleKeysItem, function(source, item)
    local plate = item.info.plate
    local model = item.info.description
    TriggerClientEvent(Config.Eventprefix..':client:UseKey', source, plate, model)
end)