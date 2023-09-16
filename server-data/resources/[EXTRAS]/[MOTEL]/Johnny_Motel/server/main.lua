cachedData = {
    ["motels"] = {},
    ["storages"] = {},
    ["furnishings"] = {},
    ["names"] = {}
}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

MySQL.ready(function()
    local sqlTasks = {}

    table.insert(sqlTasks, function(callback)        
        local firstSqlQuery = [[
            SELECT
                userIdentifier, motelData
            FROM
                world_motels
        ]]

        MySQL.Async.fetchAll(firstSqlQuery, {
            
        }, function(response)
            for motelIndex, motelData in ipairs(response) do
                local decodedData = json.decode(motelData["motelData"])
    
                if not cachedData["motels"][decodedData["room"]] then
                    cachedData["motels"][decodedData["room"]] = {}
                    cachedData["motels"][decodedData["room"]]["rooms"] = {}
                end
    
                table.insert(cachedData["motels"][decodedData["room"]]["rooms"], {
                    ["motelData"] = decodedData
                })
            end
            
            callback(true)
        end)
    end)

    table.insert(sqlTasks, function(callback)  
        local secondSqlQuery = [[
            SELECT
                storageId, storageData
            FROM
                world_storages
        ]]
        
        MySQL.Async.fetchAll(secondSqlQuery, {
            
        }, function(response)
            for storageIndex, storageData in ipairs(response) do
                local decodedData = json.decode(storageData["storageData"])

                if not cachedData["storages"][storageData["storageId"]] then
                    cachedData["storages"][storageData["storageId"]] = {}
                    cachedData["storages"][storageData["storageId"]]["items"] = {}
                end

                cachedData["storages"][storageData["storageId"]] = decodedData
            end

            callback(true)
        end)
    end)

    table.insert(sqlTasks, function(callback)    
        local thirdSqlQuery = [[
            SELECT
                motelId, furnishingData, ownedFurnishingData
            FROM
                world_furnishings
        ]]

        MySQL.Async.fetchAll(thirdSqlQuery, {
            
        }, function(response)
            for furnishingIndex, furnishingData in ipairs(response) do
                local decodedFurnishingData = json.decode(furnishingData["furnishingData"] or "{}")
                local decodedOwnedFurnishingData = json.decode(furnishingData["ownedFurnishingData"] or "{}")

                cachedData["furnishings"][furnishingData["motelId"]] = {}
                cachedData["furnishings"][furnishingData["motelId"]]["furnishing"] = decodedFurnishingData
                cachedData["furnishings"][furnishingData["motelId"]]["ownedFurnishing"] = decodedOwnedFurnishingData
            end

            callback(true)
        end)
    end)

    Async.parallel(sqlTasks, function(responses)
        ESX.Trace("SQL Tasks finished.")
    end)
end)

RegisterServerEvent("james_motels:globalEvent")
AddEventHandler("james_motels:globalEvent", function(options)
    TriggerClientEvent("james_motels:eventHandler", -1, options["event"] or "none", options["data"] or nil)
end)

