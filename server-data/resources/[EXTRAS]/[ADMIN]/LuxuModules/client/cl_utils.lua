--[[ Functions ]]
function Luxu.GetFrameworkObject()
      local prom = promise.new()

      if not FrameworkObj then while not FrameworkObj do Wait(0) end end
      prom:resolve(FrameworkObj)

      return Citizen.Await(prom)
end

function Luxu.Notify(data)
      local msg = data.msg
      local appearance = data.type
      local duration = data.duration
      if not appearance then appearance = 'info' end
      if Config.okokNotify then
            if appearance == 'primary' then appearance = 'info' end
            exports['Johnny_Notificacoes']:Alert("Menu Admin", msg, duration or 5000, appearance, true)
      elseif Config.Framework == 'qb' then
            QBCore.Functions.Notify(msg, appearance, duration or 5000)
      elseif Config.Framework == 'esx' then
            if appearance == 'primary' then appearance = 'info' end
            ESX.ShowNotification(msg, duration or 5000, appearance)
      end
end

function Luxu.ShowTextUI()

end

function Luxu.HealSelf()
      local ped = PlayerPedId()
      SetEntityMaxHealth(ped, 200)
      SetEntityHealth(ped, 200)
      ClearPedBloodDamage(ped)
      SetPlayerSprint(ped, true)
      ResetPedMovementClipset(ped, 0.0)
end

function Luxu.KillSelf()
      SetEntityHealth(PlayerPedId(), 0)
end

function Luxu.GodMode(mode)
      SetEntityInvincible(PlayerPedId(), mode)
end

function Luxu.GetVehicleModList(vehicle)
      if Config.Framework == 'qb' then
            return QBCore.Functions.GetVehicleProperties(vehicle)
      elseif Config.Framework == 'esx' then
            return ESX.Game.GetVehicleProperties(vehicle)
      end
end

function Luxu.ReloadSkin()
      local model

      local function loadPlayerSkin(gender)
            if gender == 1 then
                  model = `mp_f_freemode_01` -- Female Model
            else
                  model = `mp_m_freemode_01` -- Male Model
            end

            RequestModel(model)
            while not HasModelLoaded(model) do
                  Wait(1)
            end
            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
      end

      if Config.illeniumAppearance then
            TriggerEvent('illenium-appearance:client:reloadSkin')
      elseif Config.Framework == 'qb' then
            -- QB Core
            local playerData = QBCore.Functions.GetPlayerData()
            if not playerData.charinfo.gender then
                  return
            end

            loadPlayerSkin(playerData.charinfo.gender)
            TriggerServerEvent("qb-clothes:loadPlayerSkin")
            Wait(2000)
      else
            -- ESX
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                  local isMale = skin.sex == 0
                  TriggerEvent('skinchanger:loadDefaultModel', isMale)
                  Wait(250)
                  TriggerEvent('skinchanger:loadSkin', skin)
                  Wait(100)
            end)
      end
end

function Luxu.OpenInventory(target)
      if Config.OxInventory then
            local command = string.format('viewinv %s', target)
            ExecuteCommand(command)
            exports.ox_inventory:openInventory('player', target)
      elseif Config.QuasarInventory then
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", target)
      elseif Config.Framework == 'qb' then
            TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', target)
      else
            TriggerServerEvent('esx_inventoryhud:openPlayerInventory', target)
      end
end

--[[ Vehicle Keys  ]]
function Luxu.GiveVehicleKeys(veh)
      local vehicle = veh
      if not vehicle then
            vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
      end
      if vehicle == 0 or vehicle == nil then return end
      local plate = Luxu.GetVehiclePlate(vehicle)

      if Config.Wasabi_CarLock then
            exports.wasabi_carlock:GiveKeys(plate, false)
      elseif Config.Framework == 'qb' then
            TriggerEvent("vehiclekeys:client:SetOwner", plate)
      elseif Config.Framework == 'esx' then
		local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
		exports['qs-vehiclekeys']:GiveKeys(plate, model)
		exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Recebeste as chaves do veículo!</span>", 5000, 'success')
      end
      return true
end

--[[ Events ]]
--[[ Revive ❤️‍🩹 ]]
RegisterNetEvent('playerSpawned', function()
      IsDead = false
end)

RegisterNetEvent('LuxuModules:ApperanceChanger', function()
      if Config.illeniumAppearance then
            exports['fivem-appearance']:startPlayerCustomization(function(appearance)
                  if (appearance) then
                        TriggerServerEvent('saveCharacterCustomization', JSON.encode(appearance))
                  end
            end)
      end
end)