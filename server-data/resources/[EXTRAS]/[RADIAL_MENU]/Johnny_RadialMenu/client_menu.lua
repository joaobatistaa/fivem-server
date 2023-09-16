----------------- MENU F5 ANTIGO ------------------

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

local GUI                       = {}
GUI.Time                        = 0
local PlayerData              = {}
local coordsVisible = false
local godmode = false
local modoadmin = false
local PlayerData = {}

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

----------------- MENU F5 ANTIGO ------------------

-- Menu state
local showMenu = false
local deleteLazer = false

-- Keybind Lookup table
local keybindControls = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local MAX_MENU_ITEMS = 7

-- Main thread
Citizen.CreateThread(function()
    local keyBind = "F1"
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, keybindControls[keyBind]) and GetLastInputMethod(2) and showMenu then
            showMenu = false
            SetNuiFocus(false, false)
        end
        if IsControlPressed(1, keybindControls[keyBind]) and GetLastInputMethod(2) and not exports['qs-housing']:inDecorate() then
            showMenu = true
            local enabledMenus = {}
            for _, menuConfig in ipairs(rootMenuConfig) do
                if menuConfig:enableMenu() then
                    local dataElements = {}
                    local hasSubMenus = false
                    if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
                        hasSubMenus = true
                        local previousMenu = dataElements
                        local currentElement = {}
                        for i = 1, #menuConfig.subMenus do
                            -- if newSubMenus[menuConfig.subMenus[i]] ~= nil and newSubMenus[menuConfig.subMenus[i]].enableMenu ~= nil and not newSubMenus[menuConfig.subMenus[i]]:enableMenu() then
                            --     goto continue
                            -- end
                            currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
                            currentElement[#currentElement].id = menuConfig.subMenus[i]
                            currentElement[#currentElement].enableMenu = nil

                            if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
                                previousMenu[MAX_MENU_ITEMS + 1] = {
                                    id = "_more",
                                    title = "Mais",
                                    icon = "#more",
                                    items = currentElement
                                }
                                previousMenu = currentElement
                                currentElement = {}
                            end
                            --::continue::
                        end
                        if #currentElement > 0 then
                            previousMenu[MAX_MENU_ITEMS + 1] = {
                                id = "_more",
                                title = "Mais",
                                icon = "#more",
                                items = currentElement
                            }
                        end
                        dataElements = dataElements[MAX_MENU_ITEMS + 1].items

                    end
                    enabledMenus[#enabledMenus+1] = {
                        id = menuConfig.id,
                        title = menuConfig.displayName,
                        functionName = menuConfig.functionName,
                        icon = menuConfig.icon,
                    }
                    if hasSubMenus then
                        enabledMenus[#enabledMenus].items = dataElements
                    end
                end
            end
            SendNUIMessage({
                state = "show",
                resourceName = GetCurrentResourceName(),
                data = enabledMenus,
                menuKeyBind = keyBind
            })
            SetCursorLocation(0.5, 0.5)
            SetNuiFocus(true, true)

            -- Play sound
            PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)


            while showMenu == true do Citizen.Wait(100) end
            Citizen.Wait(100)
            while IsControlPressed(1, keybindControls[keyBind]) and GetLastInputMethod(2) do Citizen.Wait(100) end
        end
    end
end)
-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb('ok')
end)

RegisterCommand('closemenu', function(source)
	
	showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
	
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('triggerAction', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Run command
    --ExecuteCommand(data.action)
	TriggerEvent(data.action, data.parameters)


    -- Send ACK to callback function
    cb('ok')
end)

RegisterNetEvent("menu:menuexit")
AddEventHandler("menu:menuexit", function()
    showMenu = false
    SetNuiFocus(false, false)
end)



------------------------- MENU F5 ANTIGO ---------------------------------


--Notification joueur
function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end

--Message text joueur
function Text(text)
		SetTextColour(186, 186, 186, 255)
		SetTextFont(0)
		SetTextScale(0.378, 0.378)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(0.017, 0.977)
end

function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.00)
end

RegisterNetEvent("gestao:cartoes")
AddEventHandler("gestao:cartoes", function()
    openMenu()
end)

RegisterNetEvent("gestao:servicos")
AddEventHandler("gestao:servicos", function()
    ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
		TriggerEvent('esx_scoreboard:servicos', connectedPlayers)
	end)	
end)

RegisterNetEvent("gestao:hud")
AddEventHandler("gestao:hud", function()
    ExecuteCommand('definicoeshud')
	
end)

