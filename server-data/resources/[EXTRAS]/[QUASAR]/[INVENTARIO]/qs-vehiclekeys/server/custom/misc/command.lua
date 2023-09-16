if Config.Framework == 'esx' then
    ESX.RegisterCommand(Lang("ADMINCOMMAND_COMMAND"), Lang("ADMINCOMMAND_RANGE"), function(xPlayer, args, showError)
        if args.playerId then 
            local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source), false)
            local plate = GetVehicleNumberPlateText(PedVehicle)
            local model = GetEntityModel(PedVehicle)

            if DoesEntityExist(PedVehicle) then
                TriggerClientEvent(Config.Eventprefix..":client:sendMessage", xPlayer.source, Lang("ADMINCOMMAND_GIVED_VEHICLE"), "success")
                args.playerId.triggerEvent(Config.Eventprefix..":admin:giveKeys", plate, model)
            else
                TriggerClientEvent(Config.Eventprefix..":client:sendMessage", src, Lang("ADMINCOMMAND_NO_VEHICLE"), "error")
            end
        else
            TriggerClientEvent(Config.Eventprefix..":client:sendMessage", xPlayer.source, Lang("ADMINCOMMAND_NO_PLAYER"), "success")
        end
    end, false, {help = Lang("ADMINCOMMAND_HELP"), validate = true, arguments = {
        {name = 'playerId', validate = true, help = Lang("ADMINCOMMAND_PLAYER"), type = 'player'}
    }})
    
elseif Config.Framework == 'qb' then
    QBCore.Commands.Add(Lang("ADMINCOMMAND_COMMAND"), Lang("ADMINCOMMAND_HELP"), { { name = Lang("ADMINCOMMAND_PLAYER"), help = Lang("ADMINCOMMAND_PLAYER") } }, true, function(source, args)
        local target = tonumber(args[1])
        if target ~= 0 then
            local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
            local plate = GetVehicleNumberPlateText(PedVehicle)
            local model = GetEntityModel(PedVehicle)
    
            if DoesEntityExist(PedVehicle) then
                TriggerClientEvent(Config.Eventprefix..":client:sendMessage", source, Lang("ADMINCOMMAND_GIVED_VEHICLE"), "success")
                TriggerClientEvent(Config.Eventprefix..":admin:giveKeys", target, plate, model)
            else
                TriggerClientEvent(Config.Eventprefix..":client:sendMessage", source, Lang("ADMINCOMMAND_NO_VEHICLE"), "error")
            end
        else
            TriggerClientEvent(Config.Eventprefix..":client:sendMessage", source, Lang("ADMINCOMMAND_NO_PLAYER"), "success")
        end
    end, Lang("ADMINCOMMAND_RANGE"))
end