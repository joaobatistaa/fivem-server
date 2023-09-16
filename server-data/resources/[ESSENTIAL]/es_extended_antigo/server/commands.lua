local modoadmin = false

QS = nil

TriggerEvent('qs-core:getSharedObject', function(library) QS = library end)

RegisterServerEvent('modoadmin:server:TogglePermissao')
AddEventHandler('modoadmin:server:TogglePermissao', function(estado)
	modoadmin = estado
end)

--[[
ESX.RegisterCommand('limpararmas', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		local xPlayer = QS.GetPlayerFromId(args.playerId.source)
		if xPlayer then
			xPlayer.ClearInventoryWeapons()

			local time = os.date('%H:%M')
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
				args = { "Apagaste todas as armas do jogador "..GetPlayerName(tonumber(args.playerId.source)) , time }
			})
			ESX.DiscordLogFields("UserActions", "/limpararmas Utilizado", "blue", {
				{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
				{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId.source)), inline = true}
			})
			--TriggerEvent('DiscordBot:limpouloadout', xPlayer.source, args.playerId)
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Não existe nenhum <span style='color:#ff0000'>jogador</span> com esse <span style='color:#ff0000'>ID</span>!", 5000, 'error')
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = _U('command_clearloadout'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})
--]]

ESX.RegisterCommand('tp', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
		local coords = "X = "..args.x.." , Y = "..args.y.." , Z = "..args.z
		ESX.DiscordLogFields("UserActions", "/tp Utilizado", "blue", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Coords", value = coords, inline = true}
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = TranslateCap('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = TranslateCap('command_setcoords_x'), type = 'number'},
	{name = 'y', help = TranslateCap('command_setcoords_y'), type = 'number'},
	{name = 'z', help = TranslateCap('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		if ESX.DoesJobExist(args.job, args.grade) then
			args.playerId.setJob(args.job, args.grade)
			ESX.DiscordLogFields("UserActions", "/setjob Utilizado", "pink", {
				{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
				{name = "Emprego", value = args.job, inline = true},
				{name = "Cargo", value = args.grade, inline = true}
			})
			local time = os.date('%H:%M')
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
				args = { "Definiste o emprego de " , time, GetPlayerName(tonumber(args.playerId.source)), " para "..args.job.." - "..args.grade.."."}
			})
		else
			showError(TranslateCap('command_setjob_invalid'))
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = TranslateCap('command_setjob_job'), type = 'string'},
	{name = 'grade', help = TranslateCap('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('car', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		local GameBuild = tonumber(GetConvar("sv_enforceGameBuild", 2802))
		if not args.car then args.car = GameBuild >= 2699 and "draugur" or "prototipo" end
		ESX.DiscordLogFields("UserActions", "/car Utilizado", "pink", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Veículo", value = args.car, inline = true}
		})
		
		xPlayer.triggerEvent('esx:spawnVehicle', args.car)
		
		--[[
		local upgrades = Config.MaxAdminVehicles and {
			plate = "ADMINCAR", 
			modEngine = 3,
			modBrakes = 2,
			modTransmission = 2,
			modSuspension = 3,
			modArmor = true,
			windowTint = 1,
		} or {}
		local coords = xPlayer.getCoords(true)
		local PlayerPed = GetPlayerPed(xPlayer.source)
		local model = args.car
		local plate = nil

		if IsModelInCdimage(tostring(model)) then
			ESX.OneSync.SpawnVehicle(model, coords - vector3(0,0, 0.9), GetEntityHeading(PlayerPed), upgrades, function(networkId)
				local vehicle = NetworkGetEntityFromNetworkId(networkId)
				TaskWarpPedIntoVehicle(PlayerPed, vehicle, -1)
			end)
		else
			--local time = os.date('%H:%M')
			local years, months, days, hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
			local time = hours..":"..minutes
			TriggerEvent('chat:addMessage', {
				template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">Modelo do veículo inválido!</div></div>',
				args = { time }
			})
		end
		--]]
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = TranslateCap('command_car'), validate = false, arguments = {
	{name = 'car',validate = false, help = TranslateCap('command_car_car'), type = 'string'}
}}) 

ESX.RegisterCommand({'cardel', 'dv'}, 'admin', function(xPlayer, args, showError)
	if modoadmin then	
		local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source), false)
		if DoesEntityExist(PedVehicle) then
			DeleteEntity(PedVehicle)
		else
			local Vehicles = ESX.OneSync.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(xPlayer.source)), tonumber(args.radius) or 5.0)
			for i=1, #Vehicles do 
				local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
				if DoesEntityExist(Vehicle) then
					DeleteEntity(Vehicle)
				end
			end
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = TranslateCap('command_cardel'), validate = false, arguments = {
	{name = 'radius',validate = false, help = TranslateCap('command_cardel_radius'), type = 'number'}
}})

