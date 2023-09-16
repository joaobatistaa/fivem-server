ESX = nil

ESX = exports['es_extended']:getSharedObject()

local playerPlayTime = {} -- tabela para armazenar o tempo jogado de cada jogador

Citizen.CreateThread(function()
    while true do
        for _, playerId in ipairs(GetPlayers()) do
            if playerId ~= nil and tonumber(playerId) > 0 then
                local playerName = GetPlayerName(playerId)
                local xPlayer = ESX.GetPlayerFromId(playerId)
                if xPlayer then
                    local identifier = xPlayer.identifier

                    if playerPlayTime[identifier] == nil then -- jogador não encontrado na tabela, inserir novo registro
                        playerPlayTime[identifier] = {tempo = 0}
                    else
                        playerPlayTime[identifier] = {tempo = playerPlayTime[identifier].tempo + 1}
                    end
                end
            end
        end
        Citizen.Wait(60000) -- aguarda 1 minuto
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(305000) -- aguarda 5 minutos
        SavePlayersPlayTimeToDB()
    end
end)

AddEventHandler('playerDropped', function(reason)
    local playerId = source

    if playerId ~= nil and tonumber(playerId) > 0 then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            local identifier = xPlayer.identifier
        end

        SavePlayerPlayTimeToDB(identifier)
    end
    
end)


function SavePlayersPlayTimeToDB()
    for playerIdentifier, playTime in pairs(playerPlayTime) do
        if playerPlayTime[playerIdentifier] ~= nil then
            local query = "UPDATE users SET tempo_jogado = tempo_jogado + " .. playerPlayTime[playerIdentifier].tempo .. " WHERE identifier = '" .. playerIdentifier .. "'"
            MySQL.Async.execute(query, {}, function(rowsChanged)
                if rowsChanged == 0 then -- jogador não encontrado na tabela, inserir novo registro
                    --local insertQuery = "INSERT INTO tempojogado (steamid, nome, tempo_jogado) VALUES ('" .. playerIdentifier .. "', '" .. playerPlayTime[playerIdentifier].nome .. "'," .. playerPlayTime[playerIdentifier].tempo .. ")"
                    --MySQL.Async.execute(insertQuery, {})
					print('erro ao guardar tempo jogador')
                end
            end)
        end
    end
end

function SavePlayerPlayTimeToDB(playerIdentifier)
    if playerPlayTime[playerIdentifier] ~= nil then
        local query = "UPDATE users SET tempo_jogado = tempo_jogado + " .. playerPlayTime[playerIdentifier].tempo .. " WHERE identifier = '" .. playerIdentifier .. "'"
        MySQL.Async.execute(query, {}, function(rowsChanged)
            if rowsChanged == 0 then -- jogador não encontrado na tabela, inserir novo registro
                --local insertQuery = "INSERT INTO users (steamid, nome, tempo_jogado) VALUES ('" .. playerIdentifier .. "', '" .. playerPlayTime[playerIdentifier].nome .. "'," .. playerPlayTime[playerIdentifier].tempo .. ")"
                --MySQL.Async.execute(insertQuery, {})
				print('erro ao guardar tempo jogador')
            end
        end)
    end
end

RegisterCommand('toptempojogado', function(source, args, rawCommand)
    MySQL.Async.fetchAll('SELECT name, tempo_jogado FROM users ORDER BY tempo_jogado DESC LIMIT 10', {}, function(results)
        for i, result in ipairs(results) do
            local playerName = result.name
            local playTime = result.tempo_jogado

            if playTime >= 60 then
                local hours = math.floor(playTime / 60)
                local minutes = playTime % 60
                if hours == 1 and minutes == 1 then
                    formattedPlayTime = tostring(hours) .. " hora e " .. tostring(minutes) .. " minuto"
                elseif hours == 1 and minutes ~= 1 then
                    formattedPlayTime = tostring(hours) .. " hora e " .. tostring(minutes) .. " minutos"
                elseif hours ~= 1 and minutes == 1 then
                    formattedPlayTime = tostring(hours) .. " horas e " .. tostring(minutes) .. " minuto"
                else
                    formattedPlayTime = tostring(hours) .. " horas e " .. tostring(minutes) .. " minutos"
                end
            elseif playTime == 1 then
                formattedPlayTime = tostring(playTime) .. " minuto"
            else
                formattedPlayTime = tostring(playTime) .. " minutos"
            end

            TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 255},
            args = {'#'.. tostring(i) .. ' | ' .. playerName .. ' - ' .. formattedPlayTime}
            })
        end
    end)
end)

RegisterCommand('tempojogado', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT name, tempo_jogado FROM users WHERE identifier = @steamid', {
        ['@steamid'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            local playerName = result[1].name
            local playTime = result[1].tempo_jogado

            if playTime >= 60 then
                local hours = math.floor(playTime / 60)
                local minutes = playTime % 60
                if hours == 1 and minutes == 1 then
                    formattedPlayTime = tostring(hours) .. " hora e " .. tostring(minutes) .. " minuto"
                elseif hours == 1 and minutes ~= 1 then
                    formattedPlayTime = tostring(hours) .. " hora e " .. tostring(minutes) .. " minutos"
                elseif hours ~= 1 and minutes == 1 then
                    formattedPlayTime = tostring(hours) .. " horas e " .. tostring(minutes) .. " minuto"
                else
                    formattedPlayTime = tostring(hours) .. " horas e " .. tostring(minutes) .. " minutos"
                end
            elseif playTime == 1 then
                formattedPlayTime = tostring(playTime) .. " minuto"
            else
                formattedPlayTime = tostring(playTime) .. " minutos"
            end

            TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 255},
            args = {playerName .. ' - ' .. formattedPlayTime}
            })
        end
    end)
end)
