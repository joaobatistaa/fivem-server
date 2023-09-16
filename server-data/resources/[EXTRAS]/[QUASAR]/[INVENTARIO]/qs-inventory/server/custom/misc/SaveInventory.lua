RegisterNetEvent('inventory:server:SaveInventory', function(type, id)
	local src = source
    local IsVehicleOwned = exports['qs-inventory']:IsVehicleOwned(id)
	if type == "trunk" then
		if IsVehicleOwned then
			exports['qs-inventory']:SaveOwnedVehicleItems(id, Trunks[id].items)
		else
			Trunks[id].isOpen = false
		end
	elseif type == "glovebox" then
		if (IsVehicleOwned) then
			exports['qs-inventory']:SaveOwnedGloveboxItems(id, Gloveboxes[id].items)
		else
			Gloveboxes[id].isOpen = false
		end
	elseif type == "stash" then
		exports['qs-inventory']:SaveStashItems(id, Stashes[id].items)
	elseif type == "drop" then
		if Drops[id] then
			Drops[id].isOpen = false
			if Drops[id].items == nil or next(Drops[id].items) == nil then
				Drops[id] = nil
				TriggerClientEvent("inventory:client:RemoveDropItem", -1, id)
			end
		end
	elseif type == 'clothing' then
		local identifier = GetPlayerIdentifier(src)
		if not ClotheItems[identifier] then return end
		exports['qs-inventory']:SaveClotheItems(identifier, ClotheItems[identifier].items)
	end
end)