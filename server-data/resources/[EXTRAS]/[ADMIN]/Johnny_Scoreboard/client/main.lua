local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local idVisable = true
local group

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('johnny_core:setGroup')
AddEventHandler('johnny_core:setGroup', function(g)
	group = g
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = GetConvarInt('sv_maxclients', 355),
		uptime = 'unknown',
		playTime = '00h 00m'
	})
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('esx_scoreboard:updatePing')
AddEventHandler('esx_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('esx_scoreboard:toggleID')
AddEventHandler('esx_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)

RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptime
	})
end)

RegisterNetEvent('esx_scoreboard:servicos')
AddEventHandler('esx_scoreboard:servicos', function(connectedPlayers)
	local ambulance, police, sheriff, taxi, mechanic, judge, laywer, reboques, exercito, staff, players = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do

		players = players + 1

		if v.job == 'ambulance' then
			ambulance = ambulance + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'taxi' then
			taxi = taxi + 1
		elseif v.job == 'mechanic' then
			mechanic = mechanic + 1
		elseif v.job == 'sheriff' then
			sheriff = sheriff + 1
		elseif v.job == 'judge' then
			judge = judge + 1
		elseif v.job == 'laywer' then
			laywer = laywer + 1
		elseif v.job == 'reboques' then
			reboques = reboques + 1
		end
		
		if v.group == 'mod' or v.group == 'admin' or v.group == 'superadmin' then
			staff = staff + 1
		end
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menuperso_servicos',
		{
		title    = '📄 Serviços',
		align    = 'top-left',
		elements = {
			{label = '🚑 INEM: '..ambulance,	value = ''},
			{label = '👮 PSP: ' ..police,	value = ''},
	--		{label = '💂 GNR: ' ..sheriff,	value = ''},
	--		{label = '🎖️ Exército: ' ..exercito,	value = ''},
			{label = '🔧 Mecânicos: '..mechanic,	value = ''},
			{label = '⚙️ Reboques: '..reboques,		value = ''},
			{label = "🚕 Táxi: "..taxi,      value = ''},
			{label = '🛡️ Juíz: '..judge, value = ''},
			{label = '⚖️ Advogado: '..laywer, value = ''},
			{label = '📛 Staff: '..staff, value = ''},
			{label = '', value = ''},
			{label = '🎮 Jogadores: ' ..players.. '/250 ', value = ''},
		}
	}, function(data2, menu2)
		menu2.close()
	end, function(data2, menu2)
		menu2.close()
	end)
	
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ambulance, police, sheriff, taxi, mechanic, judge, laywer, army, reboques, staff, players = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do
		
		if v.job == 'ambulance' then
			ambulance = ambulance + 1
			v.name = '🚑 '..v.name
		elseif v.job == 'police' then
			police = police + 1
			v.name = '👮 '..v.name
		elseif v.job == 'taxi' then
			taxi = taxi + 1
			v.name = '🚖 '..v.name
		elseif v.job == 'mechanic' then
			mechanic = mechanic + 1
			v.name = '🔧 '..v.name
		elseif v.job == 'sheriff' then
			sheriff = sheriff + 1
			v.name = '💂 '..v.name
		elseif v.job == 'judge' then
			judge = judge + 1
			v.name = '🛡️ '..v.name
		elseif v.job == 'laywer' then
			laywer = laywer + 1
			v.name = '⚖️ '..v.name
		elseif v.job == 'reboques' then
			reboques = reboques + 1
			v.name = '⚙️ '..v.name
		elseif v.job == 'army' then
			army = army + 1
			v.name = '🎖️ '..v.name
		end
		
		if num == 1 then
			if v.group == 'mod' or v.group == 'admin' or v.group == 'superadmin' then
				v.name = '⛔ '..v.name
			end
			table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 2
		elseif num == 2 then
			if v.group == 'mod' or v.group == 'admin' or v.group == 'superadmin' then
				v.name = '⛔ '..v.name
			end
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 3
		elseif num == 3 then
			if v.group == 'mod' or v.group == 'admin' or v.group == 'superadmin' then
				v.name = '⛔ '..v.name
			end
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 4
		elseif num == 4 then
			if v.group == 'mod' or v.group == 'admin' or v.group == 'superadmin' then
				v.name = '⛔ '..v.name
			end
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, v.ping))
			num = 1
		end

		players = players + 1
		
		if v.group == 'mod' or v.group == 'admin' or v.group == 'superadmin' then
			staff = staff + 1
		end
	end

	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ambulance = ambulance, police = police, taxi = taxi, mechanic = mechanic, sheriff = sheriff, judge = judge, laywer = laywer, reboques = reboques, army = army, staff = staff, player_count = players}
	})
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['F10']) and IsInputDisabled(0) then	
			ESX.TriggerServerCallback('Johnny_Scoreboard:isStaff', function(canOpen)
				if canOpen then
					ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
						UpdatePlayerTable(connectedPlayers)
					end)
					ToggleScoreBoard()
					Citizen.Wait(200)
				end
			end)
		end
	end
end)

RegisterCommand('scoreboard', function()
	ESX.TriggerServerCallback('Johnny_Scoreboard:isStaff', function(canOpen)
		if canOpen then
			ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
				UpdatePlayerTable(connectedPlayers)
			end)
			ToggleScoreBoard()
			Citizen.Wait(200)
		end
	end)
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end

Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)
