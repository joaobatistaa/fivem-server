--[[ Functions ]]
function Luxu.GetPlayerFrameworkIdentifier(id)
      if Config.Framework == 'qb' then
            local player = type(id) == 'table' and id or QBCore.Functions.GetPlayer(id)
            if not player then return end
            return player.PlayerData.citizenid
      elseif Config.Framework == 'esx' then
            local player = type(id) == 'table' and id or ESX.GetPlayerFromId(id)
            if not player then return end
            return player.getIdentifier()
      end
end

function Luxu.KillPlayer(id)
      if id == nil then return end
      if not GetPlayerName(id) then return end
      lib.callback('LuxuModules:Client:KillSelf', id)
      return true
end

function Luxu.SetStatus(id, status, value)
      if Config.Framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(id)
            Player.Functions.SetMetaData(status, value)
            if status == 'hunger' or status == 'thirst' then
                  TriggerClientEvent('hud:client:UpdateNeeds', id, Player.PlayerData.metadata['hunger'],
                        Player.PlayerData.metadata['thirst'])
            end
      elseif Config.Framework == 'esx' then
            if value == 100 then
                  TriggerClientEvent('esx_status:set', id, status, 1000000)
            end
      end
end

function Luxu.RevivePlayer(id)
      if id == nil then return end
      if not GetPlayerName(id) then return end
      if Config.Wasabi_Ambulance then
            exports.wasabi_ambulance:RevivePlayer(id)
      elseif Config.Framework == 'qb' then
            TriggerClientEvent('hospital:client:Revive', id)
      elseif Config.Framework == 'esx' then
			TriggerClientEvent('esx_ambulancejob:revLoureivero', id)
      else
            lib.callback('LuxuModules:Client:ReviveSelf', id, nil)
      end
      return true
end

function Luxu.GetCharacterName(playerObj)
      if Config.Framework == 'qb' then
            local firstName = playerObj.PlayerData.charinfo.firstname
            local lastName  = playerObj.PlayerData.charinfo.lastname
            return string.format('%s %s', firstName, lastName)
      elseif Config.Framework == 'esx' then
            return playerObj.getName()
      end
end

function Luxu.GiveClothingMenu(id)
      if Config.illeniumAppearance then
            if Config.Framework == 'qb' then
                  TriggerClientEvent('qb-clothing:client:openMenu', id)
            elseif Config.Framework == 'esx' then
                  TriggerClientEvent('esx_skin:openSaveableMenu', id)
            end
      elseif Config.Framework == 'qb' then
            TriggerClientEvent('qb-clothing:client:openMenu', id)
      elseif Config.Framework == 'esx' then
            TriggerClientEvent('esx_skin:openSaveableMenu', id)
      end
end

function Luxu.GetOwnedVehicles(id)
      if Config.Framework == 'qb' then
            local playerObj = Luxu.GetPlayerObject(id)
            if not playerObj then return end
            local identifier = Luxu.GetFrameworkIdentifier(playerObj)

            local result = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = @citizenid', {
                  ['@citizenid'] = identifier
            })
            return result
      elseif Config.Framework == 'esx' then
            local playerObj = GetPlayerObject(id)
            if not playerObj then return end
            local identifier = Luxu.GetFrameworkIdentifier(playerObj)
            local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
                  ['@owner'] = identifier
            })
            return result
      end
end

function Luxu.GetPlayerAccounts(id)
      local playerObj = type(id) == 'table' and id or Luxu.GetPlayerObject(id)
      local data = {}
      if Config.Framework == 'qb' then
            local accounts = playerObj.PlayerData.money

            for k, v in pairs(accounts) do
                  table.insert(data, {
                        name = k,
                        money = v
                  })
            end
      elseif Config.Framework == 'esx' then
            local accounts = playerObj.getAccounts()

            for k, v in pairs(accounts) do
                  table.insert(data, {
                        name = v.name,
                        money = v.money
                  })
            end
      end
      return data
end

function Luxu.SetTime(hours, minutes)
      if Config.Framework == 'qb' then
            exports["qb-weathersync"]:setTime(hours, minutes)
      elseif Config.Framework == 'esx' then
            exports["Johnny_Sync"]:setTime(hours, minutes)
			--local data = {}
			--data.hours = hours
			--data.mins = minutes
			--TriggerClientEvent('cd_easytime:ForceUpdate', -1, data)
      end
      return true
end

function Luxu.SetWeather(weather)
      if Config.Framework == 'qb' then
            exports["qb-weathersync"]:setWeather(weather)
      elseif Config.Framework == 'esx' then
            exports["Johnny_Sync"]:setWeather(weather)
			--local data = {}
			--data.weather = weather
			--TriggerClientEvent('cd_easytime:ForceUpdate', -1, data)
      end
      return true
end