ESX.RegisterServerCallback("james_motels:fetchMotels", function(source, callback)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local sqlQuery = [[
            SELECT
                keyData
            FROM
                world_keys
            WHERE
                owner = @owner
        ]]

        MySQL.Async.fetchAll(sqlQuery, {
            ["@owner"] = player["identifier"]
        }, function(response)
            local playerKeys = {}

            for keyIndex, keyData in ipairs(response) do
                local decodedData = json.decode(keyData["keyData"])

                table.insert(playerKeys, decodedData)
            end

            GetCharacterName(player, function(playerName)
                callback(cachedData["motels"], cachedData["storages"], cachedData["furnishings"], playerKeys, playerName)
            end)
        end)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback("james_motels:addItemToStorage", function(source, callback, newTable, newItem, storageId)
    local player = ESX.GetPlayerFromId(source)

    if player then
        cachedData["storages"][storageId] = newTable

        if newItem["type"] == "item" then
            player.removeInventoryItem(newItem["name"], newItem["count"])
        elseif newItem["type"] == "weapon" then
            player.removeWeapon(newItem["name"], newItem["count"])
        elseif newItem["type"] == "black_money" then
            player.removeAccountMoney("black_money", newItem["count"])
        end
			
        TriggerClientEvent("james_motels:eventHandler", -1, "update_storages", {
            ["newTable"] = newTable,
            ["storageId"] = storageId
        })

        UpdateStorageDatabase(storageId, newTable)

        callback(true)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback("james_motels:takeItemFromStorage", function(source, callback, newTable, newItem, storageId)
    local player = ESX.GetPlayerFromId(source)

    if player then
        cachedData["storages"][storageId] = newTable

        if newItem["type"] == "item" then
            player.addInventoryItem(newItem["name"], newItem["count"])
        elseif newItem["type"] == "weapon" then
            player.addWeapon(newItem["name"], newItem["count"])
        elseif newItem["type"] == "black_money" then
            player.addAccountMoney("black_money", newItem["count"])
        end

        TriggerClientEvent("james_motels:eventHandler", -1, "update_storages", {
            ["newTable"] = newTable,
            ["storageId"] = storageId
        })

        UpdateStorageDatabase(storageId, newTable)

        callback(true)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback("james_motels:retreivePlayers", function(source, callback, playersSent)
	local player = ESX.GetPlayerFromId(source)

	if #playersSent <= 0 then
		callback(false)

		return
	end

	if player then
		local newPlayers = {}

        for playerIndex, playerSource in ipairs(playersSent) do
			local player = ESX.GetPlayerFromId(playerSource)

            local characterNames = cachedData["names"][player["source"]]

			if player then
				if player["source"] ~= source then
					table.insert(newPlayers, {
						["firstname"] = characterNames["firstname"],
						["lastname"] = characterNames["lastname"],
						["source"] = player["source"]
					})
				end
			end
		end

		callback(newPlayers)
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("james_motels:buyMotel", function(source, callback, room)
	local player = ESX.GetPlayerFromId(source)

    if player then
        if player.getMoney() >= Config.MotelPrice then
            player.removeMoney(Config.MotelPrice)
        elseif player.getAccount("bank")["money"] >= Config.MotelPrice then
            player.removeAccountMoney("bank", Config.MotelPrice)
        else
            return callback(false)
        end

        CreateMotel(source, room, function(confirmed, uuid)
            if confirmed then
                callback(true, uuid)
				TriggerClientEvent("james_motels:changeStatusInfo", source, 'comprar')
            else
                callback(false)
            end
        end)
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("james_motels:getPlayerDressing", function(source, cb)
    local player = ESX.GetPlayerFromId(source)
  
    TriggerEvent("esx_datastore:getDataStore", "property", player["identifier"], function(store)
        local count = store.count("dressing")

        local labels = {}
  
        for index = 1, count do
            local entry = store.get("dressing", index)

            table.insert(labels, entry["label"])
        end
  
        cb(labels)
    end)
end)
  
ESX.RegisterServerCallback("james_motels:getPlayerOutfit", function(source, cb, num)
    local player = ESX.GetPlayerFromId(source)

    TriggerEvent("esx_datastore:getDataStore", "property", player["identifier"], function(store)
        local outfit = store.get("dressing", num)

        cb(outfit["skin"])
    end)
end)

ESX.RegisterServerCallback("james_motels:saveFurnishing", function(source, callback, motelId, furnishingData, ownedFurnishingData)
    local player = ESX.GetPlayerFromId(source)

    if not player then return callback(false) end

    local sqlQuery = [[
        INSERT
            INTO
        world_furnishings
            (motelId, furnishingData)
        VALUES
            (@id, @data)
        ON DUPLICATE KEY UPDATE
            furnishingData = @data, ownedFurnishingData = @ownedData
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@id"] = motelId,
        ["@data"] = json.encode(furnishingData),
        ["@ownedData"] = json.encode(ownedFurnishingData)
    }, function(rowsChanged)
        if rowsChanged > 0 then
            if not cachedData["furnishings"][motelId] then
                cachedData["furnishings"][motelId] = {}
            end
        
            cachedData["furnishings"][motelId]["furnishing"] = furnishingData
            cachedData["furnishings"][motelId]["ownedFurnishing"] = ownedFurnishingData

            callback(true)
        else
            callback(false)
        end
    end)
end)

ESX.RegisterServerCallback("james_motels:checkMoney", function(source, callback)
    local player = ESX.GetPlayerFromId(source)

    if not player then return callback(false) end

    if player.getMoney() >= Config.KeyPrice then
        player.removeMoney(Config.KeyPrice)

        callback(true)
    elseif player.getAccount("bank")["money"] >= Config.KeyPrice then
        player.removeAccountMoney("bank", Config.KeyPrice)
        
        callback(true)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback("james_motels:sellMotel", function(source, callback, motelData)
    local player = ESX.GetPlayerFromId(source)

    if not player then return callback(false) end

    local removeSqlTasks = {}

    table.insert(removeSqlTasks, function(callback)        
        local sqlQuery = [[
            DELETE
                FROM
            world_motels
                WHERE
            userIdentifier = @identifier
        ]]

        MySQL.Async.execute(sqlQuery, {
            ["@identifier"] = player["identifier"]
        }, function(rowsChanged)
            if rowsChanged > 0 then
                callback(true)
            else
                callback(false)
            end
        end)
    end)

    table.insert(removeSqlTasks, function(callback)        
        local sqlQuery = [[
            DELETE
                FROM
            world_storages
                WHERE
            storageId = @motelId
        ]]

        MySQL.Async.execute(sqlQuery, {
            ["@motelId"] = "motel-" .. motelData["uniqueId"]
        }, function(rowsChanged)
            if rowsChanged > 0 then
                callback(true)
            else
                callback(false)
            end
        end)
    end)

    table.insert(removeSqlTasks, function(callback)        
        local sqlQuery = [[
            DELETE
                FROM
            world_furnishings
                WHERE
            motelId = @motelId
        ]]

        MySQL.Async.execute(sqlQuery, {
            ["@motelId"] = motelData["uniqueId"]
        }, function(rowsChanged)
            if rowsChanged > 0 then
                callback(true)
            else
                callback(false)
            end
        end)
    end)

    table.insert(removeSqlTasks, function(callback)        
        local sqlQuery = 'DELETE FROM world_keys WHERE keyData LIKE "%' .. motelData["uniqueId"] .. '%"'
        
        MySQL.Async.execute(sqlQuery, {
            
        }, function(rowsChanged)
            if rowsChanged > 0 then
                callback(true)
            else
                callback(false)
            end
        end)
    end)

    Async.parallel(removeSqlTasks, function(responses)
        if #responses == 4 then
            print("Motel successfully deleted on: " .. player["name"])
			ESX.Trace("Motel successfully deleted on: " .. player["name"])

            for roomIndex, roomData in ipairs(cachedData["motels"][motelData["room"]]["rooms"]) do
                if roomData["motelData"]["uniqueId"] == motelData["uniqueId"] then
                    table.remove(cachedData["motels"][motelData["room"]]["rooms"], roomIndex)

                    TriggerClientEvent("james_motels:eventHandler", -1, "update_motels", cachedData["motels"])
                    break
                end
            end
            player.addMoney(math.ceil(Config.MotelPrice / 2))

            callback(true)
			TriggerClientEvent("james_motels:changeStatusInfo", source, 'vender')
        else
            ESX.Trace("Motel deletion failed on: " .. player["name"])

            callback(false)
        end
    end)
end)

ESX.RegisterServerCallback("james_motels:purchaseFurnishing", function(source, callback, furnishingData, motelId)
    local player = ESX.GetPlayerFromId(source)

    if not player then return callback(false) end

    if player.getMoney() >= furnishingData["price"] then
        player.removeMoney(furnishingData["price"])
    elseif player.getAccount("bank")["money"] >= furnishingData["price"] then
        player.removeAccountMoney("bank", furnishingData["price"])
    else
        return callback(false)
    end

    if not cachedData["furnishings"][motelId] then
        cachedData["furnishings"][motelId] = {}
    end

    if not cachedData["furnishings"][motelId]["ownedFurnishing"] then
        cachedData["furnishings"][motelId]["ownedFurnishing"] = {}
    end

    furnishingData["coords"] = nil
    furnishingData["rotation"] = nil

    table.insert(cachedData["furnishings"][motelId]["ownedFurnishing"], furnishingData)

    local sqlQuery = [[
        INSERT
            INTO
        world_furnishings
            (motelId, ownedFurnishingData)
        VALUES
            (@id, @data)
        ON DUPLICATE KEY UPDATE
            ownedFurnishingData = @data
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@id"] = motelId,
        ["@data"] = json.encode(cachedData["furnishings"][motelId]["ownedFurnishing"])
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent("james_motels:eventHandler", -1, "update_owned_furnishing", {
                ["id"] = motelId,
                ["newData"] = cachedData["furnishings"][motelId]["ownedFurnishing"]
            })

            callback(true)
        else
            callback(false)
        end
    end)
end)

