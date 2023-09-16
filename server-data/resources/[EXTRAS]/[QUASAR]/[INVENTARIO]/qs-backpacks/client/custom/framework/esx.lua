--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.
    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

ESX = exports['es_extended']:getSharedObject()

local firstTime = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

    if not firstTime then 
        firstTime = true
        print('ESX Backpacks Loading')
        Wait(10000)
        print('ESX Backpacks Loaded')
        StartThread()
    end
end)

Config.ESXSkinCallback = 'esx_skin:getPlayerSkin'
Config.SkinChanger = 'skinchanger:loadClothes'