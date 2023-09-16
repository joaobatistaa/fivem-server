
local TargetScript 

Config.Target = false -- Enable/Disable target

if GetResourceState('ox_target') ~= 'missing' then
	TargetScript = 'ox'
end
if GetResourceState('qtarget') ~= 'missing' then
	TargetScript = 'qt'
end
if GetResourceState('qb-target') ~= 'missing' then
	TargetScript = 'qb'
end

Config.TargetScript = TargetScript

Config.listBooth = {
    1158960338,
    1511539537,
    1281992692,
    -429560270,
    -1559354806,
    -78626473,
    -2103798695,
    295857659,
}

function OpenTechMenu(crafter)
    if Config.TargetScript == 'ox' then 
        local options = {
            {
                name = 'qs:tech',
                label = 'Telephone Technician',
                icon = 'fa-solid fa-microchip',
                onSelect = function()
                    TriggerEvent("qs-smartphone:OpenTechMenu")
                end
            },
        }
         exports.ox_target:addLocalEntity(crafter, options)
    elseif Config.TargetScript == 'qb' then 
        exports['qb-target']:AddTargetEntity(crafter, { 
            options = {
                {
                    num = 1,
                    label = 'Telephone Technician',
                    icon = 'fa-solid fa-microchip',
                    action = function()
                        TriggerEvent("qs-smartphone:OpenTechMenu")
                    end,
                }
            },
            distance = 2.5,
        })  
    elseif Config.TargetScript == 'qt' then     
        exports.qtarget:AddTargetEntity(crafter, {
            options = {
                {
                    label = 'Telephone Technician',
                    icon = 'fa-solid fa-microchip',
                    action = function()
                        TriggerEvent("qs-smartphone:OpenTechMenu")
                    end
                }
            },
            distance = 2
        }) 
    end
end

function OpenBoothMenu()
    if Config.TargetScript == 'ox' then 
        local options = {
            {
                name = 'qs:booth',
                label = 'Telephone Booth',
                icon = 'fa-solid fa-phone',
                onSelect = function()
                    TriggerEvent("qs-smartphone:openBoothTarget")
                end
            },
        }
        exports.ox_target:addModel(Config.listBooth, options) 
    elseif Config.TargetScript == 'qb' then  
        exports['qb-target']:AddTargetModel(Config.listBooth, { 
            options = {
                {
                    num = 1,
                    label = 'Telephone Booth',
                    icon = 'fa-solid fa-phone',
                    action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                        TriggerEvent("qs-smartphone:openBoothTarget")
                    end,
                }
            },
            distance = 2.5,
        }) 
    elseif Config.TargetScript == 'qt' then  
        exports.qtarget:AddTargetModel(Config.listBooth, {
            options = {
                {
                    label = 'Telephone Booth',
                    icon = 'fa-solid fa-phone',
                    action = function()
                        TriggerEvent("qs-smartphone:openBoothTarget")
                    end
                }
            },
            distance = 1.0
        }) 
    end
end