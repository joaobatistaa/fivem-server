--[[ 
    Configurable company system, you can create multiple files
    and adapt them to your company system, these are the ones we recommend
    that we bring by default, but you can integrate others.

    Enable Config.Debug to be able to see the log inside DebugPrint.
]]

if Config.Society ~= "esx_society" then
    return
end

for societyName, _ in pairs(Config.Realestatejob) do
    local name = 'society_'..societyName
    TriggerEvent('esx_society:registerSociety', societyName, 'Remax', name, name, name, {type = 'public'})
end  

function buyHouseSocietyMoney(src, societyName, societyPaid)
    TriggerClientEvent('housing:esx_society', src, societyName, societyPaid)
end