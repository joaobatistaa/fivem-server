
--██████╗░██╗░██████╗██████╗░░█████╗░████████╗░█████╗░██╗░░██╗
--██╔══██╗██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║░░██║
--██║░░██║██║╚█████╗░██████╔╝███████║░░░██║░░░██║░░╚═╝███████║
--██║░░██║██║░╚═══██╗██╔═══╝░██╔══██║░░░██║░░░██║░░██╗██╔══██║
--██████╔╝██║██████╔╝██║░░░░░██║░░██║░░░██║░░░╚█████╔╝██║░░██║
--╚═════╝░╚═╝╚═════╝░╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝

RegisterNetEvent('warehouse:client:notifyCops')
AddEventHandler('warehouse:client:notifyCops', function(coords)
    if GetJobFramework() ~= nil and GetJobFramework().name == Config.ReqJobPolice then
        local transG = 300 * 2
        local blip = AddBlipForCoord(coords)
        local street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local street2 = GetStreetNameFromHashKey(street)

        if Config.Smartphone then
            TriggerServerEvent("warehouse:server:phoneDispatch", coords, street2)
        else
            SendTextMessage(Lang("WAREHOUSE_NOTIFICATION_POLICE_DISPATCH").." "..street2, 'inform')
        end

        SetBlipSprite(blip, 161)
        SetBlipColour(blip, 3)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.5)
        SetBlipFlashes(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Lang("WAREHOUSE_NOTIFICATION_TITLE"))
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(500)
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