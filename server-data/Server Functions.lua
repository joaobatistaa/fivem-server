-- SITE COMENTARIOS

https://fsymbols.com/generators/blocky/

-- ADDON CONVERTER

https://gta5mods.hk416.org/en

-- YTD OPTIMIZE

https://forum.cfx.re/t/how-to-optimize-texture-size-fixing-oversized-assets-bring-any-texture-dictionary-under-16-mb-physical-memory/1764640/5

======================================================================================================================================================

function SendTextMessage(msg, type)
    if type == 'inform' then 
        exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'info')
    end
    if type == 'error' then 
        exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'error')
    end
    if type == 'success' then 
        exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'success')
    end
end

"@oxmysql/lib/MySQL.lua",

-- remover

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- client -------------------
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


-- server ------------------
ESX = nil

ESX = exports['es_extended']:getSharedObject()

-----------------------------------------------------

shared_script '@es_extended/imports.lua'

-----------------------------------------

QS = nil
TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)

======================================================================================================================================================

-- quasar core

ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    local newPlate = GeneratePlate()
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    vehicleProps.plate = newPlate
    SetVehicleNumberPlateText(vehicle, newPlate)
    TriggerServerEvent('vehiclekeys:server:givekey', newPlate, vehicleData.model)
	
    if Config.EnableOwnedVehicles then
        TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
    end

    ESX.ShowNotification(_U('vehicle_purchased'))
end)

RegisterServerEvent('d3x_vehicleshop:setVehicleOwned')
AddEventHandler('d3x_vehicleshop:setVehicleOwned', function (matricula, modeloCarro)
	local _source = source
	local Player = QS.GetPlayerFromId (_source)
	
	
	TriggerEvent('vehiclekeys:server:givekey', matricula, modeloCarro)
end)


TriggerServerEvent('vehiclekeys:server:givekey', plate, model)
TriggerServerEvent('vehiclekeys:server:removekey', plate, model)

exports['qs-vehiclekeys']:GiveKeysAuto()
exports['qs-vehiclekeys']:GiveKeys(plate, model)
exports['qs-vehiclekeys']:RemoveKeys(plate, model)
exports['qs-vehiclekeys']:RemoveKeysAuto()

local vehicle = GetVehiclePedIsIn(playerPed, false)
local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

local vehicle = GetVehiclePedIsIn(playerPed, false) -- https://docs.fivem.net/natives/?_0x9A9112A0FE9A4713
local plate = ESX.Game.GetVehicleProperties(vehicle).plate
local plate = GetVehicleNumberPlateText(vehicle)


------- teste ------

RegisterCommand('teste', function(source)
	
	local qsPlayer = QS.GetPlayerFromId(source)
	
	info = {
		firstname = 'João',
		lastname = 'Batista',
		gender = 'M',
		dateofbirth = '11-10-2002',
		height = '180',
		numero_cc = '12358915'
	}
	
	qsPlayer.addItem("cartao_cidadao", 1, false, info) 
end)

local items = qsPlayer.PlayerData.items
for _, objeto in pairs(items) do
	if objeto.name == 'carta_conducao' then
		if objeto.info.numero_licenca == numero_licenca then
			qsPlayer.removeItem(objeto.name, 1, objeto.slot)
			return
		end
	end
end

======================================================================================================================================================

local data = {
	society = 'society_police',
	society_name = 'PSP',
	target = GetPlayerServerId(PlayerId()),
	targetName = -1,
	invoice_value = finalBillingPrice,
	author_name = 'PSP',
	invoice_item = 'Multa excesso de velocidade',
	invoice_notes = 'Notas: Radar (90KM/H) - A tua velocidade era: ' .. math.floor(SpeedKM) .. ' KM/H'					
}

TriggerServerEvent("okokBilling:CreateInvoice", data)

======================================================================================================================================================

-- permissão jogador

ESX.TriggerServerCallback('johnny:server:getGrupo', function(permissao)
	cargo = permissao
end)

======================================================================================================================================================

-- identidade

local identifier = xPlayer.identifier
local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
	['@identifier'] = identifier
})

local firstname = result[1].firstname
local lastname  = result[1].lastname
local sex       = result[1].sex
local dob       = result[1].dateofbirth

