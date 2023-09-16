RegisterServerEvent("inventory:server:GiveItem", function(target, name, amount, slot)
    local src = source
    local identifier = GetPlayerIdentifier(src)
	target = tonumber(target)
    local otherIdentifier = GetPlayerIdentifier(target)
    local dist = #(GetEntityCoords(GetPlayerPed(src))-GetEntityCoords(GetPlayerPed(target)))
	if src == target then return TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_CANT_GIVE"), 'error') end
	if dist > 2 then return TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_GIVE_FAR"), 'error') end
	local item = exports['qs-inventory']:GetItemBySlot(src, slot)
	if not item then TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_GIVE_NOT_FOUND"), 'error') return end
	if item.name ~= name then TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_GIVE_INCORRECT"), 'error') return end

	if amount <= item.amount then
		if amount == 0 then
			amount = item.amount
		end
		if exports['qs-inventory']:RemoveItem(src, item.name, amount, item.slot) then
			if exports['qs-inventory']:AddItem(target, item.name, amount, false, item.info) then
				TriggerClientEvent('inventory:client:ItemBox',target, ItemList[item.name], "add")
				local otherPlayerName = GetUserName(otherIdentifier)
				local playerName = GetUserName(identifier)
				TriggerClientEvent("inventory:client:sendTextMessage", target, Lang("INVENTORY_NOTIFICATION_GIVE_RECEIVED").." "..amount.." "..item.label.." "..Lang("INVENTORY_NOTIFICATION_GIVE_FROM").." "..playerName, 'inform')
				TriggerClientEvent("inventory:client:UpdatePlayerInventory", target, true)
				TriggerClientEvent('inventory:client:ItemBox',src, ItemList[item.name], "remove")
				TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_GAVE").." "..otherPlayerName.." "..amount.." "..item.label, 'inform')
				TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
				TriggerClientEvent('inventory:client:giveAnim', src)
				TriggerClientEvent('inventory:client:giveAnim', target)
				TriggerClientEvent("inventory:client:closeinv", target)
                exports['qs-inventory']:SendWebhook(Webhooks.giveitem, "Give Item To Player (Trade)", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") sent a item to player: **".. target .."**; name: **"..item.name.."**, amount: **" .. amount .. "**")
			else
				exports['qs-inventory']:AddItem(src, item.name, amount, item.slot, item.info)
				TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_OTHER_INVENTORY_FULL"), 'error')
				TriggerClientEvent("inventory:client:sendTextMessage", target, Lang("INVENTORY_NOTIFICATION_INVENTORY_FULL"), 'error')
				TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
				TriggerClientEvent("inventory:client:UpdatePlayerInventory", target, false)
				TriggerClientEvent("inventory:client:closeinv", target)
                exports['qs-inventory']:SendWebhook(Webhooks.giveitem, "Give Item To Player (Trade)", 7393279, "**".. GetPlayerName(src) .. "**(id: "..src..") sent a item to player: **".. target .."**; name: **"..item.name.."**, amount: **" .. amount .. "**")
            end
		else
			TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_INVALID_AMOUNT"), 'error')
		end
	else
		TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_INVALID_AMOUNT"), 'error')
	end
end)