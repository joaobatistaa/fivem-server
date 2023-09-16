if Config.MenuType ~= 'ox_lib' then
    return
end
if Config.Framework == 'esx' then
    return
end


function OpenCopyKeys()
    local elements = {}
    if not lib then print('You need to uncomment the ox_lib export on line 10 of fxmanifest.lua') return end 
    TriggerServerCallback(Config.Eventprefix..':server:getVehicles', function(vehicles)
        for _,v in pairs(vehicles) do
            table.insert(elements, {
                title  = Lang("VEHICLEKEYS_MENU_MODEL").." " .. QBCore.Shared.Vehicles[v.vehicle]['name'] .. ", ".. Lang("VEHICLEKEYS_MENU_PLATE").." " .. v.plate , 
                icon = 'home',
                onSelect = function(args)
                    clonekey(v.plate, QBCore.Shared.Vehicles[v.vehicle]['model'])
                end,
            })
        end
        lib.registerContext({
            id = 'VEHICLEKEYS_MENU_TITLE',
            title = Lang("VEHICLEKEYS_MENU_TITLE"),
            options = elements,
        })
        lib.showContext('VEHICLEKEYS_MENU_TITLE')
    end)
end

function OpenPlateMenu()
    local elements = {}
    if not lib then print('You need to uncomment the ox_lib export on line 10 of fxmanifest.lua') return end 
    table.insert(elements, {
        title  = Lang("VEHICLEKEYS_MENU_BUY_PLATE_DESCRIPTION")..Config.NPCPlatePrice['price'],
        icon = 'home',
        onSelect = function(args)
            TriggerEvent(Config.Eventprefix..':buyPlate')
        end,
    })
    lib.registerContext({
        id = 'VEHICLEKEYS_MENU_TITLE_PLATE',
        title = Lang("VEHICLEKEYS_MENU_TITLE_PLATE"),
        options = elements,
    })
    lib.showContext('VEHICLEKEYS_MENU_TITLE')
end