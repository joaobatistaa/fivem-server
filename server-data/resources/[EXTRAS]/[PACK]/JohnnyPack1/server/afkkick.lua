RegisterServerEvent('afk:getSteamID')
AddEventHandler('afk:getSteamID', function() -- source = the current player
  local steamid = GetPlayerIdentifiers(source)[1] -- 1 = the first element on the array which is the steamid
  TriggerClientEvent('afk:returnSteamID', source, steamid) -- return the steamid to the client side
end)

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "Foste expulso do servidor por inatividade.")
end)