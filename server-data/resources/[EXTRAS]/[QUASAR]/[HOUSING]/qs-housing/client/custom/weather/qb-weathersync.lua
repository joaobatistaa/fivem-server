--[[ 
    Here you have the weather tyme configuration, you can modify it or even 
    create your own! In case your inventory is not here, you can ask the 
    creator to create a file following this example and add it!
]]

if Config.Weather ~= "qb-weathersync" then
    return
end

RegisterNetEvent("housing:client:weatherSync")
AddEventHandler("housing:client:weatherSync", function(bool)
    if bool then
        Citizen.Wait(150)
        TriggerEvent('qb-weathersync:client:DisableSync') 
        NetworkOverrideClockTime(20, 0, 0) -- 20:00 time inside the house
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist("CLEAR")
        SetWeatherTypeNow("CLEAR")
        SetWeatherTypeNowPersist("CLEAR")
        DebugPrint('O clima foi alterado para CLEAR porque estás num interior.')
    else
        Citizen.Wait(150)
        TriggerEvent('qb-weathersync:client:EnableSync')
        DebugPrint('O tempo foi sincronizado com o servidor pois já saiste do interior.')
    end
end)