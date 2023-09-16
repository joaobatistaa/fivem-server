Config = Config or {}
Locales = Locales or {}

--███████╗██████╗░░█████╗░███╗░░░███╗███████╗░██╗░░░░░░░██╗░█████╗░██████╗░██╗░░██╗
--██╔════╝██╔══██╗██╔══██╗████╗░████║██╔════╝░██║░░██╗░░██║██╔══██╗██╔══██╗██║░██╔╝
--█████╗░░██████╔╝███████║██╔████╔██║█████╗░░░╚██╗████╗██╔╝██║░░██║██████╔╝█████═╝░
--██╔══╝░░██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝░░░░████╔═████║░██║░░██║██╔══██╗██╔═██╗░
--██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║███████╗░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║██║░╚██╗
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝

Config.Framework = 'esx' -- You can choose between 'esx' or 'qb'.
Config.Language = 'pt' -- Available languages by default: 'es' or 'en', you can create more if you wish.

Config.InventoryScript = 'qs' -- 'qs', 'qb', 'core_inventory', 'ox'
Config.MenuType = 'esx_menu_default' -- 'ox_lib', 'esx_context', 'esx_menu_default', 'nh', 'qb'
Config.TextUI = 'Draw3DText' -- 'ox_lib', 'esx_textui', 'qb', 'okokTextUI', 'Draw3DText', 'ShowHelpNotification', 'ESXShowHelpNotification'

Config.EnableTarget = false -- Disable the blips and default menus event for menus : qs-vehiclekeys:client:targetEvent
Config.Target = {
    TargetName = 'ox', -- 'qb' (qb-target) | 'qt' (qtarget) |'ox' (ox_target)
    distance = 2.0 -- Distance
 }
Config.Eventprefix = 'qs-vehiclekeys'

--░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
--██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
--██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
--██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
--██████╔╝███████╗ ██║░╚███║███████╗██║░░██║██║░░██║███████╗
--░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

Config.AllVehiclesLocked = false -- Do you want all vehicles in the city to be blocked?
Config.EnableEngineControl = true -- Enable or disable the engine on/off system.
Config.EngineControlKey = 'G' -- Key to start or stop the engine.


--██╗░░██╗███████╗██╗░░░██╗░██████╗
--██║░██╔╝██╔════╝╚██╗░██╔╝██╔════╝
--█████═╝░█████╗░░░╚████╔╝░╚█████╗░
--██╔═██╗░██╔══╝░░░░╚██╔╝░░░╚═══██╗
--██║░╚██╗███████╗░░░██║░░░██████╔╝
--╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═════╝░

Config.VehicleKeysItem = 'vehiclekeys' -- Name of the item with metadata to open the vehicle.
Config.LockDistance = 20.0
Config.Anim = 'fob_click_fp' -- Modify the animation when opening or closing the vehicle here.
Config.Animdict = 'anim@mp_player_intmenu@key_fob@' -- Modify the animation when opening or closing the vehicle here.

Config.CopyKeysMenu = true --- If you want to use the esx getdistancebetweencoords menu, otherwhise you can make it work with qtarget, the function to open menu is OpenCopyKeys()
Config.OpenCopyKeys = 'E' -- Key to open the key copy menu.
Config.MenuPlacement = 'top-left' -- Position of `esx_menu_default`.
Config.CopyKeysCost = 5000 -- Price of the copies of the keys, you can use 0 and it will be free.
Config.CopyKeysLocations = { -- List of stores to copy keys.
	vector3(-32.08, -1646.53, 29.26),
	vector3(-32.08, -1546.53, 29.26)
}

Config.CopyKeysBlip = { -- Blip of the key copy spot.
	BlipName = 'Cópias das Chaves',
	BlipSprite = 186,
	BlipColour = 3,
	BlipScale = 0.8,
}


--██████╗░██╗░░░░░░█████╗░████████╗███████╗░██████╗
--██╔══██╗██║░░░░░██╔══██╗╚══██╔══╝██╔════╝██╔════╝
--██████╔╝██║░░░░░███████║░░░██║░░░█████╗░░╚█████╗░
--██╔═══╝░██║░░░░░██╔══██║░░░██║░░░██╔══╝░░░╚═══██╗
--██║░░░░░███████╗██║░░██║░░░██║░░░███████╗██████╔╝
--╚═╝░░░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═════╝░

Config.EnableItemPlate = true -- Do you want to use the `Config.PlateItem` item to change the plate?
Config.PlateItem = 'plate' -- Name of the item required to change the plate.
Config.PlateLetters = 3 -- Modify here the type of plate.
Config.PlateNumbers = 3 -- Modify here the type of plate.
Config.PlateUseSpace = true -- Modify here the type of plate.

Config.ChangePlateItem = 'lockpick'
Config.NPCSelling = false -- NPC sell a plate?
Config.NPCSSpawnPercentage = 100 --T here is a 50% chance if the NPC will spawn at every reset
Config.NpcName = 's_m_m_hairdress_01'
Config.NPCPlatePrice = {
    price = 5000,
    account = 'bank',
}
Config.NPCSellingHours = {
    OpenHour = 1, -- The NPC will spawn on 01:00 AM 
    CloseHour = 5 -- The NPC will despawn on 05:00 AM
}
Config.NPCLocations = {
    vec4(-29.0738, -1679.8884, 29.4611, 288.5123),
    vec4(-37.1002, -1688.1785, 29.3711, 116.3096),
    vec4(-48.2662, -1688.9725, 29.4345, 79.5225),
    vec4(-50.8639, -1680.9957, 29.4515, 13.9370)
}

