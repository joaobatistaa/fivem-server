local InSpectatorMode	= false
local TargetSpectate	= nil
local LastPosition		= nil
local polarAngleDeg		= 0;
local azimuthAngleDeg	= 90;
local radius			= -3.5;
local cam 				= nil
local PlayerDate		= {}
local ShowInfos			= false
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


function OpenAdminActionMenu(player)
    ESX.TriggerServerCallback('esx_spectate:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil
	  local Money		= 0
	  local Bank		= 0
	  local blackMoney	= 0
	  local Inventory	= nil
	  
    for k,v in pairs(data.accounts) do
        if v.name == 'black_money' then
            blackMoney = v.money
		end
        if v.name == 'money' then
            Money = v.money
		end
        if v.name == 'bank' then
            Bank = v.money
		end
    end

	  if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Emprego : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Emprego : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Masculino'
        else
          sex = 'Feminino'
        end
        sexLabel = 'Sexo : ' .. sex
      else
        sexLabel = 'Sexo : Desconhecido'
      end
	  	  
      if data.dob ~= nil then
        dobLabel = 'Data de Nasc : ' .. data.dob
      else
        dobLabel = 'Data de Nasc : Desconhecido'
      end

      if data.height ~= nil then
        heightLabel = 'Altura : ' .. data.height
      else
        heightLabel = 'Altura : Desconhecido'
      end

      local elements = {
        {label = 'Nome Steam: ' .. data.name,    value = nil},
		{label = 'Nome Personagem: ' .. data.firstname .. " " .. data.lastname, value = nil},
		{label = ''..sexLabel, value = nil},
		{label = ''..dobLabel, value = nil},
		--{label = ''..heightLabel, value = nil},
		{label = ''..jobLabel, value = nil},
        {label = 'Dinheiro: '.. Money ..'€', value = nil, itemType = 'item_account', amount = Money},
        {label = 'Banco: '.. Bank ..'€', value = nil, itemType = 'item_account', amount = Bank},
        {label = 'Dinheiro Sujo: '.. blackMoney ..'€', value = nil, itemType = 'item_account', amount = blackMoney},
		{label = 'Ver Inventário', value = 'inv'},
    }

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = 'Informações do Jogador',
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)
			if data.current.value == 'inv' then
				ExecuteCommand('openinventory '..player)
				menu.close()
			end
        end,
        function(data, menu)
          menu.close()
        end
      )

    end, player)
end

RegisterNetEvent('esx_spectate:spectate')
AddEventHandler('esx_spectate:spectate', function()
	ESX.TriggerServerCallback('johnny:server:getGrupo', function(grupo)
		if grupo == 'admin' or grupo == 'superadmin' then
			ESX.TriggerServerCallback('esx_spectate:getAllJogadores', function(players)
				SetNuiFocus(true, true)

				SendNUIMessage({
					type = 'show',
					data = players,
					player = GetPlayerServerId(PlayerId())
				})
			end)
		else
			exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Ajudantes não podem dar <span style='color:#ff0000'>spectate</span>!", 5000, 'error')
		end
	end)
end)

local oldCoords = nil