ESX.RegisterCommand('setaccountmoney', 'admin', function(xPlayer, args, showError)
	if modoadmin then	
		if xPlayer then
			if args.playerId.getAccount(args.account) then
				local time = os.date('%H:%M')
				args.playerId.setAccountMoney(args.account, args.amount, "Subsídio do governo")
				ESX.DiscordLogFields("UserActions", "/setaccountmoney ("..args.account..") Utilizado", "blue", {
					{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
					{name = "Quantia", value = args.amount, inline = true}
				})
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
					args = { "Definiste a quantia da conta "..args.account.. " de " , time, GetPlayerName(tonumber(args.playerId.source)), " para "..args.amount.."€."}
				})
				
			else
				showError(TranslateCap('command_giveaccountmoney_invalid'))
			end
		else
			if args.playerId.getAccount(args.account) then
				args.playerId.setAccountMoney(args.account, args.amount, "Subsídio do governo")
				ESX.DiscordLogFields("UserActions", "/setaccountmoney ("..args.account..") Utilizado", "blue", {
					{name = "Staff", value = 'CONSOLA (HOST)', inline = true},
					{name = "Quantia", value = args.amount, inline = true}
				})
				print("Definiste a quantia da conta "..args.acount.." de "..GetPlayerName(tonumber(args.playerId.source)).." para "..args.amount.."€.")
			else
				showError(TranslateCap('command_giveaccountmoney_invalid'))
			end
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_setaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = TranslateCap('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = TranslateCap('command_setaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('giveaccountmoney', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		if xPlayer then
			if args.playerId.getAccount(args.account) then
				local time = os.date('%H:%M')
				args.playerId.addAccountMoney(args.account, args.amount, "Subsídio do governo")
				
				ESX.DiscordLogFields("UserActions", "/giveaccountmoney ("..args.account..") Utilizado", "blue", {
					{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
					{name = "Jogador", value = GetPlayerName(args.playerId.source), inline = true},
					{name = "Quantia", value = args.amount, inline = true}
				})
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
					args = { "Deste "..args.amount.. "€ para " , time, GetPlayerName(tonumber(args.playerId.source)), " para a conta "..args.account.."."}
				})
			else
				showError(TranslateCap('command_giveaccountmoney_invalid'))
			end
		else
			local time = os.date('%H:%M')
			args.playerId.addAccountMoney(args.account, args.amount, "Subsídio do governo")
			ESX.DiscordLogFields("UserActions", "/giveaccountmoney ("..args.account..") Utilizado", "blue", {
				{name = "Staff", value = 'CONSOLA (HOST)', inline = true},
				{name = "Quantia", value = args.amount, inline = true}
			})
			print("Deste "..args.amount.."€ para a conta "..args.acount.." de "..GetPlayerName(tonumber(args.playerId.source))..".")
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_giveaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = TranslateCap('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = TranslateCap('command_giveaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('limparchat', 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:client:ClearChat')
	TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "SUCESSO", "<span style='color:#c7c7c7'>O CHAT foi <span style='color:#069a19'><b>LIMPO</b></span> com sucesso!", 5000, 'success')
	ESX.DiscordLogFields("UserActions", "/limparchat Utilizado", "green", {
		{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true}
	})
end, false, {help = TranslateCap('command_clear')})

ESX.RegisterCommand('limparchattodos', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('chat:client:ClearChat', -1)
	TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "SUCESSO", "<span style='color:#c7c7c7'>O CHAT foi <span style='color:#069a19'><b>LIMPO</b></span> com sucesso!", 5000, 'success')
	ESX.DiscordLogFields("UserActions", "/limparchattodos Utilizado", "green", {
		{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true}
	})
end, true, {help = TranslateCap('command_clearall')})

ESX.RegisterCommand("refreshjobs", 'admin', function(xPlayer, args, showError)
	ESX.RefreshJobs()
end, true, {help = TranslateCap('command_clearall')})