RegisterNetEvent("gestao:admin")
AddEventHandler("gestao:admin", function()
	ESX.TriggerServerCallback('NB:getUsergroup', function(group)
		playergroup = group
		local elements = {}
					
		if playergroup == 'mod' then
			--	table.insert(elements, {label = 'Ligar/Desligar Reports',										value = 'menuperso_reportstoggle'})
			table.insert(elements, {label = '📋 Lista de Reports',										value = 'menuperso_reports'})
			--table.insert(elements, {label = 'Lista de Avisos',										value = 'menuperso_avisos'})
			--table.insert(elements, {label = 'Lista de Bans',										value = 'menuperso_bans'})
			--table.insert(elements, {label = 'Advertir um jogador',										value = 'menuperso_daraviso'})
			--table.insert(elements, {label = '⛔ Banir um jogador',										value = 'menuperso_banir'})
			table.insert(elements, {label = '🔧 Reparar um veiculo',							value = 'menuperso_modo_vehicle_repair'})
			table.insert(elements, {label = '🧽 Limpar Veículo',						value = 'menuperso_limpar'})
			table.insert(elements, {label = '🔑 Destrancar Carros',						value = 'menuperso_modo_destrancar'})	
			--table.insert(elements, {label = 'Spawnar um veiculo',							value = 'menuperso_modo_vehicle_spawn'})
			--	table.insert(elements, {label = 'TP para um jogador',    							value = 'menuperso_modo_tp_toplayer'})
			--	table.insert(elements, {label = 'Trazer um jogador para mim',             			value = 'menuperso_modo_tp_playertome'})	
			--	table.insert(elements, {label = 'Teleportar para marcador no mapa',							value = 'menuperso_modo_tp_marcker'})
		end
				
		if playergroup == 'admin' then
			--table.insert(elements, {label = 'Ligar/Desligar Reports',										value = 'menuperso_reportstoggle'})
			table.insert(elements, {label = '📋 Lista de Reports',										value = 'menuperso_reports'})
			--table.insert(elements, {label = 'Lista de Avisos',										value = 'menuperso_avisos'})
			--table.insert(elements, {label = 'Lista de Bans',										value = 'menuperso_bans'})
			--table.insert(elements, {label = 'Advertir um jogador',										value = 'menuperso_daraviso'})
			--table.insert(elements, {label = '⛔ Banir um jogador',										value = 'menuperso_banir'})
			--table.insert(elements, {label = 'Lista de Jogadores',										value = 'menuperso_players'})
			--	table.insert(elements, {label = 'TP para um jogador',    							value = 'menuperso_modo_tp_toplayer'})
			--	table.insert(elements, {label = 'Trazer um jogador para mim',             			value = 'menuperso_modo_tp_playertome'})
			--	table.insert(elements, {label = 'Teleportar para as coordenadas',						value = 'menuperso_modo_tp_pos'})
			--table.insert(elements, {label = 'Teleportar para marcador no mapa',							value = 'menuperso_modo_tp_marcker'})
			--table.insert(elements, {label = '🎥 Modo NoClip',										value = 'menuperso_modo_no_clip'})
			--	table.insert(elements, {label = 'Modo GOD',									value = 'menuperso_modo_godmode'})
			table.insert(elements, {label = '🔧 Reparar um veiculo',							value = 'menuperso_modo_vehicle_repair'})
			table.insert(elements, {label = '🧽 Limpar Veículo',						value = 'menuperso_limpar'})
			table.insert(elements, {label = '🔑 Destrancar Carros',						value = 'menuperso_modo_destrancar'})	
			--table.insert(elements, {label = 'Spawnar um veiculo',							value = 'menuperso_modo_vehicle_spawn'})
			table.insert(elements, {label = '🔁 Virar veículo',								value = 'menuperso_modo_vehicle_flip'})
			--	table.insert(elements, {label = 'Mostrar/Ocultar Coordenadas',		value = 'menuperso_modo_showcoord'})
			--	table.insert(elements, {label = 'Curar jogador',					value = 'menuperso_modo_heal_player'})
			--	table.insert(elements, {label = 'Modo Espectador',						value = 'menuperso_modo_spec_player'})
			table.insert(elements, {label = '🧑 Mudar aparência',									value = 'menuperso_modo_changer_skin'})
			table.insert(elements, {label = '👕 Roupas Guardadas',										value = 'menuperso_roupasguardadas'})
			table.insert(elements, {label = '🎒 Abrir inventário de um jogador',					value = 'menuperso_openinv'})
		end
				
		if playergroup == 'superadmin' then
			--table.insert(elements, {label = 'Ligar/Desligar Reports',										value = 'menuperso_reportstoggle'})
			table.insert(elements, {label = '📋 Lista de Reports',										value = 'menuperso_reports'})
			table.insert(elements, {label = '✉️ Enviar Email para Todos',								value = 'menuperso_enviar_email'})
			table.insert(elements, {label = '✅ Dar Verificado',								value = 'menuperso_dar_verificado'})
			table.insert(elements, {label = '❌ Retirar Verificado',								value = 'menuperso_retirar_verificado'})
			--table.insert(elements, {label = '✉️ Enviar Email para Todos',								value = 'menuperso_enviar_email'})
			--table.insert(elements, {label = 'Lista de Avisos',										value = 'menuperso_avisos'})
			--table.insert(elements, {label = 'Lista de Bans',										value = 'menuperso_bans'})
			--table.insert(elements, {label = 'Advertir um jogador',										value = 'menuperso_daraviso'})
			--table.insert(elements, {label = 'Banir um jogador',										value = 'menuperso_banir'})
			--table.insert(elements, {label = 'Lista de Jogadores',										value = 'menuperso_players'})
			--	table.insert(elements, {label = 'Teleportar para um jogador',    							value = 'menuperso_modo_tp_toplayer'})
			--	table.insert(elements, {label = 'Trazer um jogador para mim',             			value = 'menuperso_modo_tp_playertome'})
			--table.insert(elements, {label = '📍 Teleportar para as coordenadas',						value = 'menuperso_modo_tp_pos'})
			--table.insert(elements, {label = 'Teleportar para marcador no mapa',							value = 'menuperso_modo_tp_marcker'})
			--table.insert(elements, {label = '🎥 Modo NoClip',										value = 'menuperso_modo_no_clip'})
			table.insert(elements, {label = '♾️ Modo GOD',									value = 'menuperso_modo_godmode'})
			table.insert(elements, {label = '👻 Modo Invísivel',								value = 'menuperso_modo_mode_fantome'})
			table.insert(elements, {label = '🔧 Reparar um veiculo',							value = 'menuperso_modo_vehicle_repair'})
			table.insert(elements, {label = '🧽 Limpar Veículo',						value = 'menuperso_limpar'})
			table.insert(elements, {label = '🔑 Destrancar Carros',							value = 'menuperso_modo_destrancar'})
			--table.insert(elements, {label = 'Spawnar um veiculo',							value = 'menuperso_modo_vehicle_spawn'})
			table.insert(elements, {label = '🔁 Virar veículo',								value = 'menuperso_modo_vehicle_flip'})
		--	table.insert(elements, {label = 'Dar dinheiro (carteira)',						value = 'menuperso_modo_give_money'})
			--table.insert(elements, {label = 'Dar dinheiro (banco)',						value = 'menuperso_modo_give_moneybank'})
			--table.insert(elements, {label = 'Dar dinheiro sujo',						value = 'menuperso_modo_give_moneydirty'})
			--table.insert(elements, {label = 'Mostrar/Ocultar Coordenadas',		value = 'menuperso_modo_showcoord'})			
			--	table.insert(elements, {label = 'Curar jogador',					value = 'menuperso_modo_heal_player'})
			table.insert(elements, {label = '🧑 Mudar aparência',									value = 'menuperso_modo_changer_skin'})
			--table.insert(elements, {label = 'Alterar Clima/Hora',										value = 'menuperso_climahora'})
			table.insert(elements, {label = '🚗 Tunar Carro',										value = 'menuperso_tunar'})
			table.insert(elements, {label = '👕 Roupas Guardadas',										value = 'menuperso_roupasguardadas'})
			table.insert(elements, {label = '📦 ON/OFF - Apagar Objetos',										value = 'menuperso_apagarobjetos'})
			table.insert(elements, {label = '🎒 Abrir inventário de um jogador',					value = 'menuperso_openinv'})
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menuperso_modo',
			{
				title    = '⛔ Admin',
				align    = 'top-left',
				elements = elements
			},
		function(data2, menu2)

							if data2.current.value == 'menuperso_reports' then
								ExecuteCommand('reports')
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_reportstoggle' then
								ExecuteCommand('togglereports')
								menu2.close()
								--menu.close()		
							end
							
							if data2.current.value == 'menuperso_avisos' then
								ExecuteCommand('menuadmin warnlist')
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_bans' then
								ExecuteCommand('menuadmin banlist')
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_openinv' then
								admin_open_inv()
								menu2.close()
							end
							
							if data2.current.value == 'menuperso_players' then
								ExecuteCommand('jogadores')
							end
							
							if data2.current.value == 'menuperso_daraviso' then
								ExecuteCommand('menuadmin warn')
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_banir' then
								ExecuteCommand('menuadmin ban')
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_modo_tp_toplayer' then
								admin_tp_toplayer()
							end

							if data2.current.value == 'menuperso_modo_tp_playertome' then
								admin_tp_playertome()
							end

							if data2.current.value == 'menuperso_modo_tp_pos' then
								admin_tp_pos()
							end

							if data2.current.value == 'menuperso_modo_no_clip' then
								ExecuteCommand('mapper')
							end

							if data2.current.value == 'menuperso_modo_godmode' then
								admin_godmode()
							end

							if data2.current.value == 'menuperso_modo_mode_fantome' then
								admin_mode_fantome()
							end

							if data2.current.value == 'menuperso_modo_vehicle_repair' then
								admin_vehicle_repair()
							end

							if data2.current.value == 'menuperso_modo_vehicle_spawn' then
								admin_vehicle_spawn()
							end

							if data2.current.value == 'menuperso_modo_vehicle_flip' then
								admin_vehicle_flip()
							end

							if data2.current.value == 'menuperso_modo_give_money' then
								admin_give_money()
							end

							if data2.current.value == 'menuperso_modo_give_moneybank' then
								admin_give_bank()
							end

							if data2.current.value == 'menuperso_modo_give_moneydirty' then
								admin_give_dirty()
							end

							if data2.current.value == 'menuperso_modo_showcoord' then
								modo_showcoord()
							end

							if data2.current.value == 'menuperso_modo_showname' then
								modo_showname()
							end

							if data2.current.value == 'menuperso_modo_tp_marcker' then
								admin_tp_marcker()
							end

							if data2.current.value == 'menuperso_modo_heal_player' then
								admin_heal_player()
							end

							if data2.current.value == 'menuperso_modo_spec_player' then
								admin_spec_player()
								menu2.close()
							end
							
							if data2.current.value == 'menuperso_enviar_email' then
								local assunto = ''
								local mensagem = ''
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'email_assunto', {
									title = 'Indica o assunto',
								}, function (data2, menu2)
									assunto = tostring(data2.value)
									if assunto == nil then
										exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Assunto inválido!", 5000, 'error')
									else
										menu2.close()
										ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'email_mensagem', {
											title = 'Indica a mensagem',
										}, function (data3, menu3)
											mensagem = tostring(data3.value)
											if assunto == nil then
												exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Mensagem inválida!", 5000, 'error')
											else
												ExecuteCommand('enviaremail '..assunto..' '..mensagem)
												menu3.close()
											end
										end, function (data3, menu3)
											menu3.close()
										end)
									end
								end, function (data2, menu2)
									menu2.close()
								end)
							end
							
							if data2.current.value == 'menuperso_dar_verificado' then
								local idJogador = ''
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'verificado_id', {
									title = 'Indica o id do jogador',
								}, function (data, menu)
									idJogador = data.value
									if idJogador == nil then
										exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>ID inválido!", 5000, 'error')
									else
										ExecuteCommand('darverificado '..idJogador)
										menu.close()
									end
								end, function (data, menu)
									menu.close()
								end)
							end
							
							if data2.current.value == 'menuperso_retirar_verificado' then
								local idJogador = ''
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'verificado_id2', {
									title = 'Indica o id do jogador',
								}, function (data, menu)
									idJogador = data.value
									if idJogador == nil then
										exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>ID inválido!", 5000, 'error')
									else
										ExecuteCommand('retirarverificado '..idJogador)
										menu.close()
									end
								end, function (data, menu)
									menu.close()
								end)
							end
							
							if data2.current.value == 'menuperso_modo_changer_skin' then
								changer_skin()
							end
							
							if data2.current.value == 'menuperso_modo_destrancar' then
								destrancar_carros()
								--menu2.close()
								--menu.close()
							end 
							
							if data2.current.value == 'menuperso_climahora' then
								ExecuteCommand('easytime')
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_tunar' then
								--ExecuteCommand('menutunagem')
								--exports['WTRP_Tunagens']:openByMenuAdmin()
								TriggerEvent('menutunagem:admin')
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_roupasguardadas' then
								OpenRoupasGuardadas()
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_apagarobjetos' then
								ExecuteCommand('idgun')
								menu2.close()
							end
								
							
							if data2.current.value == 'menuperso_limpar' then
								local playerPed = PlayerPedId()
								local vehicle   = ESX.Game.GetVehicleInDirection()
								local coords    = GetEntityCoords(playerPed)

								if IsPedSittingInAnyVehicle(playerPed) then
									--ESX.ShowNotification('~r~Tens que estar fora do veículo!')
									exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar fora do veículo!", 5000, 'error')
									return
								end

								if DoesEntityExist(vehicle) then
									SetVehicleDirtLevel(vehicle, 0)
									--ESX.ShowNotification('~g~Veículo Limpo!')
									exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Veículo limpo com <span style='color:#069a19'>sucesso</span>!", 3000, 'success')
								else
									--ESX.ShowNotification('~r~Não há veiculos por perto!')
									exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Não há veículos por perto!", 5000, 'error')
								end
							end
			end,
		function(data2, menu2)
			menu2.close()
		end)
	end)
