local function GiveItemToPlayer(source, item, amount)
	local id = source
	local identifier = GetPlayerIdentifier(id)
	amount = tonumber(amount)
	local itemData = ItemList[item:lower()]
	if not identifier then return end
	if itemData then
		local info = {}
		if itemData["name"] == "id_card" then
			local _, charinfo = GetUserName(identifier)
			info.firstname = charinfo.firstname
			info.lastname = charinfo.lastname
			info.birthdate = charinfo.dateofbirth
			info.gender = Config.Genders[charinfo.gender]
		elseif itemData["name"] == "driver_license" then
			local _, charinfo = GetUserName(identifier)
			info.firstname = charinfo.firstname
			info.lastname = charinfo.lastname
			info.birthdate = charinfo.dateofbirth
			info.type = "Class C Driver License"
		elseif itemData["type"] == "weapon" then
			info.serie = exports['qs-inventory']:CreateSerialNumber()
			info.quality = 100
			info.ammo = amount
		elseif itemData["name"] == "harness" then
			info.uses = 20
		elseif itemData["name"] == "plate" then
			info.plate = exports['qs-inventory']:GeneratePlate()
		elseif itemData["name"] == "markedbills" then
			info.worth = math.random(5000, 10000)
		elseif itemData["name"] == "labkey" then
			info.lab = exports["qb-methlab"]:GenerateRandomLab()
		elseif itemData["name"] == "printerdocument" then
			info.url = "https://cdn.discordapp.com/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png"
		end

		if itemData["type"] == "weapon" then 
			exports['qs-inventory']:AddItem(id, itemData["name"], 1, false, info)
			TriggerClientEvent('inventory:client:ItemBox', source, ItemList[itemData["name"]], 'add')
			exports['qs-inventory']:SendWebhook(Webhooks.admin, "Give Weapon To Player (Admin)", 7393279, "**".. GetPlayerName(source) .. "**(id: "..source..") sent a weapon; name: **"..itemData["name"].."**, bullets: **" .. amount .. "**")
			return
		end

		if exports['qs-inventory']:AddItem(id, itemData["name"], amount, false, info) then
			TriggerClientEvent("inventory:client:sendTextMessage", source, Lang("INVENTORY_NOTIFICATION_GIVE_ITEM").." "..amount.." "..itemData["name"], 'error')
			TriggerClientEvent('inventory:client:ItemBox', source, ItemList[itemData["name"]], 'add')
			exports['qs-inventory']:SendWebhook(Webhooks.admin, "Give Item To Player (Admin)", 7393279, "**".. GetPlayerName(source) .. "**(id: "..source..") sent a item; name: **"..itemData["name"].."**, amount: **" .. amount .. "**")
		else
			TriggerClientEvent("inventory:client:sendTextMessage", source, Lang("INVENTORY_NOTIFICATION_CANT_GIVE"), 'error')
		end
	else
		TriggerClientEvent("inventory:client:sendTextMessage", source, Lang("INVENTORY_NOTIFICATION_MISSING_ITEM"), 'error')
	end
end

exports('GiveItemToPlayer', GiveItemToPlayer)