ESX.RegisterCommand('setgroup', 'superadmin', function(xPlayer, args, showError)
	if xPlayer then
		if modoadmin then
			local time = os.date('%H:%M')

			ESX.DiscordLogFields("UserActions", "/setgroup Utilizado", "red", {
				{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
				{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId.source)), inline = true},
				{name = "Novo Grupo", value = args.group, inline = true}
			})
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
				args = { "Definiste o grupo de " , time, GetPlayerName(tonumber(args.playerId.source)), "para "..args.group}
			})
			--if args.group == "superadmin" then args.group = "admin" print("[^3WARNING^7] ^5Superadmin^7 detected, setting group to ^5admin^7") end
			args.playerId.setGroup(args.group)
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
		end
	else
		args.playerId.setGroup(args.group)
		ESX.DiscordLogFields("UserActions", "/setgroup Utilizado", "red", {
			{name = "Staff", value = 'CONSOLA (HOST)', inline = true},
			{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId.source)), inline = true},
			{name = "Novo Grupo", value = args.group, inline = true}
		})
		print("O grupo do jogador "..GetPlayerName(tonumber(args.playerId.source)).." foi definido para "..args.group)
	end
end, true, {help = TranslateCap('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = TranslateCap('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('save', 'admin', function(xPlayer, args, showError)
	Core.SavePlayer(args.playerId)
	print("[^2Info^0] Saved Player - ^5".. args.playerId.source .. "^0")
end, true, {help = TranslateCap('command_save'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('saveall', 'admin', function(xPlayer, args, showError)
	Core.SavePlayers()
end, true, {help = TranslateCap('command_saveall')})

ESX.RegisterCommand('permissao', {"user", "admin"}, function(xPlayer, args, showError)
	print(xPlayer.getName()..", Estás atualmente a: ^5".. xPlayer.getGroup() .. "^0")
end, true)

ESX.RegisterCommand('emprego', {"user", "admin"}, function(xPlayer, args, showError)
	print(xPlayer.getName()..", Estás atualmente a: ^5".. xPlayer.getJob().name.. "^0 - ^5".. xPlayer.getJob().grade_label .. "^0")
end, true)

ESX.RegisterCommand('info', {"user", "admin"}, function(xPlayer, args, showError)
	local job = xPlayer.getJob().name
	local jobgrade = xPlayer.getJob().grade_name
	print("^2ID : ^5"..xPlayer.source.." ^0| ^2Nome:^5"..xPlayer.getName().." ^0 | ^2Permissão:^5"..xPlayer.getGroup().."^0 | ^2Emprego:^5".. job.."^0")
end, true)

ESX.RegisterCommand('tpm', "admin", function(xPlayer, args, showError)
	if modoadmin then
		xPlayer.triggerEvent("esx:tpm")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true)

ESX.RegisterCommand('goto', "admin", function(xPlayer, args, showError)
	if modoadmin then
		local time = os.date('%H:%M')
		local targetCoords = args.playerId.getCoords()
		xPlayer.setCoords(targetCoords)
		local coords = "X= "..targetCoords.x..", Y= "..targetCoords.y..", Z= "..targetCoords.z
		ESX.DiscordLogFields("UserActions", "/goto Utilizado", "blue", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Jogador Destino", value = GetPlayerName(args.playerId.source), inline = true},
			{name = "Coords", value = coords, inline = true}
		})
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
			args = { "Foste teleportado até ao jogador " , time, GetPlayerName(args.playerId.source), "."}
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_goto'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('bring', "admin", function(xPlayer, args, showError)
	if modoadmin then
		local time = os.date('%H:%M')
		local playerCoords = xPlayer.getCoords()
		args.playerId.setCoords(playerCoords)

		local coords = "X= "..playerCoords.x..", Y= "..playerCoords.y..", Z= "..playerCoords.z
		ESX.DiscordLogFields("UserActions", "/bring Utilizado", "blue", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Jogador Destino", value = GetPlayerName(args.playerId.source), inline = true},
			{name = "Coords", value = coords, inline = true}
		})
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
			args = { "Deste bring ao jogador " , time, GetPlayerName(args.playerId.source), "."}
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_bring'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('kill', "admin", function(xPlayer, args, showError)
	if modoadmin then
		local time = os.date('%H:%M')
		args.playerId.triggerEvent("esx:killPlayer")
		
		ESX.DiscordLogFields("UserActions", "/kill Utilizado", "white", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId.source)), inline = true}
		})
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
			args = { "O jogador" , time, GetPlayerName(tonumber(args.playerId.source)), "foi morto."}
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_kill'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('freeze', "admin", function(xPlayer, args, showError)
	if modoadmin then
		local time = os.date('%H:%M')
		args.playerId.triggerEvent('esx:freezePlayer', "freeze")
		ESX.DiscordLogFields("UserActions", "/freeze Utilizado", "white", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId.source)), inline = true}
		})
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
			args = { "O jogador" , time, GetPlayerName(tonumber(args.playerId.source)), "foi congelado"}
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_freeze'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('unfreeze', "admin", function(xPlayer, args, showError)
	if modoadmin then
		local time = os.date('%H:%M')
		args.playerId.triggerEvent('esx:freezePlayer', "unfreeze")
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
			args = { "O jogador" , time, GetPlayerName(tonumber(args.playerId.source)), "foi descongelado."}
		})
		ESX.DiscordLogFields("UserActions", "/unfreeze Utilizado", "white", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId.source)), inline = true}
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = TranslateCap('command_unfreeze'), validate = true, arguments = {
	{name = 'playerId', help = TranslateCap('commandgeneric_playerid'), type = 'player'}
}})

