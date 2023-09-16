ESX = nil

ESX = exports['es_extended']:getSharedObject()

local JoinCoolDown = {}
local BannedAlready = false
local BannedAlready2 = false
local isBypassing = false
local isBypassing2 = false
local DatabaseStuff = {}
local BannedAccounts = {}
local Admins = {
    "steam:11000",
    "example",
}

AddEventHandler('esx:playerLoaded', function(source)
    local source = source
    local Steam = "NONE"
    local Lice = "NONE"
    local Live = "NONE"
    local Xbox = "NONE"
    local Discord = "NONE"
    local IP = "NONE"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            Steam = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            Lice = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            Live = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            Discord = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IP = v
        end
    end
    if GetNumPlayerTokens(source) == 0 or GetNumPlayerTokens(source) == nil or GetNumPlayerTokens(source) < 0 or GetNumPlayerTokens(source) == "null" or GetNumPlayerTokens(source) == "**Invalid**" or not GetNumPlayerTokens(source) then
        DiscordLog(source, "Os números dos tokens do jogador são desconhecidos")
        DropPlayer(source, "JOHNNY SYSTEM: \n Ocorreu um problema ao recuperar as informações do FiveM.\n Reinicia o FiveM.")
        return
    end
    for a, b in pairs(BannedAccounts) do
        for c, d in pairs(b) do 
            for e, f in pairs(json.decode(d.Tokens)) do
                for g = 0, GetNumPlayerTokens(source) - 1 do
                    if GetPlayerToken(source, g) == f or d.License == tostring(Lice) or d.Live == tostring(Live) or d.Xbox == tostring(Xbox) or d.Discord == tostring(Discord) or d.IP == tostring(IP) or d.Steam == tostring(Steam) then
                        if os.time() < tonumber(d.Expire) then
                            BannedAlready2 = true
                            if d.Steam ~= tostring(Steam) then
                                isBypassing2 = true
                            end
                            break
                        else
                            CreateUnbanThread(tostring(d.Steam))
                            break
                        end
                    end
                end
            end
        end
    end
    if BannedAlready2 then
        BannedAlready2 = false
        DiscordLog(source, "Tentou entrar, mas foi banido (expulso do servidor ao tentar entrar no servidor (foi banido))")
		DropPlayer(source, "Razão do Kick: Foste banido do servidor!")
    end
    if isBypassing2 then
        isBypassing2 = false
        DiscordLog(source, "Tentou entrar no servidor ao tentar enganar o sistema (Steam ID diferente) (Tentou entrar com outro Steam ID) - Nova conta banida!")
        BanNewAccount(tonumber(source), "Tentou ultrapassar o sistema: JOHNNY SYSTEM", os.time() + (300 * 86400))
	    DropPlayer(source, "Razão do Kick: Foste banido deste servidor!")
    end
end)

AddEventHandler('Initiate:BanSql', function(hex, id, reason, name, day)
    local time
    if tonumber(day) == 0 then
		time = 9999
    else
		time = day
   end
   
   local dataBan = os.date("%d/%m/%Y %X")
   
    MySQL.Async.execute('UPDATE wtrp_bans SET Reason = @Reason, BanDate = @BanDate, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
    {
        ['@isBanned'] = 1,
        ['@BanDate'] = dataBan,
        ['@Reason'] = reason,
        ['@Steam'] = hex,
        ['@Expire'] = os.time() + (time * 86400)
    })
	
	local duracao  = converter_tempo_para_string(time)
	
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.8); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> [Johnny System]<br>  {1}</div>',
        args = { name, 'O jogador [' .. name .. '] foi BANIDO.<br>Razão: ' ..reason.."<br>Duração: "..duracao..""}
    })

	DropPlayer(id, reason)
    SetTimeout(5000, function()
        ReloadBans()
    end)
	
	local playerName = nil
	for _, player in ipairs(GetPlayers()) do
		if GetPlayerIdentifier(player, 0) == hex then
			playerName = GetPlayerName(player)
			break
		end
	end
	
	print("O jogador "..playerName.. "foi banido por: "..GetPlayerName(source).." | Razão: "..reason.." | Duração: "..duracao.."")
	DiscordLog(source, "O jogador "..playerName.. "foi banido por: "..GetPlayerName(source).." | Razão: "..reason.." | Duração: "..duracao.."")
