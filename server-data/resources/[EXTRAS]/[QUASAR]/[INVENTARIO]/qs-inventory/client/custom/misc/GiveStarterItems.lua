--[[  
    We recommend not modifying anything on this side, the Starter Items 
    are all in your server/custom/framework/esx.lua, it won't work in 
    qb-core since that framework has its native ones that do it automatically.
]]

AddEventHandler('inventory:client:GiveStarterItems', function()
    local id = PlayerId()
    TriggerServerEvent('inventory:server:GiveStarterItems', id)
end)