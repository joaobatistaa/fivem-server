local frameworkObject = false
playerkill = false
timeFinish = false

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    while not response do
      Citizen.Wait(0)
     end
    Citizen.Wait(500)
    SendNUIMessage({
      action = 'KEYBIND',
      key = Config.KeyControl
    })
    SendNUIMessage ({
      action = 'LOCALE',
      locale = Config.Locale
    })
end)


RegisterNUICallback('GetResponse', function(data, cb)
    response = true
end)


RegisterNUICallback('timeEnable', function(data)
  timeFinish = true
end)

-- RegisterCommand('kill',function()
--   ApplyDamageToPed(PlayerPedId(), 200, 0)
-- end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
         if playerkill and IsControlJustPressed(0, Config.KeyControl.giveup.key) then
              if timeFinish then
                TriggerEvent('codem-deathscreen:giveup')
              else
                SendNUIMessage({
                  action = 'NOTIFY',
                  message =  Config.Locale['EXPRIED']
                })
              end
         elseif  playerkill and  IsControlJustPressed(0, Config.KeyControl.waitdoctor.key) then
            TriggerEvent('codem-deathscreen:waitDoctor')
         end
    end
end)

  

AddEventHandler('esx:onPlayerDeath', function(data)
  local DeathReason, Killer, DeathCauseHash, Weapon
   local wait = 1000
   local playerPed = PlayerPedId()
     local PedKiller = GetPedSourceOfDeath(GetPlayerPed(PlayerId()))
     local killername = GetPlayerName(PedKiller)
     DeathCauseHash = GetPedCauseOfDeath(GetPlayerPed(PlayerId()))
     Weapon = WeaponNames[tostring(DeathCauseHash)]

     if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
       Killer = NetworkGetPlayerIndexFromPed(PedKiller)
     elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
       Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
     end
     if (Killer == PlayerId()) then
       DeathReason = 'committed suicide'
     elseif (Killer == nil) then
       DeathReason = 'died'
     else
       DeathReason = getKillerLabel(DeathCauseHash)
     end


     if DeathReason == 'committed suicide' or DeathReason == 'died' then
       TriggerServerEvent('playerDied',0,DeathReason,Weapon)
     
     else
       TriggerServerEvent('playerDied',GetPlayerServerId(Killer),DeathReason,Weapon)
     
     end
   Killer = nil
   DeathReason = nil
   DeathCauseHash = nil
   Weapon = nil

end)

RegisterNetEvent('codem-deathscreen:revive')
AddEventHandler('codem-deathscreen:revive',function()
  SendNUIMessage({
    action = 'OPEN_MENU',
    death = false,
  })
end)

RegisterNetEvent('codem-deathscreen:clientData')
AddEventHandler('codem-deathscreen:clientData', function(time,reason,weapon)

    playerkill = true
    timeFinish = false  
    SendNUIMessage({
        action = 'OPEN_MENU',
        death = true,
        timer = time,
        giveuptime = tonumber(Config.GiveUpTime * 60000),
        reason = reason,
        weapon = weapon
    })

end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SendNUIMessage({
            action = "send_response",
            resourceName = GetCurrentResourceName()
        })
        if response then

            return
        end
    end
end)