end)

AddEventHandler('TargetPlayerIsOffline', function(hex, reason, xAdmin, day)
    local Ttime
    if tonumber(day) == 0 then
	Ttime = 9999
    else
	Ttime = day
    end
    MySQL.Async.fetchAll('SELECT Steam FROM wtrp_bans WHERE Steam = @Steam',
    {
        ['@Steam'] = hex

    }, function(data)
        if data[1] then
            MySQL.Async.execute('UPDATE wtrp_bans SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
            {
                ['@isBanned'] = 1,
                ['@Reason'] = reason,
                ['@Steam'] = hex,
                ['@Expire'] = os.time() + (Ttime * 86400)
            })
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 131, 0, 0.4); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> [Johnny System]<br>  {1}</div>',
                args = { hex, '^1' .. hex .. ' ^0Banido, Razão: ^1' ..reason.." ^0Duração: t ^1"..Ttime.." ^0 Dia(s)."}
            })
            SetTimeout(5000, function()
                ReloadBans()
            end)
        else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Esse Steam ID não foi <span style='color:#ff0000'>encontrado</span> na Base de Dados!", 5000, 'error')
        end
    end)
end)

AddEventHandler('playerConnecting', function(name, setKickReason)
    local source = source
    local Steam = "NONE"
    local Lice = "NONE"
    local Live = "NONE"
    local Xbox = "NONE"
    local Discord = "NONE"
    local IP = "NONE"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            Steam = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            Lice = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            Live = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            Discord = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IP = v
        end
    end
    if Steam == nil or Lice == nil or Steam == "" or Lice == "" or Steam == "NONE" or Lice == "NONE" then
        setKickReason("\n \n JOHNNY SYSTEM: \n A tua Steam não está aberta, abre primeiro a Steam. \n Reinicia o FiveM.")
        CancelEvent()
        return
    end
    if GetNumPlayerTokens(source) == 0 or GetNumPlayerTokens(source) == nil or GetNumPlayerTokens(source) < 0 or GetNumPlayerTokens(source) == "null" or GetNumPlayerTokens(source) == "**Invalid**" or not GetNumPlayerTokens(source) then
        DiscordLog(source, "Os números máximos de token são nulos")
        setKickReason("\n \n JOHNNY SYSTEM: \n Ocorreu um problema ao recuperar as informações do FiveM \n Reinicia o FiveM.")
        CancelEvent()
        return
    end
    if JoinCoolDown[Steam] == nil then
        JoinCoolDown[Steam] = os.time()
    elseif os.time() - JoinCoolDown[Steam] < 15 then 
        setKickReason("\n \n JOHNNY SYSTEM: \n Cód. de Erro : #12\n \n Não faças spam no botão Conectar")
        CancelEvent()
        return
    else
        JoinCoolDown[Steam] = nil
    end
    for a, b in pairs(BannedAccounts) do
        for c, d in pairs(b) do 
            for e, f in pairs(json.decode(d.Tokens)) do
                for g = 0, GetNumPlayerTokens(source) - 1 do
                    if GetPlayerToken(source, g) == f or d.License == tostring(Lice) or d.Live == tostring(Live) or d.Xbox == tostring(Xbox) or d.Discord == tostring(Discord) or d.IP == tostring(IP) or d.Steam == tostring(Steam) then
                        if os.time() < tonumber(d.Expire) then
                            BannedAlready = true
                            if d.Steam ~= tostring(Steam) then
                                isBypassing = true
                            end
							print(math.floor(((tonumber(d.Expire) - os.time())/86400)))
                            setKickReason("\n \n Foste banido deste servidor.\nData do Ban: "..d.BanDate.." \n Ban ID: #"..d.ID.."\n Razão: "..d.Reason.."\n Duração: Estás banido por "..converter_tempo_para_string(math.floor(((tonumber(d.Expire) - os.time())/86400))).."!")
                            CancelEvent()
                            break
                        else
                            CreateUnbanThread(tostring(d.Steam))
                            break
                        end
                    end
                end
            end
        end
    end
    if not BannedAlready and not isBypassing then
        InitiateDatabase(tonumber(source))
    end
    if BannedAlready then
        BannedAlready = false
        DiscordLog(source, "Tentou entrar, mas foi banido (foi rejeitado antes de carregar no servidor)")
    end
    if isBypassing then
        isBypassing = false
        DiscordLog(source, "Tentou entrar no servidor ao tentar enganar o sistema (Steam ID diferente) (Tentou entrar com outro Steam ID) - Nova conta banida!")
        BanNewAccount(tonumber(source), "Tentou entrar com nova conta (Já tens uma conta banida neste servidor com outro Steam ID) - JOHNNY SYSTEM", os.time() + (300 * 86400))
    end
end)


