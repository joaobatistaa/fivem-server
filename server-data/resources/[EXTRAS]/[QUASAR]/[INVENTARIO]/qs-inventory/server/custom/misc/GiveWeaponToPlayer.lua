local function GiveWeaponToPlayer(source, item, amount)
	local id = source
	local identifier = GetPlayerIdentifier(id)
	amount = tonumber(amount)
	local itemData = ItemList[item:lower()]
	if not identifier then return end
	if itemData then
		local info = {}
        if itemData["type"] == "weapon" then
			info.serie = exports['qs-inventory']:CreateSerialNumber()
			info.quality = 100
            info.ammo = amount
        end

        if itemData["type"] ~= "weapon" or amount > 250 then return end
		if exports['qs-inventory']:AddItem(id, itemData["name"], 1, false, info) then
			TriggerClientEvent("inventory:client:sendTextMessage", source, Lang("INVENTORY_NOTIFICATION_GIVE_ITEM").." "..amount.." "..itemData["name"], 'error')
			TriggerClientEvent('inventory:client:ItemBox', source, ItemList[itemData["name"]], 'add')
			exports['qs-inventory']:SendWebhook(Webhooks.admin, "Give Weapon To Player (Admin)", 7393279, "**".. GetPlayerName(source) .. "**(id: "..source..") sent a weapon; name: **"..itemData["name"].."**, bullets: **" .. amount .. "**")
		else
			TriggerClientEvent("inventory:client:sendTextMessage", source, Lang("INVENTORY_NOTIFICATION_CANT_GIVE"), 'error')
		end
	else
		TriggerClientEvent("inventory:client:sendTextMessage", source, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
	end
end

exports('GiveWeaponToPlayer', GiveWeaponToPlayer)