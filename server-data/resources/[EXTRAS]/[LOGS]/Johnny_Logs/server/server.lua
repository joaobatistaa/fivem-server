local time = os.date("%d/%m/%Y %X")

--[[
Config.green              = 56108
Config.grey               = 8421504
Config.red                = 16711680
Config.orange             = 16744192
Config.blue               = 2061822
Config.purple             = 11750815

--]]

function sendToDiscord(title, msg, webhook, cor)
    local embed = {}
	local color = 'azul'
	
	if cor == 'verde' then
		color = 56108
	elseif cor == 'vermelho' then	
		color = 16711680
	elseif cor == 'roxo' then	
		color = 11750815
	elseif cor == 'azul' then	
		color = 2061822
	elseif cor == 'laranja' then	
		color = 16744192
	elseif cor == 'cinzento' then	
		color = 8421504
	else
		color = 2061822
	end
	
    embed = {
        {
            ["color"] = color,
            ["title"] = "**".. title .."**",
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "Made by Johnny73-",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Johnny Logs", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

-- TROCA DE NOME --

playerTracker = {}

function GetAllPlayers()
    local players = {}

    for _, i in ipairs(GetPlayers()) do
        table.insert(players, i)    
    end

    return players
end

AddEventHandler('playerConnecting', function(playerName, deferrals)
    local src = source 
    local ip = ExtractIdentifiers(src).ip 
    if playerTracker[ip] ~= nil then 
        if playerTracker[ip] ~= GetPlayerName(src) then 
            sendToDiscord('ALERTA', "O jogador __**" .. GetPlayerName(src) .. "**__ trocou de nome da steam!!!! Último nome: __**" ..playerTracker[ip] .. "**__ (FASE BETA)", DiscordWebhookTrocaNome, 'laranja')
        end
    end 
    playerTracker[ip] = GetPlayerName(src)
end)


-- System Infos
sendToDiscord("SERVIDOR ONLINE", "O servidor iniciou e está agora online!\n ```css\n["..time.."]\n```", DiscordWebhookSystemInfos, 'azul')
--PerformHttpRequest(DiscordWebhookSystemInfos, function(err, text, headers) end, 'POST', json.encode({username = "Logs WorldTuga RP", content = "```css\n[" .. time .. "]>  O servidor iniciou/reiniciou e está agora online, ! \n```"}), { ['Content-Type'] = 'application/json' })

------ LOGS ENTRADAS E SAIDAS DE PLAYERS -----


AddEventHandler('playerConnecting', function()
	if GetPlayerName(source) ~= nil then
		local steamId = 'NIL'
		for k,v in pairs(GetPlayerIdentifiers(source)) do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamId = v
			end
		end
		
		sendToDiscord("Entrada no Servidor", "O jogador **( ["..steamId.."] " .. GetPlayerName(source) .. ")** entrou no servidor!\n ```css\n["..time.."]\n```", DiscordWebhookEntradasSaidas, 'verde')
	end
end)

AddEventHandler('playerDropped', function(Reason)
	if GetPlayerName(source) ~= nil then
		local steamId = 'NIL'
		for k,v in pairs(GetPlayerIdentifiers(source)) do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamId = v
			end
		end
		
		sendToDiscord("Saída do Servidor", "O jogador **( ["..steamId.."] " .. GetPlayerName(source) .. ")** saiu do servidor!\nRazão: "..Reason.. "\n```css\n["..time.."]\n```", DiscordWebhookEntradasSaidas, 'vermelho')
	end
end) 

------ LOGS ENTRADAS E SAIDAS DE PLAYERS -----

------ LOGS COMPRA VENDA CASAS -----

--[[
RegisterServerEvent('DiscordBot:compracasa')
AddEventHandler('DiscordBot:compracasa', function(idjogador, steamid, idcasa, preco)
	local nomejogador = GetPlayerName(idjogador)

	TriggerEvent('DiscordBot:ToDiscord', 'compravendacasas', SystemName, "O jogador ( [" .. steamid .. "] " .. nomejogador .. " ) comprou a casa #" ..idcasa.. " por " .. preco .."€.", 'system', source, false, false)
end)


RegisterServerEvent('DiscordBot:vendacasa')
AddEventHandler('DiscordBot:vendacasa', function(idjogador, steamid, idcasa, preco)
	local nomejogador = GetPlayerName(idjogador)

	TriggerEvent('DiscordBot:ToDiscord', 'compravendacasas', SystemName, "O jogador ( [" .. steamid .. "] " .. nomejogador .. " vendeu a casa #" ..idcasa.. " por " .. preco .."€.", 'system', source, false, false)
end)
--]]

RegisterServerEvent('DiscordBot:casaCriada')
AddEventHandler('DiscordBot:casaCriada', function(idjogador, steamid, nomeCasa, preco, coords)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("CASA CRIADA", "O trabalhador da Remax **( [" .. steamid .. "] " .. nomejogador .. "** criou uma casa:\n - **Nome:** [" ..nomeCasa.. "]\n - **Coordenadas:** ["..coords.."]\n - **Preço de Venda:** "..preco.."€\n```css\n["..time.."]\n```", DiscordWebhookCasasCriadas, 'verde')
end)


RegisterServerEvent('DiscordBot:casaRemovida')
AddEventHandler('DiscordBot:casaRemovida', function(idjogador, steamid, nomeCasa)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("CASA REMOVIDA", "O trabalhador da Remax **( [" .. steamid .. "] " .. nomejogador .. "** removeu uma casa:\n - **Nome da Casa:** " ..nomeCasa.. "\n```css\n["..time.."]\n```", DiscordWebhookCasasRemovidas, 'vermelho')
end)

------ LOGS COMPRA VENDA CASAS -----

------- LOGS DE CHAT ----------

RegisterServerEvent('DiscordBot:chatgeral')
AddEventHandler('DiscordBot:chatgeral', function(idjogador, mensagem)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local chatescrito = mensagem
	
	sendToDiscord("CHAT GERAL", "O jogador **( [" .. jogadorid .. "] " .. playerName .. " )** escreveu no chat:\n - **"..chatescrito.."**\n```css\n["..time.."]\n```", DiscordWebhookChat, 'azul')
end)

RegisterServerEvent('DiscordBot:chatgeral2')
AddEventHandler('DiscordBot:chatgeral2', function(idjogador, mensagem)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local chatescrito = mensagem
	
	sendToDiscord("/ME", "O jogador **( [" .. jogadorid .. "] " .. playerName .. " )** escreveu em /me:\n - **"..chatescrito.."**\n```css\n["..time.."]\n```", DiscordWebhookChat, 'azul')
end)

-----------LOGS DE CHAT -----------

---------- LOGS BAN / UNBAN --------

RegisterServerEvent('DiscordBot:banido')
AddEventHandler('DiscordBot:banido', function(idjogador, nomeStaff, idjogadordestino, nomejogadordestino, steamidjogadorbanido, razao, duracao, tipo)
	if tipo == 0 then
		if idjogador ~= 0 and idjogador ~= 99999 then
			sendToDiscord("JOGADOR BANIDO TEMP", "O Staff **( [" .. idjogador .. "] " .. nomeStaff .. " )** baniu um jogador:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** "..duracao.." dia(s)\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		else 
			sendToDiscord("JOGADOR BANIDO TEMP", "Um jogador foi banido pela consola do servidor:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** "..duracao.." dia(s)\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		end
	elseif tipo == 1 then
		if idjogador == 99999 then
			sendToDiscord("JOGADOR BANIDO PERM", "O **AntiCheat By Johnny** baniu um jogador:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** PERMANENTE\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		elseif idjogador ~= 0 and idjogador ~= 99999 then
			sendToDiscord("JOGADOR BANIDO PERM", "O Staff **( [" .. idjogador .. "] " .. nomeStaff .. " )** baniu um jogador:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** PERMANENTE\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		else
			sendToDiscord("JOGADOR BANIDO PERM", "Um jogador foi banido pela consola do servidor:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** PERMANENTE\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		end
	end
end)

RegisterServerEvent('DiscordBot:banido_offline')
AddEventHandler('DiscordBot:banido_offline', function(idjogador, nomeStaff, idjogadordestino, nomejogadordestino, steamidjogadorbanido, razao, duracao, tipo)
	if tipo == 0 then
		if idjogador ~= 0 then
			sendToDiscord("JOGADOR BANIDO TEMP", "O Staff **( [" .. idjogador .. "] " .. nomeStaff .. " )** baniu offline um jogador:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** "..duracao.." dia(s)\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		else
			sendToDiscord("JOGADOR BANIDO TEMP", "Um jogador foi banido offline pela consola do servidor:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** "..duracao.." dia(s)\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		end
	elseif tipo == 1 then
		if idjogador ~= 0 then
			sendToDiscord("JOGADOR BANIDO PERM", "O Staff **( [" .. idjogador .. "] " .. nomeStaff .. " )** baniu offline um jogador:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** PERMANENTE\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		else
			sendToDiscord("JOGADOR BANIDO PERM", "Um jogador foi banido offline pela consola do servidor:\n - **Info Jogador:** [" .. steamidjogadorbanido .. "] [ID: "..idjogadordestino.."] " .. nomejogadordestino .. "\n - **Razão:** "..razao.."\n - **Duração:** PERMANENTE\n```css\n["..time.."]\n```", DiscordWebhookBans, 'vermelho')
		end
	end
end)

RegisterServerEvent('DiscordBot:desbanido')
AddEventHandler('DiscordBot:desbanido', function(idjogador, nomejogadordestino, steamid)
	local nomejogador
	
	if idjogador ~= 0 then
		nomejogador = GetPlayerName(idjogador)
		sendToDiscord("JOGADOR DESBANIDO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** desbaniu um jogador:\n - **Info Jogador:** [" .. steamid .. "] " .. nomejogadordestino .. "\n```css\n["..time.."]\n```", DiscordWebhookUnbans, 'verde')
	else
		sendToDiscord("JOGADOR DESBANIDO", "Um staff desbaniu um jogador pela consola do servidor:\n - **Info Jogador:** [" .. steamid .. "] " .. nomejogadordestino .. "\n```css\n["..time.."]\n```", DiscordWebhookUnbans, 'verde')
	end
end)

---------- LOGS BAN / UNBAN ----------

------------ LOGS ASSALTOS ------------

RegisterServerEvent('DiscordBot:assaltos')
AddEventHandler('DiscordBot:assaltos', function(idjogador, steamid, localassalto)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("ASSALTO INICIADO", "Assalto Iniciado:\n - **Assaltado por:** [" .. steamid .. "] [ID: "..idjogador.."] " .. nomejogador .. "\n - **Local do Assalto:** "..localassalto.."\n```css\n["..time.."]\n```", DiscordWebhookAssaltos, 'verde')
end)

RegisterServerEvent('DiscordBot:assaltos2')
AddEventHandler('DiscordBot:assaltos2', function(idjogador, steamid, localassalto)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("ASSALTO CANCELADO", "Assalto cancelado:\n - **Assalto iniciado por:** [" .. steamid .. "] [ID:"..idjogador.."]" .. nomejogador .. "\n - **Local do Assalto:** "..localassalto.. "\n```css\n["..time.."]\n```", DiscordWebhookAssaltos, 'vermelho')
end)

------------ LOGS ASSALTOS -------------


-------- LOGS COMBAT LOG ------------

RegisterServerEvent('DiscordBot:combatlog')
AddEventHandler('DiscordBot:combatlog', function(idjogador, steamid)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("COMBAT LOG", "O jogador **( [" .. steamid .. "] " .. nomejogador .. " )** desconectou-se quando estava em combate (morto)\n```css\n["..time.."]\n```", DiscordWebhookCombatLog, 'laranja')
end)

-------- LOGS COMBAT LOG ------------


------- LOGS COMANDOS ADMIN --------

RegisterServerEvent('DiscordBot:setjob')
AddEventHandler('DiscordBot:setjob', function(idjogador, idjogadordestino, emprego, cargo, steamiddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogadordestino = GetPlayerName(idjogadordestino)
	
	sendToDiscord("SET JOB", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** alterou o emprego de um jogador:\n - **Jogador:** ["..steamiddestino.."] [ID: " .. idjogadordestino .. "] " .. nomejogadordestino .. "\n - **Nome do Emprego:** "..emprego.."\n - **Cargo:** "..cargo.."\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'verde')
end)

RegisterServerEvent('DiscordBot:teleport')
AddEventHandler('DiscordBot:teleport', function(idjogador, x, y, z)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("TELEPORT TO COORDS", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu teleport para para as coordenadas: **["..x..", "..y..", "..z.."]**\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
end)

RegisterServerEvent('DiscordBot:teleportToPlayer')
AddEventHandler('DiscordBot:teleportToPlayer', function(idjogador, idjogadordestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogadordestino = GetPlayerName(idjogadordestino)
	
	sendToDiscord("TELEPORT TO PLAYER", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu teleport para o jogador **( [" .. idjogadordestino .. "] " .. nomejogadordestino .. " )**\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
end)

RegisterServerEvent('DiscordBot:spawncarro')
AddEventHandler('DiscordBot:spawncarro', function(idjogador, modelocarro)
	local nomejogador = GetPlayerName(idjogador)
	if modelocarro ~= nil then
		sendToDiscord("SPAWN CAR", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** spawnou um carro:\n - **Modelo do Carro:** "..modelocarro.."\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'verde')
	end
end)

RegisterServerEvent('DiscordBot:delcar')
AddEventHandler('DiscordBot:delcar', function(idjogador, modelocarro)
	local nomejogador = GetPlayerName(idjogador)
	if modelocarro ~= nil then
		sendToDiscord("DEL CAR", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** apagou um carro com o modelo **"..modelocarro.."**!\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
	end
end)

RegisterServerEvent('DiscordBot:dvcar')
AddEventHandler('DiscordBot:dvcar', function(idjogador, raio)
	local nomejogador = GetPlayerName(idjogador)
	if raio ~= nil then
		sendToDiscord("DV", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** executou o comando /dv num raio de **"..raio.."**!\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
	
	else
		sendToDiscord("DV", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** executou o comando /dv!\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
	end
end)

RegisterServerEvent('DiscordBot:spawnped')
AddEventHandler('DiscordBot:spawnped', function(idjogador, modeloped)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("SPAWN PED", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** spawnou um ped!\n - **Nome do Model:** "..modeloped.." \n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'verde')
end)

RegisterServerEvent('DiscordBot:givemoneyconta')
AddEventHandler('DiscordBot:givemoneyconta', function(idjogador, iddestino, quantia, conta, steamiddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	sendToDiscord("GIVE MONEY", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu dinheiro a um jogador:\n - **Jogador Destino:** ( ["..steamiddestino.."] [ID: " .. iddestino .. "] " .. nomejogador2 .. " )\n - **Tipo de Dinheiro:** "..conta.."\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'verde')
end)

RegisterServerEvent('DiscordBot:setgrupo')
AddEventHandler('DiscordBot:setgrupo', function(idjogador, iddestino, grupo)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	sendToDiscord("PERMISSAO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu permissão de: **'"..grupo.."'** ao jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )** !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
end)

RegisterServerEvent('DiscordBot:kickjogador')
AddEventHandler('DiscordBot:kickjogador', function(idjogador, iddestino, razao)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	sendToDiscord("KICK", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu kick ao jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )** !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
end) 

--[[
RegisterServerEvent('DiscordBot:daritem')
AddEventHandler('DiscordBot:daritem', function(idjogador, iddestino, item, quantidade)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	TriggerEvent('DiscordBot:ToDiscord', 'comandosadmin', SystemName, "O Staff ( [" .. idjogador .. "] " .. nomejogador .. " ) deu ao jogador ( [" .. iddestino .. "] " .. nomejogador2 .. " ) " .. quantidade .. "x de " .. item .. "", 'system', source, false, false)
end)


RegisterServerEvent('DiscordBot:dararma')
AddEventHandler('DiscordBot:dararma', function(idjogador, iddestino, arma, balas)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	if balas == nil then
		balas = 0
	end
	
	TriggerEvent('DiscordBot:ToDiscord', 'comandosadmin', SystemName, "O Staff ( [" .. idjogador .. "] " .. nomejogador .. " ) deu ao jogador ( [" .. iddestino .. "] " .. nomejogador2 .. " ) 1x " .. arma .. " com " .. balas .. "x balas", 'system', source, false, false)
end)

RegisterServerEvent('DiscordBot:dararmacomponente')
AddEventHandler('DiscordBot:dararmacomponente', function(idjogador, iddestino, arma, componente)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	TriggerEvent('DiscordBot:ToDiscord', 'comandosadmin', SystemName, "O Staff ( [" .. idjogador .. "] " .. nomejogador .. " ) deu para a arma [".. arma .."] do jogador ( [" .. iddestino .. "] " .. nomejogador2 .. " )  o seguinte componente: "..componente, 'system', source, false, false)
end)
--]]


RegisterServerEvent('DiscordBot:congelou')
AddEventHandler('DiscordBot:congelou', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	sendToDiscord("FREEZE", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu freeze ao jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )** !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
end) 

RegisterServerEvent('DiscordBot:bring')
AddEventHandler('DiscordBot:bring', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	sendToDiscord("BRING", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu bring ao jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )** !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
end)  

RegisterServerEvent('DiscordBot:slap')
AddEventHandler('DiscordBot:slap', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	sendToDiscord("SLAP", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu slap ao jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )** !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
end)  

RegisterServerEvent('DiscordBot:goto')
AddEventHandler('DiscordBot:goto', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	if tonumber(idjogador) ~= tonumber(iddestino) then
		sendToDiscord("GO TO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu teleport para o jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )** !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
	else
		sendToDiscord("GO TO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu teleport para si mesmo !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
	end
end)  

RegisterServerEvent('DiscordBot:suicidio')
AddEventHandler('DiscordBot:suicidio', function(idjogador)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("SUICIDIO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** suicidou-se através do comando staff /die !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
end)  

RegisterServerEvent('DiscordBot:matou')
AddEventHandler('DiscordBot:matou', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2 = GetPlayerName(iddestino)
	
	if tonumber(idjogador) ~= tonumber(iddestino) then
		sendToDiscord("SLAY", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** matou o jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )** através do /slay !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
	else
		sendToDiscord("SLAY", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** matou-se a si mesmo através do /slay !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
	end
end) 

RegisterServerEvent('DiscordBot:limpouinv')
AddEventHandler('DiscordBot:limpouinv', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2
	
	if iddestino == nil then
		nomejogador2 = GetPlayerName(idjogador)
		iddestino = idjogador
	else
		nomejogador2 = GetPlayerName(iddestino)
	end
	
	sendToDiscord("LIMPOU INVENTÁRIO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** apagou o inventário de **( [" .. iddestino .. "] " .. nomejogador2 .. " )**\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
end)

RegisterServerEvent('DiscordBot:disconnect')
AddEventHandler('DiscordBot:disconnect', function(idjogador)
	local nomejogador = GetPlayerName(idjogador)
	
	sendToDiscord("DISCONNECT", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** desconectou-se através do comando staff /disc ou /disconnect !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'vermelho')
end)

RegisterServerEvent('DiscordBot:clearchat')
AddEventHandler('DiscordBot:clearchat', function(idjogador, todos)
	local nomejogador = GetPlayerName(idjogador)

	if todos == 1 then
		sendToDiscord("CHAT LIMPO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** apagou o chat do servidor através do comando /clearchat !\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
	else
		sendToDiscord("CHAT LIMPO", "O Jogador **( [" .. idjogador .. "] " .. nomejogador .. " )** apagou o chat para ele através do comando /clear!\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
	end
end)

RegisterServerEvent('DiscordBot:limpouloadout')
AddEventHandler('DiscordBot:limpouloadout', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	local nomejogador2
	
	if iddestino == nil then
		nomejogador2 = GetPlayerName(idjogador)
		iddestino = idjogador
	else 
		nomejogador2 = GetPlayerName(iddestino)
	end
	
	sendToDiscord("LOADOUT LIMPO", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** apagou todas as armas de **( [" .. iddestino .. "] " .. nomejogador2 .. " )**\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
end)

RegisterServerEvent('DiscordBot:deurevive')
AddEventHandler('DiscordBot:deurevive', function(idjogador, iddestino)
	local nomejogador = GetPlayerName(idjogador)
	
	if tonumber(idjogador) ~= tonumber(iddestino) then	
		local nomejogador2 = GetPlayerName(iddestino)
		sendToDiscord("REVIVE", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu revive ao jogador **( [" .. iddestino .. "] " .. nomejogador2 .. " )**\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
		--TriggerEvent('DiscordBot:ToDiscord', 'comandosadmin', SystemName, "O Staff ( [" .. idjogador .. "] " .. nomejogador .. " ) deu revive ao jogador ( [" .. iddestino .. "] " .. nomejogador2 .. " )", 'system', source, false, false)
	else
		sendToDiscord("REVIVE", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** deu revive a si mesmo!\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
		--TriggerEvent('DiscordBot:ToDiscord', 'comandosadmin', SystemName, "O Staff ( [" .. idjogador .. "] " .. nomejogador .. " ) deu revive a si mesmo", 'system', source, false, false)
	end
end) 

RegisterServerEvent('DiscordBot:mapper')
AddEventHandler('DiscordBot:mapper', function(idjogador)
	local nomejogador = GetPlayerName(idjogador)
	
	
	sendToDiscord("MAPPER", "O Staff **( [" .. idjogador .. "] " .. nomejogador .. " )** entrou/saiu do modo mapper!\n```css\n["..time.."]\n```", DiscordWebhookComandosAdmin, 'azul')
end)

------- LOGS COMANDOS ADMIN --------


------ LOGS BANCO --------

RegisterServerEvent('DiscordBot:levantamentobancario')
AddEventHandler('DiscordBot:levantamentobancario', function(idjogador, steamid, montante)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local quantia = montante
	
	sendToDiscord("LEVANTAMENTO", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou um levantamento da sua conta bancária:\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoLevantamento, 'vermelho')
end)

RegisterServerEvent('DiscordBot:depositobancario')
AddEventHandler('DiscordBot:depositobancario', function(idjogador, steamid, montante)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local quantia = montante
	
	sendToDiscord("DEPÓSITO", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou um depósito na sua conta bancária:\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoDeposito, 'verde')
end)

RegisterServerEvent('DiscordBot:transferenciabancaria')
AddEventHandler('DiscordBot:transferenciabancaria', function(idjogador, jogadorSteamId, montante, contadestino, targetSteamId)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local idcontadestino = contadestino
	local playerName2 = GetPlayerName(idcontadestino)
	local quantia = montante
	
	sendToDiscord("TRANSFERÊNCIA ENTRE JOGADORES", "O jogador **( ["..jogadorSteamId.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou uma transferência:\n - **Para:** ["..targetSteamId.."] [ID: " .. idcontadestino .. "] " .. playerName2 .. "\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoTransferencias, 'azul')
end)

RegisterServerEvent('DiscordBot:transferenciabancariaTelemovel')
AddEventHandler('DiscordBot:transferenciabancariaTelemovel', function(idjogador, jogadorSteamId, montante, iban, targetSteamId, contadestino)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local idcontadestino = contadestino
	local playerName2 = GetPlayerName(idcontadestino)
	local quantia = montante
	
	if idcontadestino ~= 0 then
		sendToDiscord("TRANSFERÊNCIA POR TELEMOVEL", "O jogador **( ["..jogadorSteamId.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou uma transferência por telemóvel:\n - **Para:** ["..targetSteamId.."] [ID: " .. idcontadestino .. "] " .. playerName2 .. "\n - **IBAN:**"..iban.."\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoTransferencias, 'azul')
	else
		sendToDiscord("TRANSFERÊNCIA POR TELEMOVEL", "O jogador **( ["..jogadorSteamId.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou uma transferência por telemóvel:\n - **Para:** ["..targetSteamId.."] [ID: **JOGADOR OFFLINE** ] " .. playerName2 .. "\n - **IBAN:**"..iban.."\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoTransferencias, 'azul')
	end
end)

RegisterServerEvent('DiscordBot:depositoBancarioEmpresa')
AddEventHandler('DiscordBot:depositoBancarioEmpresa', function(idjogador, steamid, montante, empresa)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local quantia = montante
	
	sendToDiscord("DEPÓSITO EMPRESA", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou um depósito na conta da empresa:\n - **Nome da Empresa:** "..empresa.."\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoDeposito, 'verde')
end)

RegisterServerEvent('DiscordBot:levantamentoBancarioEmpresa')
AddEventHandler('DiscordBot:levantamentoBancarioEmpresa', function(idjogador, steamid, montante, empresa)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local quantia = montante
	
	sendToDiscord("LEVANTAMENTO EMPRESA", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou um levantamento da conta da empresa:\n - **Nome da Empresa:** "..empresa.."\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoLevantamento, 'vermelho')
end)

RegisterServerEvent('DiscordBot:transferenciaBancariaEmpresa')
AddEventHandler('DiscordBot:transferenciaBancariaEmpresa', function(idjogador, steamid, montante, empresaLocal, empresaDestino)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local quantia = montante
	
	sendToDiscord("TRANSFERÊNCIA ENTRE EMPRESAS", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou uma transferência da conta da sua empresa:\n - **Nome da sua Empresa:** "..empresaLocal.."\n - **Nome da Empresa Destino:** "..empresaDestino.."\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoTransferencias, 'azul')
end)

RegisterServerEvent('DiscordBot:transferenciaBancariaParaEmpresa')
AddEventHandler('DiscordBot:transferenciaBancariaParaEmpresa', function(idjogador, steamid, montante, empresaDestino)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local quantia = montante
	
	sendToDiscord("TRANSFERÊNCIA DE JOGADOR PARA EMPRESA", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou uma transferência para uma empresa:\n - **Nome da Empresa Destino:** "..empresaDestino.."\n - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoTransferencias, 'azul')
end)

RegisterServerEvent('DiscordBot:transferenciaBancariaEmpresaParaJogador')
AddEventHandler('DiscordBot:transferenciaBancariaEmpresaParaJogador', function(idjogador, SteamJogadorLocal, montante, empresa, jogadorDestino, SteamJogadorDestino)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local playerNameDestino = GetPlayerName(jogadorDestino)
	local quantia = montante
	
	sendToDiscord("TRANSFERÊNCIA DE EMPRESA PARA JOGADOR", "O jogador **( ["..SteamJogadorLocal.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** efetuou uma transferência da sua empresa para um jogador:\n - **Nome da sua Empresa:** "..empresa.."\n - **Info do Jogador Destino:** ["..SteamJogadorDestino.."] [ID: " .. jogadorDestino .. "] " .. playerNameDestino .. " - **Quantia:** "..quantia.."€\n```css\n["..time.."]\n```", DiscordWebhookBancoTransferencias, 'azul')
end)

------ LOGS TRANSAÇÕES BANCÁRIAS --------


------ LOGS COMPRA E VENDA CARROS -------

RegisterServerEvent('DiscordBot:compracarros')
AddEventHandler('DiscordBot:compracarros', function(idjogador, matricula, steamid, label, precoCarro)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	
	sendToDiscord("COMPRA DE CARRO", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** comprou um carro no stand:\n - **Nome do Carro:** "..label.."\n - **Matrícula:** ".. matricula.. "\n - **Valor do Carro:** "..precoCarro.."€\n```css\n["..time.."]\n```", DiscordWebhookCompraCarros, 'verde')
end)

RegisterServerEvent('DiscordBot:vendacarros')
AddEventHandler('DiscordBot:vendacarros', function(idjogador, nomecarro, matricula, price, steamid)
	local jogadorid = idjogador
	local playerName = GetPlayerName(jogadorid)
	local nomedocarro = nomecarro
	local matric = matricula
	local preco = price
	
	sendToDiscord("COMPRA DE CARRO", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** vendeu um carro no stand:\n - **Nome do Carro:** "..nomedocarro.."\n - **Matrícula:** ".. matric.. "\n - **Preço da Venda:** "..preco.."€\n```css\n["..time.."]\n```", DiscordWebhookVendaCarros, 'vermelho')
end)

------ LOGS COMPRA E VENDA CARROS -------

---------------- LOGS DE KILLS ----------------

RegisterServerEvent('DiscordBot:killerlog')
AddEventHandler('DiscordBot:killerlog', function(id,player,killer,DeathReason, Weapon)
  if Weapon == nil then _Weapon = "" else _Weapon = "`"..Weapon.."`" end
	if id == 1 then  -- Suicide/died
		sendToDiscord("MORTE", "O jogador **[" .. source .. "] [" .. GetPlayerIdentifiers(source)[1] .. "] " .. GetPlayerName(source) .. "** suicidou-se ou morreu por (fome, atropelamento, etc..)\n ```css\n["..time.."]\n```", DiscordWebhookKillinglogs, 'vermelho')
	elseif id == 2 then -- Killed by other player
		sendToDiscord("MORTE", "O jogador **[" .. source .. "] [" .. GetPlayerIdentifiers(source)[1] .. "] " .. GetPlayerName(source) .. "** foi morto por [" .. killer .. "] [" .. GetPlayerIdentifiers(killer)[1] .. "] " .. GetPlayerName(killer) .. "!\n **Causa da Morte:** "..DeathReason.."\n **Arma:** ".._Weapon.. " \n ```css\n["..time.."]\n```", DiscordWebhookKillinglogs, 'vermelho')
	else -- When gets killed by something else
		sendToDiscord("MORTE", "O jogador **[" .. source .. "] [" .. GetPlayerIdentifiers(source)[1] .. "] " .. GetPlayerName(source) .. "** foi morto por causas desconhecidas!\n ```css\n["..time.."]\n```", DiscordWebhookKillinglogs, 'vermelho')
	end
end)

----------------- LOGS DE KILLS ----------------

----------------- LOGS DE TIROS ----------------

RegisterServerEvent('DiscordBot:tirosdisparados')
AddEventHandler('DiscordBot:tirosdisparados', function(jogadorid,playerName,weapon)
	if weapon == nil then _Weapon = "Arma Desconhecida" else _Weapon = "`"..weapon.."`" end
	
	local steamid = PlayerIdentifier('steam', jogadorid)
	
	sendToDiscord("TIROS DISPARADOS", "O jogador **( ["..steamid.."] [ID: " .. jogadorid .. "] " .. playerName .. " )** disparou tiros com a arma **".._Weapon.."** \n```css\n["..time.."]\n```", DiscordWebhookTirosDisparados, 'azul')
end)

----------------- LOGS DE TIROS ----------------

function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end

--Event to actually send Messages to Discord
RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, Source, TTS, FromChatResource)
	if Message == nil or Message == '' then
		return nil
	end

	if WebHook:lower() == 'chatgeral' then
		WebHook = DiscordWebhookChat
	elseif WebHook:lower() == 'system' then
		WebHook = DiscordWebhookSystemInfos
	elseif WebHook:lower() == 'kill' then
		WebHook = DiscordWebhookKillinglogs
	elseif WebHook:lower() == 'tirosdisparados' then
		WebHook = DiscordWebhookTirosDisparados
	elseif WebHook:lower() == 'entsai' then
		WebHook = DiscordWebhookEntradasSaidas
	elseif WebHook:lower() == 'assaltos' then
		WebHook = DiscordWebhookAssaltos
	elseif WebHook:lower() == 'depositos' then
		WebHook = DiscordWebhookBancoDeposito
	elseif WebHook:lower() == 'levantamentos' then
		WebHook = DiscordWebhookBancoLevantamento
	elseif WebHook:lower() == 'transferencias' then
		WebHook = DiscordWebhookBancoTransferencias
	elseif WebHook:lower() == 'compracarros' then
		WebHook = DiscordWebhookCompraCarros
	elseif WebHook:lower() == 'vendacarros' then
		WebHook = DiscordWebhookVendaCarros
	elseif WebHook:lower() == 'bans' then
		WebHook = DiscordWebhookBans
	elseif WebHook:lower() == 'unbans' then
		WebHook = DiscordWebhookUnbans
	elseif WebHook:lower() == 'comandosadmin' then
		WebHook = DiscordWebhookComandosAdmin
	elseif WebHook:lower() == 'combatlog' then
		WebHook = DiscordWebhookCombatLog
	elseif WebHook:lower() == 'casasremovidas' then
		WebHook = DiscordWebhookCasasRemovidas
	elseif WebHook:lower() == 'casascriadas' then
		WebHook = DiscordWebhookCasasCriadas
	elseif not WebHook:find('discordapp.com/api/webhooks') then
		print('Please specify a webhook link!')
		return nil
	end
	
	if Image:lower() == 'user' then
		Image = UserAvatar
	elseif Image:lower() == 'system' then
		Image = SystemAvatar
	end
	
	if not TTS or TTS == '' then
		TTS = false
	end

	for i = 0, 9 do
		Name = Name:gsub('%^' .. i, '')
		Message = Message:gsub('%^' .. i, '')
	end

	MessageSplitted = stringsplit(Message, ' ')

	if FromChatResource and not IsCommand(MessageSplitted, 'Registered') then
		return nil
	end
	
	if not IsCommand(MessageSplitted, 'Blacklisted') and not (WebHook == DiscordWebhookSystemInfos or WebHook == DiscordWebhookEntradasSaidas or WebHook == DiscordWebhookCasasRemovidas or WebHook == DiscordWebhookCasasCriadas or WebHook == DiscordWebhookCompraCarros or WebHook == DiscordWebhookVendaCarros or WebHook == DiscordWebhookCombatLog or WebHook == DiscordWebhookKillinglogs or WebHook == DiscordWebhookAssaltos or WebHook == DiscordWebhookUnbans or WebHook == DiscordWebhookBans or WebHook == DiscordWebhookBancoDeposito or WebHook == DiscordWebhookBancoLevantamento or WebHook == DiscordWebhookBancoTransferencias or WebHook == DiscordWebhookComandosAdmin or WebHook == DiscordWebhookChat or WebHook == DiscordWebhookTirosDisparados) then
		--Checking if the message contains a command which has his own webhook
		if IsCommand(MessageSplitted, 'HavingOwnWebhook') then
			Webhook = GetOwnWebhook(MessageSplitted)
		end
		
		--Checking if the message contains a special command
		if IsCommand(MessageSplitted, 'Special') then
			MessageSplitted = ReplaceSpecialCommand(MessageSplitted)
		end
		
		---Checking if the message contains a command which belongs into a tts channel
		if IsCommand(MessageSplitted, 'TTS') then
			TTS = true
		end
		
		--Combining the message to one string again
		Message = table.concat(MessageSplitted, ' ')
		
		--Adding the username if needed
		if Source == 0 then
			Message = Message:gsub('USERNAME_NEEDED_HERE', 'Remote Console')
		else
			Message = Message:gsub('USERNAME_NEEDED_HERE', GetPlayerName(Source))
		end
		
		--Adding the userid if needed
		Message = Message:gsub('USERID_NEEDED_HERE', Source)
		
		-- Shortens the Name, if needed
		if Name:len() > 23 then
			Name = Name:sub(1, 23)
		end

		--Getting the steam avatar if available
		if not Source == 0 and GetIDFromSource('steam', Source) then
			PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
				local SteamProfileSplitted = stringsplit(Content, '\n')
				for i, Line in ipairs(SteamProfileSplitted) do
					if Line:find('<avatarFull>') then
						PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''), tts = TTS}), {['Content-Type'] = 'application/json'})
						break
					end
				end
			end)
		else
			--Using the default avatar if no steam avatar is available
			PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
		end
	else
		PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
	end
end)

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for Key, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for Key, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for Key, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for Key, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	elseif Type == 'Registered' then
		local RegisteredCommands = GetRegisteredCommands()
		for Key, RegisteredCommand in ipairs(GetRegisteredCommands()) do
			if String[1]:lower():gsub('/', '') == RegisteredCommand.name:lower() then
				return true
			end
		end
	end
	return false
end

function ReplaceSpecialCommand(String)
	for i, SpecialCommand in ipairs(SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'WEBHOOK_LINK_HERE' then
				print('Please enter a webhook link for the command: ' .. String[1])
				return DiscordWebhookChat
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
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