function converter_tempo_para_string(tempo_em_dias)
    local tempo_em_minutos = tempo_em_dias * 1440 -- 1440 minutos em um dia
    local dias = math.floor(tempo_em_minutos / 1440)
    local horas = math.floor((tempo_em_minutos - dias * 1440) / 60)
    local minutos = tempo_em_minutos - dias * 1440 - horas * 60
	print(dias)
	print(horas)
	print(minutos)
    if dias > 0 then
        return string.format("%d dias, %d horas e %d minutos", dias, horas, minutos)
    elseif horas > 0 then
        return string.format("%d horas e %d minutos", horas, minutos)
    else
        return string.format("%d minutos", minutos)
    end
end

function CreateUnbanThread(Steam)
    MySQL.Async.fetchAll('SELECT Steam FROM wtrp_bans WHERE Steam = @Steam',
    {
        ['@Steam'] = Steam

    }, function(data)
        if data[1] then
            MySQL.Async.execute('UPDATE wtrp_bans SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
            {
                ['@isBanned'] = 0,
                ['@Reason'] = "",
                ['@Steam'] = Steam,
                ['@Expire'] = 0
            })
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end
    end)
end

function InitiateDatabase(source)
    local source = source
    local ST = "None"
    local LC = "None"
    local LV = "None"
    local XB = "None"
    local DS = "None"
    local IiP = "None"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            ST  = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            LC  = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            LV  = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            DS = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IiP = v
        end
    end
    if ST == "None" then print(source.." Não tem Steam ID") return end
    DatabaseStuff[ST] = {}
    for i = 0, GetNumPlayerTokens(source) - 1 do 
        table.insert(DatabaseStuff[ST], GetPlayerToken(source, i))
    end
    MySQL.Async.fetchAll('SELECT * FROM wtrp_bans WHERE Steam = @Steam',
    {
        ['@Steam'] = ST

    }, function(data) 
        if data[1] == nil then
            MySQL.Async.execute('INSERT INTO wtrp_bans (Steam, License, Tokens, Discord, IP, Xbox, Live, Reason, Expire, isBanned) VALUES (@Steam, @License, @Tokens, @Discord, @IP, @Xbox, @Live, @Reason, @Expire, @isBanned)',
            {
                ['@Steam'] = ST,
                ['@License'] = LC,
                ['@Discord'] = DS,
                ['@Xbox'] = XB,
                ['@IP'] = IiP,
                ['@Live'] = LV,
                ['@Reason'] = "",
                ['@Tokens'] = json.encode(DatabaseStuff[ST]),
                ['@Expire'] = 0,
                ['@isBanned'] = 0
            })
            DatabaseStuff[ST] = nil
        end 
    end)
end