end)

function OpenRoupasGuardadas()
	ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
          local elements = {}

          for i=1, #dressing, 1 do
            table.insert(elements, {label = dressing[i], value = i})
          end

          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
              title    = 'Vestiário',
              align    = 'top-left',
              elements = elements,
            }, function(data, menu)

              TriggerEvent('skinchanger:getSkin', function(skin)

                ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)

                  TriggerEvent('skinchanger:loadClothes', skin, clothes)
                  TriggerEvent('esx_skin:setLastSkin', skin)

                  TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('esx_skin:save', skin)
                  end)
				  exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Roupa <span style='color:#069a19'>carregada</span> com sucesso!", 3000, 'success')
				--  ESX.ShowNotification(_U('loaded_outfit'))
				  HasLoadCloth = true
                end, data.current.value)
              end)
            end, function(data, menu)
              menu.close()
            end
          )
        end)
end


function openMenu()
	local elements  = {}
	local playerPed = PlayerPedId()
	local vehicle2 = ESX.Game.GetClosestVehicle()
	table.insert(elements, {label = 'Ver Cartão de Cidadão', value = 'checkID'})
	table.insert(elements, {label = 'Ver Carta de Condução', value = 'checkDriver'})
	table.insert(elements, {label = 'Ver Licença de Porte de Armas', value = 'checkFirearms'})
	table.insert(elements, {label = 'Ver Licença de Caça', value = 'hunt'})
	table.insert(elements, {label = 'Mostrar Cartão de Cidadão', value = 'showID'})
	table.insert(elements, {label = 'Mostrar Carta de Condução', value = 'showDriver'})
	table.insert(elements, {label = 'Mostrar Licença de Porte de Armas', value = 'showFirearms'})
	table.insert(elements, {label = 'Mostrar Licença de Caça', value = 'mostrar_hunt'})

	if DoesEntityExist(vehicle2) then
		table.insert(elements, {label = 'Ver Seguro do Carro', value = 'ver_seguro_carro'})
		table.insert(elements, {label = 'Mostrar Seguro do Carro', value = 'mostrar_seguro_carro'})
	end
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = '💳 Cartões',
		align    = 'top-left',
		elements = elements
	},
	function(data, menu)
		local val = data.current.value
		local vehicle  = ESX.Game.GetClosestVehicle()
		local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
		
		if val == 'checkID' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), nil, false)
		elseif val == 'checkDriver' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver', false)
		elseif val == 'checkFirearms' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon', false)
		elseif val == 'hunt' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'hunt', false)
		elseif val == 'ver_seguro_carro' then
			local plate = vehicleData.plate
			TriggerServerEvent('t1ger_carinsurance:openSV', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), plate)
		else
			local player, distance = ESX.Game.GetClosestPlayer()
			
			if distance ~= -1 and distance <= 3.0 then
				if val == 'showID' then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), nil, true)
				elseif val == 'showDriver' then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver', true)
				elseif val == 'showFirearms' then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon', true)
				elseif val == 'mostrar_hunt' then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'hunt', true)
				elseif val == 'mostrar_seguro_carro' then
					local plate = vehicleData.plate
					TriggerServerEvent('t1ger_carinsurance:openSV', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), plate)
				end
			else
				exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Não há jogadores por perto!", 5000, 'error')
			end
		end
	end,
	function(data, menu)
		menu.close()
	end
)
end

