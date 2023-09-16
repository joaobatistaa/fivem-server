Config = {}

Config.getSharedObject = "esx:getSharedObject" --Modify it if you use an ESX Custom.


Config.esx_vehicleshopsetVehicleOwned = "d3x_vehicleshop:setVehicleOwned" -- esx_vehicleshop event to set an owner for a vehicle
Config.esx_vehicleshopisPlateTaken = "d3x_vehicleshop:isPlateTaken"

Config.CarModel = '718b'

Config.CasinoTicket = 'casino_ticket'

Config.NotificationType = 'DrawText3D' -- 'ShowHelpNotification', 'DrawText3D' or 'disable'.

Config.Marker = { --Modify the Shop marker as you like.
    type = 2, 
    scale = {x = 0.2, y = 0.2, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 120},
    movement = 1 --Use 0 to disable movement.
}

function SendTextMessage(msg, type) --You can add your notification system here for simple messages.
    if type == 'inform' then 
        --QS.Notification("inform", msg)
        exports['mythic_notify']:DoHudText('inform', msg)
    end
    if type == 'error' then 
        --QS.Notification("error", msg)
        exports['mythic_notify']:DoHudText('error', msg)
    end
    if type == 'success' then 
        --QS.Notification("success", msg)
        exports['mythic_notify']:DoHudText('success', msg)
    end
end

DrawText3D = function (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end