======================================================================================================================================================

-- teclas

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

======================================================================================================================================================

exports['mythic_notify']:DoHudText('inform', msg)

exports['mythic_notify']:DoHudText('error', msg)

exports['mythic_notify']:DoHudText('success', msg)

exports['mythic_notify']:DoHudText('roxo', msg)

TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = ''})

======================================================================================================================================================

exports['progressbar']:Progress({
	name = "unique_action_name",
	duration = 10000,
	label = "A montar item...",
	useWhileDead = false,
	canCancel = false,
	controlDisables = {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	},
	animation = {
		animDict = "mini@repair",
		anim = "fixing_a_player",
	},
	prop = {
		model = "p_amb_clipboard_01",
		bone = 18905,
		coords = { x = 0.10, y = 0.02, z = 0.08 },
		rotation = { x = -80.0, y = 0.0, z = 0.0 },
	},
	propTwo = {
		model = "prop_pencil_01",
		bone = 58866,
		coords = { x = 0.12, y = 0.0, z = 0.001 },
		rotation = { x = -150.0, y = 0.0, z = 0.0 },
	},
}, function(status)
	if not status then
		--Do Something If Event Wasn't Cancelled
	end
end)
Citizen.Wait(10000)
StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)

TriggerEvent("canUseInventoryAndHotbar:toggle", true)
TriggerEvent("canHandsUp:toggle", true)
exports['qs-smartphone']:canUsePhone(true)
	
======================================================================================================================================================

exports['qs-core']:Notify("Test Message", "primary")

exports['qs-core']:Notify("Test Message", "success")

exports['qs-core']:Notify("Test Message", "error")

exports['qs-core']:Notify("Test Message", "police")

exports['qs-core']:Notify("Test Message", "ambulance")

TriggerClientEvent('qs-core:Notify', xPlayer.source, "Test Message", "primary")

TriggerClientEvent('qs-core:Notify', xPlayer.source, "Test Message", "success")

TriggerClientEvent('qs-core:Notify', xPlayer.source, "Test Message", "error")

TriggerClientEvent('qs-core:Notify', xPlayer.source, "Test Message", "police")

TriggerClientEvent('qs-core:Notify', xPlayer.source, "Test Message", "ambulance")

exports['qs-core']:DrawText3D(location.x, location.y, location.z, "E- Example Text")

exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>You have widthdrawn <span style='color:#069a19'><b>100$</b></span>!", 5000, 'success')

exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>Server restart in <span style='color:#fff'>5 minutes</span>!", 5000, 'info')

exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>You have no <span style='color:#ff0000'>permissions</span>!", 5000, 'error')

exports['Johnny_Notificacoes']:Alert("NOVA MENSAGEM", "<span style='color:#ffc107'>695-2713: </span><span style='color:#c7c7c7'> How are you?", 5000, 'warning')

exports['Johnny_Notificacoes']:Alert("TWITTER", "<span style='color:#01a2dc'>@USER69: </span><span style='color:#c7c7c7'> Hello everyone!", 5000, 'sms')

exports['Johnny_Notificacoes']:Alert("GUARDADO", "<span style='color:#c7c7c7'>Clothes saved successfully!", 5000, 'long')

TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>You have widthdrawn <span style='color:#069a19'><b>100$</b></span>!", 5000, 'success')

RegisterNetEvent('johnny_empregos:ShowNotification')
AddEventHandler('johnny_empregos:ShowNotification', function(msg, type)
	ShowNotification(msg, type)
end)

function ShowNotification(msg, type)
	if type == 'success' then
		exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'success')
	elseif type == 'info' then
		exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..msg.."", 8000, 'info')
	elseif type == 'error' then
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'error')
	else
		exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'warning')
	end
end


======================================================================================================================================================

-- client side, notificacao smartphone
TriggerEvent('qs-smartphone:client:notify', {
    title = 'Title',
    text = 'Description',
    icon = "./img/apps/whatsapp.png",
    timeout = 1500
})

-- server side, notificacao smartphone
TriggerClientEvent('qs-smartphone:client:notify', source, {
    title = 'Title',
    text = 'Description',
    icon = "./img/apps/whatsapp.png",
    timeout = 1500
})

