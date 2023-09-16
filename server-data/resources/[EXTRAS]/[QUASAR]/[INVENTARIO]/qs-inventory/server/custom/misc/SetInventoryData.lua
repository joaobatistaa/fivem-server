RegisterNetEvent('inventory:server:SetInventoryData', function(fromInventory, toInventory, fromSlot, toSlot, fromAmount, toAmount, fromInventoryIsClothesInventory, toInventoryIsClothesInventory)
	local src = source
	local Player = GetPlayerFromId(src)
	local identifier = GetPlayerIdentifier(src)
	fromSlot = tonumber(fromSlot)
	toSlot = tonumber(toSlot)

	if (fromInventory == "player" or fromInventory == "hotbar") and (SplitStr(toInventory, "-")[1] == "itemshop" or toInventory == "crafting") then
		return
	end

	if fromInventoryIsClothesInventory and toInventoryIsClothesInventory then
		return
	end

	if (SplitStr(fromInventory, "-")[1] == "selling") then
		return
	end

	if fromInventoryIsClothesInventory then
		if not ClotheItems?[identifier] then return end
		local item = ClotheItems?[identifier]?.items?[fromSlot]
		if not item then return end
		local itemIsClothPart = checkItemIsClothingPart(item.name)
		if not itemIsClothPart then  
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_CANT_MOVE"), 'inform')
			return
		end
		TriggerClientEvent('clothes:takeOffClothes', src, item.name)
		exports['qs-inventory']:AddItem(src, item.name, 1, toSlot, item.info)
		exports['qs-inventory']:RemoveFromClothes(identifier, fromSlot, item.name, 1)
		TriggerClientEvent('inventory:saveClothes', src)
		return
	elseif toInventoryIsClothesInventory then
		local item = exports['qs-inventory']:GetItemBySlot(src, fromSlot)
		if not item then return end
		local itemIsClothPart = checkItemIsClothingPart(item.name)
		if not itemIsClothPart then  
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_CANT_MOVE"), 'inform')
			return
		end
		exports['qs-inventory']:UseItem(item.name, src, item)
		exports['qs-inventory']:AddToClothes(identifier, item.name, item.info)
		exports['qs-inventory']:RemoveItem(src, item.name, 1, fromSlot)
		TriggerClientEvent('inventory:saveClothes', src)
		return
	end

	if SplitStr(toInventory, "-")[1] == "selling" then
		if fromInventory ~= "player" and fromInventory ~= "hotbar" then return end
		local fromItemData = exports['qs-inventory']:GetItemBySlot(src, fromSlot)
		fromAmount = tonumber(fromAmount) and tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local sell_id = SplitStr(toInventory, "-")[2]
			local toItemData = SellItems[sell_id].items[toSlot]
			DebugPrint(toItemData.name, fromItemData.name)
			if toItemData and toItemData.name == fromItemData.name then
				exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
				local price = exports['qs-inventory']:getPriceItemForSelling(fromItemData.name)
				if not price then return end
				if fromAmount == 0 then
					return TriggerClientEvent("inventory:client:sendTextMessage", src, "Debes colocar un monto antes de vender...", 'error')
				end
				AddAccountMoney(src, 'money', price * fromAmount)
				TriggerClientEvent("inventory:client:sendTextMessage", src, price * fromAmount.." "..Lang("INVENTORY_NOTIFICATION_SELLING_SUCCESS"), 'success')
				exports['qs-inventory']:SendWebhook(Webhooks.sell, "Item Sale", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") sold an item; name: **"..fromItemData.name.."**, price: **" ..price * fromAmount.. "**, amount: **" ..fromAmount.. "**")
			else
				TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_SELLING_BAD_ITEM"), 'error')
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_SELLING_BAD_ITEM"), 'error')
		end
		return
	end

	if fromInventory == "player" or fromInventory == "hotbar" then
		local fromItemData = exports['qs-inventory']:GetItemBySlot(src, fromSlot)
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.Link, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount.. "**")
					end
				end
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			elseif SplitStr(toInventory, "-")[1] == "otherplayer" then
				local playerId = tonumber(SplitStr(toInventory, "-")[2])
				local toItemData = inventories[playerId][toSlot]
				exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData then
					local itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(playerId, itemInfo["name"], toAmount, fromSlot)
						exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
					end
				end
				local itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddItem(playerId, itemInfo["name"], fromAmount, toSlot, fromItemData.info)
			elseif SplitStr(toInventory, "-")[1] == "trunk" then
				local plate = SplitStr(toInventory, "-")[2]
				local toItemData = Trunks[plate].items[toSlot]
				exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData then
					local itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveFromTrunk(plate, fromSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
					end
				end
				local itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.trunk, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in trunk; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
			elseif SplitStr(toInventory, "-")[1] == "glovebox" then
				local plate = SplitStr(toInventory, "-")[2]
				local toItemData = Gloveboxes[plate].items[toSlot]
				exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData then
					local itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
					end
				end
				local itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.glovebox, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in glovebox; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
			elseif SplitStr(toInventory, "-")[1] == "stash" then
				local stashId = SplitStr(toInventory, "-")[2]
				local toItemData = Stashes[stashId].items[toSlot]
				exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData then
					local itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*")
					end
				end
				local itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.stash, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in stash; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - stash id: *" .. stashId .. "*")
			elseif SplitStr(toInventory, "_")[1] == "garbage" then
				local garbageId = SplitStr(toInventory, "_")[2]
				local toItemData = GarbageItems[garbageId].items[toSlot]
				exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData then
					local itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveFromGarbage(garbageId, toSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - garbage: *" .. garbageId .. "*")
					end
				end
				local itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToGarbage(garbageId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.garbage, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in garbage; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - garbage id: *" .. garbageId .. "*")
			elseif SplitStr(toInventory, "-")[1] == "traphouse" then
				-- Traphouse
				local traphouseId = SplitStr(toInventory, "_")[2]
				local toItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, toSlot)
				local IsItemValid = exports['qb-traphouse']:CanItemBeSaled(fromItemData.name:lower())
				if IsItemValid then
					exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData  then
						local itemInfo = ItemList[toItemData.name:lower()]
						toAmount = tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"], toAmount)
							exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
							exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - traphouse: *" .. traphouseId .. "*")
						end
					end
					local itemInfo = ItemList[fromItemData.name:lower()]
					exports['qb-traphouse']:AddHouseItem(traphouseId, toSlot, itemInfo["name"], fromAmount, fromItemData.info, src)
					exports['qs-inventory']:SendWebhook(Webhooks.swap, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in traphouse; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - traphouse id: *" .. traphouseId .. "*")
				else
					TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_CANT_SELL"), 'error')
				end
			else
				-- drop
				toInventory = tonumber(toInventory)
				if toInventory == nil or toInventory == 0 then
					exports['qs-inventory']:CreateNewDrop(src, fromSlot, toSlot, fromAmount)
					exports['qs-inventory']:SendWebhook(Webhooks.drop, "Create New Drop", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") create new drop!")
				else
					local toItemData = Drops[toInventory].items[toSlot]
					exports['qs-inventory']:RemoveItem(src, fromItemData.name, fromAmount, fromSlot)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData then
						local itemInfo = ItemList[toItemData.name:lower()]
						toAmount = tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							exports['qs-inventory']:AddItem(src, toItemData.name, toAmount, fromSlot, toItemData.info)
							exports['qs-inventory']:RemoveFromDrop(toInventory, fromSlot, itemInfo["name"], toAmount)
							exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - dropid: *" .. toInventory .. "*")
						end
					end
					local itemInfo = ItemList[fromItemData.name:lower()]
					exports['qs-inventory']:AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
					exports['qs-inventory']:SendWebhook(Webhooks.drop, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in drop; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - drop id: *" .. toInventory .. "*")
					if itemInfo["name"] == "radio" then
						--TriggerClientEvent('Radio.Set', src, false)
						TriggerClientEvent('ls-radio:onRadioDrop2', src)
						
					elseif itemInfo["name"] == 'money' and Config.Framework == 'esx' then
						local money = exports['qs-inventory']:GetItemTotalAmount(src, 'money')
						Player.setAccountMoney('money', money, 'dropped')
					elseif itemInfo["name"] == 'black_money' and Config.Framework == 'esx' then
						local money = exports['qs-inventory']:GetItemTotalAmount(src, 'black_money')
						Player.setAccountMoney('black_money', money, 'dropped')
					end
					TriggerClientEvent('inventory:ClearWeapons', src)
				end
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_GIVE_DONT_HAVE"), 'error')
		end
	elseif SplitStr(fromInventory, "-")[1] == "otherplayer" then
		local playerId = tonumber(SplitStr(fromInventory, "-")[2])
		local fromItemData = inventories[playerId][fromSlot]
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local itemInfo = ItemList[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qs-inventory']:RemoveItem(playerId, itemInfo["name"], fromAmount, fromSlot)
				exports['qs-inventory']:SendWebhook(Webhooks.robbery, "Deposit Item (robbery)", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in inventory (robbery); name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "**, otherplayer id: **" .. playerId .. "**")
				TriggerClientEvent("inventory:client:CheckWeapon", playerId, fromItemData.name)
				if toItemData then
					itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qs-inventory']:AddItem(playerId, itemInfo["name"], toAmount, fromSlot, toItemData.info)
					end
				end
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = inventories[playerId][toSlot]
				exports['qs-inventory']:RemoveItem(playerId, itemInfo["name"], fromAmount, fromSlot)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qs-inventory']:RemoveItem(playerId, itemInfo["name"], toAmount, toSlot)
						exports['qs-inventory']:AddItem(playerId, itemInfo["name"], toAmount, fromSlot, toItemData.info)
					end
				end
				itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddItem(playerId, itemInfo["name"], fromAmount, toSlot, fromItemData.info)
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
		end
	elseif SplitStr(fromInventory, "-")[1] == "trunk" then
		local plate = SplitStr(fromInventory, "-")[2]
		local fromItemData = Trunks[plate].items[fromSlot]
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local itemInfo = ItemList[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qs-inventory']:RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qs-inventory']:AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*")
					end
				end
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = Trunks[plate].items[toSlot]
				exports['qs-inventory']:RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qs-inventory']:RemoveFromTrunk(plate, toSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.trunk, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in trunk; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
		end
	elseif SplitStr(fromInventory, "-")[1] == "glovebox" then
		local plate = SplitStr(fromInventory, "-")[2]
		local fromItemData = Gloveboxes[plate].items[fromSlot]
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local itemInfo = ItemList[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qs-inventory']:RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qs-inventory']:AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: *"..src..")* swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*")
					end
				end
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = Gloveboxes[plate].items[toSlot]
				exports['qs-inventory']:RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qs-inventory']:RemoveFromGlovebox(plate, toSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.glovebox, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in glovebox; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
		end
	elseif SplitStr(fromInventory, "-")[1] == "stash" then
		local stashId = SplitStr(fromInventory, "-")[2]
		local fromItemData = Stashes[stashId].items[fromSlot]
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local itemInfo = ItemList[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qs-inventory']:RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qs-inventory']:AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** stash: *" .. stashId .. "*")
					end
				end
				exports['qs-inventory']:SaveStashItems(stashId, Stashes[stashId].items)
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = Stashes[stashId].items[toSlot]
				exports['qs-inventory']:RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qs-inventory']:RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.stash, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in stash; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - stash id: *" .. stashId .. "*")
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
		end
	elseif SplitStr(fromInventory, "_")[1] == "garbage" then
		local garbageId = SplitStr(fromInventory, "_")[2]
		local fromItemData = GarbageItems[garbageId].items[fromSlot]
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local itemInfo = ItemList[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qs-inventory']:RemoveFromGarbage(garbageId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qs-inventory']:AddToGarbage(garbageId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** garbage: *" .. garbageId .. "*")
					end
				end
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = GarbageItems[garbageId].items[toSlot]
				exports['qs-inventory']:RemoveFromGarbage(garbageId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qs-inventory']:RemoveFromGarbage(garbageId, toSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddToGarbage(garbageId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToGarbage(garbageId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.garbage, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in garbage; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - garbage id: *" .. garbageId .. "*")
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
		end
	elseif SplitStr(fromInventory, "-")[1] == "traphouse" then
		local traphouseId = SplitStr(fromInventory, "-")[2]
		local fromItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, fromSlot)
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local itemInfo = ItemList[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					itemInfo = ItemList[toItemData.name:lower()]
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qb-traphouse']:AddHouseItem(traphouseId, fromSlot, itemInfo["name"], toAmount, toItemData.info, src)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** stash: *" .. traphouseId .. "*")
					end
				end
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				local toItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, toSlot)
				exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qb-traphouse']:RemoveHouseItem(traphouseId, toSlot, itemInfo["name"], toAmount)
						exports['qb-traphouse']:AddHouseItem(traphouseId, fromSlot, itemInfo["name"], toAmount, toItemData.info, src)
					end
				end
				itemInfo = ItemList[fromItemData.name:lower()]
				exports['qb-traphouse']:AddHouseItem(traphouseId, toSlot, itemInfo["name"], fromAmount, fromItemData.info, src)
				exports['qs-inventory']:SendWebhook(Webhooks.traphouse, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in traphouse; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - traphouse id: *" .. traphouseId .. "*")
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
		end
	elseif SplitStr(fromInventory, "-")[1] == "itemshop" then
		local shopType = SplitStr(fromInventory, "-")[2]
		local itemData = ShopItems[shopType].items[fromSlot]
		local itemInfo = ItemList[itemData.name:lower()]
		local bankBalance = GetAccountMoney(src, 'bank')
		local price = tonumber((itemData.price*fromAmount))
		local money = GetAccountMoney(src, ShopItems[shopType].account)

		if SplitStr(shopType, "_")[1] == "Dealer" then
			if SplitStr(itemData.name, "_")[1] == "weapon" then
				price = tonumber(itemData.price)
				if money >= price then
					RemoveAccountMoney(src, 'money', price or 0)
					itemData.info.serie = exports['qs-inventory']:CreateSerialNumber()
					itemData.info.quality = 100
					exports['qs-inventory']:AddItem(src, itemData.name, 1, toSlot, itemData.info)
					TriggerClientEvent('qb-drugs:client:updateDealerItems', src, itemData, 1)
					TriggerClientEvent("inventory:client:sendTextMessage", src, itemInfo["label"].." "..Lang("INVENTORY_NOTIFICATION_BOUGHT"), 'success')
					exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $"..price)
				else
					TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_NO_MONEY"), 'error')
					return
				end
			else
				if money >= price then
					exports['qs-inventory']:AddItem(src, itemData.name, fromAmount, toSlot, itemData.info)
					TriggerClientEvent('qb-drugs:client:updateDealerItems', src, itemData, fromAmount)
					TriggerClientEvent("inventory:client:sendTextMessage", src, itemInfo["label"].." "..Lang("INVENTORY_NOTIFICATION_BOUGHT"), 'success')
					exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. "  for $"..price)
				else
					TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_NO_MONEY"), 'error')
					return
				end
			end
		elseif SplitStr(shopType, "_")[1] == "Itemshop" then
			if money >= price then
				RemoveAccountMoney(src, ShopItems[shopType].account, price or 0)
                if SplitStr(itemData.name, "_")[1] == "weapon" then
                    itemData.info.serie = exports['qs-inventory']:CreateSerialNumber()
					itemData.info.quality = 100
                end
				exports['qs-inventory']:AddItem(src, itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('shops:client:UpdateShop', src, SplitStr(shopType, "_")[2], itemData, fromAmount)
				TriggerClientEvent("inventory:client:sendTextMessage", src, itemInfo["label"].." "..Lang("INVENTORY_NOTIFICATION_BOUGHT"), 'success')
				exports['qs-inventory']:SendWebhook(Webhooks.bought, "Shop item bought", 7393279, "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $"..price)
			else
				TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_NO_MONEY"), 'error')
				return
			end
		else
			if money >= price then
				RemoveAccountMoney(src, 'money', price or 0)
				exports['qs-inventory']:AddItem(src, itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent("inventory:client:sendTextMessage", src, itemInfo["label"].." "..Lang("INVENTORY_NOTIFICATION_BOUGHT"), 'success')
				exports['qs-inventory']:SendWebhook(Webhooks.bought, "Shop item bought", 7393279, "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $"..price)
			else
				TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_NO_MONEY"), 'error')
				return
			end
		end
	elseif fromInventory == "crafting" then
		local itemData = Config.CraftingItems[fromSlot]
		if exports['qs-crafting'] and exports['qs-crafting'].GetCraftingInfo then
			itemData = (exports['qs-crafting']:GetCraftingInfo())[fromSlot]
		end

		if exports['qs-inventory']:hasCraftItems(src, itemData.costs, fromAmount) then
			TriggerClientEvent("inventory:client:CraftItems", src, itemData.name, itemData.costs, fromAmount, toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEMS"), 'error')
		end
	elseif fromInventory == "attachment_crafting" then
		local itemData = Config.AttachmentCrafting["items"][fromSlot]
		if exports['qs-inventory']:hasCraftItems(src, itemData.costs, fromAmount) then
			TriggerClientEvent("inventory:client:CraftAttachment", src, itemData.name, itemData.costs, fromAmount, toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEMS"), 'error')
		end
	else
		-- drop
		fromInventory = tonumber(fromInventory)
		local fromItemData = Drops[fromInventory].items[fromSlot]
		fromAmount = tonumber(fromAmount) or fromItemData.amount
		if fromItemData and fromItemData.amount >= fromAmount then
			local itemInfo = ItemList[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = exports['qs-inventory']:GetItemBySlot(src, toSlot)
				exports['qs-inventory']:RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					toAmount = tonumber(toAmount) and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qs-inventory']:RemoveItem(src, toItemData.name, toAmount, toSlot)
						exports['qs-inventory']:AddToDrop(fromInventory, toSlot, itemInfo["name"], toAmount, toItemData.info)
						exports['qs-inventory']:SendWebhook(Webhooks.swap, "Swapped Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") swapped item; name: **"..toItemData.name.."**, amount: **" .. toAmount .. "** with item; name: **"..fromItemData.name.."**, amount: **" .. fromAmount .. "** - dropid: *" .. fromInventory .. "*")
						if itemInfo["name"] == "radio" then
							--TriggerClientEvent('Radio.Set', src, false)
							TriggerClientEvent('ls-radio:onRadioDrop2', src)
						elseif itemInfo["name"] == 'money' and Config.Framework == 'esx' then
							local money = exports['qs-inventory']:GetItemTotalAmount(src, 'money')
							Player.setAccountMoney('money', money, 'dropped')
						elseif itemInfo["name"] == 'black_money' and Config.Framework == 'esx' then
							local money = exports['qs-inventory']:GetItemTotalAmount(src, 'black_money')
							Player.setAccountMoney('black_money', money, 'dropped')
						end
						TriggerClientEvent('inventory:ClearWeapons', src)
					end
				end
				exports['qs-inventory']:AddItem(src, fromItemData.name, fromAmount, toSlot, fromItemData.info)
			else
				toInventory = tonumber(toInventory)
				local toItemData = Drops[toInventory].items[toSlot]
				exports['qs-inventory']:RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData then
					toAmount = tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						itemInfo = ItemList[toItemData.name:lower()]
						exports['qs-inventory']:RemoveFromDrop(toInventory, toSlot, itemInfo["name"], toAmount)
						exports['qs-inventory']:AddToDrop(fromInventory, fromSlot, itemInfo["name"], toAmount, toItemData.info)
						if itemInfo["name"] == "radio" then
							--TriggerClientEvent('Radio.Set', src, false)
							TriggerClientEvent('ls-radio:onRadioDrop2', src)
						elseif itemInfo["name"] == 'money' and Config.Framework == 'esx' then
							local money = exports['qs-inventory']:GetItemTotalAmount(src, 'money')
							Player.setAccountMoney('money', money, 'dropped')
						elseif itemInfo["name"] == 'black_money' and Config.Framework == 'esx' then
							local money = exports['qs-inventory']:GetItemTotalAmount(src, 'black_money')
							Player.setAccountMoney('black_money', money, 'dropped')
						end
						TriggerClientEvent('inventory:ClearWeapons', src)
					end
				end
				itemInfo = ItemList[fromItemData.name:lower()]
				exports['qs-inventory']:AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
				exports['qs-inventory']:SendWebhook(Webhooks.drop, "Deposit Item", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") deposit item in drop; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - drop id: *" .. toInventory .. "*")
				if itemInfo["name"] == "radio" then
					--TriggerClientEvent('Radio.Set', src, false)
					TriggerClientEvent('ls-radio:onRadioDrop2', src)
				elseif itemInfo["name"] == 'money' and Config.Framework == 'esx' then
					local money = exports['qs-inventory']:GetItemTotalAmount(src, 'money')
					Player.setAccountMoney('money', money, 'dropped')
				elseif itemInfo["name"] == 'black_money' and Config.Framework == 'esx' then
					local money = exports['qs-inventory']:GetItemTotalAmount(src, 'black_money')
					Player.setAccountMoney('black_money', money, 'dropped')
				end
				TriggerClientEvent('inventory:ClearWeapons', src)
			end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
		end
	end
end)