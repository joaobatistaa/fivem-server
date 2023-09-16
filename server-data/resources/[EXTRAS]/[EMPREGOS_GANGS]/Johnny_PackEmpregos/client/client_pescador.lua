local playerPed     	= PlayerPedId()
local isInBaitShopMenu  = false
local currentBaitshop   = {}
local shopMenu
local anchored = false
local boat = nil
local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local bait = "none"
--[[
Citizen.CreateThread(function()

	if SellFishblip == nil then
		SellFishblip = AddBlipForCoord(Config.PescadorInfo.SellFish.x, Config.PescadorInfo.SellFish.y, Config.PescadorInfo.SellFish.z)
		SetBlipSprite(SellFishblip, 68)
		SetBlipDisplay(SellFishblip, 4)
		SetBlipScale(SellFishblip, 0.8)
		SetBlipAsShortRange(SellFishblip, true)
		SetBlipColour(SellFishblip, 15)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Venda de Peixe")
		EndTextCommandSetBlipName(SellFishblip)
	end
	
	if SellTartarugablip == nil then
		SellTartarugablip = AddBlipForCoord(Config.PescadorInfo.SellTurtle.x, Config.PescadorInfo.SellTurtle.y, Config.PescadorInfo.SellTurtle.z)
		SetBlipSprite(SellTartarugablip, 68)
		SetBlipDisplay(SellTartarugablip, 4)
		SetBlipScale(SellTartarugablip, 0.8)
		SetBlipAsShortRange(SellTartarugablip, true)
		SetBlipColour(SellTartarugablip, 15)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Venda de Tartaruga")
		EndTextCommandSetBlipName(SellTartarugablip)
	end
	
	if SellTubaraoblip == nil then
		SellTubaraoblip = AddBlipForCoord(Config.PescadorInfo.SellShark.x, Config.PescadorInfo.SellShark.y, Config.PescadorInfo.SellShark.z)
		SetBlipSprite(SellTubaraoblip, 68)
		SetBlipDisplay(SellTubaraoblip, 4)
		SetBlipScale(SellTubaraoblip, 0.8)
		SetBlipAsShortRange(SellTubaraoblip, true)
		SetBlipColour(SellTubaraoblip, 15)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Venda de Tubarão")
		EndTextCommandSetBlipName(SellTubaraoblip)
	end

	local blipFishingShop = AddBlipForCoord(1694.8238525391, 3755.3889160156, 34.705341339111)
	SetBlipSprite(blipFishingShop, 68)
	SetBlipColour(blipFishingShop, 15)
	SetBlipScale(blipFishingShop, 0.0)
	SetBlipAsShortRange(blipFishingShop, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Loja de Pesca")
	EndTextCommandSetBlipName(blipFishingShop)
end) --]]

RegisterNetEvent('vg_fishing:message')
AddEventHandler('vg_fishing:message', function(text)
	exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..text.."", 5000, 'success')
end, false)

RegisterNetEvent('vg_fishing:message2')
AddEventHandler('vg_fishing:message2', function(text)
	exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..text.."", 5000, 'error')
end, false)

RegisterNetEvent('vg_fishing:message3')
AddEventHandler('vg_fishing:message3', function(text)
	exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..text.."", 5000, 'info')
end, false)


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	local sleep = 1500
	while true do
		sleep = 1500

		local playerPed = PlayerPedId()

		local playerCoords = GetEntityCoords(PlayerPedId())

		if (GetDistanceBetweenCoords(playerCoords, Config.PescadorInfo.SellFish.x, Config.PescadorInfo.SellFish.y, Config.PescadorInfo.SellFish.z, true) < 9.0) then
			sleep = 5
			Draw3DText(Config.PescadorInfo.SellFish.x, Config.PescadorInfo.SellFish.y, Config.PescadorInfo.SellFish.z + 0.5, '[E] Vender Peixe')
			
			if IsControlJustReleased(0, 51) then
				exports['progressbar']:Progress({
					name = "sell_shark",
					duration = 5000,
					label = "A vender peixe...",
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
				}, function(status)
					if not status then
						--Do Something If Event Wasn't Cancelled
					end
				end)
				Citizen.Wait(4000)
				StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
				TriggerServerEvent('vg_fishing:startSelling', "fish")
			end
		end

		if (GetDistanceBetweenCoords(playerCoords, Config.PescadorInfo.SellShark.x, Config.PescadorInfo.SellShark.y, Config.PescadorInfo.SellShark.z, true) < 9.0) then
			sleep = 5
			Draw3DText(Config.PescadorInfo.SellShark.x, Config.PescadorInfo.SellShark.y, Config.PescadorInfo.SellShark.z + 0.5, '[E] Vender Carne de Tubarão')
			
			if IsControlJustReleased(0, 51) then
				exports['progressbar']:Progress({
					name = "sell_shark",
					duration = 8000,
					label = "A vender carne de tubarão...",
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
				}, function(status)
					if not status then
						--Do Something If Event Wasn't Cancelled
					end
				end)
				Citizen.Wait(4000)
				StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
				TriggerServerEvent('vg_fishing:startSelling', "shark")
			end
		end
		
		if (GetDistanceBetweenCoords(playerCoords, Config.PescadorInfo.SellTurtle.x, Config.PescadorInfo.SellTurtle.y, Config.PescadorInfo.SellTurtle.z, true) < 9.0) then
			sleep = 5
			Draw3DText(Config.PescadorInfo.SellTurtle.x, Config.PescadorInfo.SellTurtle.y, Config.PescadorInfo.SellTurtle.z + 0.5, '[E] Vender Tartaruga')
			
			if IsControlJustReleased(0, 51) then
				exports['progressbar']:Progress({
					name = "sell_shark",
					duration = 8000,
					label = "A vender tartaruga...",
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
				}, function(status)
					if not status then
						--Do Something If Event Wasn't Cancelled
					end
				end)
				Citizen.Wait(8000)
				StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
				TriggerServerEvent('vg_fishing:startSelling', "turtle")
			end
		end

		Citizen.Wait(sleep)
    end
