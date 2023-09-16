ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local disableNotifications = false
local disableNotificationSounds = false
RegisterNetEvent('dispatch:toggleNotifications')
AddEventHandler('dispatch:toggleNotifications', function(state)
    state = tostring(state)
    if state == "on" then
        disableNotifications = false
        disableNotificationSounds = false
        exports['mythic_notify']:DoHudText('azul', 'Alertas ativados')
    elseif state == "off" then
        disableNotifications = true
        disableNotificationSounds = true
        exports['mythic_notify']:DoHudText('azul', 'Alertas desativados')
    elseif state == "mute" then
        disableNotifications = false
        disableNotificationSounds = true
		exports['mythic_notify']:DoHudText('azul', 'Sons de alertas desativados')
    else
		exports['mythic_notify']:DoHudText('azul', 'Opções Válidas: on/off/mute')
    end
end)

local function randomizeBlipLocation(pOrigin)
  local x = pOrigin.x
  local y = pOrigin.y
  local z = pOrigin.z
  local luck = math.random(2)
  y = math.random(25) + y
  if luck == 1 then
      x = math.random(25) + x
  end
  return {x = x, y = y, z = z}
end

RegisterCommand('clearblips', function()
  TriggerEvent('clearJobBlips')
end)

RegisterNetEvent('dispatch:clNotify')
AddEventHandler('dispatch:clNotify', function(pNotificationData)
  if pNotificationData ~= nil then
    while PlayerData == nil do
		PlayerData = ESX.GetPlayerData()
		Citizen.Wait(500)
	end
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' then --or ESX.GetPlayerData().job.name == 'ambulance' then
        if not disableNotifications then
          if pNotificationData.origin ~= nil then
            if pNotificationData.originStatic == nil or not pNotificationData.originStatic then
                pNotificationData.origin = randomizeBlipLocation(pNotificationData.origin)
                else
                  pNotificationData.origin = pNotificationData.origin
                end
            end
            SendNUIMessage({
              mId = "notification",
              eData = pNotificationData
            })
        end
      end
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if (IsControlJustReleased(0, 121) and (PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj' or PlayerData.job.name == 'police')) then--or PlayerData.job.name == 'ambulance' then
			showDispatchLog = not showDispatchLog
            SetNuiFocus(showDispatchLog, showDispatchLog)
            SetNuiFocusKeepInput(showDispatchLog)
            SendNUIMessage({
                mId = "showDispatchLog",
                eData = showDispatchLog
            })
        end
        if showDispatchLog then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 142, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(0, 47, true) -- disable weapon
            DisableControlAction(0, 58, true) -- disable weapon
            DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
        end
    end
end)

RegisterNUICallback('setGPSMarker', function(data, cb)
  SetNewWaypoint(data.gpsMarkerLocation.x, data.gpsMarkerLocation.y)
  exports['mythic_notify']:DoHudText('azul', 'Waypoint marcado')
end)

RegisterNUICallback('disableGui', function(data, cb)
  showDispatchLog = not showDispatchLog
  SetNuiFocus(showDispatchLog, showDispatchLog)
  SetNuiFocusKeepInput(showDispatchLog)
end)

RegisterNetEvent('alert:noPedCheck')
AddEventHandler('alert:noPedCheck', function(alertType)
  if alertType == "banktruck" then
    AlertBankTruck()
  end
end)

function GetStreetAndZone()
  local plyPos = GetEntityCoords(PlayerPedId(), true)
  local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
  local street1 = GetStreetNameFromHashKey(s1)
  local street2 = GetStreetNameFromHashKey(s2)
  local zone = GetLabelText(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
  local street = street1 .. ", " .. zone
  return street
end


local function uuid()
    math.randomseed(GetCloudTimeAsInt())
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

RegisterNetEvent('civilian:alertPolice')
AddEventHandler("civilian:alertPolice",function(basedistance,alertType,objPassed,isGunshot,isSpeeder)

    local job = PlayerData.job.name
    local pd = false
    if job == "police" or job == "sheriff" then
        pd = true
    end

    local object = objPassed

    if not daytime then
      basedistance = basedistance * 8.2
    else
      basedistance = basedistance * 3.45
    end

    if isGunshot == nil then 
      isGunshot = false 
    end

    Citizen.Wait(math.random(5000))

    if (alertType == "gunshot" or alertType == "gunshotvehicle") then
      AlertGunShot()
    end

    if alertType == "robberyhouse" and not (PlayerData.job.name == 'police' or PlayerData.job.name == 'pj' or PlayerData.job.name == 'sheriff') then
      AlertCheckRobbery2()
    end
end)

tasksIdle = {
  [1] = "CODE_HUMAN_MEDIC_KNEEL",
  [2] = "WORLD_HUMAN_STAND_MOBILE",
}

function AlertGunShot()
    Citizen.CreateThread(function() 
      local street1 = GetStreetAndZone()
      local gender = IsPedMale(PlayerPedId())
      local plyPos = GetEntityCoords(PlayerPedId())
  
      local initialTenCode = '10-13'
      local eventId = uuid()
      Wait(math.random(5000))
      -- if PlayerData.job.name == 'police' then	
      TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = initialTenCode,
        firstStreet = street1,
        gender = gender,
        isImportant = false,
        priority = 1,
        eventId = eventId,
        origin = {
          x = plyPos.x,
          y = plyPos.y,
          z = plyPos.z
        },
        dispatchMessage = "Tiros Disparados",
      })
      TriggerEvent('ym-outlawalert:gunshotInProgress')
      Wait(math.random(3000,5000))
        -- end
  end)
end


function AlertJewelRob()
  local street1 = GetStreetAndZone()
  local gender = IsPedMale(PlayerPedId())
  local plyPos = GetEntityCoords(PlayerPedId())
  local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
  local dispatchCode = "10-90"
  local eventId = uuid()
  if PlayerData.job.name == 'police' or PlayerData.job.name == 'pj' then
  TriggerServerEvent('dispatch:svNotify', {
    dispatchCode = dispatchCode,
    firstStreet = street1,
    gender = gender,
    eventId = eventId,
    isImportant = true,
    priority = 1,
    dispatchMessage = "Vangelico Robbery In Progress",
    origin = {
      x = plyPos.x,
      y = plyPos.y,
      z = plyPos.z
    }
  })
  
  TriggerEvent('ym-alerts:jewelrobbey')
  Wait(math.random(5000,15000))

  if math.random(1,10) > 3 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
    plyPos = GetEntityCoords(PlayerPedId())
    vehicleData = GetVehicleDescription() or {}
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'pj' then
    TriggerServerEvent('dispatch:svNotify', {
      dispatchCode = 'CarFleeing',
      relatedCode = dispatchCode,
      firstStreet = street1,
      gender = gender,
      model = vehicleData.model,
      plate = vehicleData.plate,
      firstColor = vehicleData.firstColor,
      secondColor = vehicleData.secondColor,
      heading = vehicleData.heading,
      eventId = eventId,
      isImportant = true,
      priority = 1,
      origin = {
        x = plyPos.x,
        y = plyPos.y,
        z = plyPos.z
      }
    })
    TriggerEvent('ym-alerts:jewelrobbey')
  end
end
  end
end

function AlertFleecaRobbery()
  local street1 = GetStreetAndZone()
  local gender = IsPedMale(PlayerPedId())
  local plyPos = GetEntityCoords(PlayerPedId())
  local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
  local dispatchCode = "10-90"
  local eventId = uuid()
  if PlayerData.job.name == 'police' or PlayerData.job.name == 'pj' then
  TriggerServerEvent('dispatch:svNotify', {
    dispatchCode = dispatchCode,
    firstStreet = street1,
    gender = gender,
    eventId = eventId,
    isImportant = true,
    priority = 1,
    dispatchMessage = "Fleeca Robbery",
    origin = {
      x = plyPos.x,
      y = plyPos.y,
      z = plyPos.z
    }
  })
  
  Wait(math.random(5000,15000))

  if math.random(1,10) > 3 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
    plyPos = GetEntityCoords(PlayerPedId())
    vehicleData = GetVehicleDescription() or {}
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'pj' then
    TriggerServerEvent('dispatch:svNotify', {
      dispatchCode = 'CarFleeing',
      relatedCode = dispatchCode,
      firstStreet = street1,
      gender = gender,
      model = vehicleData.model,
      plate = vehicleData.plate,
      firstColor = vehicleData.firstColor,
      secondColor = vehicleData.secondColor,
      heading = vehicleData.heading,
      eventId = eventId,
      isImportant = true,
      priority = 1,
      origin = {
        x = plyPos.x,
        y = plyPos.y,
        z = plyPos.z
      }
    })
  end
end
  end
end

RegisterNetEvent('ym-dispatch:bankrobbery')
AddEventHandler("ym-dispatch:bankrobbery",function()
  AlertFleecaRobbery()
end)

RegisterNetEvent('ym-dispatch:jewelrobbery')
AddEventHandler("ym-dispatch:jewelrobbery",function()
  AlertJewelRob()
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
      if IsControlPressed(0, 21) and IsControlJustReleased(0, 174) and (PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj') then
        TriggerEvent('police:panic1')
      end
      if IsControlPressed(0, 21) and IsControlJustReleased(0,  173) and (PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj') then
       TriggerEvent('police:panic2')
      end
      if IsControlPressed(0, 21) and IsControlJustReleased(1,  175) and (PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj') then
        TriggerEvent('police:panic3')
      end
      if IsControlPressed(0, 21) and IsControlJustReleased(1,  27) and (PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'pj') then
        TriggerEvent('police:panic99')
      end	  
  end
end)