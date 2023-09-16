if Config.MenuType ~= 'esx_menu_default' then
    return
end

if Config.Framework == 'qb' then
    return
end

function OpenCopyKeys()
    local elements = {}
    TriggerServerCallback(Config.Eventprefix..':server:getVehicles', function(vehicles)
        for _,v in pairs(vehicles) do
            local hashVehicule = v.vehicle.model
            local plate = v.vehicle.plate
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule) 
            table.insert(elements, {label = Lang("VEHICLEKEYS_MENU_MODEL").." " .. vehicleName .. " ".. Lang("VEHICLEKEYS_MENU_PLATE").." " .. plate , value = v})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
            title = Lang("VEHICLEKEYS_MENU_TITLE"),
            align = Config.MenuPlacement,
            elements = elements
        }, function(data, menu)
            if (data.current.value) then
                menu.close()
                open = false
                clonekey(data.current.value.vehicle.plate, GetDisplayNameFromVehicleModel(data.current.value.vehicle.model))
            end
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenPlateMenu()
    local elements = {}
    table.insert(elements, {
        label = Lang("VEHICLEKEYS_MENU_BUY_PLATE_DESCRIPTION")..Config.NPCPlatePrice['price'],
        value = 'buyNormal'
    })
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
        title = Lang("VEHICLEKEYS_MENU_TITLE_PLATE"),
        align = Config.MenuPlacement,
        elements = elements
    }, function(data, menu)
        if data.current.value == 'buyNormal' then
            menu.close()
            TriggerEvent(Config.Eventprefix..':buyPlate')
        elseif data.current.value == 'buyNormal' then

        elseif data.current.value == 'buyNormal' then
            
        end
    end, function(data, menu)
        menu.close()
    end)
end