-- client side, notificacao ecra de bloqueio smartphone
TriggerServerEvent('qs-smartphone:server:AddNotifies', {
    head = 'Title',
    msg = 'Description',
    app = 'image name' -- qs-smartphone/html/img/app/imagename.png.
})

-- client side, novo email
TriggerServerEvent('qs-smartphone:server:sendNewMail', {
	sender = 'Robby Williams',
	subject = 'Hey bro, how are you?',
	message = 'Soon we will launch more versions and this will be more complete, what are you waiting for to get this great phone brother?',
	button = {}
})

--police dispatch
local alertData = {
	title = "Store Robbery",
	coords = {x = GetEntityCoords(GetPlayerPed(1)).x, y = GetEntityCoords(GetPlayerPed(1)).y, z = GetEntityCoords(GetPlayerPed(1)).z},
	description = "A robbery started at the store!"
}
TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)

======================================================================================================================================================
local mostrado = false

if GetDistanceBetweenCoords(coords, coord_x, coord_y, coord_z, true) < 5 then

	if GetDistanceBetweenCoords(coords, coord_x, coord_y, coord_z, true) < 3 and not mostrado then
		exports['okokTextUI']:Open('[E] - Guardar Veículo', 'darkgreen', 'left')
		mostrado = true
	end
	
	if GetDistanceBetweenCoords(coords, coord_x, coord_y, coord_z, true) > 3 and mostrado then
		exports['okokTextUI']:Close()
		mostrado = false
	end
	
end

