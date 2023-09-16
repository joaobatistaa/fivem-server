local openingDoor = false
local lockpicking = false

function LockpickDoor(isAdvanced)
    local vehicle = GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 2.0 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus >= 1) then
                local lockpickTime = math.random(15000, 30000)
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime*0.5)
                end
                LockpickDoorAnim(lockpickTime)
                TriggerEvent('lockpick:client:openLockpick', lockpickFinish)
                -- or 
                -- TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
                sHotwiring = true
            end
        end
    end
end

function LockpickDoorAnim(time)
    local ped = PlayerPedId()
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function lockpickFinish(success)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle()
    local driver = GetPedInVehicleSeat(vehicle, -1)
    if success then 
        if math.random(1, 100) <= Config.LockpickFail then
            finishLockpick = true
            print('finishLockpick', finishLockpick)
            TriggerServerEvent(Config.Eventprefix..':server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 1)
            StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            SendTextMessage(Lang("VEHICLEKEYS_NOTIFICATION_LOCKPICK_SUCCESS"), 'success')
            PlayVehicleDoorOpenSound(vehicle, 0)
            TriggerServerEvent(Config.Eventprefix..':server:notifyCops', coords)  
    
            if Config.LockpickAlarm then if math.random(1, 100) < Config.StartAlarmChance then startAlarm(vehicle) end end
            if math.random(1, 100) < Config.LockpickBrokenChance then
                SendTextMessage(Lang("VEHICLEKEYS_NOTIFICATION_LOCKPICK_BROKEN"), 'error')
                TriggerServerEvent(Config.Eventprefix..":server:RemoveLockpick", Config.LockpickItem, 1)
                if Config.Debug then
                    TriggerServerEvent(Config.Eventprefix..':server:serverLog', '[qs-vehiclekeys] A lockpick attempt failed on: '..coords)
                end
            end
            finishLockpick = true
            openingDoor = false
            IsHotwiring = false
            Wait(20000)
            finishLockpick = false
        else
            openingDoor = false
            IsHotwiring = false
            StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            SendTextMessage(Lang("VEHICLEKEYS_NOTIFICATION_LOCKPICK_FAIL"), 'error')
            PlayVehicleDoorOpenSound(vehicle, 0)
            startAlarm(vehicle)
            TriggerServerEvent(Config.Eventprefix..':server:notifyCops', coords) 
        end
    else
        openingDoor = false
        IsHotwiring = false
        StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
        SendTextMessage(Lang("VEHICLEKEYS_NOTIFICATION_LOCKPICK_FAIL"), 'error')
        PlayVehicleDoorOpenSound(vehicle, 0)
        startAlarm(vehicle)
        TriggerServerEvent(Config.Eventprefix..':server:notifyCops', coords) 
    end
end