function BanNewAccount(source, Reason, Time)
    local source = source
    local ST = "None"
    local LC = "None"
    local LV = "None"
    local XB = "None"
    local DS = "None"
    local IiP = "None"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            ST  = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            LC  = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            LV  = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            DS = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IiP = v
        end
    end
    if ST == "None" then print(source.." Não tem Steam ID") return end
    DatabaseStuff[ST] = {}
    for i = 0, GetNumPlayerTokens(source) - 1 do 
        table.insert(DatabaseStuff[ST], GetPlayerToken(source, i))
    end
    MySQL.Async.fetchAll('SELECT * FROM wtrp_bans WHERE Steam = @Steam',
    {
        ['@Steam'] = ST

    }, function(data) 
        if data[1] == nil then
            MySQL.Async.execute('INSERT INTO wtrp_bans (Steam, License, Tokens, Discord, IP, Xbox, Live, Reason, Expire, isBanned) VALUES (@Steam, @License, @Tokens, @Discord, @IP, @Xbox, @Live, @Reason, @Expire, @isBanned)',
            {
                ['@Steam'] = ST,
                ['@License'] = LC,
                ['@Discord'] = DS,
                ['@Xbox'] = XB,
                ['@IP'] = IiP,
                ['@Live'] = LV,
                ['@Reason'] = Reason,
                ['@Tokens'] = json.encode(DatabaseStuff[ST]),
                ['@Expire'] = Time,
                ['@isBanned'] = 1
            })
            DatabaseStuff[ST] = nil
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end 
    end)
end

RegisterCommand('atualizarbans', function(source, args)
    if IsPlayerAllowedToBan(source) or source == 0 then
        ReloadBans()
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Lista de Bans <span style='color:#069a19'>Atualizada</span>!", 5000, 'success')
    end
end)

RegisterServerEvent("HR_BanSystem:BanMe")
AddEventHandler("HR_BanSystem:BanMe", function(Reason, Time)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            Cheat = v
        end
    end
    TriggerEvent('Initiate:BanSql', Cheat, tonumber(source), tostring(Reason), GetPlayerName(source), tonumber(Time))
end)

function BanThis(source, Reason, Times)
    local time = Times
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            STP = v
        end
    end
    if Times == nil or not Times then
        time = 365
    end
    TriggerEvent('Initiate:BanSql', STP, tonumber(source), tostring(Reason), GetPlayerName(source), tonumber(time))
end

RegisterCommand('banir', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = tonumber(args[1])
    if IsPlayerAllowedToBan(source) or source == 0 then
        if args[1] then
            if tonumber(args[2]) then
                if tostring(args[3]) then
                    if tonumber(args[1]) then
                        if GetPlayerName(target) then
                            for k, v in ipairs(GetPlayerIdentifiers(target)) do
                                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                                    Hex = v
                                end
                            end
                            TriggerEvent('Initiate:BanSql', Hex, tonumber(target), table.concat(args, " ",3), GetPlayerName(target), tonumber(args[2]))
                        else
                            TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>O jogador não está <span style='color:#ff0000'>online</span>!", 5000, 'error')
                        end
                    else
                        if string.find(args[1], "steam:") ~= nil then
                            TriggerEvent('TargetPlayerIsOffline', args[1], table.concat(args, " ",3), tonumber(xPlayer.source), tonumber(args[2]))
                        else
                            TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Steam ID <span style='color:#ff0000'>inválido</span>!", 5000, 'error')
                        end
                    end
                else
                    TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Indica a <span style='color:#ff0000'>Razão do Ban</span>!", 5000, 'error')
                end
            else
                TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Indica a <span style='color:#ff0000'>Duração do Ban</span>!", 5000, 'error')
            end
        else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Indica o <span style='color:#ff0000'>ID do Jogador</span> ou o <span style='color:#ff0000'>Steam ID</span>!", 5000, 'error')
        end
    else
        if source ~= 0 then
            TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>permissões</span> suficientes!", 5000, 'error')
        end
    end
end)

