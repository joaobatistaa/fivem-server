RegisterNetEvent('chat:ooc')
AddEventHandler('chat:ooc', function(playerId, name, message, time)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	if target ~= -1 then
		local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
		local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

		if targetPed == source or #(sourceCoords - targetCoords) < Config.OOCDistance then
			TriggerEvent('chat:addMessage', {
				template = '<div class="chat-message ooc"><i class="fas fa-globe"></i> <b><span style="color: #ababab">[OOC] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { name, message, time }
			})
		end
	end
end)