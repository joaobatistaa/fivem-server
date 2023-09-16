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


local handcuffed                = false
local IsDragged                 = false
local CopPed                    = 0
local IsAbleToSearch            = false

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

function IsAbleToSteal(targetSID, err)
    ESX.TriggerServerCallback('esx_thief:getValue', function(result)
        local result = result
    	if result.value then
    		err(false)
    	else
    		err('O indivíduo não tem as mãos no ar!')
			exports['mythic_notify']:DoHudText('error', 'Não tens algemas no inventário!')
    	end
    end, targetSID)
end

---- MENU

function GetPlayers()
    local players = {}

    for i = 0, 500 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function OpenCuffMenu()

  local elements = {
        {label = 'Algemar', value = 'cuff'},
        {label = 'Desalgemar', value = 'uncuff'}, 
        {label = 'Arrastar', value = 'drag'},
		{label = 'Revistar', value = 'search'}, 
      }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cuffing',
    {
      title    = 'Menu Assalto',
      align    = 'top-left',
      elements = elements
      },
          function(data2, menu2)
            local player, distance = ESX.Game.GetClosestPlayer()
            if distance ~= -1 and distance <= 3.0 then
              if data2.current.value == 'cuff' then
                --if Config.EnableItems then

                    local target_id = GetPlayerServerId(player)
                
                    --IsAbleToSteal(target_id, function(err)
                        if IsEntityPlayingAnim(GetPlayerPed(player), 'missminuteman_1ig_2', 'handsup_base', 3) then
                            ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                                if quantity > 0 then
                                    IsAbleToSearch = true
									TriggerServerEvent('esx_policejob:algemar1', GetPlayerServerId(player))
									handcuffed = true
                                else
									exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>algemas</span> no inventário!", 5000, 'error')
                                end
                            end, 'handcuffs')
                        else
							exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>O civil não tem as <span style='color:#ff0000'>mãos</span> no ar!", 5000, 'error')
                        end
                    --end)
               -- else
                    --IsAbleToSearch = true
                    --TriggerServerEvent('cuffSendscfhwechtnbuoiwperyrver', GetPlayerServerId(player))
                --end
              end
              if data2.current.value == 'uncuff' then
                --if Config.EnableItems then
                    ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                        if quantity > 0 then
                            IsAbleToSearch = false
                            TriggerServerEvent('esx_policejob:desalgemar1', GetPlayerServerId(player))
							handcuffed = false
                        else
                            exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>algemas</span> no inventário!", 5000, 'error')
                        end
                    end, 'handcuffs')
                --else
                  --  IsAbleToSearch = false
                   -- TriggerServerEvent('cuffSendscfhwechtnbuoiwperyrver', GetPlayerServerId(player))
                --end
				end
				if data2.current.value == 'drag' then
              --  if Config.EnableItems then
               --     ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
               --         if quantity > 0 then
             --               IsAbleToSearch = false
            --                TriggerServerEvent('dragServer', GetPlayerServerId(player))
             --           else
              --              ESX.ShowNotification(_U('no_rope'))
              --          end
              --      end, 'rope')
             --   else
                    --TriggerServerEvent('dragServer', GetPlayerServerId(player))
					TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(player))
				--  end
				end  
				if data2.current.value == 'search' then

					local ped = PlayerPedId()

					if IsPedArmed(ped, 7) then
						if IsAbleToSearch then
							local target, distance = ESX.Game.GetClosestPlayer()
							if target ~= -1 and distance ~= -1 and distance <= 2.0 then
								local target_id = GetPlayerServerId(target)
								TriggerServerEvent('esx_policejob:message', target_id, 'Estás a ser revistado por alguém!')
								OpenBodySearchMenu(target_id)
								--TriggerEvent('animation')
							elseif distance < 20 and distance > 2.0 then
								exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Estás <span style='color:#ff0000'>longe</span> do indivíduo!", 5000, 'error')
							else
								exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não há <span style='color:#ff0000'>jogadores</span> por perto!", 5000, 'error')
							end
						else
							exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>O indivíduo não está <span style='color:#ff0000'>algemado</span>!", 5000, 'error')      
						end
					else
						exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Tens que estar <span style='color:#ff0000'>armado</span> para revistar!", 5000, 'error')
					end
				end
            else
				exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não há <span style='color:#ff0000'>jogadores</span> por perto!", 5000, 'error')
            end
          end,
    function(data2, menu2)
      menu2.close()
    end
  )

end

function OpenBodySearchMenu(player)
	TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", player)
end


RegisterNetEvent('roubojogadores:cuffClient')
AddEventHandler('roubojogadores:cuffClient', function()
	handcuffed = true
end)

RegisterNetEvent('roubojogadores:unCuffClient')
AddEventHandler('roubojogadores:unCuffClient', function()
	handcuffed = false
end)

RegisterNetEvent('cuffs:OpenMenu')
AddEventHandler('cuffs:OpenMenu', function()
	OpenCuffMenu()
end)

RegisterNetEvent('cuffscript:drag')
AddEventHandler('cuffscript:drag', function(cop)
  --TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if handcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterCommand('menuroubo', function(source)
	local ped = PlayerPedId()

    if not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then -- OPEN CUFF MENU
        OpenCuffMenu()
    end
end)


RegisterNetEvent('animation')
AddEventHandler('animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
        TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",-1, -1, -1, 120, 1, 0, 0, 0)
end)





