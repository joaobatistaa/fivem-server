function GetFrameworkObject()
    local object = nil
    if Config.Framework == "esx" then
        object = exports['es_extended']:getSharedObject()
    end
    if Config.Framework == "newqb" then
        object = exports["qb-core"]:GetCoreObject()
    end
    if Config.Framework == "oldqb" then
        while object == nil do
            TriggerEvent('QBCore:GetObject', function(obj)object = obj end)
            Citizen.Wait(200)
        end
    end
    return object
end
