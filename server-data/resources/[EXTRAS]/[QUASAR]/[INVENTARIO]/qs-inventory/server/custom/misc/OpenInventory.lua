RegisterNetEvent('inventory:server:OpenInventory', function(name, id, other, entityModel)
	local src = source
	local ply = Player(src)
	local jobName = GetJobName(src)
    local IsVehicleOwned = exports['qs-inventory']:IsVehicleOwned(id)

	if ply.state.inv_busy then
		return TriggerClientEvent("inventory:client:sendTextMessage", src, Lang("INVENTORY_NOTIFICATION_NOT_ACCESSIBLE"), 'error')
	end
	if name and id then
		local secondInv = {}
		if name == "stash" then
			if Stashes[id] then
				if Stashes[id].isOpen then
					local Target = GetPlayerFromId(Stashes[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Stashes[id].isOpen, name, id, Stashes[id].label)
					else
						Stashes[id].isOpen = false
					end
				end
			end
			local maxweight = 1000000
			local slots = 50
			if other then
				maxweight = other.maxweight or 1000000
				slots = other.slots or 50
			end
			secondInv.name = "stash-"..id
			secondInv.label = "Stash-"..id
			secondInv.maxweight = maxweight
			secondInv.inventory = {}
			secondInv.slots = slots
			if Stashes[id] and Stashes[id].isOpen then
				secondInv.name = "none-inv"
				secondInv.label = "Stash-None"
				secondInv.maxweight = 1000000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				local stashItems = exports['qs-inventory']:GetStashItems(id)
				if next(stashItems) then
					secondInv.inventory = stashItems
					Stashes[id] = {}
					Stashes[id].items = stashItems
					Stashes[id].isOpen = src
					Stashes[id].label = secondInv.label
				else
					Stashes[id] = {}
					Stashes[id].items = {}
					Stashes[id].isOpen = src
					Stashes[id].label = secondInv.label
				end
			end
		elseif name == "trunk" then
			if Trunks[id] then
				if Trunks[id].isOpen then
					local Target = GetPlayerFromId(Trunks[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Trunks[id].isOpen, name, id, Trunks[id].label)
					else
						Trunks[id].isOpen = false
					end
				end
			end
			secondInv.name = "trunk-"..id
			secondInv.label = Lang("INVENTORY_NUI_TRUNK_LABEL").."-"..id
			secondInv.maxweight = other.maxweight or 60000
			secondInv.inventory = {}
			secondInv.slots = other.slots or 50
			if (Trunks[id] and Trunks[id].isOpen) or (SplitStr(id, "PLZI")[2] and jobName ~= "police") then
				secondInv.name = "none-inv"
				secondInv.label = Lang("INVENTORY_NUI_TRUNK_LABEL").."-None"
				secondInv.maxweight = other.maxweight or 60000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				if id then
					local ownedItems = exports['qs-inventory']:GetOwnedVehicleItems(id)
					if IsVehicleOwned and next(ownedItems) then
						secondInv.inventory = ownedItems
						Trunks[id] = {}
						Trunks[id].items = ownedItems
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					elseif Trunks[id] and not Trunks[id].isOpen then
						secondInv.inventory = Trunks[id].items
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					else
						Trunks[id] = {}
						Trunks[id].items = {}
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					end
				end
			end
		elseif name == "glovebox" then
			if Gloveboxes[id] then
				if Gloveboxes[id].isOpen then
					local Target = GetPlayerFromId(Gloveboxes[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Gloveboxes[id].isOpen, name, id, Gloveboxes[id].label)
					else
						Gloveboxes[id].isOpen = false
					end
				end
			end
			secondInv.name = "glovebox-"..id
			secondInv.label = Lang("INVENTORY_NUI_GLOVEBOX_LABEL").."-"..id
			secondInv.maxweight = other?.maxweight or 10000
			secondInv.inventory = {}
			secondInv.slots = other?.slots or 10
			if Gloveboxes[id] and Gloveboxes[id].isOpen then
				secondInv.name = "none-inv"
				secondInv.label = Lang("INVENTORY_NUI_GLOVEBOX_LABEL").."-None"
				secondInv.maxweight = 10000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				local ownedItems = exports['qs-inventory']:GetOwnedVehicleGloveboxItems(id)
				if Gloveboxes[id] and not Gloveboxes[id].isOpen then
					secondInv.inventory = Gloveboxes[id].items
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				elseif IsVehicleOwned and next(ownedItems) then
					secondInv.inventory = ownedItems
					Gloveboxes[id] = {}
					Gloveboxes[id].items = ownedItems
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				else
					Gloveboxes[id] = {}
					Gloveboxes[id].items = {}
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				end
			end
		elseif name == "shop" then
			secondInv.name = "itemshop-"..id
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = exports['qs-inventory']:SetupShopItems(other.items)
			ShopItems[id] = {}
			ShopItems[id].items = other.items
			ShopItems[id].account = other.type or 'money'
			secondInv.slots = #other.items
		elseif name == "selling" then
			secondInv.name = "selling-"..id
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = exports['qs-inventory']:SetupSellingItems(id, other.items)
			SellItems[id] = {}
			SellItems[id].items = other.items
			secondInv.slots = #other.items
		elseif name == "garbage" then
			if not entityModel then DebugPrint('Model for garbage system not found') end
			secondInv.name = "garbage_" .. id
			secondInv.label = Lang("INVENTORY_NUI_GARBAGE_LABEL").."-"..id
			secondInv.maxweight = 900000
			if GarbageItems[id] == nil then
				GarbageItems[id] = {}
				local items = {}
				Config.GarbageItems[id] = Config.GarbageItemsForProp[entityModel].items[math.random(1, #Config.GarbageItemsForProp[entityModel].items)]
				for a, x in pairs(Config.GarbageItems[id]) do
					items[a] = table.clone(x)
					items[a].amount = math.random(x.amount.min, x.amount.max)
				end
				GarbageItems[id].items = items
			end
			secondInv.inventory = exports['qs-inventory']:SetupGarbageItems(id, GarbageItems[id].items)
			secondInv.slots = 30
		elseif name == "traphouse" then
			secondInv.name = "traphouse-"..id
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = other.slots
		elseif name == "crafting" then
			secondInv.name = "crafting"
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = #other.items
		elseif name == "attachment_crafting" then
			secondInv.name = "attachment_crafting"
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = #other.items
		elseif name == "otherplayer" then
			id = tonumber(id)
			local OtherPlayer = GetPlayerFromId(id)
			if OtherPlayer then
				secondInv.name = "otherplayer-"..id
				secondInv.label = "Player-"..id
				secondInv.maxweight = Config.InventoryWeight.weight
				secondInv.inventory = inventories[id]
				if (jobName == "police") then
					secondInv.slots = Config.InventoryWeight.slots
				else
					secondInv.slots = Config.InventoryWeight.slots - 1
				end
				Citizen.Wait(250)
			end
		else
			if Drops[id] then
				if Drops[id].isOpen then
					local Target = GetPlayerFromId(Drops[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Drops[id].isOpen, name, id, Drops[id].label)
					else
						Drops[id].isOpen = false
					end
				end
			end
			if Drops[id] and not Drops[id].isOpen then
				secondInv.coords = Drops[id].coords
				secondInv.name = id
				secondInv.label = "Dropped-"..tostring(id)
				secondInv.maxweight = 100000
				secondInv.inventory = Drops[id].items
				secondInv.slots = 30
				Drops[id].isOpen = src
				Drops[id].label = secondInv.label
				Drops[id].createdTime = os.time()
			else
				secondInv.name = "none-inv"
				secondInv.label = "Dropped-None"
				secondInv.maxweight = 100000
				secondInv.inventory = {}
				secondInv.slots = 0
			end
		end
		TriggerClientEvent("inventory:client:closeinv", id)
		Citizen.Wait(0)
		TriggerClientEvent("inventory:client:OpenInventory", src, {}, inventories[src], secondInv)
	else
		TriggerClientEvent("inventory:client:OpenInventory", src, {}, inventories[src])
	end
end)