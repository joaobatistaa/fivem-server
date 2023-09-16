local function ItemsToItemInfo()
	local itemInfos = {
		[1] = {costs = ItemList["metalscrap"]["label"] .. ": 22x, " ..ItemList["plastic"]["label"] .. ": 32x."},
		[2] = {costs = ItemList["metalscrap"]["label"] .. ": 30x, " ..ItemList["plastic"]["label"] .. ": 42x."},
		[3] = {costs = ItemList["metalscrap"]["label"] .. ": 30x, " ..ItemList["plastic"]["label"] .. ": 45x, "..ItemList["aluminum"]["label"] .. ": 28x."},
		[4] = {costs = ItemList["electronickit"]["label"] .. ": 2x, " ..ItemList["plastic"]["label"] .. ": 52x, "..ItemList["steel"]["label"] .. ": 40x."},
		[5] = {costs = ItemList["metalscrap"]["label"] .. ": 10x, " ..ItemList["plastic"]["label"] .. ": 50x, "..ItemList["aluminum"]["label"] .. ": 30x, "..ItemList["iron"]["label"] .. ": 17x, "..ItemList["electronickit"]["label"] .. ": 1x."},
		[6] = {costs = ItemList["metalscrap"]["label"] .. ": 36x, " ..ItemList["steel"]["label"] .. ": 24x, "..ItemList["aluminum"]["label"] .. ": 28x."},
		[7] = {costs = ItemList["metalscrap"]["label"] .. ": 32x, " ..ItemList["steel"]["label"] .. ": 43x, "..ItemList["plastic"]["label"] .. ": 61x."},
		[8] = {costs = ItemList["metalscrap"]["label"] .. ": 50x, " ..ItemList["steel"]["label"] .. ": 37x, "..ItemList["copper"]["label"] .. ": 26x."},
		[9] = {costs = ItemList["iron"]["label"] .. ": 60x, " ..ItemList["glass"]["label"] .. ": 30x."},
		[10] = {costs = ItemList["aluminum"]["label"] .. ": 60x, " ..ItemList["glass"]["label"] .. ": 30x."},
		[11] = {costs = ItemList["iron"]["label"] .. ": 33x, " ..ItemList["steel"]["label"] .. ": 44x, "..ItemList["plastic"]["label"] .. ": 55x, "..ItemList["aluminum"]["label"] .. ": 22x."},
		[12] = {costs = ItemList["iron"]["label"] .. ": 50x, " ..ItemList["steel"]["label"] .. ": 50x, "..ItemList["screwdriverset"]["label"] .. ": 3x, "..ItemList["advancedlockpick"]["label"] .. ": 2x."},
	}

	local items = {}
	for _, item in pairs(Config.CraftingItems) do
		local itemInfo = ItemList[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.CraftingItems = items
end

exports('ItemsToItemInfo', ItemsToItemInfo)

local function SetupAttachmentItemsInfo()
	local itemInfos = {
		[1] = {costs = ItemList["metalscrap"]["label"] .. ": 140x, " .. ItemList["steel"]["label"] .. ": 250x, " .. ItemList["rubber"]["label"] .. ": 60x"},
		[2] = {costs = ItemList["metalscrap"]["label"] .. ": 165x, " .. ItemList["steel"]["label"] .. ": 285x, " .. ItemList["rubber"]["label"] .. ": 75x"},
		[3] = {costs = ItemList["metalscrap"]["label"] .. ": 190x, " .. ItemList["steel"]["label"] .. ": 305x, " .. ItemList["rubber"]["label"] .. ": 85x, " .. ItemList["smg_extendedclip"]["label"] .. ": 1x"},
		[4] = {costs = ItemList["metalscrap"]["label"] .. ": 205x, " .. ItemList["steel"]["label"] .. ": 340x, " .. ItemList["rubber"]["label"] .. ": 110x, " .. ItemList["smg_extendedclip"]["label"] .. ": 2x"},
		[5] = {costs = ItemList["metalscrap"]["label"] .. ": 230x, " .. ItemList["steel"]["label"] .. ": 365x, " .. ItemList["rubber"]["label"] .. ": 130x"},
		[6] = {costs = ItemList["metalscrap"]["label"] .. ": 255x, " .. ItemList["steel"]["label"] .. ": 390x, " .. ItemList["rubber"]["label"] .. ": 145x"},
		[7] = {costs = ItemList["metalscrap"]["label"] .. ": 270x, " .. ItemList["steel"]["label"] .. ": 435x, " .. ItemList["rubber"]["label"] .. ": 155x"},
		[8] = {costs = ItemList["metalscrap"]["label"] .. ": 300x, " .. ItemList["steel"]["label"] .. ": 469x, " .. ItemList["rubber"]["label"] .. ": 170x"},
	}

	local items = {}
	for _, item in pairs(Config.AttachmentCrafting["items"]) do
		local itemInfo = ItemList[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.AttachmentCrafting["items"] = items
end

exports('SetupAttachmentItemsInfo', SetupAttachmentItemsInfo)