RegisterServerEvent("HR_BanSystem:CheckBan")
AddEventHandler("HR_BanSystem:CheckBan", function(hex)
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM wtrp_bans WHERE Steam = @Steam',
    {
        ['@Steam'] = hex

    }, function(data)
        if data[1] then
            if data[1].isBanned == 1 then
                DiscordLog(source, "Tried To Bypass BanSystem(KVP Method)")
                DropPlayer(source, "Razão do Kick: Foste banido")
            end
        end
    end)
end)

RegisterCommand('desbanir', function(source, args)
    if IsPlayerAllowedToBan(source) or source == 0 then
        if tostring(args[1]) then
            MySQL.Async.fetchAll('SELECT Steam FROM wtrp_bans WHERE Steam = @Steam',
            {
                ['@Steam'] = args[1]
    
            }, function(data)
                if data[1] then
                    MySQL.Async.execute('UPDATE wtrp_bans SET Reason = @Reason, BanDate = @BanDate, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
                    {
                        ['@isBanned'] = 0,
                        ['@Reason'] = "",
                        ['@BanDate'] = "",
                        ['@Steam'] = args[1],
                        ['@Expire'] = 0
                    })
                    SetTimeout(5000, function()
                        ReloadBans()
                    end)
					local playerName = nil
					for _, player in ipairs(GetPlayers()) do
						print(GetPlayerIdentifier(player, 0))
						print(tostring(args[1]))
						if GetPlayerIdentifier(player, 0) == tostring(args[1]) then
							playerName = GetPlayerName(player)
							break
						end
					end
					--print("O jogador "..playerName.. "foi desbanido por: "..GetPlayerName(source))
					DiscordLog(source, "O jogador "..playerName.. "foi desbanido por: "..GetPlayerName(source))
					TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>O jogador" ..playerName.. "foi <span style='color:#069a19'>desbanido</span> com sucesso!", 5000, 'success')
                else
					TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>O Steam ID <span style='color:#ff0000'>não</span> existe na base de dados!", 5000, 'error')
                end
            end)
        else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Steam ID <span style='color:#ff0000'>inválido</span>!", 5000, 'error')
        end
    else
        if source ~= 0 then
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>permissões</span> suficientes!", 5000, 'error')
        end
    end
end)

function ReloadBans()
    Citizen.CreateThread(function()
        BannedAccounts = {}
        MySQL.Async.fetchAll('SELECT * FROM wtrp_bans', {}, function(info)
            for i = 1, #info do
                if info[i].isBanned == 1 then
                    Citizen.Wait(2)
                    table.insert(BannedAccounts, {info[i]})
                end
            end
        end)
    end)
end

MySQL.ready(function()
	ReloadBans()
    print("LISTA DE BANS CARREGADA")
end)

function IsPlayerAllowedToBan(player)
    local allowed = false
	local xPlayer = ESX.GetPlayerFromId(player)
	local grupo = xPlayer.getGroup()
	
	if grupo == 'admin' or grupo == 'superadmin' then
		allowed = true
	end
	--[[
	for i, id in ipairs(Admins) do
		for x, pid in ipairs(GetPlayerIdentifiers(player)) do
			if string.lower(pid) == string.lower(id) then
				allowed = true
			end
		end
	end		
	--]]
    return allowed
end

function DiscordLog(source, method)
    PerformHttpRequest('https://discord.com/api/webhooks/1078117029791404042/2u_TJ2Fr319WSaXf1_2b-uBfbQAL8Qk80OtjyI4sOQ141RZ1Tp1ms9kD8uZfqcPijkRG', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'Jogador',
    embeds =  {{["color"] = 65280,
                ["author"] = {["name"] = 'Johnny Logs',
                ["icon_url"] = ''},
                ["description"] = "** 🌐 LOG BANS 🌐**\n```css\n[Nome]: " ..GetPlayerName(source).. "\n" .. "[ID]: " .. source.. "\n" .. "[Método]: " .. method .. "\n```",
                ["footer"] = {["text"] = "© Johnny Logs- "..os.date("%x %X  %p"),
                ["icon_url"] = '',},}
                },
    avatar_url = ''
    }),
    {['Content-Type'] = 'application/json'
    })
end
