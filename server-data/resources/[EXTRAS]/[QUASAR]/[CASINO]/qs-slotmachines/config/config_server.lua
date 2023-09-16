local activeSlot = {}
local activeSlotPlayers = {}

RegisterNetEvent('casino:taskStartSlots')
AddEventHandler('casino:taskStartSlots',function(index, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Config.ChipsItem)
	if item.count >= data.bet then
		if activeSlot[index] then
			xPlayer.removeInventoryItem(Config.ChipsItem,data.bet)
			local w = {a = math.random(1,16),b = math.random(1,16),c = math.random(1,16)}
			
			local rnd1 = math.random(1,100)
			local rnd2 = math.random(1,100)
			local rnd3 = math.random(1,100)
			
			if Config.Offset then
				if rnd1 > 70 then w.a = w.a + 0.5 end
				if rnd2 > 70 then w.b = w.b + 0.5 end
				if rnd3 > 70 then w.c = w.c + 0.5 end
			end
			TriggerClientEvent("qs-slotmachines:sendMessage", source, Lang("BETTING") .. data.bet .. ' ' .. Lang("CHIPS_NAME"), "inform")
			TriggerClientEvent('casino:slots:startSpin', source, index, w)
			activeSlot[index].win = w
		end
	else 
		TriggerClientEvent("qs-slotmachines:sendMessage", source, Lang("NOT_ENOUGH_CHIPS") , "error")
	end
end)

function CheckForWin(w, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	local a = Config.Wins[w.a]
	local b = Config.Wins[w.b]
	local c = Config.Wins[w.c]

	local total = 0
	if a == b and b == c and a == c then
		if Config.Mult[a] then
			total = data.bet*Config.Mult[a]
		end		
	elseif a == '6' and b == '6' then
		total = data.bet*3
	elseif a == '6' and c == '6' then
		total = data.bet*3
	elseif b == '6' and c == '6' then
		total = data.bet*3
		
	elseif a == '6' then
		total = data.bet*2
	elseif b == '6' then
		total = data.bet*2
	elseif c == '6' then
		total = data.bet*2
	end
	if total > 0 then
		TriggerClientEvent("qs-slotmachines:sendMessage", source, Lang("YOU_WIN") .. total .. " " .. Lang("CHIPS_NAME"), "success")
		xPlayer.addInventoryItem(Config.ChipsItem, total)
	end
end

ESX.RegisterServerCallback('casino:slots:isSeatUsed',function(source, cb, index)
	if activeSlot[index] ~= nil then
		if activeSlot[index].used then
			cb(true)
		else
			activeSlot[index].used = true
			activeSlotPlayers[source] = index
			cb(false)
		end
	else
		activeSlot[index] = {}
		activeSlotPlayers[source] = index
		activeSlot[index].used = true
		cb(false)
	end
end)

RegisterNetEvent('casino:slotsCheckWin')
AddEventHandler('casino:slotsCheckWin',function(index, data, dt)
	if activeSlot[index] then
		if activeSlot[index].win then
			if activeSlot[index].win.a == data.a and activeSlot[index].win.b == data.b and activeSlot[index].win.c == data.c then
				CheckForWin(activeSlot[index].win, dt)
			end
		end
	end
end)

RegisterNetEvent('casino:slots:notUsing')
AddEventHandler('casino:slots:notUsing',function(index)
	if activeSlot[index] ~= nil then
		activeSlot[index].used = false
		activeSlotPlayers[source] = nil
	end
end)

AddEventHandler('playerDropped',function()
	if activeSlotPlayers[source] then 
		activeSlot[activeSlotPlayers[source]].used = false
		activeSlotPlayers[source] = nil
	end
end)