--[[
ESX.RegisterCommand("noclip", 'admin', function(xPlayer, args, showError)
	if modoadmin then
		xPlayer.triggerEvent('esx:noclip')
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false)
--]]

ESX.RegisterCommand('players', "admin", function(xPlayer, args, showError)
	local xPlayers = ESX.GetExtendedPlayers() -- Returns all xPlayers
	print("^5"..#xPlayers.." ^2jogadore(s) online^0")
	for i=1, #(xPlayers) do 
		local xPlayer = xPlayers[i]
		print("^1[ ^2ID : ^5"..xPlayer.source.." ^0| ^2Nome : ^5"..xPlayer.getName().." ^0 | ^2SteamID : ^5".. xPlayer.identifier .."^1]^0\n")
	end
end, true)

ESX.RegisterCommand('kick', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		if xPlayer then
			local player = args.playerId.source
			local playersteam = GetPlayerIdentifier(player)
			DropPlayer(player, args.reason)
			
			local time = os.date('%H:%M')

			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
				args = { "O jogador" , time, GetPlayerName(tonumber(player)), "foi expulso (" .. args.reason .. ")"}
			})
			ESX.DiscordLogFields("UserActions", "/kick Utilizado", "red", {
				{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
				{name = "Jogador Destino", value = GetPlayerName(tonumber(player)), inline = true},
				{name = "Razão", value = args.reason, inline = true},
			})
			--PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = "Administrator logs", content = "```css\n[" .. time .. "]> Por: " .. sname .. " | Ação: Kick ao jogador ("..player..") "..playername.." - Razão: "..args.reason..". \nSteam Hex: " .. playersteam .. "\n```"}), { ['Content-Type'] = 'application/json' })
		else
			local player = args.playerId.source
			local playersteam = GetPlayerIdentifier(player)
			DropPlayer(player, args.reason)
			
			ESX.DiscordLogFields("UserActions", "/kick Utilizado", "red", {
				{name = "Staff", value = 'Consola (HOST)', inline = true},
				{name = "Jogador Destino", value = GetPlayerName(player), inline = true},
				{name = "Razão", value = args.reason, inline = true},
			})
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = 'Expulsar um jogador', validate = true, arguments = {
	{name = 'playerId', help = 'ID do Jogador', type = 'player'},
	{name = 'reason', help = 'Razão do Kick', type = 'string'}
}})

