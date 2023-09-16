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
local WeaponLiscence = {x = 442.77, y = -981.86, z = 30.69}

local LojaCidadao = {x = 236.95, y = -407.86, z = 46.92}

local portearma_preco = 15000
local segunda_via_portearma_preco = 5000
local licenca_caca_preco = 10000
local segunda_via_licenca_caca_preco = 2500

local PlayerData              = {}

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

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local player = GetPlayerPed(-1)
        local coords = GetEntityCoords(player)
		local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

		if GetDistanceBetweenCoords(coords, WeaponLiscence.x, WeaponLiscence.y, WeaponLiscence.z, true) < 30.0 and (PlayerData.job.name == "police" or PlayerData.job.name == "sheriff") then
			if GetDistanceBetweenCoords(coords, WeaponLiscence.x, WeaponLiscence.y, WeaponLiscence.z, true) < 5.0 and (PlayerData.job.name == "police" or PlayerData.job.name == "sheriff") then
				DrawText3Ds(WeaponLiscence.x, WeaponLiscence.y, WeaponLiscence.z + 1.1, 'Pressiona [~r~E~s~] para abrir o menu policial', 0.3)

				if IsControlJustReleased(0, Keys["E"]) then
					--if closestPlayer ~= -1 and playerDistance <= 4.0 then
						TriggerEvent('wtrp:menuPrincipal', closestPlayer)
						--Citizen.Wait(2000)
					--else
						--exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
					--end  
				end
			end
		else
			Citizen.Wait(5000)
		end
    end
end)
--]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local player = GetPlayerPed(-1)
        local coords = GetEntityCoords(player)
		local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

		if GetDistanceBetweenCoords(coords, LojaCidadao.x, LojaCidadao.y, LojaCidadao.z, true) < 20.0 then
			if GetDistanceBetweenCoords(coords, LojaCidadao.x, LojaCidadao.y, LojaCidadao.z, true) < 5.0 then
				DrawText3Ds(LojaCidadao.x, LojaCidadao.y, LojaCidadao.z + 1.1, '~b~E~s~ - Renovar o cartão de cidadão')

				if IsControlJustReleased(0, Keys["E"]) then
					--if closestPlayer ~= -1 and playerDistance <= 4.0 then
						--TriggerEvent('wtrp:menuPrincipal', closestPlayer)
						AtribuirCartaoCidadao()
						--Citizen.Wait(2000)
					--else
						--exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
					--end  
				end
			end
		else
			Citizen.Wait(5000)
		end
    end
end)

function AtribuirCartaoCidadao(idjogador)
    exports['progressbar']:Progress({
		name = "unique_action_name",
		duration = 10000,
		label = "A renovar Cartão de Cidadão...",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "missheistdockssetup1clipboard@base",
			anim = "base",
			flags = 49,
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
	TriggerServerEvent('wtrp:segundavia_cartao_cidadao')
end

RegisterNetEvent("wtrp:menuPrincipal")
AddEventHandler("wtrp:menuPrincipal", function(idjogador)
    
	ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license7',{
        title = 'Menu Policial',
        align = 'top-left',
		elements = {
          { label = 'Atribuir Licenças', value = 'licencas' },
          --{ label = 'Ver Veículos Apreendidos', value = 'veiculos_apreendidos' },
        }
      },
      function (data, menu)
        if data.current.value == 'licencas' then
			local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and playerDistance <= 4.0 then
				TriggerEvent('suku:OpenBuyLicenseMenu', closestPlayer)
				Citizen.Wait(2000)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há jogadores por perto!')
			end  
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
	
end)

DrawText3Ds = function(x, y, z, text)
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

RegisterNetEvent("suku:OpenBuyLicenseMenu")
AddEventHandler("suku:OpenBuyLicenseMenu", function(idjogador)
    
	ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
        title = 'Atribuir uma Licença ao Jogador (ID: ' .. GetPlayerServerId(idjogador) .. ')',
        align = 'top-left',
		elements = {
         -- { label = 'Atribuir um porte de armas ao jogador', value = 'porte_arma' },
         -- { label = 'Atribuir segunda via do porte de arma', value = '2via_porte_arma' },
		  { label = 'Atribuir Licença de Caça ao jogador', value = 'licenca_caca' },
          { label = 'Atribuir segunda via da Licença de Caça', value = '2via_licenca_caca' },
        }
      },
      function (data, menu)
        if data.current.value == 'porte_arma' then
			OpenBuyLicenseMenu(GetPlayerServerId(idjogador))
		elseif data.current.value == '2via_porte_arma' then
			OpenBuyLicenseMenu2(GetPlayerServerId(idjogador))
		elseif data.current.value == 'licenca_caca' then
			OpenBuyLicenseMenu3(GetPlayerServerId(idjogador))
		elseif data.current.value == '2via_licenca_caca' then
			OpenBuyLicenseMenu4(GetPlayerServerId(idjogador))
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
	
end)

