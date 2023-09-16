-- OX inventory
if Config.InventoryScript ~= 'ox' then
    return 
end

local ox_inventory = exports.ox_inventory
exports('useKey', function(data, slot) 
    ox_inventory:useItem(data, function(data)
        if data then
            TriggerEvent(Config.Eventprefix..':client:UseKey', data.metadata.plate, data.metadata.model)
        end
    end)
end)

exports('usePate', function(data, slot) 
    ox_inventory:useItem(data, function(data)
        if data then
            TriggerEvent(Config.Eventprefix..':client:UsePlate', data.metadata.plate)
        end
    end)
end)