function OpenPersonnelMenu()
	
	ESX.UI.Menu.CloseAll()
	
	ESX.TriggerServerCallback('NB:getUsergroup', function(group)
		playergroup = group
		
		local elements = {}
		
		table.insert(elements, {label = '💳 Cartões',		value = 'menuperso_moi'})
		table.insert(elements, {label = '🎬 Ações',					value = 'menuperso_actions'})
		--if (IsInVehicle()) then
			--local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
		--	if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
			--	table.insert(elements, {label = 'Véhicule',					value = 'menuperso_vehicule'})
			--end
		--end
		table.insert(elements, {label = '🛰️ GPS Rápido',			value = 'menuperso_gpsrapide'})
		table.insert(elements, {label = '📄️ Serviços',			value = 'menuperso_servicos'})
		if PlayerData.job.grade_name == 'boss' then
			table.insert(elements, {label = '💼 Gestão da Empresa',			value = 'menuperso_grade'})
		end
				
		if (playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin') and modoadmin then
			table.insert(elements, {label = '⛔ Admin',				value = 'menuperso_modo'})
		end
		table.insert(elements, {label = '🔑 Chaves Motel',			value = 'menuperso_chaves'})
		table.insert(elements, {label = '⚙️ Definições',			value = 'menuperso_definicoes'})
		
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'menu_perso',
			{
				title    = '👨 Menu Pessoal',
				align    = 'top-left',
				elements = elements
			},
			function(data, menu)
	
				local elements = {}
				
				if playergroup == 'mod' then
					--	table.insert(elements, {label = 'Ligar/Desligar Reports',										value = 'menuperso_reportstoggle'})
					table.insert(elements, {label = 'Lista de Reports',										value = 'menuperso_reports'})
					table.insert(elements, {label = 'Lista de Avisos',										value = 'menuperso_avisos'})
					table.insert(elements, {label = 'Lista de Bans',										value = 'menuperso_bans'})
					table.insert(elements, {label = 'Advertir um jogador',										value = 'menuperso_daraviso'})
					table.insert(elements, {label = 'Banir um jogador',										value = 'menuperso_banir'})
					table.insert(elements, {label = 'Reparar um veiculo',							value = 'menuperso_modo_vehicle_repair'})
					table.insert(elements, {label = 'Limpar Veículo',						value = 'menuperso_limpar'})
					table.insert(elements, {label = 'Destrancar Carros',						value = 'menuperso_modo_destrancar'})	
					table.insert(elements, {label = 'Spawnar um veiculo',							value = 'menuperso_modo_vehicle_spawn'})
					--	table.insert(elements, {label = 'TP para um jogador',    							value = 'menuperso_modo_tp_toplayer'})
					--	table.insert(elements, {label = 'Trazer um jogador para mim',             			value = 'menuperso_modo_tp_playertome'})	
					--	table.insert(elements, {label = 'Teleportar para marcador no mapa',							value = 'menuperso_modo_tp_marcker'})
				end
						
				if playergroup == 'admin' then
					--table.insert(elements, {label = 'Ligar/Desligar Reports',										value = 'menuperso_reportstoggle'})
					table.insert(elements, {label = 'Lista de Reports',										value = 'menuperso_reports'})
					table.insert(elements, {label = 'Lista de Avisos',										value = 'menuperso_avisos'})
					table.insert(elements, {label = 'Lista de Bans',										value = 'menuperso_bans'})
					table.insert(elements, {label = 'Advertir um jogador',										value = 'menuperso_daraviso'})
					table.insert(elements, {label = 'Banir um jogador',										value = 'menuperso_banir'})
					table.insert(elements, {label = 'Lista de Jogadores',										value = 'menuperso_players'})
					--	table.insert(elements, {label = 'TP para um jogador',    							value = 'menuperso_modo_tp_toplayer'})
					--	table.insert(elements, {label = 'Trazer um jogador para mim',             			value = 'menuperso_modo_tp_playertome'})
					--	table.insert(elements, {label = 'Teleportar para as coordenadas',						value = 'menuperso_modo_tp_pos'})
					table.insert(elements, {label = 'Teleportar para marcador no mapa',							value = 'menuperso_modo_tp_marcker'})
					--	table.insert(elements, {label = 'NoClip',										value = 'menuperso_modo_no_clip'})
					--	table.insert(elements, {label = 'Modo GOD',									value = 'menuperso_modo_godmode'})
					table.insert(elements, {label = 'Reparar um veiculo',							value = 'menuperso_modo_vehicle_repair'})
					table.insert(elements, {label = 'Limpar Veículo',						value = 'menuperso_limpar'})
					table.insert(elements, {label = 'Destrancar Carros',						value = 'menuperso_modo_destrancar'})	
					table.insert(elements, {label = 'Spawnar um veiculo',							value = 'menuperso_modo_vehicle_spawn'})
					table.insert(elements, {label = 'Virar veículo',								value = 'menuperso_modo_vehicle_flip'})
					--	table.insert(elements, {label = 'Mostrar/Ocultar Coordenadas',		value = 'menuperso_modo_showcoord'})
					--	table.insert(elements, {label = 'Curar jogador',					value = 'menuperso_modo_heal_player'})
					--	table.insert(elements, {label = 'Modo Espectador',						value = 'menuperso_modo_spec_player'})
					table.insert(elements, {label = 'Mudar aparência',									value = 'menuperso_modo_changer_skin'})
					table.insert(elements, {label = 'Roupas Guardadas',										value = 'menuperso_roupasguardadas'})
					table.insert(elements, {label = 'Abrir inventário de um jogador',					value = 'menuperso_openinv'})
				end
						
				if playergroup == 'superadmin' then
					--table.insert(elements, {label = 'Ligar/Desligar Reports',										value = 'menuperso_reportstoggle'})
					table.insert(elements, {label = 'Lista de Reports',										value = 'menuperso_reports'})
					table.insert(elements, {label = 'Lista de Avisos',										value = 'menuperso_avisos'})
					table.insert(elements, {label = 'Lista de Bans',										value = 'menuperso_bans'})
					table.insert(elements, {label = 'Advertir um jogador',										value = 'menuperso_daraviso'})
					table.insert(elements, {label = 'Banir um jogador',										value = 'menuperso_banir'})
					table.insert(elements, {label = 'Lista de Jogadores',										value = 'menuperso_players'})
					--	table.insert(elements, {label = 'Teleportar para um jogador',    							value = 'menuperso_modo_tp_toplayer'})
					--	table.insert(elements, {label = 'Trazer um jogador para mim',             			value = 'menuperso_modo_tp_playertome'})
					table.insert(elements, {label = 'Teleportar para as coordenadas',						value = 'menuperso_modo_tp_pos'})
					table.insert(elements, {label = 'Teleportar para marcador no mapa',							value = 'menuperso_modo_tp_marcker'})
					--	table.insert(elements, {label = 'NoClip',										value = 'menuperso_modo_no_clip'})
					table.insert(elements, {label = 'Modo GOD',									value = 'menuperso_modo_godmode'})
					table.insert(elements, {label = 'Modo Invísivel',								value = 'menuperso_modo_mode_fantome'})
					table.insert(elements, {label = 'Reparar um veiculo',							value = 'menuperso_modo_vehicle_repair'})
					table.insert(elements, {label = 'Limpar Veículo',						value = 'menuperso_limpar'})
					table.insert(elements, {label = 'Destrancar Carros',							value = 'menuperso_modo_destrancar'})
					table.insert(elements, {label = 'Spawnar um veiculo',							value = 'menuperso_modo_vehicle_spawn'})
					table.insert(elements, {label = 'Virar veículo',								value = 'menuperso_modo_vehicle_flip'})
					table.insert(elements, {label = 'Dar dinheiro (carteira)',						value = 'menuperso_modo_give_money'})
					table.insert(elements, {label = 'Dar dinheiro (banco)',						value = 'menuperso_modo_give_moneybank'})
					table.insert(elements, {label = 'Dar dinheiro sujo',						value = 'menuperso_modo_give_moneydirty'})
					table.insert(elements, {label = 'Mostrar/Ocultar Coordenadas',		value = 'menuperso_modo_showcoord'})			
					--	table.insert(elements, {label = 'Curar jogador',					value = 'menuperso_modo_heal_player'})
					table.insert(elements, {label = 'Mudar aparência',									value = 'menuperso_modo_changer_skin'})
					--table.insert(elements, {label = 'Alterar Clima/Hora',										value = 'menuperso_climahora'})
					table.insert(elements, {label = 'Tunar Carro',										value = 'menuperso_tunar'})
					table.insert(elements, {label = 'Roupas Guardadas',										value = 'menuperso_roupasguardadas'})
					table.insert(elements, {label = 'ON/OFF - Apagar Objetos',										value = 'menuperso_apagarobjetos'})
					table.insert(elements, {label = 'Abrir inventário de um jogador',					value = 'menuperso_openinv'})
				end

				if data.current.value == 'menuperso_modo' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_modo',
						{
							title    = '⛔ Admin',
							align    = 'top-left',
							elements = elements
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_reports' then
								ExecuteCommand('menuadmin reports')
								menu2.close()
								menu.close()
							end
							
							if data2.current.value == 'menuperso_reportstoggle' then
								ExecuteCommand('togglereports')
								menu2.close()
								menu.close()		
							end
							
							if data2.current.value == 'menuperso_avisos' then
								ExecuteCommand('menuadmin warnlist')
								menu2.close()
								menu.close()
							end
							
							if data2.current.value == 'menuperso_bans' then
								ExecuteCommand('menuadmin banlist')
								menu2.close()
								menu.close()
							end
							
							if data2.current.value == 'menuperso_openinv' then
								admin_open_inv()
							end
							
							if data2.current.value == 'menuperso_players' then
								ExecuteCommand('jogadores')
							end
							
							if data2.current.value == 'menuperso_daraviso' then
								ExecuteCommand('menuadmin warn')
								menu2.close()
								menu.close()
							end
							
							if data2.current.value == 'menuperso_banir' then
								ExecuteCommand('menuadmin ban')
								menu2.close()
								menu.close()
							end
							
							if data2.current.value == 'menuperso_modo_tp_toplayer' then
								admin_tp_toplayer()
							end

							if data2.current.value == 'menuperso_modo_tp_playertome' then
								admin_tp_playertome()
							end

							if data2.current.value == 'menuperso_modo_tp_pos' then
								admin_tp_pos()
							end

							if data2.current.value == 'menuperso_modo_no_clip' then
								ExecuteCommand('mapper')
							end

							if data2.current.value == 'menuperso_modo_godmode' then
								admin_godmode()
							end

							if data2.current.value == 'menuperso_modo_mode_fantome' then
								admin_mode_fantome()
							end

							if data2.current.value == 'menuperso_modo_vehicle_repair' then
								admin_vehicle_repair()
							end

							if data2.current.value == 'menuperso_modo_vehicle_spawn' then
								admin_vehicle_spawn()
							end

							if data2.current.value == 'menuperso_modo_vehicle_flip' then
								admin_vehicle_flip()
							end

							if data2.current.value == 'menuperso_modo_give_money' then
								admin_give_money()
							end

							if data2.current.value == 'menuperso_modo_give_moneybank' then
								admin_give_bank()
							end

							if data2.current.value == 'menuperso_modo_give_moneydirty' then
								admin_give_dirty()
							end

							if data2.current.value == 'menuperso_modo_showcoord' then
								modo_showcoord()
							end

							if data2.current.value == 'menuperso_modo_showname' then
								modo_showname()
							end

							if data2.current.value == 'menuperso_modo_tp_marcker' then
								admin_tp_marcker()
							end

							if data2.current.value == 'menuperso_modo_heal_player' then
								admin_heal_player()
							end

							if data2.current.value == 'menuperso_modo_spec_player' then
								admin_spec_player()
								menu2.close()
							end

							if data2.current.value == 'menuperso_modo_changer_skin' then
								changer_skin()
							end
							
							if data2.current.value == 'menuperso_modo_destrancar' then
								destrancar_carros()
								menu2.close()
								menu.close()
							end 
							
							if data2.current.value == 'menuperso_climahora' then
								ExecuteCommand('easytime')
								menu2.close()
								menu.close()
							end
							
							if data2.current.value == 'menuperso_tunar' then
								ExecuteCommand('menutunagem')
								menu2.close()
								menu.close()
							end
							
							if data2.current.value == 'menuperso_removerobjetos' then
								RemoverObjetos()
							end
							
							if data2.current.value == 'menuperso_roupasguardadas' then
								OpenRoupasGuardadas()
								menu2.close()
								--menu.close()
							end
							
							if data2.current.value == 'menuperso_apagarobjetos' then
								ExecuteCommand('idgun')
								menu2.close()
							end
							
							if data2.current.value == 'menuperso_limpar' then
								local playerPed = PlayerPedId()
								local vehicle   = ESX.Game.GetVehicleInDirection()
								local coords    = GetEntityCoords(playerPed)

								if IsPedSittingInAnyVehicle(playerPed) then
									--ESX.ShowNotification('~r~Tens que estar fora do veículo!') 
									exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Tens que estar fora do veículo!", 5000, 'error')
									return
								end

								if DoesEntityExist(vehicle) then
									SetVehicleDirtLevel(vehicle, 0)
									--ESX.ShowNotification('~g~Veículo Limpo!')
									exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Veículo limpo com <span style='color:#069a19'>sucesso</span>!", 3000, 'success')
								else
									--ESX.ShowNotification('~r~Não há veiculos por perto!')
									exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Não há veículos por perto!", 5000, 'error')
								end
							end
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end
				
				if data.current.value == 'menuperso_chaves' then
					TriggerEvent('james_motels:menuchaves')
				end
				
				if data.current.value == 'menuperso_definicoes' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_definicoes',
						{
							title    = '⚙️ Definições',
							align    = 'top-left',
							elements = {
								{label = 'Alternar HUD',  value = 'menuperso_hud1'},
							},
						},
						function(data2, menu2)
							if data2.current.value == 'menuperso_hud1' then
								ExecuteCommand('hud')
							end
						end,
						function(data2, menu2)
							menu2.close()
						end)
				end

				if data.current.value == 'menuperso_moi' then
					openMenu()
				end 

				if data.current.value == 'menuperso_actions' then

					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_actions',
						{
							title    = '🎬 Ações',
							align    = 'top-left',
							elements = {
								{label = 'Cancelar animação',  value = 'menuperso_actions__annuler'},
								--{label = 'Faire ses besoins [WIP]',     value = 'menuperso_actions_pipi'},
								{label = 'Animações de saudação',  value = 'menuperso_actions_Salute'},
								{label = 'Animações de humor',  value = 'menuperso_actions_Humor'},
								{label = 'Animações de trabalho',  value = 'menuperso_actions_Travail'},
								{label = 'Animações festivas',  value = 'menuperso_actions_Festives'},
								{label = 'Animações diversas',  value = 'menuperso_actions_Others'},
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_actions__annuler' then
								local ped = GetPlayerPed(-1);
								if ped then
									ClearPedTasks(ped);
								end
							end

							if data2.current.value == 'menuperso_actions_pipi' then
								ESX.UI.Menu.CloseAll()
							end

							if data2.current.value == 'menuperso_actions_Salute' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Salute',
									{
										title    = 'Animações de saudação',
										align    = 'top-left',
										elements = {
											{label = 'Cumprimentar',  value = 'menuperso_actions_Salute_saluer'},
											{label = 'Apertar as mãoes',     value = 'menuperso_actions_Salute_serrerlamain'},
											{label = 'Dar mais 5',     value = 'menuperso_actions_Salute_tapeen5'},
											{label = 'Saudação Militar',  value = 'menuperso_actions_Salute_salutmilitaire'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Salute_saluer' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_hello" })
										end

										if data3.current.value == 'menuperso_actions_Salute_serrerlamain' then
											animsAction({ lib = "mp_common", anim = "givetake1_a" })
										end

										if data3.current.value == 'menuperso_actions_Salute_tapeen5' then
											animsAction({ lib = "mp_ped_interaction", anim = "highfive_guy_a" })
										end

										if data3.current.value == 'menuperso_actions_Salute_salutmilitaire' then
											animsAction({ lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Humor' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Humor',
									{
										title    = 'Animações de humor',
										align    = 'top-left',
										elements = {
											{label = 'Bater palmas',  value = 'menuperso_actions_Humor_feliciter'},
											{label = 'Super',     value = 'menuperso_actions_Humor_super'},
											{label = 'Tem calma',     value = 'menuperso_actions_Humor_calmetoi'},
											{label = 'Ter medo',  value = 'menuperso_actions_Humor_avoirpeur'},
											{label = 'Porra!',  value = 'menuperso_actions_Humor_cestpaspossible'},
											{label = 'Abraço',  value = 'menuperso_actions_Humor_enlacer'},
											{label = 'Vai para o ***',  value = 'menuperso_actions_Humor_doightdhonneur'},
											{label = 'Bater uma',  value = 'menuperso_actions_Humor_branleur'},
											{label = 'Suicidar',  value = 'menuperso_actions_Humor_balledanslatete'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Humor_feliciter' then
											animsActionScenario({anim = "WORLD_HUMAN_CHEERING" })
										end

										if data3.current.value == 'menuperso_actions_Humor_super' then
											animsAction({ lib = "anim@mp_player_intcelebrationmale@thumbs_up", anim = "thumbs_up" })
										end

										if data3.current.value == 'menuperso_actions_Humor_calmetoi' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_easy_now" })
										end

										if data3.current.value == 'menuperso_actions_Humor_avoirpeur' then
											animsAction({ lib = "amb@code_human_cower_stand@female@idle_a", anim = "idle_c" })
										end

										if data3.current.value == 'menuperso_actions_Humor_cestpaspossible' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_damn" })
										end

										if data3.current.value == 'menuperso_actions_Humor_enlacer' then
											animsAction({ lib = "mp_ped_interaction", anim = "kisses_guy_a" })
										end

										if data3.current.value == 'menuperso_actions_Humor_doightdhonneur' then
											animsAction({ lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" })
										end

										if data3.current.value == 'menuperso_actions_Humor_branleur' then
											animsAction({ lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01" })
										end

										if data3.current.value == 'menuperso_actions_Humor_balledanslatete' then
											animsAction({ lib = "mp_suicide", anim = "pistol" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Travail' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Travail',
									{
										title    = 'Animações de Trabalho',
										align    = 'top-left',
										elements = {
											{label = 'Pescador',  value = 'menuperso_actions_Travail_pecheur'},
											{label = 'Agricultor',     value = 'menuperso_actions_Travail_agriculteur'},
											{label = 'Mecânico',     value = 'menuperso_actions_Travail_depanneur'},		
											{label = 'Inspector',  value = 'menuperso_actions_Travail_inspecter'},
											{label = 'Tirar notas',  value = 'menuperso_actions_Travail_prendredesnotes'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Travail_pecheur' then
											animsActionScenario({anim = "world_human_stand_fishing" })
										end

										if data3.current.value == 'menuperso_actions_Travail_agriculteur' then
											animsActionScenario({anim = "world_human_gardener_plant" })
										end

										if data3.current.value == 'menuperso_actions_Travail_depanneur' then
											animsActionScenario({anim = "world_human_vehicle_mechanic" })
										end

										if data3.current.value == 'menuperso_actions_Travail_prendredesnotes' then
											animsActionScenario({anim = "WORLD_HUMAN_CLIPBOARD" })
										end

										if data3.current.value == 'menuperso_actions_Travail_inspecter' then
											animsActionScenario({anim = "CODE_HUMAN_MEDIC_KNEEL" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Festives' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Festives',
									{
										title    = 'Animações festivas',
										align    = 'top-left',
										elements = {
									        {label = 'Dançar',  value = 'menuperso_actions_Festives_danser'},
											{label = 'Tocar música',     value = 'menuperso_actions_Festives_jouerdelamusique'},
											{label = 'Beber uma cerveja',     value = 'menuperso_actions_Festives_boireunebiere'},
											{label = 'Guitarra',  value = 'menuperso_actions_Festives_airguitar'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Festives_danser' then
											animsAction({ lib = "amb@world_human_partying@female@partying_beer@base", anim = "base" })
										end

										if data3.current.value == 'menuperso_actions_Festives_jouerdelamusique' then
											animsActionScenario({anim = "WORLD_HUMAN_MUSICIAN" })
										end

										if data3.current.value == 'menuperso_actions_Festives_boireunebiere' then
											animsActionScenario({anim = "WORLD_HUMAN_DRINKING" })
										end

										if data3.current.value == 'menuperso_actions_Festives_airguitar' then
											animsAction({ lib = "anim@mp_player_intcelebrationfemale@air_guitar", anim = "air_guitar" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Others' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Others',
									{
										title    = 'Animações diversas',
										align    = 'top-left',
										elements = {
											{label = 'Fumar um cigarro',     value = 'menuperso_actions_Others_fumeruneclope'},
											{label = 'Fazer flexões',     value = 'menuperso_actions_Others_fairedespompes'},
											{label = 'Olhar nos binóculos',     value = 'menuperso_actions_Others_regarderauxjumelles'},
											{label = 'Fazer yoga',     value = 'menuperso_actions_Others_faireduyoga'},
											{label = 'Ficar estátua',     value = 'menuperso_actions_Others_fairelastatut'},
											{label = 'Correr',     value = 'menuperso_actions_Others_fairedujogging'},
											{label = 'Mostrar músculos',     value = 'menuperso_actions_Others_fairedesetirements'},
											{label = 'Pegar',     value = 'menuperso_actions_Others_racoller'},
											{label = 'Pegar 2',     value = 'menuperso_actions_Others_racoller2'},
											{label = 'Sentar',     value = 'menuperso_actions_Others_sasseoir'},
											{label = 'Sentar no chão',     value = 'menuperso_actions_Others_sasseoirparterre'},
											{label = 'Esperar',     value = 'menuperso_actions_Others_attendre'},
											{label = 'Limpar algo',     value = 'menuperso_actions_Others_nettoyerquelquechose'},
											{label = 'Levantar as mãos',     value = 'menuperso_actions_Others_leverlesmains'},
											{label = 'Posição de pesquisa',     value = 'menuperso_actions_Others_positiondefouille'},
											{label = 'Coçar as bolas',     value = 'menuperso_actions_Others_segratterlesc'},
											{label = 'Tirar uma selfie',     value = 'menuperso_actions_Others_prendreunselfie'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Others_fumeruneclope' then
											animsActionScenario({ anim = "WORLD_HUMAN_SMOKING" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairedespompes' then
											animsActionScenario({ anim = "WORLD_HUMAN_PUSH_UPS" })
										end

										if data3.current.value == 'menuperso_actions_Others_regarderauxjumelles' then
											animsActionScenario({ anim = "WORLD_HUMAN_BINOCULARS" })
										end

										if data3.current.value == 'menuperso_actions_Others_faireduyoga' then
											animsActionScenario({ anim = "WORLD_HUMAN_YOGA" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairelastatut' then
											animsActionScenario({ anim = "WORLD_HUMAN_HUMAN_STATUE" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairedujogging' then
											animsActionScenario({ anim = "WORLD_HUMAN_JOG_STANDING" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairedesetirements' then
											animsActionScenario({ anim = "WORLD_HUMAN_MUSCLE_FLEX" })
										end

										if data3.current.value == 'menuperso_actions_Others_racoller' then
											animsActionScenario({ anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" })
										end

										if data3.current.value == 'menuperso_actions_Others_racoller2' then
											animsActionScenario({ anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" })
										end

										if data3.current.value == 'menuperso_actions_Others_sasseoir' then
											animsAction({ lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle" })
										end

										if data3.current.value == 'menuperso_actions_Others_sasseoirparterre' then
											animsActionScenario({ anim = "WORLD_HUMAN_PICNIC" })
										end

										if data3.current.value == 'menuperso_actions_Others_attendre' then
											animsActionScenario({ anim = "world_human_leaning" })
										end

										if data3.current.value == 'menuperso_actions_Others_nettoyerquelquechose' then
											animsActionScenario({ anim = "world_human_maid_clean" })
										end

										if data3.current.value == 'menuperso_actions_Others_leverlesmains' then
											animsAction({ lib = "random@mugging3", anim = "handsup_standing_base" })
										end

										if data3.current.value == 'menuperso_actions_Others_positiondefouille' then
											animsAction({ lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" })
										end

										if data3.current.value == 'menuperso_actions_Others_segratterlesc' then
											animsAction({ lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" })
										end

										if data3.current.value == 'menuperso_actions_Others_prendreunselfie' then
											animsActionScenario({ anim = "world_human_tourist_mobile" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end
							
							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end

				if data.current.value == 'menuperso_gpsrapide' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_gpsrapide',
						{
							title    = '🛰️ GPS Rápido',
							align    = 'top-left',
							elements = {
								{label = 'Centro de Emprego',     value = 'menuperso_gpsrapide_poleemploi'},
								{label = 'Departamento da Policia de WTRP',              value = 'menuperso_gpsrapide_comico'},
								{label = 'Hospital', value = 'menuperso_gpsrapide_hopital'},
								{label = 'Concessionária',  value = 'menuperso_gpsrapide_concessionnaire'}
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_gpsrapide_poleemploi' then
								x, y, z = Config.poleemploi.x, Config.poleemploi.y, Config.poleemploi.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								--ESX.ShowNotification("Destino adicionado no GPS!")
								exports['Johnny_Notificacoes']:Alert("GPS", "<span style='color:#c7c7c7'>Destino marcado no GPS!", 5000, 'info')
							end

							if data2.current.value == 'menuperso_gpsrapide_comico' then
								x, y, z = Config.comico.x, Config.comico.y, Config.comico.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								--ESX.ShowNotification("Destino adicionado no GPS!")
								exports['Johnny_Notificacoes']:Alert("GPS", "<span style='color:#c7c7c7'>Destino marcado no GPS!", 5000, 'info')
							end

							if data2.current.value == 'menuperso_gpsrapide_hopital' then
								x, y, z = Config.hopital.x, Config.hopital.y, Config.hopital.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								--ESX.ShowNotification("Destino adicionado no GPS!")
								exports['Johnny_Notificacoes']:Alert("GPS", "<span style='color:#c7c7c7'>Destino marcado no GPS!", 5000, 'info')
							end

							if data2.current.value == 'menuperso_gpsrapide_concessionnaire' then
								x, y, z = Config.concessionnaire.x, Config.concessionnaire.y, Config.concessionnaire.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								--ESX.ShowNotification("Destino adicionado no GPS!")
								exports['Johnny_Notificacoes']:Alert("GPS", "<span style='color:#c7c7c7'>Destino marcado no GPS!", 5000, 'info')
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)

				end
				
				if data.current.value == 'menuperso_servicos' then

					ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
						TriggerEvent('esx_scoreboard:servicos', connectedPlayers)
					end)		
					
				end
				
				if data.current.value == 'menuperso_grade' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_grade',
						{
							title    = '💼 Gestão da Empresa',
							align    = 'top-left',
							elements = {
								{label = 'Recrutar',     value = 'menuperso_grade_recruter'},
								{label = 'Demitir',              value = 'menuperso_grade_virer'},
								{label = 'Promover', value = 'menuperso_grade_promouvoir'},
								{label = 'Despromover',  value = 'menuperso_grade_destituer'}
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_grade_recruter' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Nenhum jogador nas proximidades")
									else
										TriggerServerEvent('NB:recndscfhwechtnbuoiwperyruterplayer', GetPlayerServerId(closestPlayer), job,grade)
									end

								else
									Notify("Não tens ~r~Permissão~w~.")

								end
								
							end

							if data2.current.value == 'menuperso_grade_virer' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Nenhum jogador nas proximidades")
									else
										TriggerServerEvent('NB:virerplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Não tens ~r~Permissão~w~.")

								end
								
							end

							if data2.current.value == 'menuperso_grade_promouvoir' then

								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Nenhum jogador nas proximidades")
									else
										TriggerServerEvent('NB:promouvoirplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Não tens ~r~Permissão~w~.")

								end
								
								
							end

							if data2.current.value == 'menuperso_grade_destituer' then

								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Nenhum jogador nas proximidades")
									else
										TriggerServerEvent('NB:destituerplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Não tens ~r~Permissão~w~.")

								end
								
								
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end	
				
				
			end,
			function(data, menu)
				menu.close()
			end
		)
		
	end)
end

---------------------------------------------------------------------------Modération

function RemoverObjetos()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full',
		'prop_busstop_02'
	}

	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	local closestDistance = -1
	local closestEntity   = nil

	for i=1, #trackedEntities, 1 do
		local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey(trackedEntities[i]), false, false, false)
		
		
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)
			local distance  = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, objCoords.x, objCoords.y, objCoords.z, true)
			DeleteObject(object)
		end
	end
end

-- Draws boundingbox around the object with given color parms
function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim = 
	{ 
		x = 0.5*(max.x - min.x), 
		y = 0.5*(max.y - min.y), 
		z = 0.5*(max.z - min.z)
	}

    local FUR = 
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x, 
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y, 
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL = 
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 = 
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 = 
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 = 
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 = 
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 = 
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 = 
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end

-- Embed direction in rotation vector
function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

-- Raycast function for "Admin Lazer"
function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

function DrawText3D(x, y, z, text, lines)
    -- Amount of lines default 1
    if lines == nil then
        lines = 1
    end

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
    DrawRect(0.0, 0.0+0.0125 * lines, 0.017+ factor, 0.03 * lines, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- GOTO JOUEUR
function admin_tp_toplayer()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o id do jogador...")
	inputgoto = 1
end

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputgoto == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputgoto = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputgoto = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputgoto = 0
			end
		end
		if inputgoto == 2 then
			sleep = 5
			local gotoply = GetOnscreenKeyboardResult()
			local playerPed = GetPlayerPed(-1)
			local teleportPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(gotoply))))
			SetEntityCoords(playerPed, teleportPed)
			
			inputgoto = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN GOTO JOUEUR

-- TP UN JOUEUR A MOI
function admin_tp_playertome()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o ID do jogador...")
	inputteleport = 1
end

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputteleport == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputteleport = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				inputteleport = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputteleport = 0
			end
		end
		if inputteleport == 2 then
			sleep = 5
			local teleportply = GetOnscreenKeyboardResult()
			local playerPed = GetPlayerFromServerId(tonumber(teleportply))
			local teleportPed = GetEntityCoords(GetPlayerPed(-1))
			SetEntityCoords(playerPed, teleportPed)
			
			inputteleport = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN TP UN JOUEUR A MOI

-- TP A POSITION
function admin_tp_pos()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira as coordenadas [x][y][z]...")
	inputpos = 1
end

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputpos == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputpos = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputpos = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputpos = 0
			end
		end
		if inputpos == 2 then
			sleep = 5
			local pos = GetOnscreenKeyboardResult() -- GetOnscreenKeyboardResult RECUPERE LA POSITION RENTRER PAR LE JOUEUR
			local _,_,x,y,z = string.find( pos or "0,0,0", "([%d%.]+),([%d%.]+),([%d%.]+)" )
			
			--SetEntityCoords(GetPlayerPed(-1), x, y, z)
		    SetEntityCoords(GetPlayerPed(-1), x+0.0001, y+0.0001, z+0.0001) -- TP LE JOUEUR A LA POSITION
			inputpos = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN TP A POSITION

-- GOD MODE
function admin_godmode()
   local ped = GetPlayerPed(-1)
  
    if not godmode then -- activé
		godmode = true
		--Notify("Modo GOD: ~g~Ativado")
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Modo GOD: <span style='color:#069a19'>ATIVADO</span>", 5000, 'success')
		SetEntityInvincible(GetPlayerPed(-1), true)
		SetPlayerInvincible(PlayerId(), true)
		SetPedCanRagdoll(GetPlayerPed(-1), false)
		ClearPedBloodDamage(GetPlayerPed(-1))
		ResetPedVisibleDamage(GetPlayerPed(-1))
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
		--SetEntityVisible(GetPlayerPed(-1), false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), false)
	else
		godmode = false
		--Notify("Modo GOD: ~g~Desativado")
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Modo GOD: <span style='color:#ff0000'>DESATIVADO</span>", 5000, 'error')
		SetEntityInvincible(GetPlayerPed(-1), false)
		SetPlayerInvincible(PlayerId(), false)
		SetPedCanRagdoll(GetPlayerPed(-1), true)
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		--SetEntityVisible(GetPlayerPed(-1), true)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
    end
end
--[[
Citizen.CreateThread(function() --Godmode
	while true do
		local sleep = true
		if godmode == true then
			sleep = false
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			--SetEntityVisible(GetPlayerPed(-1), false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		elseif godmode == false then
			sleep = false
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			--SetEntityVisible(GetPlayerPed(-1), true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		end
		if sleep==true then
			Citizen.Wait(2000)
		end
        Citizen.Wait(0)
	end
end) --]]
-- FIN GOD MODE

-- INVISIBLE
function admin_mode_fantome()
  invisible = not invisible
  local ped = GetPlayerPed(-1)
  
  if invisible then -- activé
		SetEntityVisible(ped, false, false)
		--Notify("Modo fantasma: Ativado")
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Modo Fantasma: <span style='color:#069a19'>ATIVADO</span>", 5000, 'success')
	else
		SetEntityVisible(ped, true, false)
		--Notify("Modo fantasma: Desativado")
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Modo Fantasma: <span style='color:#ff0000'>DESATIVADO</span>", 5000, 'error')
  end
end
-- FIN INVISIBLE

-- Réparer vehicule
function admin_vehicle_repair()

    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsUsing(ped)
	
	SetVehicleFixed(car)
	SetVehicleDirtLevel(car, 0.0)
	exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Veículo reparado com <span style='color:#069a19'>sucesso</span>!", 3000, 'success')
end
-- FIN Réparer vehicule

-- Spawn vehicule
function admin_vehicle_spawn()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o ID do carro...")
	inputvehicle = 1
end

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputvehicle == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputvehicle = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputvehicle = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputvehicle = 0
			end
		end
		if inputvehicle == 2 then
			sleep = 5
			local vehicleidd = GetOnscreenKeyboardResult()

				local car = GetHashKey(vehicleidd)
				
				Citizen.CreateThread(function()
					Citizen.Wait(10)
					RequestModel(car)
					while not HasModelLoaded(car) do
						Citizen.Wait(0)
					end
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
					veh = CreateVehicle(car, x,y,z, 0.0, true, false)
					SetEntityVelocity(veh, 2000)
					SetVehicleOnGroundProperly(veh)
					SetVehicleHasBeenOwnedByPlayer(veh,true)
					local id = NetworkGetNetworkIdFromEntity(veh)
					SetNetworkIdCanMigrate(id, true)
					SetVehRadioStation(veh, "OFF")
					SetPedIntoVehicle(GetPlayerPed(-1),  veh,  -1)
					--Notify("Veiculo spawnado com sucesso")
					exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Veiculo <span style='color:#069a19'>spawnado</span> com sucesso!", 5000, 'success')
				end)
		
        inputvehicle = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN Spawn vehicule

-- flipVehicle
function admin_vehicle_flip()

    local player = PlayerPedId()
    posdepmenu = GetEntityCoords(player)
    carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
	
	if carTargetDep ~= nil and carTargetDep ~= 0 then
		platecarTargetDep = GetVehicleNumberPlateText(carTargetDep)
	
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		playerCoords = playerCoords + vector3(0, 2, 0)
	
		SetEntityCoords(carTargetDep, playerCoords)
	
	--Notify("Veiculo virado")
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>O veículo foi <span style='color:#069a19'>VIRADO</span> com sucesso!", 5000, 'success')
	else
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Não há <span style='color:#ff0000'>veículos</span> por perto!", 5000, 'error')
	end

end
-- FIN flipVehicle

-- GIVE DE L'ARGENT
function admin_give_money()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o montante...")
	inputmoney = 1
end

function admin_open_inv()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o id do jogador...")
	inputinv = 1
end



Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputmoney == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputmoney = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoney = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoney = 0
			end
		end
		if inputmoney == 2 then
			sleep = 5
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMndscfhwechtnbuoiwperyenu:giveCash', money)
			inputmoney = 0
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputinv == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputinv = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputinv = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputinv = 0
			end
		end
		if inputinv == 2 then
			sleep = 5
			local idjogador = GetOnscreenKeyboardResult()
			local idjogador = tonumber(idjogador)
			
			ExecuteCommand('openinventory '..idjogador)
			--TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", idjogador)
			inputinv = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN GIVE DE L'ARGENT

-- GIVE DE L'ARGENT EN BANQUE
function admin_give_bank()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o montante...")
	inputmoneybank = 1
end

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputmoneybank == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneybank = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneybank = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneybank = 0
			end
		end
		if inputmoneybank == 2 then
			sleep = 5
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMendscfhwechtnbuoiwperynu:giveBank', money)
			inputmoneybank = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN GIVE DE L'ARGENT EN BANQUE

-- GIVE DE L'ARGENT SALE
function admin_give_dirty()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o montante...")
	inputmoneydirty = 1
end

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputmoneydirty == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneydirty = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneydirty = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneydirty = 0
			end
		end
		if inputmoneydirty == 2 then
			sleep = 5
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMenu:giveDirtyMndscfhwechtnbuoiwperyoney', money)
			--TriggerEvent("inventory:receiveItem", 'black_money', money)
			inputmoneydirty = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN GIVE DE L'ARGENT SALE

-- Afficher Coord
function modo_showcoord()
	ToggleCoords()
end

Citizen.CreateThread(function()
    while true do
    	local sleep=true
		if coordsVisible then
			sleep=false
    		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    		roundx = tonumber(string.format("%.2f", x))
    		roundy = tonumber(string.format("%.2f", y))
    		roundz = tonumber(string.format("%.2f", z))
        	SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.50)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~X:~s~ "..roundx)
			DrawText(0.35, 0.90)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.50)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Y:~s~ "..roundy)
			DrawText(0.45, 0.90)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.50)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Z:~s~ "..roundz)
			DrawText(0.55, 0.90)
			heading = GetEntityHeading(GetPlayerPed(-1))
			roundh = tonumber(string.format("%.2f", heading))
        	SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.50)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Virado para:~s~ "..roundh)
			DrawText(0.40, 0.96)
			speed = GetEntitySpeed(PlayerPedId())
			rounds = tonumber(string.format("%.2f", speed)) 
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.40)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Velocidade: ~s~"..rounds)
			health = GetEntityHealth(PlayerPedId())
			DrawText(0.01, 0.62)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.40)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~r~Vida: ~s~"..health)
			DrawText(0.01, 0.58)
			veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
			vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
			if IsPedInAnyVehicle(PlayerPedId(), 1) then
			 	vehenground = tonumber(string.format("%.2f", veheng))
				vehbodround = tonumber(string.format("%.2f", vehbody))
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.40)
				SetTextDropshadow(1, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString("~r~Vida do Motor: ~s~"..vehenground)
				DrawText(0.01, 0.50)
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.40)
				SetTextDropshadow(1, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString("~r~Vida da carroçaria: ~s~"..vehbodround)
				DrawText(0.01, 0.54) --hehe
			end
	    end
		if sleep==true then
			Citizen.Wait(1000)
		end
        Citizen.Wait(0)
	end
end)

ToggleCoords = function()
	coordsVisible = not coordsVisible
end
-- FIN Afficher Coord

function destrancar_carros()
	
	local player = GetPlayerPed(-1)	
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local vehicle = GetClosestVehicle(x, y, z, 7.000, 0, 127)
	local lock = GetVehicleDoorLockStatus(vehicle)
	
	if DoesEntityExist(vehicle) then
		if lock == 2 then
			SetVehicleDoorsLocked(vehicle, 1)
			--ESX.ShowNotification("Destrancaste o veículo mais próximo!")
			exports['Johnny_Notificacoes']:Alert("ADMIN", "<span style='color:#c7c7c7'>Veículo <span style='color:#069a19'>destrancado</span> com sucesso!", 5000, 'success')
		end
	end
	
end



--RegisterCommand("tpm", function(source)
--    admin_tp_marcker()
--end)
-- FIN TP MARCKER

-- HEAL JOUEUR
function admin_heal_player()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Insira o ID do jogador...")
	inputheal = 1
end

Citizen.CreateThread(function()
	while true do
		local sleep = 250
		if inputheal == 1 then
			sleep = 5
			if UpdateOnscreenKeyboard() == 3 then
				inputheal = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				inputheal = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputheal = 0
			end
		end
		if inputheal == 2 then
			sleep = 5
			local healply = GetOnscreenKeyboardResult()
			TriggerServerEvent('esx_ambulancejob:revLoureivero', healply)
		
			inputheal = 0
		end
		Citizen.Wait(sleep)
	end
end)
-- FIN HEAL JOUEUR

-- SPEC JOUEUR
function admin_spec_player()
	TriggerEvent('esx_spectate:spectate')
end
-- FIN SPEC JOUEUR

---------------------------------------------------------------------------Me concernant

function openTelephone()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuTelephone')
end

function openInventaire()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuInventaire')
end

function openFacture()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuFactures')
end

---------------------------------------------------------------------------Actions

local playAnim = false
local dataAnim = {}

function animsAction(animObj)
	if (IsInVehicle()) then
		local source = GetPlayerServerId();
		ESX.ShowNotification("Sai do veiculo para fazer isso!")
	else
		Citizen.CreateThread(function()
			if not playAnim then
				local playerPed = GetPlayerPed(-1);
				if DoesEntityExist(playerPed) then -- Ckeck if ped exist
					dataAnim = animObj

					-- Play Animation
					RequestAnimDict(dataAnim.lib)
					while not HasAnimDictLoaded(dataAnim.lib) do
						Citizen.Wait(0)
					end
					if HasAnimDictLoaded(dataAnim.lib) then
						local flag = 0
						if dataAnim.loop ~= nil and dataAnim.loop then
							flag = 1
						elseif dataAnim.move ~= nil and dataAnim.move then
							flag = 49
						end

						TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
						playAnimation = true
					end

					-- Wait end annimation
					while true do
						Citizen.Wait(0)
						if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
							playAnim = false
							TriggerEvent('ft_animation:ClFinish')
							break
						end
					end
				end -- end ped exist
			end
		end)
	end
end
	

function animsActionScenario(animObj)
	if (IsInVehicle()) then
		local source = GetPlayerServerId();
		ESX.ShowNotification("Sai do veiculo para fazer isso!")
	else
		Citizen.CreateThread(function()
			if not playAnim then
				local playerPed = GetPlayerPed(-1);
				if DoesEntityExist(playerPed) then
					dataAnim = animObj
					TaskStartScenarioInPlace(playerPed, dataAnim.anim, 0, false)
					playAnimation = true
				end
			end
		end)
	end
end

-- Verifie si le joueurs est dans un vehicule ou pas
function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function changer_skin()
	TriggerEvent('esx_skin:openSaveableMenu', source)
end

function save_skin()
	TriggerEvent('esx_skin:requestSaveSkin', source)
end

---------------------------------------------------------------------------------------------------------
--NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:goTpMarcker')
AddEventHandler('NB:goTpMarcker', function()
	admin_tp_marcker()
end)

RegisterNetEvent('NB:openMenuPersonnel')
AddEventHandler('NB:openMenuPersonnel', function()
	OpenPersonnelMenu()
end)

AddEventHandler('modoadmin:client:TogglePermissao', function(estado)
	modoadmin = estado
end)



----------------------------------- MENU F5 ANTIGO ------------------------------