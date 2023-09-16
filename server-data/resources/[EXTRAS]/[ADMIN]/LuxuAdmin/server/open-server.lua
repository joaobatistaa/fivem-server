RegisterNetEvent('LuxuAdmin:Server:SaveCar', function(mods, veh, _, plate)
      local src = source
      if Config.Framework == 'qb' then
            --[[ QB ]]
            local Player = QBCore.Functions.GetPlayer(src)
            local result = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
            if result[1] == nil then
                  MySQL.insert(
                        'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)'
                        , {
                              Player.PlayerData.license,
                              Player.PlayerData.citizenid,
                              veh.model,
                              veh.hash,
                              json.encode(mods),
                              plate,
                              0
                        })
                  Notify(src, "success.success_vehicle_owner", 'success', 5000)
            else
                  Notify(src, "error.failed_vehicle_owner", 'error', 3000)
            end
            --[[ ESX ]]
      else
            local category = 'car'
            --[[ find category ]]
            for model, vehicle in pairs(VehiclesInfo) do
                  if model == veh.model then
                        category = vehicle.category
                        break
                  end
            end

            local xPlayer = ESX.GetPlayerFromId(src)
            local plate = mods.plate
            MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type, model, identifier) VALUES (?, ?, ?, ?, ?, ?)'
            , {
                  xPlayer.getIdentifier(),
                  plate,
                  json.encode({ model = GetHashKey(veh.model), plate = plate }),
                  category,
                  veh.model,
				  xPlayer.getIdentifier(),
            })
      end

      local name = GetPlayerName(src)
      local targetName = GetPlayerName(target_src)
      DiscordLog(GetPlayerIdentifiers(src), string.format('**%s** used **Slap** on **%s**', name, targetName))
end)

RegisterNetEvent('LuxuAdmin:server:GiveFoodAndWater', function(player)
      local src = source
      if not HasPermission(src, 'luxuadmin.givefoodandwater') then return end
      local targetName = GetPlayerName(player)
      if not targetName then return end
      local name = GetPlayerName(src)
      Luxu.SetStatus(player, 'hunger', 100)
      SetTimeout(500, function()
            Luxu.SetStatus(player, 'thirst', 100)
      end)
      DiscordLog(GetPlayerIdentifiers(src),
            string.format('**%s** gave food and water to **%s**', name, targetName))
end)

RegisterNetEvent('LuxuAdmin:Server:ControlPlayer', function(targetplayersrc, isControlingPlayer)
      local src = source
      if not HasPermission(src, 'luxuadmin.controlplayer') then return end
      if src == targetplayersrc then return end -- check if trying to control self
      local targetPed = GetPlayerPed(targetplayersrc)
      local target_coords = GetEntityCoords(targetPed)
      if isControlingPlayer == false then
            TriggerClientEvent('LuxuAdmin:SpectateControl', targetplayersrc, target_coords)
            TriggerClientEvent('LuxuAdmin:ReloadSkin', src)
            return
      end

      local adminPed = GetPlayerPed(src)


      if Config.Framework == 'qb' then
            local Player = QBCore.Functions.GetPlayer(targetplayersrc)
            local result = MySQL.Sync.fetchAll('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?',
                  { Player.PlayerData.citizenid, 1 })
            if result[1] ~= nil then
                  TriggerClientEvent("qb-clothes:loadSkin", src, false, result[1].model, result[1].skin)
            else
                  TriggerClientEvent("qb-clothes:loadSkin", src, true)
            end
      elseif Config.Framework == 'esx' then
            local xPlayer = ESX.GetPlayerFromId(targetplayersrc)
            local result = MySQL.Sync.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
                  ['@identifier'] = xPlayer.identifier
            })
            if result[1] ~= nil then
                  local skin = json.decode(result[1].skin)
                  local isMale
                  if skin.sex == 0 then isMale = true else isMale = false end
                  CreateThread(function()
                        --[[ TriggerClientEvent('skinchanger:loadDefaultModel', src, isMale) ]]
                        -- not safe
                        Wait(250)
                        TriggerClientEvent('skinchanger:loadSkin', src, skin)
                  end)
            end
      end
      --[[ Log ]]
      local name = GetPlayerName(src)
      local targetName = GetPlayerName(targetplayersrc)
      DiscordLog(GetPlayerIdentifiers(src),
            string.format('**%s** used control player on %s', name, targetName))

      SetEntityCoords(adminPed, target_coords)
      TriggerClientEvent('LuxuAdmin:SpectateControl', targetplayersrc, src, target_coords)
end)

