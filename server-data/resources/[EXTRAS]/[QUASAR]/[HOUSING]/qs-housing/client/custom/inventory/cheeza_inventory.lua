--[[ 
    Here you have the configuration of stashes, you can modify it or even 
    create your own! In case your inventory is not here, you can ask the 
    creator to create a file following this example and add it!
]]

if Config.Inventory ~= "cheeza_inventory" then
    return
end

function HousingStash(id, other, mlo)
    TriggerEvent('inventory:openHouse', "HouseStash", id, "House", other.weight)
end

--[[ 
    Furniture stash system, choose your own weight and slots!
]]

ObjectStash = {}