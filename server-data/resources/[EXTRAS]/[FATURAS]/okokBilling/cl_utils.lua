ESX = exports.es_extended:getSharedObject()

Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(1)
		if IsControlJustReleased(1, Config.OpenMenuKey) then
			TriggerEvent(Config.EventPrefix..":OpenSelectionMenu")
		end
	end
end)

RegisterCommand(Config.OpenMenuCommand, function(source, args, rawCommand)
	TriggerEvent(Config.EventPrefix..":OpenSelectionMenu")
end)

RegisterNetEvent(Config.EventPrefix..":notification")
AddEventHandler(Config.EventPrefix..":notification", function(title, text, time, type)
	exports['Johnny_Notificacoes']:Alert(title, text, time, type)
end)

function onMenuClose()
	-- Code to execute when the menu is closed
end

function playerjob()
	return ESX.GetPlayerData().job
end

function playerjoblabel()
	return ESX.GetPlayerData().job.label
end

function playerIdentifier()
	return ESX.GetPlayerData().identifier
end

function getNearPlayers()
	ESX.TriggerServerCallback(Config.EventPrefix..":Get10NearestPlayers", function(nearestPlayers)
		if nearestPlayers ~= nil then
			if nearestPlayers[1] ~= nil then
				SendNUIMessage({
					action = 'updateNearPlayers',
					nearPlayers = nearestPlayers,
				})
			else
				TriggerEvent(Config.EventPrefix..':notification', _L('near_error').title, _L('near_error').text, _L('near_error').time, _L('near_error').type)
			end
		else
			TriggerEvent(Config.EventPrefix..':notification', _L('near_error').title, _L('near_error').text, _L('near_error').time, _L('near_error').type)
		end
	end)
end