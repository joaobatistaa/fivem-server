local loadingScreenFinished = false

local guiEnabled = false
local isDead = false
local cam  = nil

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false
end)

AddEventHandler('esx:loadingScreenOff', function()
	loadingScreenFinished = true
end)

RegisterNetEvent('jsfour-register:alreadyRegistered')
AddEventHandler('jsfour-register:alreadyRegistered', function()
	while not loadingScreenFinished do
		Citizen.Wait(100)
	end

	TriggerEvent('esx_skin:playerRegistered')
end)

function EnableGui(state, fakeid)
	SetNuiFocus(state, state)
	guiEnabled = state

	if state == true and not fakeid then
		SendNUIMessage({
			action = "open"
		})
	elseif state == true and fakeid then
		SendNUIMessage({
			action = "fakeid"
		})
	else
		SendNUIMessage({
			action = "close"
		})
	end
end

-- Open the register form, (call from server)
RegisterNetEvent('jsfour-register:open')
AddEventHandler('jsfour-register:open', function()
	TriggerEvent('esx_skin:resetFirstSpawn')
	
	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end
	SetCamActive(cam,  true)
	RenderScriptCams(true,  false,  0,  true,  true)
	SetCamCoord(cam, -288.92544555664, -2443.6701660156, 591.98687744141)
	PointCamAtCoord(cam, -169.18321228027, -1056.4204101563, 129.99223327637)

	SetEntityCollision(GetPlayerPed(-1),  false,  false)
	SetEntityVisible(GetPlayerPed(-1),  false)
	FreezeEntityPosition(GetPlayerPed(-1), true);
	
	while not loadingScreenFinished do
		Citizen.Wait(100)
	end
	
	if not isDead then
		EnableGui(true, false)
	end
end)

-- Open the register form, (call from server)
RegisterNetEvent('jsfour-register:open_identity')
AddEventHandler('jsfour-register:open_identity', function()
	SetEntityCollision(GetPlayerPed(-1),  false,  false)
	--SetEntityVisible(GetPlayerPed(-1),  false)
	FreezeEntityPosition(GetPlayerPed(-1), true);
	
	if not isDead then
		EnableGui(true, true)
	end
end)

-- Register the player (call from javascript > send to server < callback from server)
RegisterNUICallback('register', function(data, cb)
	cb('ok')

	if data.fakeid then
		ESX.TriggerServerCallback('jsfour-register:update', function( success )
			if success then
				EnableGui(false)
				exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Criaste uma identidade falsa e <span style='color:#069a19'>recebeste</span> um novo <span style='color:#069a19'>cartão de cidadão</span>.", 5000, 'success')
				DoScreenFadeOut(1000)
				Wait(1000)
				SetEntityCollision(GetPlayerPed(-1),  true,  true)
				FreezeEntityPosition(GetPlayerPed(-1), false)
				DoScreenFadeIn(1000)
				Wait(1000)
			else
				exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Ocorreu um <span style='color:#ff0000'>erro</span> ao criar a tua identidade! Verifica que todos os dados foram inseridos corretamente. Se o erro continuar, contacta o Johnny.", 5000, 'error')
			end
		end, data)
	else
		ESX.TriggerServerCallback('jsfour-register:register', function( success )
			if success then
				EnableGui(false)
				TriggerEvent('inventory:client:GiveStarterItems')
				exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Criaste a tua identidade e <span style='color:#069a19'>recebeste</span> um novo <span style='color:#069a19'>cartão de cidadão</span>.", 5000, 'success')
				
				DoScreenFadeOut(1000)
				Wait(1000)
				SetCamActive(cam,  false)
				RenderScriptCams(false,  false,  0,  true,  true)
				SetEntityCollision(GetPlayerPed(-1),  true,  true)
				SetEntityVisible(GetPlayerPed(-1),  true)
				FreezeEntityPosition(GetPlayerPed(-1), false)
				SetEntityCoords(GetPlayerPed(-1), -268.522, -956.666, 31.223)
				TriggerEvent('esx_skin:playerRegistered')
				DoScreenFadeIn(1000)
				Wait(1000)
			else
				exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Ocorreu um <span style='color:#ff0000'>erro</span> ao criar a tua identidade! Verifica que todos os dados foram inseridos corretamente. Se o erro continuar, contacta o Johnny.", 5000, 'error')
			end
		end, data)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if guiEnabled then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)
