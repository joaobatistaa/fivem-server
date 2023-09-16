function ExtractIdentifiers(src)
    
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

local logs = "https://discord.com/api/webhooks/1078127871249358929/wv4ZuGJ-whCsFbx72tYKWxy4RBIoGE7e4_6cjVinExq8dQEj35Nn8PKsj51ECceowbcH"

local kick_msg = "Foste banido permanentemente por: Ban Automático por Atividade Suspeita. Abre ticket caso penses que seja um erro"
local discord_msg = '`O jogador tentou usar o nui_devtools`\n`e foi banido permanentemente`\n`ANTI NUI_DEVTOOLS`'
local color_msg = 16767235

function sendToDiscord(source,message,color,identifier)
    local _source = source
    local name = GetPlayerName(_source)
	
    if not color then
        color = color_msg
    end
    local sendD = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = "`Jogador`: **"..name.."**\nSteam: **"..identifier.steam.."** \nIP: **"..identifier.ip.."**\nDiscord: **"..identifier.discord.."**\nFivem: **"..identifier.license.."**",
            ["footer"] = {
                ["text"] = "WorldTuga RP - "..os.date("%x %X %p")
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "WorldTuga RP - Anti nui_devtools", embeds = sendD}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent(GetCurrentResourceName())
AddEventHandler(GetCurrentResourceName(), function()
    local _source = source
    local identifier = ExtractIdentifiers(_source)
    local identifierDb
    if extendedVersionV1Final then
        identifierDb = identifier.license
    else
        identifierDb = identifier.steam
    end
    if checkmethod == 'steam' then
		if json.encode(allowlist) == "[]" then
			TriggerEvent('BanSql:nuiBlocker', _source)
			--DropPlayer(_source, kick_msg)
			sendToDiscord (_source, discord_msg, color_msg, identifier)		
		end
		for _, v in pairs(allowlist) do
			if v ~= identifierDb then
				TriggerEvent('BanSql:nuiBlocker', _source)
				--DropPlayer(_source, kick_msg)
				sendToDiscord (_source, discord_msg, color_msg, identifier)
			end
        end
	elseif checkmethod == 'SQL' then
        MySQL.Async.fetchAll("SELECT group FROM users WHERE identifier = @identifier",{['@identifier'] = identifierDb }, function(results) 
            if results[1].group ~= 'admin' or 'superadmin' then
				sendToDiscord (_source, discord_msg, color_msg,identifier)
				DropPlayer(_source, kick_msg)
            end
        end)
	end
end)