RegisterNetEvent("EasyAdmin:requestSpectate")
AddEventHandler('EasyAdmin:requestSpectate', function(playerServerId, enable)
	local localPed = PlayerPedId()
	
	
	if enable then
		if oldCoords == nil then
			oldCoords = GetEntityCoords(localPed)
		end
		
		ESX.TriggerServerCallback("esx_spectate:requestPlayerCoords", function(coords)
			if not coords then
				oldCoords = false
				TargetSpectate = nil
				InSpectatorMode = false
				return
			end
			InSpectatorMode = true
			TargetSpectate = playerServerId
			
			RequestCollisionAtCoord(coords)
			SetEntityVisible(localPed, false)
			SetEntityCoords(localPed, coords + vector3(0, 0, 10))
			FreezeEntityPosition(localPed, true)
			Wait(1500)
			SetEntityCoords(localPed, coords - vector3(0, 0, 10))
			
			local targetPed = GetPlayerPed(GetPlayerFromServerId(playerServerId))
			
			NetworkSetInSpectatorMode(true, targetPed)
			exports["mumble-voip"]:SetCallChannel(playerServerId)
		end, playerServerId)
	else
		InSpectatorMode = false
		TargetSpectate = nil
		
		if oldCoords then
			local localPed = PlayerPedId()
	
			RequestCollisionAtCoord(oldCoords)
			NetworkSetInSpectatorMode(false, localPed)
			FreezeEntityPosition(localPed, false)
			SetEntityCoords(localPed, oldCoords)
			SetEntityVisible(localPed, true)	
			oldCoords = nil
		end	
		
		local id = GetPlayerServerId(PlayerId())
		exports["mumble-voip"]:SetCallChannel(id)
	end
end)

RegisterNUICallback('select', function(data, cb)
	TriggerEvent('EasyAdmin:requestSpectate', data.id, true)
	SetNuiFocus(false)
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
end)

RegisterNUICallback('quit', function(data, cb)
	SetNuiFocus(false)
	TriggerEvent('EasyAdmin:requestSpectate', nil, false)
end)

RegisterNUICallback('kick', function(data, cb)
	SetNuiFocus(false)
	TriggerServerEvent('esx_spectate:kick', data.id, data.reason)
end)

local function SendVoiceToPlayer(intPlayer, boolSend)
	Citizen.InvokeNative(0x97DD4C5944CC2E6A, intPlayer, boolSend)
end

Citizen.CreateThread(function()

  	while true do

		Wait(0)

		if InSpectatorMode then

			local targetPlayerId = GetPlayerFromServerId(TargetSpectate)
			local playerPed	  = PlayerPedId()
			local targetPed	  = GetPlayerPed(targetPlayerId)
			local coords	 = GetEntityCoords(targetPed)

			if IsControlPressed(2, 241) then
				radius = radius + 2.0;
			end

			if IsControlPressed(2, 242) then
				radius = radius - 2.0;
			end

			if radius > -1 then
				radius = -1
			end

			local xMagnitude = GetDisabledControlNormal(0, 1);
			local yMagnitude = GetDisabledControlNormal(0, 2);

			polarAngleDeg = polarAngleDeg + xMagnitude * 10;

			if polarAngleDeg >= 360 then
				polarAngleDeg = 0
			end

			azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10;

			if azimuthAngleDeg >= 360 then
				azimuthAngleDeg = 0;
			end

			local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

			SetCamCoord(cam,  nextCamLocation.x,  nextCamLocation.y,  nextCamLocation.z)
			PointCamAtEntity(cam,  targetPed)
			SetEntityCoords(playerPed,  coords.x, coords.y, coords.z + 10)

			if IsControlJustReleased(0, 113) then -- tecla g
				print(TargetSpectate)
				OpenAdminActionMenu(TargetSpectate)	
			end
			
-- taken from Easy Admin (thx to Bluethefurry)  --
			local text = {}
			-- cheat checks
			local targetGod = GetPlayerInvincible(targetPlayerId)
			if targetGod then
				table.insert(text,"Godmode: ~r~Ativo~w~")
			else
				table.insert(text,"Godmode: ~g~Desativado~w~")
			end
			if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed, false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
				table.insert(text,"~r~Anti-Ragdoll~w~")
			end
			-- health info
			table.insert(text,"Vida"..": "..GetEntityHealth(targetPed).."/"..GetEntityMaxHealth(targetPed))
			table.insert(text,"Colete"..": "..GetPedArmour(targetPed))

			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end
-- end of taken from easyadmin -- 
		else
			Wait(500)
		end

  	end
end)

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
	-- convert degrees to radians
	local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}

	return pos
end