function Luxu.FreezeTime()
      local status
      if Config.Framework == 'qb' then
            --[[ QB ]]
            status = exports["qb-weathersync"]:setTimeFreeze();
      else
            --[[ ESX ]]
            status = exports["Johnny_Sync"]:setTimeFreeze();
      end
      return true, status
end

function Luxu.GiveVehicle(src, model)
      local playerObj = Luxu.GetPlayerObject(src)
      if not playerObj then return end

      local CarInfo = lib.callback.await('LuxuModules:Client:SpawnCarAndReturnInfo', src, model)


      if not CarInfo then return false end

      local identifier = Luxu.GetFrameworkIdentifier(playerObj)
      local result
      if Config.Framework == 'qb' then
            local license = playerObj.PlayerData.license
            result = MySQL.Sync.execute(
                  'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)'
                  , {
                        license,
                        identifier,
                        CarInfo.model,
                        CarInfo.modelHash,
                        json.encode(CarInfo.mods),
                        CarInfo.plate,
                        0
                  })
      elseif Config.Framework == 'esx' then
            result = MySQL.Sync.execute(
                  'INSERT INTO owned_vehicles (owner, plate, vehicle, identifier, type, model) VALUES (?, ?, ?, ?, ?, ?)'
                  , {
                        identifier,
                        CarInfo.plate,
                        json.encode({ model = CarInfo.modelHash, plate = CarInfo.plate }),
						identifier,
                        CarInfo.class,
                        CarInfo.model,
                  })
      end
      return result
end

function Luxu.SetAccountMoney(id, account, operation, amount)
      local playerObj = Luxu.GetPlayerObject(id)
      local accounts = Luxu.GetPlayerAccounts(id)
      local balance
      for _, v in ipairs(accounts) do
            if v.name == account then
                  balance = v.money
                  break
            end
      end
      if type(balance) ~= 'number' then return end
      if not playerObj then return end
      if Config.Framework == 'qb' then
            if operation == 'add' then
                  playerObj.Functions.AddMoney(account, amount)
            elseif operation == 'remove' then
                  playerObj.Functions.RemoveMoney(account, amount)
            elseif operation == 'set' then
                  playerObj.Functions.SetMoney(account, amount)
            end
      elseif Config.Framework == 'esx' then
            if operation == 'add' then
                  playerObj.addAccountMoney(account, amount)
            elseif operation == 'remove' then
                  playerObj.removeAccountMoney(account, amount)
            elseif operation == 'set' then
                  playerObj.setAccountMoney(account, amount)
            end
      end
      return true
end

function Luxu.GivePlayerItem(id, item, amount)
      local playerObj = type(id) == 'number' and Luxu.GetPlayerObject(id) or id
      if not playerObj then return end
      if Config.Framework == 'qb' then
            playerObj.Functions.AddItem(item, amount)
      elseif Config.Framework == 'esx' then
            playerObj.addInventoryItem(item, amount)
      end
      return true
end

function Luxu.SetPlayerJob(id, job, grade)
      local PlayerObj = type(id) == 'number' and Luxu.GetPlayerObject(id) or id
      if not PlayerObj then return end
      if Config.Framework == 'qb' then
            PlayerObj.Functions.SetJob(job, grade)
      elseif Config.Framework == 'esx' then
            if not ESX.DoesJobExist(job, grade) then return end
            PlayerObj.setJob(job, grade)
      end
      return true
end

function Luxu.ToggleJobDuty(id, mode)
      local PlayerObj = type(id) == 'number' and Luxu.GetPlayerObject(id) or id
      if not PlayerObj then return end
      if Config.Framework == 'qb' then
            Player.Functions.SetJobDuty(mode)
      elseif Config.Framework == 'esx' then
            --[[ Unknown ]]
      end
end

--[[ Events ]]
RegisterNetEvent('LuxuModules:Server:PlayerDied', function(_src)
      local src = _src or source
end)


--[[ Revive ❤️‍🩹 ]]
RegisterNetEvent('QBCore:Server:SetMetaData', function(meta, data)
      local src = source
      if meta == "inlaststand" or meta == 'isdead' then
            TriggerClientEvent('LuxuModules:Client:UpdateDeadStatus', src, data)
            if data == true then
                  TriggerEvent('LuxuModules:Server:PlayerDied', src)
            end
      end
end)

RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead)
      TriggerClientEvent('LuxuModules:Client:UpdateDeadStatus', source, isDead)
      if isDead then
            TriggerEvent('LuxuModules:Server:PlayerDied', source)
      end
end)
RegisterNetEvent('hospital:server:SetLaststandStatus', function(isDead)
      TriggerClientEvent('LuxuModules:Client:UpdateDeadStatus', source, isDead)
      if isDead then
            TriggerEvent('LuxuModules:Server:PlayerDied', source)
      end
end)