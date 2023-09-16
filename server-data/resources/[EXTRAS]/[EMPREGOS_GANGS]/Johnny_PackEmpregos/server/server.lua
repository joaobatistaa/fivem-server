ESX = nil

ESX = exports['es_extended']:getSharedObject()

function sendToDiscordEmpregos(data)
	DiscordWebHook = "https://discord.com/api/webhooks/1078116445868806234/SXEKBI0eYwQQp7i42h5rwhlV9oasVlxiLFyByz-6eeO-EJoqcdFjffYFGXjfgWoiJfas"
	
	if data.emprego ~= nil and data.pagamento ~= nil and data.playerid ~= nil and data.identifier ~= nil and data.playername ~= nil and data.discord ~= nil then
		local information = {
			{
				["color"] = '65352',
				["author"] = {
					["icon_url"] = '',
					["name"] = 'Johnny Logs',
				},
				["title"] = 'NOVO PAGAMENTO - EMPREGO: '..data.emprego,
				["description"] = '**Emprego:** '..data.emprego..'\n**Pagamento:** '..data.pagamento..'\n\n**ID:** '..data.playerid..'\n**SteamID:** '..data.identifier..'\n**Nome da Steam:** '..data.playername..'\n**Discord:** '..data.discord,
				["footer"] = {
					["text"] = os.date('%d/%m/%Y [%X]'),
				}
			}
		}
		PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = 'WTRP Logs', embeds = information}), {['Content-Type'] = 'application/json'})
	end
end

function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)
		
        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end