end)

local inAcao = false
RegisterNetEvent('vg_fishing:anchor')
AddEventHandler('vg_fishing:anchor', function(text)
	local coords = GetEntityCoords(PlayerPedId())
	boat = ESX.Game.GetClosestVehicle(coords, nil)

	if not IsPedInAnyVehicle(ped) and boat ~= nil and not inAcao then -- TECLA G
		if not anchored then
			inAcao = true
			--TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchordown", 0.6)
			exports['progressbar']:Progress({
				name = "baixar_ancora",
				duration = 6000,
				label = "A baixar a âncora...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(6000)
			--ShowNotification("Anker geworfen")
			SetBoatAnchor(boat, true)
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Âncora <span style='color:#069a19'>baixada</span>!", 5000, 'success')
			--ClearPedTasks(playerPed)
			inAcao = false
		else
			inAcao = true
			--TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchorup", 0.6)
			exports['progressbar']:Progress({
				name = "recolher_ancora",
				duration = 6000,
				label = "A recolher a âncora...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
			}, function(status)
				if not status then
					--Do Something If Event Wasn't Cancelled
				end
			end)
			Citizen.Wait(6000)
			SetBoatAnchor(boat, false)
			--ShowNotification("Anker eingeholt")
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Âncora <span style='color:#069a19'>recolhida</span>!", 5000, 'success')
			--ClearPedTasks(playerPed)
			inAcao = false
		end
		anchored = not anchored
	else
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Estás a <span style='color:#ff0000'>conduzir</span> um barco! Sai do volante primeiro!", 5000, 'error')
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if fishing then

			if IsControlJustReleased(0, Keys["TOP"]) then
				input = 6
			end
			if IsControlJustReleased(0, Keys["RIGHT"]) then
				input = 7
			end
			if IsControlJustReleased(0, Keys["DOWN"]) then
				input = 8
			end
			if IsControlJustReleased(0, Keys["LEFT"]) then
				input = 9
			end

			if IsControlJustReleased(0, Keys['X']) then
				ClearPedTasks(playerPed)
				ClearPedTasks(GetPlayerPed(-1))
				fishing = false
				exports['mythic_notify']:DoHudText('error', 'Paraste de Pescar!')
			end
			if fishing then
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(PlayerPedId())
				--if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 or IsPedInAnyVehicle(PlayerPedId()) then
				
				--else
					--fishing = false
					--ShowNotification("~r~Stopped fishing")
					--exports['mythic_notify']:DoHudText('error', 'Paraste de Pescar!')
				--end
				if IsEntityDead(playerPed) then
					fishing = false
					exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não podes pescar enquanto estás <span style='color:#ff0000'>morto</span>!", 5000, 'error')
				elseif IsEntityInWater(playerPed) then
					fishing = false
					exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não podes pescar enquanto estás na <span style='color:#ff0000'>água</span>!", 5000, 'error')
				end
			end


			if pausetimer > 3 then
				input = 99
			end

			if pause and input ~= 0 then
				pause = false
				
				if input == correct then
					TriggerServerEvent('vg_fishing:catch', bait)
				else
					exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>O peixe fugiu!", 5000, 'info')
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.PescadorInfo.FishTime.a , Config.PescadorInfo.FishTime.b)
		Wait(wait)
		if fishing then
			pause = true
			correct = math.random(6,9)
			local label
			if correct == 9 then
				label = "SETA ESQUERDA"
			elseif correct == 8 then
				label = "SETA BAIXO"
			elseif correct == 7 then
				label = "SETA DIREITA"
			else
				label = "SETA CIMA"
			end
			exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>O peixe mordeu o isco!\nPressiona <span style='color:#fff'>"..label .."</span> para apanhá-lo!", 5000, 'info')
			input = 0
			pausetimer = 0
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('vg_fishing:break')
AddEventHandler('vg_fishing:break', function()
	fishing = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('vg_fishing:spawnPed')
AddEventHandler('vg_fishing:spawnPed', function()
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
	while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
		Citizen.Wait( 1 )
	end
	local pos = GetEntityCoords(PlayerPedId())

	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
	Citizen.Wait(5000)
	DeleteEntity(ped)
end)

RegisterNetEvent('vg_fishing:setbait')
AddEventHandler('vg_fishing:setbait', function(bool)
	bait = bool
end)

RegisterNetEvent('vg_fishing:fishstart')
AddEventHandler('vg_fishing:fishstart', function()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)
	if IsPedInAnyVehicle(playerPed) then
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não podes pescar dentro de um <span style='color:#ff0000'>veículo</span>!", 5000, 'error')
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -2400 or pos.x >= 4300 then
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Começaste a pescar!", 5000, 'success')
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_FISHING", 0, true)
			TriggerEvent('vg_fishing:playSound', "fishing_start")
			fishing = true
		else
			exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>Tens que ir para mais longe da <span style='color:#fff'>costa</span>!", 5000, 'info')
		end
	end
end, false)

RegisterNetEvent('vg_fishing:playSound')
AddEventHandler('vg_fishing:playSound', function(sound)
	local clientNetId = GetPlayerServerId(PlayerId())
	TriggerServerEvent("InteractSound_SV:PlayOnOne", clientNetId, sound, 0.5)
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
	SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 68)
end