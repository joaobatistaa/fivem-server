RegisterNetEvent('inventory:server:UseItemSlot', function(slot)
	local src = source
	local itemData = exports['qs-inventory']:GetItemBySlot(src, slot)
	if not itemData then return end
	exports['qs-inventory']:useItemSlot(src, itemData)
end)