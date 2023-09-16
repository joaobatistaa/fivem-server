--░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
--██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
--██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
--██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
--╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
--░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

Config = {}

Config.EnableRobbery = false -- Enable/Disable steals, this increases performance consumption.
Config.ReqPoliceCount = 3 -- Minimum police to start a robbery.
Config.ReqJobPolice = 'police' -- Police job name.
Config.RefreshPolice = 2000 -- Ammount of time to check por police count again, higher for more performance, don't use below 2000ms.
Config.Smartphone = true

Config.LockpickItem = 'lockpick' -- Name of the item needed for the robbery.
Config.LockpickBrokenChance = 80 -- Chances of breaking the item to steal.

Config.Inventory = { -- Inventory stash space and slots.
    maxweight = 1000000,
    slots = 100,
}

Config.DistanceCoords = 10.0 -- View distance of DrawText3D.
Config.Warehouse = { -- You can add more warehouse.
    --[1] = {x = -1565.45, y = -231.24, z = 49.47, h = 200.16, type = "keypad"},
    --[2] = {x = -12.76, y = -1429.16, z = 31.10, h = 200.16, type = "keypad"},
    --[3] = {x = 2432.38, y = 4971.81, z = 42.34, h = 200.16, type = "keypad"},
    --[4] = {x = 100.09, y = 53.79, z = 73.51, h = 200.16, type = "keypad"},
   -- [5] = {x = 563.41, y = -3127.03, z = 18.77, h = 200.16, type = "keypad"},
    --[6] = {x = 1407.18, y = 1127.92, z = 114.33, h = 200.16, type = "keypad"},
}

Config.WarehouseCodes = { -- You can add as many pins here.
    --[1] = 1743,
    --[2] = 1982,
    --[3] = 7234,
    --[4] = 9182,
    --[5] = 1834,
    --[6] = 8437,
   -- [7] = 5173,
}


--██╗░░░██╗██╗░██████╗██╗░░░██╗░█████╗░██╗░░░░░  ░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░
--██║░░░██║██║██╔════╝██║░░░██║██╔══██╗██║░░░░░  ██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░
--╚██╗░██╔╝██║╚█████╗░██║░░░██║███████║██║░░░░░  ██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░
--░╚████╔╝░██║░╚═══██╗██║░░░██║██╔══██║██║░░░░░  ██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗
--░░╚██╔╝░░██║██████╔╝╚██████╔╝██║░░██║███████╗  ╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝
--░░░╚═╝░░░╚═╝╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝  ░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░

function SendTextMessage(msg, type) --You can add your notification system here for simple messages.
    if type == 'inform' then 
        --SetNotificationTextEntry('STRING')
        --AddTextComponentString(msg)
        --DrawNotification(0,1)
    
        --MORE EXAMPLES OF NOTIFICATIONS.
        exports['qs-core']:Notify(msg, "primary")
        --exports['mythic_notify']:DoHudText('inform', msg)
    end
    if type == 'error' then 
        --SetNotificationTextEntry('STRING')
        --AddTextComponentString(msg)
        --DrawNotification(0,1)
    
        --MORE EXAMPLES OF NOTIFICATIONS.
        exports['qs-core']:Notify(msg, "error")
        --exports['mythic_notify']:DoHudText('error', msg)
    end
    if type == 'success' then 
        --SetNotificationTextEntry('STRING')
        --AddTextComponentString(msg)
        --DrawNotification(0,1)
    
        --MORE EXAMPLES OF NOTIFICATIONS.
        exports['qs-core']:Notify(msg, "success")
        --exports['mythic_notify']:DoHudText('success', msg)
    end
end

function DrawText3D(x, y, z, text) -- If you use different characters in your language, you can modify the DrawText3D here.
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry('STRING')
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x, y, z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end