-- CONFIG --

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 1200

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

local dontkick = { -- declare your steamid below
  "steam:110000115708986", -- Johnny
	"steam:1100001470baaf7", -- JJesus
	"steam:11000010b53f4e3", -- Tesouras
	"steam:1100001467293b6", -- Brunoje
	"steam:110000112c0e5e4", -- Teixeira
	"steam:11000011be465f3", -- Cavalinho
}
local whitelisted = nil

-- CODE --

local function checkIfWhitelisted(steamid)

  for _, v in ipairs(dontkick) do -- looping through the dontkick array
    if v == steamid then -- if match
      --print("You are now whitelisted")
      return true -- a  return will stop from looping further since you've already got what you wanted
    end
  end -- if the loop ends = no match
  --print("Not whitelisted")
  return false
end

RegisterNetEvent("afk:returnSteamID")
AddEventHandler("afk:returnSteamID", function(steamid) -- return steamid client side
  whitelisted = checkIfWhitelisted(steamid)
end)

CreateThread(function()
  TriggerServerEvent("afk:getSteamID")
  if whitelisted == nil then
    Wait(1000) -- important since events are asynchrone, under 1000ms, the script may continue before even getting the steamid
  end
  if not whitelisted then -- same as 'if whitelist == false then'
    while true do
      --print('AFK active')
      Wait(1000)
      playerPed = GetPlayerPed(-1)
      if playerPed then
        currentPos = GetEntityCoords(playerPed, true)
        if currentPos == prevPos then
          if time > 0 then
            if kickWarning and time == math.ceil(secondsUntilKick / 4) then
				--TriggerEvent("chatMessage", "AVISO", {255, 0, 0}, "^1Vais ser expulso em " .. time .. " segundos por estares AFK!")
				exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'>Vais ser expulso em <span style='color:#fff'>".. time .." segundos</span> por estares AFK!", 10000, 'info')
			end
            time = time - 1
          else
            TriggerServerEvent("kickForBeingAnAFKDouchebag")
          end
        else
          time = secondsUntilKick
        end
        prevPos = currentPos
      end
    end
  end
end)
