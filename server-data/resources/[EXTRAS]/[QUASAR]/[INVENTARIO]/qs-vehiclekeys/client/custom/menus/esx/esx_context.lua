if Config.MenuType ~= 'esx_context' then
    return
end

if Config.Framework == 'qb' then
    return
end

function OpenCopyKeys()
    local elements = {}
    TriggerServerCallback(Config.Eventprefix..':server:getVehicles', function(vehicles)
        table.insert(elements, {
            title = Lang("VEHICLEKEYS_MENU_TITLE")
        })
        for _,v in pairs(vehicles) do
            local hashVehicule = v.vehicle.model
            local plate = v.vehicle.plate
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule) 
            table.insert(elements, {
                title = Lang("VEHICLEKEYS_MENU_MODEL").." " .. vehicleName .. " ".. Lang("VEHICLEKEYS_MENU_PLATE").." " .. plate , 
                name = "take",
                metadata = {vehicleName, plate}
            })
        end
        ESX.OpenContext("right" , elements, function(menu,element)
            if element.name == "take" then
                clonekey(element.metadata[2], element.metadata[1])
                ESX.CloseContext()
            end
        end, function(menu)
            ESX.CloseContext()
        end)
    end)
end

function OpenPlateMenu()
    local elements = {}
    table.insert(elements, {
        title = Lang("VEHICLEKEYS_MENU_BUY_PLATE")
    })
    table.insert(elements, {
        title = Lang("VEHICLEKEYS_MENU_BUY_PLATE_DESCRIPTION")..Config.NPCPlatePrice['price'],
        name = "take",
    })
    ESX.OpenContext("right" , elements, function(menu,element)
        if element.name == "take" then
            TriggerEvent(Config.Eventprefix..':buyPlate')
            ESX.CloseContext()
        end
    end, function(menu)
        ESX.CloseContext()
    end)
end