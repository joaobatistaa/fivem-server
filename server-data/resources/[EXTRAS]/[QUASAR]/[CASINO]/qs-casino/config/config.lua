Config = {}

Config.getSharedObject = 'esx:getSharedObject'

Config.NotificationType = 'DrawText3D' -- 'ShowHelpNotification', 'DrawText3D' or 'disable'.

Config.CasinoShop = true
Config.CasinoNpcs = true
Config.CarOnShow = '718b'

Config.Ticket = 200000 -- cost ($) fo the lucky wheel ticket
Config.Account = 'money'

Config.TeleportsDistance = 5.0

Config.Teleports = {
    --Casino main door.
    {
        enter = {935.8365, 46.94, 81.09, 0}, -- enter
        exit = {1090.00, 207.00, -49.5, 358}, -- leave
    }, 
    --Casino to roof.
    {
        enter ={964.2912597, 58.9096641, 112.56, 52.36}, -- enter
        exit = {1085.69, 214.83, -49.5, 308.88}, -- leave
    },
    --Management to penthouse.
    {
        enter = {980.47, 56.66, 116.16, 51.23}, -- enter
        exit = {1119.46, 262.92, -51.5, 348.51}, -- leave
    },
    --Roof to penthouse.
    {
        enter = {967.2, 63.99, 112.55, 34.29}, -- enter
        exit = {969.62, 63.14, 112.0, 238.44}, -- leave
    },
}

Config.Locations = {
    cashier = vector3(1115.68, 219.96, -49.44),
}

Config.Blip = {
    {name="The Diamond Casino & Resort", id = 617, scale = 0.65, colour = 32, x = 961.3036, y = 41.50835, z = 75.74136}
}

Config.Marker = { 
    type = 2, 
    scale = {x = 0.2, y = 0.2, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 160},
    movement = 1 --Use 0 to disable movement
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