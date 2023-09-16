if Config.MenuType ~= 'qb' then
    return
end

if Config.Framework == 'esx' then
    return
end

function OpenCopyKeys()
    local elements = {}
    TriggerServerCallback(Config.Eventprefix..':server:getVehicles', function(vehicles)
        table.insert(elements, {
            isMenuHeader  = true,
            header = Lang("VEHICLEKEYS_MENU_TITLE"),
            icon = 'fa-solid fa-infinity'
        })
        for k,v in pairs(vehicles) do -- loop through our table
            if not v.vehicle or not QBCore.Shared.Vehicles[v.vehicle]['name'] then
                return print('Missing vehicle:', v.vehicle, 'QBShared : ', QBCore.Shared.Vehicles[v.vehicle]['name'])
            end
            if not v.plate then
                return print('Missing plate :', v.plate, ' Vehicle : ', v.vehicle)
            end
            table.insert(elements, {
                header = Lang("VEHICLEKEYS_MENU_MODEL").." " ..QBCore.Shared.Vehicles[v.vehicle]['name'].. " ",
                txt = Lang("VEHICLEKEYS_MENU_PLATE").." " .. v.plate,
                icon = 'fa-solid fa-face-grin-tears',
                params = {
                    event = Config.Eventprefix..':client:cloneVehicles',
                    args = {
                        plate = v.plate,
                        model = QBCore.Shared.Vehicles[v.vehicle]['model']
                    }
                }
            })
        end
        exports[qb_menu_name]:openMenu(elements) -- open our menu
    end)
end

function OpenPlateMenu()
    local elements = {}
    table.insert(elements, {
        isHeader = true,
        header = Lang("VEHICLEKEYS_MENU_TITLE_PLATE"),
        icon = 'fa-solid fa-infinity'
    })
    table.insert(elements, { 
        header = Lang("VEHICLEKEYS_MENU_BUY_PLATE"),
        txt = Lang("VEHICLEKEYS_MENU_BUY_PLATE_DESCRIPTION")..Config.NPCPlatePrice['price'],
        icon = 'fa-solid fa-face-grin-tears',
        params = {
            event = Config.Eventprefix..':buyPlate',
        }
    })
    exports[qb_menu_name]:openMenu(elements)
end