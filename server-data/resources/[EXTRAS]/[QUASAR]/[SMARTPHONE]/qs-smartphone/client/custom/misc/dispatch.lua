RegisterNetEvent('qs-smartphone:client:CustomClientDispatch', function(data, sender)

    --[[     
        data.phone   return the job 
        data.message return the message 
        data.type    return the type of message
        sender       return the sender of message
    ]]
 
    --[[ 
        local dispatch = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {data.phone}, -- Data of job
            coords = dispatch.coords,
            title = '10-15 - Phone Dispatch',
            message = data.message, -- Data of messages
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 431, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = data.message,
                time = (5*60*1000),
                sound = 1,
            }
        })  
    ]]
end)