ESX.RegisterCommand('slap', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		local player = args.playerId.source
		
		local time = os.date('%H:%M')
		TriggerClientEvent('esx:slap', player)
		--TriggerEvent('DiscordBot:slap', xPlayer.source, player)
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
			args = { "O jogador" , time, GetPlayerName(player), "levou um impulso"}
		})
		ESX.DiscordLogFields("UserActions", "/slap Utilizado", "blue", {
			{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
			{name = "Jogador Destino", value = GetPlayerName(player), inline = true}
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = 'Dar um estalo num jogador', validate = true, arguments = {
	{name = 'playerId', help = 'ID do Jogador', type = 'player'}
}})

--[[
ESX.RegisterCommand('die', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		TriggerClientEvent('admin:kill', xPlayer.source)
		--TriggerEvent('DiscordBot:suicidio', xPlayer.source)
		ESX.DiscordLogFields("UserActions", "/die Utilizado", "blue", {
			{name = "Staff", value = xPlayer.name, inline = true},
			{name = "Jogador Destino", value = GetPlayerName(args.playerId), inline = true}
		})
		
		local time = os.date('%H:%M')
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
			args = { "Suicidaste-te!" , time }
		})
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, true, {help = 'Suicidar-se'})
--]]
--[[
ESX.RegisterCommand('slay', 'admin', function(xPlayer, args, showError)
	if modoadmin then	
		local player = args.playerId
		if args.playerId then
			TriggerClientEvent('admin:kill', player)
			TriggerEvent('DiscordBot:matou', xPlayer.source, player)
			
			local time = os.date('%H:%M')
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
				args = { "O jogador" , time, GetPlayerName(player), "foi morto"}
			})
		else
			TriggerClientEvent('admin:kill', xPlayer.source)
			TriggerEvent('DiscordBot:matou', xPlayer.source, xPlayer.source)
			local time = os.date('%H:%M')
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
				args = { "Suicidaste-te!" , time }
			})
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = 'Matar um jogador', validate = false, arguments = {
	{name = 'playerId', help = 'ID do Jogador', type = 'any'}
}})
--]]

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	if modoadmin then

		if args.playerId then

			local xPlayer2 = ESX.GetPlayerFromId(args.playerId)
			
			if xPlayer2 ~= nil then
				xPlayer2.triggerEvent('esx_ambulancejob:revLoureivero')	
				local time = os.date('%H:%M')
				
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
					args = { "O jogador" , time, GetPlayerName(tonumber(args.playerId)), "levou revive."}
				})
				ESX.DiscordLogFields("UserActions", "/revive Utilizado", "green", {
					{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
					{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId)), inline = true}
				})
				--TriggerEvent('DiscordBot:deurevive', xPlayer.source, args.playerId)
			else
				local time = os.date('%H:%M')
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">Não existe nenhum jogador no servidor com esse ID!</div></div>',
					args = { time }
				})
			end
		else
			xPlayer.triggerEvent('esx_ambulancejob:revLoureivero')
			local time = os.date('%H:%M')
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
				args = { "O jogador" , time, GetPlayerName(xPlayer.source), "levou revive."}
			})
			ESX.DiscordLogFields("UserActions", "/revive Utilizado", "green", {
				{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
				{name = "Jogador Destino", value = GetPlayerName(xPlayer.source), inline = true}
			})
			--TriggerEvent('DiscordBot:deurevive', xPlayer.source, xPlayer.source)
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = 'Reviver um jogador', validate = false, arguments = {
	{name = 'playerId', help = 'ID do Jogador', type = 'any'}
}})

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		if args.playerId then
			local xPlayer2 = ESX.GetPlayerFromId(args.playerId)
			if xPlayer2 ~= nil then
				--TriggerClientEvent('mythic_hospital:client:RemoveBleed', args.playerId)
				--TriggerClientEvent('mythic_hospital:client:ResetLimbs', args.playerId)
				TriggerClientEvent('esx_basicneeds:healPlayer', args.playerId)
				local time = os.date('%H:%M')
				TriggerClientEvent('chat:addMessage', args.playerId, {
					template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
					args = { "A tua vida, fome e sede foram regeneradas por um staff." , time }
				})
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0} <span style="color: #df7b00">{2}</span> {3}</b></div></div>',
					args = { "O jogador" , time, GetPlayerName(tonumber(args.playerId)), "levou heal (vida, fome e sede)."}
				})
				ESX.DiscordLogFields("UserActions", "/heal Utilizado", "green", {
					{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
					{name = "Jogador Destino", value = GetPlayerName(tonumber(args.playerId)), inline = true}
				})
			else
				local time = os.date('%H:%M')
				TriggerClientEvent('chat:addMessage', xPlayer.source, {
					template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">Não existe nenhum jogador no servidor com esse ID!</div></div>',
					args = { time }
				})
			end
		else
			TriggerClientEvent('esx_basicneeds:healPlayer', xPlayer.source)

			local time = os.date('%H:%M')
			TriggerClientEvent('chat:addMessage', xPlayer.source, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
				args = { "A tua vida, fome e sede foram regeneradas." , time }
			})
			ESX.DiscordLogFields("UserActions", "/heal Utilizado", "green", {
				{name = "Staff", value = GetPlayerName(xPlayer.source), inline = true},
				{name = "Jogador Destino", value = GetPlayerName(xPlayer.source), inline = true}
			})
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = 'Curar um jogador - regenera a vida, fome e sede', validate = false, arguments = {
	{name = 'playerId', help = 'ID do Jogador', type = 'any'}
}})

ESX.RegisterCommand('mapper', 'admin', function(xPlayer, args, showError)
	if modoadmin then
		TriggerClientEvent('es_mapper:toggle', xPlayer.source)
		TriggerEvent('DiscordBot:mapper', xPlayer.source)
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar em <span style='color:#ff0000'>modo admin</span> para executares esse comando!", 5000, 'error')
	end
end, false, {help = 'Modo Edição de Mapa'})
