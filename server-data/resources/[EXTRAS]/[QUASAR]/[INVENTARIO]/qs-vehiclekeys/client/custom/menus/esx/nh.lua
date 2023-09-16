if Config.MenuType ~= 'nh' then
    return
end

if Config.Framework == 'qb' then
    return
end

function OpenCopyKeys()
    local elements = {}
    TriggerServerCallback(Config.Eventprefix..':server:getVehicles', function(vehicles)
        table.insert(elements, {
            header  = Lang("VEHICLEKEYS_MENU_TITLE")
        })
        for _,v in pairs(vehicles) do
            local hashVehicule = v.vehicle.model
            local plate = v.vehicle.plate
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule) 
            table.insert(elements, {
                header = Lang("VEHICLEKEYS_MENU_MODEL").." " .. vehicleName .. " ".. Lang("VEHICLEKEYS_MENU_PLATE").." " .. plate , 
                event  = Config.Eventprefix..':client:cloneVehicles',
                args = {
                    plate,
                    vehicleName
                }
            })
        end
        TriggerEvent(nh_trigger, elements)
    end)
end

function OpenPlateMenu()
    local elements = {}
    table.insert(elements, {
        header  = Lang("VEHICLEKEYS_MENU_BUY_PLATE")
    }) 
    table.insert(elements, {
        header = Lang("VEHICLEKEYS_MENU_BUY_PLATE_DESCRIPTION")..Config.NPCPlatePrice['price'],
        event  = Config.Eventprefix..':buyPlate',
    })
    TriggerEvent(nh_trigger, elements)
end