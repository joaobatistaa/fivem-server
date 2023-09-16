local Active = false
local test = nil
local test1 = nil
local spam = true

local isDead = false

local localConfig = {
	Price = 1000,
	ReviveTime = 20000,
	MedicosAtivos = 0
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)	


RegisterNetEvent('Johnny_InemNPC:startEvent')
AddEventHandler('Johnny_InemNPC:startEvent', function()
	if isDead and spam then
		ESX.TriggerServerCallback('hhfw:docOnline', function(EMSOnline, hasEnoughMoney)
			if EMSOnline == localConfig.MedicosAtivos and spam then
				SpawnVehicle(GetEntityCoords(PlayerPedId()))
				TriggerServerEvent('hhfw:charge')
				Notify("O INEM está a chegar.")
			end
		end)
	else
		print('Algum cheater deu trigger a este event...')
	end
end)

function SpawnVehicle(x, y, z)  
	spam = false
	local vehhash = GetHashKey("ambulance")                                                     
	local loc = GetEntityCoords(PlayerPedId())
	RequestModel(vehhash)
	while not HasModelLoaded(vehhash) do
		Wait(1)
	end
	RequestModel('s_m_m_Doctor_01')
	while not HasModelLoaded('s_m_m_Doctor_01') do
		Wait(1)
	end
	local spawnRadius = 40                                                    
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(loc.x + math.random(-spawnRadius, spawnRadius), loc.y + math.random(-spawnRadius, spawnRadius), loc.z, 0, 3, 0)

	if not DoesEntityExist(vehhash) then
        mechVeh = CreateVehicle(vehhash, spawnPos, spawnHeading, true, false)                        
        ClearAreaOfVehicles(GetEntityCoords(mechVeh), 5000, false, false, false, false, false);  
        SetVehicleOnGroundProperly(mechVeh)
		SetVehicleNumberPlateText(mechVeh, "INEM")
		SetEntityAsMissionEntity(mechVeh, true, true)
		SetVehicleEngineOn(mechVeh, true, true, false)
        
        mechPed = CreatePedInsideVehicle(mechVeh, 26, GetHashKey('s_m_m_Doctor_01'), -1, true, false)              	
        
        mechBlip = AddBlipForEntity(mechVeh)                                                        	
        SetBlipFlashes(mechBlip, true)  
        SetBlipColour(mechBlip, 5)


		PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
		Wait(2000)
		TaskVehicleDriveToCoord(mechPed, mechVeh, loc.x, loc.y, loc.z, 20.0, 0, GetEntityModel(mechVeh), 524863, 2.0)
		test = mechVeh
		test1 = mechPed
		Active = true
    end
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200)
	  
        if Active then
            local loc = GetEntityCoords(GetPlayerPed(-1))
			local lc = GetEntityCoords(test)
			local ld = GetEntityCoords(test1)
            local dist = Vdist(loc.x, loc.y, loc.z, lc.x, lc.y, lc.z)
			local dist1 = Vdist(loc.x, loc.y, loc.z, ld.x, ld.y, ld.z)

			--if dist <= 20 then
				if Active then
					TaskGoToCoordAnyMeans(test1, loc.x, loc.y, loc.z, 1.0, 0, 0, 786603, 0xbf800000)
				end
				if dist1 <= 1 then 
					Active = false
					ClearPedTasks(test1)
					DoctorNPC()
				end
            --end
        end
    end
end)


function DoctorNPC()
	RequestAnimDict("mini@cpr@char_a@cpr_str")
	while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
		Citizen.Wait(1000)
	end

	TaskPlayAnim(test1, "mini@cpr@char_a@cpr_str","cpr_pumpchest",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
	--exports['progressBars']:startUI(localConfig.ReviveTime, "The MedicosAtivos is giving you medical aid")
	exports['progressbar']:Progress({
        name = "unique_action_name",
        duration = localConfig.ReviveTime,
        label = "Estás a receber ajuda médica...",
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {},
        prop = {}
    }, function(status)
        if not status then
			ClearPedTasks(test1)
			Citizen.Wait(500)
			TriggerEvent('esx_ambulancejob:revLoureivero')
			StopScreenEffect('DeathFailOut')
			local data = {
				society = 'society_ambulance',
				society_name = 'INEM',
				target = GetPlayerServerId(PlayerId()),
				targetName = -1,
				invoice_value = localConfig.Price,
				author_name = 'INEM',
				invoice_item = 'Tratamento do INEM',
				invoice_notes = 'Tratamento recebido no local pelo médico do INEM.'					
			}

			--TriggerServerEvent("okokBilling:createInvoicePlayer", data)
			TriggerServerEvent("okokBilling:CreateCustomInvoice", GetPlayerServerId(PlayerId()), localConfig.Price, 'Tratamento recebido no local pelo médico do INEM', 'Tratamento Médico', 'society_ambulance', 'INEM')
			Notify("Foste tratado e recebeste uma fatura no valor de: "..localConfig.Price.. "€")
			RemovePedElegantly(test1)
			DeleteEntity(test)
			spam = true
        end
    end)	
end


function Notify(msg)
	exports['mythic_notify']:DoHudText('inform', msg)
end