function OpenBuyLicenseMenu(idjogador)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop2_license',{
        title = 'Registar Licença de Porte de Armas ao (ID: '.. idjogador ..')',
        align = 'top-left',
		elements = {
          { label = 'Sim (O jogador irá pagar: ' .. portearma_preco ..'€)', value = 'yes' },
          { label = 'Não', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
			ESX.TriggerServerCallback("suku:verificalicenca", function(licenca)
				if licenca then
					exports['mythic_notify']:DoHudText('error', 'O jogador já possui licença de porte de armas!')
				else
					ESX.TriggerServerCallback('suku:buyLicense', function(bought)
				
					end, idjogador)	
				end
				
			end, idjogador)
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end

function OpenBuyLicenseMenu2(idjogador)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop4_license',{
        title = 'Atribuir Segunda Via de Licença de Porte de Armas ao (ID: '.. idjogador ..')',
        align = 'top-left',
		elements = {
          { label = 'Sim (O jogador irá pagar: '..segunda_via_portearma_preco..'€)', value = 'yes' },
          { label = 'Não', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
			ESX.TriggerServerCallback("suku:verificalicenca", function(licenca)	
				if licenca then
					TriggerServerEvent('suku:segundavia', idjogador)
				else
					exports['mythic_notify']:DoHudText('error', 'O jogador não está registado na base de dados!')
				end
				
			end, idjogador)
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end

function OpenBuyLicenseMenu3(idjogador)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license_caca',{
        title = 'Registar Licença de Caça ao (ID: '.. idjogador ..')',
        align = 'top-left',
		elements = {
          { label = 'Sim (O jogador irá pagar: ' .. licenca_caca_preco ..'€)', value = 'yes' },
          { label = 'Não', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
			ESX.TriggerServerCallback("suku:verificaLicencaCaca", function(licenca)
				if licenca then
					exports['mythic_notify']:DoHudText('error', 'O jogador já possui licença de caça!')
				else
					ESX.TriggerServerCallback('suku:buyLicenseCaca', function(bought)
					
					end, idjogador)	
				end
				
			end, idjogador)
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end

function OpenBuyLicenseMenu4(idjogador)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop5_license',{
        title = 'Atribuir Segunda Via da Licença de Caça ao (ID: '.. idjogador ..')',
        align = 'top-left',
		elements = {
          { label = 'Sim (O jogador irá pagar: '..segunda_via_licenca_caca_preco..'€)', value = 'yes' },
          { label = 'Não', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
			ESX.TriggerServerCallback("suku:verificaLicencaCaca", function(licenca)	
				if licenca then
					TriggerServerEvent('suku:segundaviaCaca', idjogador)
				else
					exports['mythic_notify']:DoHudText('error', 'O jogador não está registado na base de dados!')
				end
				
			end, idjogador)
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end