RegisterNetEvent('LuxuAdmin:server:deletePlayerVeh', function(data)
      local src = source
      if not HasPermission(src, 'luxuadmin.deleteplayerveh') then return end
      local target_ped = GetPlayerPed(data and data.src or src)
      local vehicle = GetVehiclePedIsIn(target_ped, false)
      if vehicle ~= 0 then
            DeleteEntity(vehicle)
      end
      --[[ Log ]]
      local name = GetPlayerName(src)
      local targetName = GetPlayerName(data and data.src or src)
      DiscordLog(GetPlayerIdentifiers(src),
            string.format('**%s** destroyed vehicle of %s', name, targetName))
end)


local PossibleSeats = { -1, 0, 1, 2, 3, 4, 5, 6, }
RegisterNetEvent('LuxuAdmin:Server:DeleteUnusedVehicles', function()
      local src = source
      if not HasPermission(src, 'luxuadmin.deleteunusedvehs') then return end
      CreateThread(function()
            local vehicles = GetAllVehicles()
            for _, vehicle in ipairs(vehicles) do
                  local isVehicleUsed = false
                  for _, seat in ipairs(PossibleSeats) do
                        local ped = GetPedInVehicleSeat(vehicle, seat)
                        if ped ~= 0 then
                              isVehicleUsed = true
                              break
                        end
                  end
                  if not isVehicleUsed then DeleteEntity(vehicle) end
            end
      end)
      --[[ Log ]]
      local name = GetPlayerName(src)
      DiscordLog(GetPlayerIdentifiers(src),
            string.format('**%s** Deleted all unused vehicles', name))
end)

RegisterServerEvent("WorldTuga:BanThisCheater", function(source, reason)
    local source = source

    local loadFile= LoadResourceFile(GetCurrentResourceName(), "database/banlist.json")
	local decode = json.decode(loadFile)
	local license
	local steam
	local licensas = {}
	
	for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
		end
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steam = v
		end
		table.insert(licensas, v)
      end
	  
	local try = {
	{
		["name"] = "Licensa",
		["value"] = license,
		["inline"] = true,
	},{
		["name"] = "SteamID",
		["value"] = steam,
		["inline"] = true,
	},{
		["name"] = "Nome",
		["value"] = GetPlayerName(source),
		["inline"] = true,
	},{
		["name"] = "ID Atual",
		["value"] = source,
		["inline"] = true,
	},{
		["name"] = "Razão",
		["value"] = reason,
		["inline"] = true,
	},{
		["name"] = "Tempo",
		["value"] = "Permanente",
		["inline"] = true,
	},{
		["name"] = "Dado por:",
		["value"] = "AntiCheat",
		["inline"] = true,
	},{
		["name"] = "Script:",
		["value"] = GetCurrentResourceName(),
		["inline"] = true,
	}
}
	
	TriggerEvent("CreateLog", "bans", "WorldTuga | Bans", "**Jogador Banido.**", "red", "WorldTuga Logs", true, try)
	
	table.insert(decode, {license = license, name = GetPlayerName(source), date = os.time(os.date('*t')), expiration = -1, reason = reason, givenby = "Anticheat", identifiers = licensas})
	SaveResourceFile(GetCurrentResourceName(), "database/banlist.json", json.encode(decode), -1)
	DropPlayer(source, reason)
end)

local Webhooks = {
    ["bans"] = "https://discord.com/api/webhooks/1078117029791404042/2u_TJ2Fr319WSaXf1_2b-uBfbQAL8Qk80OtjyI4sOQ141RZ1Tp1ms9kD8uZfqcPijkRG",
}

local Colors = {
    ["default"] = 16711680,
    ["blue"] = 25087,
    ["green"] = 762640,
    ["white"] = 16777215,
    ["black"] = 0,
    ["orange"] = 16743168,
    ["lightgreen"] = 65309,
    ["yellow"] = 15335168,
    ["turqois"] = 62207,
    ["pink"] = 16711900,
    ["red"] = 16711680,
}



RegisterServerEvent("CreateLog", function(name, botName, title, color, message, tagEveryone, fields)
	    local embedData
    local tag = tagEveryone ~= nil and tagEveryone or false
    local webHook = Webhooks[name] ~= nil and Webhooks[name] or Webhooks["default"]
    if fields == nil then
        embedData = {
            {
                ["title"] = title,
                ["color"] = Colors[color] ~= nil and Colors[color] or Colors["default"],
                ["footer"] = {
                    ["text"] = os.date("%c"),
                },
                ["description"] = message,
            }
        }
    else
        embedData = {
            {
                ["title"] = title,
                ["color"] = Colors[color] ~= nil and Colors[color] or Colors["default"],
                ["fields"] = fields,
                ["footer"] = {
                    ["text"] = message.. " " ..os.date("%d-%m-%Y %X"),
                },
            }
        }
    end
	PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = botName, embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = botName, content = "@everyone"}), { ['Content-Type'] = 'application/json' })
    end
end