--████████╗██╗░░██╗███████╗███████╗████████╗░██████╗
--╚══██╔══╝██║░░██║██╔════╝██╔════╝╚══██╔══╝██╔════╝
--░░░██║░░░███████║█████╗░░█████╗░░░░░██║░░░╚█████╗░
--░░░██║░░░██╔══██║██╔══╝░░██╔══╝░░░░░██║░░░░╚═══██╗
--░░░██║░░░██║░░██║███████╗██║░░░░░░░░██║░░░██████╔╝
--░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░

Config.StealVehiclesPeds = false -- If you enable this, players can target an NPC driver to receive their keys.
Config.StealVehiclesPedsPolice = 50 -- This is the chance for the NPC to call the police after being robbed (1-100).

Config.ReqPolice = false -- Do you want police in your city to enable robberies?
Config.ReqPoliceCount = 1 -- Minimum police to start a robbery.
Config.ReqJobPolice = 'police' -- Police job name.
Config.RefreshPolice = 1000 -- Ammount of time to check por police count again, higher for more performance, don't use below 1000ms.

Config.LockpickItem = 'carlockpick' -- Item required to start lockpicking.
Config.LockpickBrokenChance = 50 -- Chance of breaking your `Config.LockpickItem` item (1-100).
Config.LockpickFail = 50
Config.AdvancedLockpickItem = 'caradvancedlockpick' -- Don't need police to lockpick

Config.LockpickAlarm = true -- If you enable this option, the policemen will receive dispatch when the alarm sounds.
Config.StartAlarmChance = 50 -- Chance of the alarm going off, remember this will trigger dispatch to `Config.ReqJobPolice` (1-100).

Config.LockpickWhitelist = { -- This vehicles don't have hotwire
    'adder'
}


-- ███████╗███╗   ███╗ █████╗ ██████╗ ████████╗██████╗ ██╗  ██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔════╝████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║  ██║██╔═══██╗████╗  ██║██╔════╝
-- ███████╗██╔████╔██║███████║██████╔╝   ██║   ██████╔╝███████║██║   ██║██╔██╗ ██║█████╗  
-- ╚════██║██║╚██╔╝██║██╔══██║██╔══██╗   ██║   ██╔═══╝ ██╔══██║██║   ██║██║╚██╗██║██╔══╝  
-- ███████║██║ ╚═╝ ██║██║  ██║██║  ██║   ██║   ██║     ██║  ██║╚██████╔╝██║ ╚████║███████╗
-- ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                       
Config.Smartphone = true -- If you have qs-smartphone, you can enable this function.
Config.ChargeCommand = 'carregartelemovel' -- Command to load or unload your qs-smartphone.
Config.ChargeStatusCommand = 'bateria' -- Command to display or hide the battery percentage while charging.

--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗     ██████╗ ██████╗ ███╗   ██╗████████╗██████╗  ██████╗ ██╗     
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔═══██╗██║     
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗      ██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝██║   ██║██║     
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝      ██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██║   ██║██║     
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗    ╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║╚██████╔╝███████╗
--  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
                                                                                                                     
--[[  -- Ignore in developing
Config.OpenKeyMenu = 'F5'
Config.OpenCommandMenu = 'openveh'
Config.LabelCommand = 'Open Vehicle'
Config.CloseCommandMenu = 'closeveh' 
]]


--██████╗░██╗░██████╗██████╗░░█████╗░████████╗░█████╗░██╗░░██╗
--██╔══██╗██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║░░██║
--██║░░██║██║╚█████╗░██████╔╝███████║░░░██║░░░██║░░╚═╝███████║
--██║░░██║██║░╚═══██╗██╔═══╝░██╔══██║░░░██║░░░██║░░██╗██╔══██║
--██████╔╝██║██████╔╝██║░░░░░██║░░██║░░░██║░░░╚█████╔╝██║░░██║
--╚═════╝░╚═╝╚═════╝░╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝

RegisterNetEvent(Config.Eventprefix..':client:notifyCops', function(coords)
    if GetJobFramework() ~= nil and GetJobFramework().name == Config.ReqJobPolice then
        local transG = 300 * 2
        local blip = AddBlipForCoord(coords)
        local street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local street2 = GetStreetNameFromHashKey(street)

        if Config.Smartphone then
            TriggerServerEvent("vehiclekeys:server:phoneDispatch", coords, street2)
        else
            SendTextMessage(Lang("VEHICLEKEYS_NOTIFICATION_POLICE_DISPATCH").." "..street2, 'inform')
        end

        SetBlipSprite(blip, 161)
        SetBlipColour(blip, 3)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.5)
        SetBlipFlashes(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Lang("VEHICLEKEYS_NOTIFICATION_TITLE"))
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Citizen.Wait(500)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
	end
end)

Config.Debug = false -- If you want to see more about what happens internally in the script use true.