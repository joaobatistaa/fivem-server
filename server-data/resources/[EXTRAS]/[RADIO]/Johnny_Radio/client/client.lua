local PlayerData                = {}
local frequencia = 0
local phoneProp = 0

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end

function newPhoneProp()
  deletePhone()
  RequestModel("prop_cs_walkie_talkie")
  while not HasModelLoaded("prop_cs_walkie_talkie") do
    Citizen.Wait(1)
  end

  phoneProp = CreateObject("prop_cs_walkie_talkie", 1.0, 1.0, 1.0, 1, 1, 0)
  local bone = GetPedBoneIndex(PlayerPedId(), 28422)
  AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone()
  if phoneProp ~= 0 then
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
    phoneProp = 0
  end
end

function enableRadio(enable)
  
  if enable then
    local dict = "cellphone@"
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      dict = "anim@cellphone@in_car@ps"
    end

    loadAnimDict(dict)

    local anim = "cellphone_text_in"
    TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
    newPhoneProp()
	
	if frequencia ~= nil and frequencia ~= 0 then
		exports['mythic_notify']:DoHudText('inform', Config.messages['on_radio'] .. frequencia .. '.00 MHz </b>')
	else
		exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
	end
	
  else
	local dict = "cellphone@"
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      dict = "anim@cellphone@in_car@ps"
    end

    loadAnimDict(dict)
	local anim = "cellphone_text_out"
 --   ClearPedSecondaryTask(PlayerPedId())
	Citizen.Wait(180)
	deletePhone()
	TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
--	StopAnimTask(PlayerPedId(), dict, anim, 1.0)
  end
  
  SetNuiFocus(true, true)
  radioMenu = enable

  SendNUIMessage({

    type = "enableui",
    enable = enable

  })

end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

--[[
RegisterCommand('radio', function(source, args)
    if Config.enableCmd then
      enableRadio(true)
    end
end, false)



RegisterCommand('radiotest', function(source, args)
  local playerName = GetPlayerName(PlayerId())
--  local data = exports.voip:getPlayerData(playerName, "radio:channel")

  print(frequencia)

  if frequencia == "nil" or frequencia == 0 then
    exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
  else
   exports['mythic_notify']:DoHudText('inform', Config.messages['on_radio'] .. frequencia .. '.00 MHz </b>')
 end

end, false) 
--]]


