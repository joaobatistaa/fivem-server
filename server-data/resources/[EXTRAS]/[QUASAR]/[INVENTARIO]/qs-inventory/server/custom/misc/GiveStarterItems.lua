--[[  
    We recommend not modifying anything on this side, the Starter Items 
    are all in your server/custom/framework/esx.lua, it won't work in 
    qb-core since that framework has its native ones that do it automatically.
]]

RegisterServerEvent('inventory:server:GiveStarterItems')
AddEventHandler('inventory:server:GiveStarterItems', function()
    local src = source

    for k, v in pairs(StarterItems) do
        exports['qs-inventory']:AddItem(src, k, v)
    end
end)