if GetDistanceBetweenCoords(coords, coord_x, coord_y, coord_z, true) < 50 then
	canSleep = false
	DrawMarker(2, coord_x, coord_y, coord_z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
end

======================================================================================================================================================

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

if GetDistanceBetweenCoords(coords, coord_x, coord_y, coord_z, true) < 3 then
	DrawText3Ds(coord_x, coord_y, coord_z + 0.2, '~b~E~s~ - Label', 0.3)
end

if GetDistanceBetweenCoords(coords, coord_x, coord_y, coord_z, true) < 50 then
	canSleep = false
	DrawMarker(2, coord_x, coord_y, coord_z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
end

======================================================================================================================================================

TriggerServerEvent("inventory:server:OpenInventory", "stash", "redline")
TriggerEvent("inventory:client:SetCurrentStash", "redline")

======================================================================================================================================================

TriggerEvent('renzu_customs:openmenu')

======================================================================================================================================================

--client / server side
RegisterCommand("phone", function()
	--something
end)

-- client/server side
ESX.RegisterUsableItem('sacouniforme', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	-- something
end)

======================================================================================================================================================

-- New Code with DrawtextUI

	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			local coords = GetEntityCoords(PlayerPedId())
				for i, v in pairs(Config.Locations) do
					local pos = Config.Locations[i]
					local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
					if dist <= 3.5 then
						-- NEW CODE START
						local table = {
							['key'] = 'E', -- key
							['event'] = 'script:myevent',
							['title'] = 'Press [E] to BUY Jerry Can',
							['fa'] = '<i class="fad fa-gas-pump"></i>',
							['custom_arg'] = {}, -- example: {1,2,3,4}
						}
					   TriggerEvent('renzu_popui:drawtextuiwithinput',table) -- show the ui
					   while dist <= 3.5 do -- wait for dist become > 3.5 and close the ui once its > 3.5
							coords = GetEntityCoords(PlayerPedId() -- coords need to be here to be refreshed ea 500ms
							dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
							Wait(500)
					   end
					   TriggerEvent('renzu_popui:closeui') -- close the ui once dist is > 3.5
					   Wait(1000) -- wait 1 second
					   -- NEW CODE END
					end
				end
			Citizen.Wait(sleep)
		end
	end)

-- New Code with POPUI

	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			local coords = GetEntityCoords(PlayerPedId())
				for i, v in pairs(Config.Locations) do
					local pos = Config.Locations[i]
					local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
					if dist <= 3.5 then
						-- NEW CODE START
						local table = {
							['event'] = 'opengarage',
							['title'] = 'Garage A',
							['confirm'] = '[ENTER]',
							['reject'] = '[CLOSE]',
							['fa'] = '<i class="fad fa-gas-pump"></i>',
							['use_cursor'] = false, -- USE MOUSE CURSOR INSTEAD OF INPUT (ENTER)
					   }
					   TriggerEvent('renzu_popui:showui',table) -- show the ui
					   while dist <= 3.5 do -- wait for dist become > 3.5 and close the ui once its > 3.5
							coords = GetEntityCoords(PlayerPedId() -- coords need to be here to be refreshed ea 500ms
							dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
							Wait(500)
					   end
					   TriggerEvent('renzu_popui:closeui') -- close the ui once dist is > 3.5
					   Wait(1000) -- wait 1 second
					   -- NEW CODE END
					end
				end
			Citizen.Wait(sleep)
		end
	end)

======================================================================================================================================================

-- server side

xPlayer.getAccount('bank').money

xPlayer.getAccount('black_money').money

xPlayer.getAccount('money').money // xPlayer.getMoney()

xPlayer.removeMoney(amount)

xPlayer.removeAccountMoney('bank', amount)

xPlayer.addAccountMoney('bank', amount)

TriggerEvent('esx_addonaccount:getSharedAccount', 'society_exemplo', function(account)
	account.addMoney(amount)
end)

======================================================================================================================================================

ESX.RegisterCommand("repairweapon", "superadmin", function(xPlayer, args)
    if args[1] and tonumber(args[1]) then
        TriggerClientEvent('weapons:client:SetWeaponQuality', xPlayer.source, tonumber(args[1]))
    end
end)

ESX.RegisterCommand(Config.Commands["giveitem"], 'superadmin', function(xPlayer, args)
    TriggerEvent('giveitem:command', args)
end, true, {help = 'Giveitem', validate = true, arguments = {
	{name = 'player', help = 'ID Jogador', type = 'number'},
	{name = 'item', help = 'Nome do Item', type = 'string'},
	{name = 'count', help = 'Quantidade', type = 'number'}
}})

========================================================================================================================================================

-- mensagem do servidor de info

local time = os.date('%H:%M')
TriggerClientEvent('chat:addMessage', source, {
	template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
	args = { "O grupo do jogador "..variavel.." foi definido para "..variavel2.."!" , time }
})

========================================================================================================================================================

-- mensagem de sucesso

local time = os.date('%H:%M')
TriggerClientEvent('chat:addMessage', source, {
	template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
	args = { "O grupo do jogador "..variavel.." foi definido para "..variavel2.."!" , time }
})

========================================================================================================================================================

-- mensagem de erro

local time = os.date('%H:%M')
TriggerClientEvent('chat:addMessage', Source, {
	template = '<div class="chat-message error"><i class="fas fa-ban"></i> <b><span style="color: #f81111">WTRP SYSTEM</span>&nbsp;|&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">Jogador não encontrado!</div></div>',
	args = { time }
})

========================================================================================================================================================

-- mensagem de info com cor

local time = os.date('%H:%M')
TriggerClientEvent('chat:addMessage', xPlayer.source, {
	template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">WTRP SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b></div></div>',
	args = { "O dinheiro do tipo ("..args.account..") foi transferido para o jogador "..GetPlayerName(args.playerId.source) , time,  }
})
========================================================================================================================================================

-- print de uma tabela k para a label v para o valor

for k,v in pairs(args) do
	print(v)
end

========================================================================================================================================================

local steamid  = false
local license  = false
local discord  = false
local xbl      = false
local liveid   = false
local ip       = false

for k,v in pairs(GetPlayerIdentifiers(source))do
	print(v)
	
	if string.sub(v, 1, string.len("steam:")) == "steam:" then
		steamid = v
	elseif string.sub(v, 1, string.len("license:")) == "license:" then
		license = v
	elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
		xbl  = v
	elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
		ip = v
	elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
		discord = v
	elseif string.sub(v, 1, string.len("live:")) == "live:" then
		liveid = v
	end

end

============================================================================================================================================================

local fuel = exports['Johnny_Combustivel']:GetFuel(GetVehiclePedIsIn(PlayerPedId()))