RegisterNUICallback('joinRadio', function(data, cb)
    local _source = source
    local PlayerData = ESX.GetPlayerData(_source)
    local playerName = GetPlayerName(PlayerId())
   -- local getPlayerRadioChannel = exports.voip:getPlayerData(playerName, "radio:channel")
	
	ESX.TriggerServerCallback('johnny:server:getGrupo', function(group)
		playergroup = group
		if playergroup == 'superadmin' or playergroup == 'admin' or playergroup == 'mod' then
			isStaff = true
		else
			isStaff = false
		end
    end)
	
	if tonumber(data.channel) == nil then
		exports['mythic_notify']:SendAlert('error', Config.messages['you_leave'] .. canalantigo .. '.00 MHz </b>')
		exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
		canalantigo = 0
	elseif tonumber(data.channel) ~= canalantigo then
		if tonumber(data.channel) <= Config.RestrictedChannels then
			if tonumber(data.channel) then
				if tonumber(data.channel)==0 or tonumber(data.channel)==nil then
					exports['mythic_notify']:DoHudText('error', Config.messages['freq_invalid'])						
				elseif tonumber(data.channel)>0 and tonumber(data.channel) <=9 then
					if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'bombeiros' or PlayerData.job.name == 'sheriff') then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>9 and tonumber(data.channel) <=39 then
					if(PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff') then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>39 and tonumber(data.channel) <=59 then
					if(PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'bombeiros') then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>59 and tonumber(data.channel) <=69 then
					if PlayerData.job.name == 'mechanic' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>69 and tonumber(data.channel) <=79 then
					if (PlayerData.job.name == 'judge' or PlayerData.job.name == 'laywer') then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>79 and tonumber(data.channel) <=89 then
					if PlayerData.job.name == 'vagos' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>89 and tonumber(data.channel) <=99 then
					if PlayerData.job.name == 'grove' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>99 and tonumber(data.channel) <=109 then
					if PlayerData.job.name == 'ballas' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>109 and tonumber(data.channel) <=119 then
					if PlayerData.job.name == 'vanilla' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>119 and tonumber(data.channel) <=129 then
					if PlayerData.job.name == 'bahamas' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>129 and tonumber(data.channel) <=139 then
					if PlayerData.job.name == 'mafia' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>139 and tonumber(data.channel) <=149 then
					if PlayerData.job.name == 'peakyblinders' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>149 and tonumber(data.channel) <=159 then
					if PlayerData.job.name == 'NA' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>159 and tonumber(data.channel) <=169 then
					if PlayerData.job.name == 'NA' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>169 and tonumber(data.channel) <=179 then
					if PlayerData.job.name == 'NA' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>179 and tonumber(data.channel) <=189 then
					if PlayerData.job.name == 'NA' then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>239 and tonumber(data.channel) <=249 then
					if isStaff then
						exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
						frequencia = data.channel
						exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
					else
						exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
					end
				elseif tonumber(data.channel)>249 and tonumber(data.channel) <=1000 then
					exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
					frequencia = data.channel
					exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
				else
					exports['mythic_notify']:DoHudText('error', Config.messages['freq_invalid'])	
				end
			else
				exports['mythic_notify']:DoHudText('error', Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
			end
		end
		if tonumber(data.channel) > Config.RestrictedChannels then
			exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
			frequencia = data.channel
			exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
			-- canalantigo = math.floor(tonumber(data.channel))
		end
	else
		exports['mythic_notify']:DoHudText('error', Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
	end

    cb('ok')
end)

-- opuszczanie radia

RegisterNUICallback('leaveRadio', function(data, cb)
   local playerName = GetPlayerName(PlayerId())
--[[   local getPlayerRadioChannel = exports.voip:getPlayerData(playerName, "radio:channel")

    if getPlayerRadioChannel == "nil" then
      exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
    else
        exports.voip:removePlayerFromRadio(getPlayerRadioChannel)
        exports.voip:setPlayerData(playerName, "radio:channel", "nil", true)
        exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end --]]
	local freq = frequencia
	exports["mumble-voip"]:SetRadioChannel(0)
	frequencia = 0
	exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. freq .. '.00 MHz </b>')

   cb('ok')

end)

RegisterNUICallback('escape', function(data, cb)

    enableRadio(false)
    SetNuiFocus(false, false)
	
    cb('ok')
end)

-- net eventy

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
	--if exports["WTRP_Inventario"]:hasEnoughOfItem("radio",1,false) then
		enableRadio(true)
	--else
		--exports['mythic_notify']:DoHudText('error', 'Não tens uma rádio no inventário!')
	--end
end)

RegisterNetEvent('ls-radio:usarClient')
AddEventHandler('ls-radio:usarClient', function()
	--if exports["WTRP_Inventario"]:hasEnoughOfItem("radio",1,false) then
		TriggerServerEvent('ls-radio:usarServer')
	--else
		--exports['mythic_notify']:DoHudText('error', 'Não tens uma rádio no inventário!')
	--end
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function(source)
	local playerName = GetPlayerName(source)
--	local getPlayerRadioChannel = exports.voip:getPlayerData(playerName, "radio:channel")
	local freq = frequencia
	exports["mumble-voip"]:SetRadioChannel(0)
	frequencia = 0
	
	exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
--	exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. freq .. '.00 MHz </b>')
--[[  if getPlayerRadioChannel ~= "nil" then

    exports.voip:removePlayerFromRadio(getPlayerRadioChannel)
    exports.voip:setPlayerData(playerName, "radio:channel", "nil", true)
    exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')

end --]]
end)

RegisterNetEvent('ls-radio:onRadioDrop2')
AddEventHandler('ls-radio:onRadioDrop2', function(source)
	local playerName = GetPlayerName(source)
--	local getPlayerRadioChannel = exports.voip:getPlayerData(playerName, "radio:channel")
	local freq = frequencia
	exports["mumble-voip"]:SetRadioChannel(0)
	frequencia = 0
	
--	exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
--	exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. freq .. '.00 MHz </b>')
--[[  if getPlayerRadioChannel ~= "nil" then

    exports.voip:removePlayerFromRadio(getPlayerRadioChannel)
    exports.voip:setPlayerData(playerName, "radio:channel", "nil", true)
    exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')

end --]]
end)

local IsDead = false

AddEventHandler('esx:onPlayerSpawn', function()
	IsDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	IsDead = true
end)

local mostrado = false

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
		else
          Citizen.Wait(1500)
        end

		if IsDead then
			if tonumber(frequencia) > 0 then
				exports["mumble-voip"]:SetRadioChannel(0)
				frequencia = 0
			end
		end
        Citizen.Wait(10)
    end
end)
