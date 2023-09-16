RegisterNetEvent('qs-smartphone:sever:CustomServerDispatch', function(data, sender)
    --[[ 
        data.phone   return the job 
        data.message return the message 
        data.type    return the type of message
        sender       return the ID of sender
    ]]
    
    --[[ 
        Example of cd_dispatch
        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = {data.phone},
            coords = vector3(0, 0, 0),
            title = '10-15 - Store Robbery',
            message = data.message,
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