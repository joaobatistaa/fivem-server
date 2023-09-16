if Config.MenuType ~= 'nh' then
    return
end

if Config.Framework == 'esx' then
    return
end

function OpenCopyKeys()
    local elements = {}
    TriggerServerCallback(Config.Eventprefix..':server:getVehicles', function(vehicles)
        table.insert(elements, {
            header  = Lang("VEHICLEKEYS_MENU_TITLE")
        })
        for _,v in pairs(vehicles) do
            table.insert(elements, {
                header = Lang("VEHICLEKEYS_MENU_MODEL").." " .. QBCore.Shared.Vehicles[v.vehicle]['name'] .. " ".. Lang("VEHICLEKEYS_MENU_PLATE").." " .. v.plate , 
                event  = Config.Eventprefix..':client:cloneVehicles',
                args = {
                    v.plate,
                    QBCore.Shared.Vehicles[v.vehicle]['model']
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