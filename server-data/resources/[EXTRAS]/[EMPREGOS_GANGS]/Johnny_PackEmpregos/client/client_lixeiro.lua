isLoggedIn = false
local PlayerJobLixeiroInfo = {}
local GarbageVehicle = nil
local hasVuilniswagen = false
local hasZak = false
local GarbageLocation = 0
local DeliveryBlip = nil
local IsWorking = false
local AmountOfBags = 0
local GarbageObject = nil
local EndBlipLixeiro = nil
local GarbageBlip = nil
local Earnings = 0
local CanTakeBag = true
local JobBlipsLixeiro = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	isLoggedIn = true
    GarbageVehicle = nil
    hasVuilniswagen = false
    hasZak = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlipLixeiro = nil
	refreshBlipsLixeiro()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
    isLoggedIn = true
    GarbageVehicle = nil
    hasVuilniswagen = false
    hasZak = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlipLixeiro = nil
	deleteBlipsLixeiro()
	refreshBlipsLixeiro()
end)

function deleteBlipsLixeiro()
	RemoveBlip(GarbageBlip)
	if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end
end

function refreshBlipsLixeiro()
	if PlayerData and PlayerData.job.name == 'lixeiro' then
		if GarbageBlip == nil then
			GarbageBlip = AddBlipForCoord(Config.LixeiroLocations["main"].coords.x, Config.LixeiroLocations["main"].coords.y, Config.LixeiroLocations["main"].coords.z)
			SetBlipSprite(GarbageBlip, 318)
			SetBlipDisplay(GarbageBlip, 4)
			SetBlipScale(GarbageBlip, 1.1)
			SetBlipAsShortRange(GarbageBlip, true)
			SetBlipColour(GarbageBlip, 5)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(Config.LixeiroLocations["main"].label)
			EndTextCommandSetBlipName(GarbageBlip)
		end
	end
end

function BringBackCarLixeiro()
	local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
	local plate = GetVehicleNumberPlateText(veh)
	--TriggerServerEvent('vehiclekeys:server:removekey', plate, model)
	exports['qs-vehiclekeys']:RemoveKeysAuto()
    DeleteVehicle(veh)
    if EndBlipLixeiro ~= nil then
        RemoveBlip(EndBlipLixeiro)
    end
    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end
    if Earnings > 0 then
        PayCheckLoopLixeiro(GarbageLocation)
    end
    GarbageVehicle = nil
    hasVuilniswagen = false
    hasZak = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlipLixeiro = nil
end

function PayCheckLoopLixeiro(location)
    Citizen.CreateThread(function()
        while Earnings > 0 do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local coords = Config.LixeiroLocations["paycheck"].coords
            local distance = GetDistanceBetweenCoords(pos, coords.x, coords.y, coords.z, true)
			local canSleep = true

            if distance < 30 then
				canSleep = false
                DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
                if distance < 1.5 then
                    DrawText3Ds(coords.x, coords.y, coords.z + 0.2, "~g~E~w~ - Receber Pagamento")
                    if IsControlJustPressed(0, Keys["E"]) then
                        TriggerServerEvent('qb-garbagejob:server:PayafafsasShit', Earnings, location)
						exports['Johnny_Notificacoes']:Alert("EMPRESA", "<span style='color:#c7c7c7'>Recebeste <span style='color:#069a19'>"..Earnings.."€</span> pelo teu trabalho!", 5000, 'success')
                        Earnings = 0
                    end
                elseif distance < 5 then
                    DrawText3D(coords.x, coords.y, coords.z, "Pagamento")
                end
            end
			
			if canSleep then
				 Citizen.Wait(1000)
			end

            Citizen.Wait(1)
        end
    end)
end

function VestiarioLixeiro()

  local elements = {
    {label = 'Roupa Normal', value = 'cloakroom2'},
	{label = 'Roupa de Lixeiro', value = 'cloakroom'},
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'lixeiro_actions',
    {
      title    = 'Vestiário',
	  align    = 'top-left',
      elements = elements
    },
    function(data, menu)
	  
	  if data.current.value == 'cloakroom' then
        menu.close()
		setUniformLixeiro(data.current.value)
      end

      if data.current.value == 'cloakroom2' then
        menu.close()
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
	  end

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'lixeiro_actions_menu'
      CurrentActionMsg  = ''
      CurrentActionData = {}

    end
  )

end


function setUniformLixeiro(job)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.LixeiroUniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.LixeiroUniforms[job].male)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		else
			if Config.LixeiroUniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.LixeiroUniforms[job].female)
			else
				exports['mythic_notify']:DoHudText('error', 'Não há roupas no vestiário!')
			end

		end
	end)
end

Citizen.CreateThread(function()
    while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(1)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local spawnplek = Config.LixeiroLocations["vehicle"].label
        local InVehicle = IsPedInAnyVehicle(ped, false)
        local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.LixeiroLocations["vehicle"].coords.x, Config.LixeiroLocations["vehicle"].coords.y, Config.LixeiroLocations["vehicle"].coords.z, true)
		local distance2 = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.LixeiroLocations["vestiario"].coords.x, Config.LixeiroLocations["vestiario"].coords.y, Config.LixeiroLocations["vestiario"].coords.z, true)
		
        if ESX ~= nil then
			PlayerJobLixeiroInfo = PlayerData.job
			if PlayerJobLixeiroInfo ~= nil then

				if PlayerJobLixeiroInfo.name == "lixeiro" then
					local canSleep = true
					if distance < 30.0 then
						canSleep = false
						DrawMarker(2, Config.LixeiroLocations["vehicle"].coords.x, Config.LixeiroLocations["vehicle"].coords.y, Config.LixeiroLocations["vehicle"].coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
						if distance < 1.5 then
							if InVehicle then
								DrawText3Ds(Config.LixeiroLocations["vehicle"].coords.x, Config.LixeiroLocations["vehicle"].coords.y, Config.LixeiroLocations["vehicle"].coords.z + 0.2, "~b~E~w~ - Guardar Camião")
								if IsControlJustReleased(0, Keys["E"]) then
								    ESX.TriggerServerCallback('qb-garbagejob:server:CheckBail', function(DidBail)
										if DidBail then
											BringBackCarLixeiro()
											exports['Johnny_Notificacoes']:Alert("EMPRESA", "<span style='color:#c7c7c7'>Terminaste o trabalho e recebeste <span style='color:#069a19'>"..Config.LixeiroValorCaucao.."€</span> (valor da caução inicial) por teres entregue o veículo!", 5000, 'success')
											exports['Johnny_Notificacoes']:Alert("EMPRESA", "<span style='color:#c7c7c7'>Dirige-te ao escritório ai ao lado para receberes o <span style='color:#069a19'>dinheiro</span> pelo teu trabalho!", 10000, 'info')
									    else
											exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não pagaste o valor da <span style='color:#ff0000'>caução ("..Config.LixeiroValorCaucao.."€)</span>!", 5000, 'error')   
										end
								    end)
								end
							else
								DrawText3Ds(Config.LixeiroLocations["vehicle"].coords.x, Config.LixeiroLocations["vehicle"].coords.y, Config.LixeiroLocations["vehicle"].coords.z + 0.2, "~b~E~w~ - Iniciar Trabalho")
								if IsControlJustReleased(0, Keys["E"]) then
								    ESX.TriggerServerCallback('qb-garbagejob:server:HasMoney', function(HasMoney)
									    if HasMoney then
												local coords = Config.LixeiroLocations["vehicle"].coords
												spawnvehicleLixeiro("trash", function(veh)
												GarbageVehicle = veh
												SetVehicleNumberPlateText(veh, "GARB"..tostring(math.random(1000, 9999)))
												SetEntityHeading(veh, coords.h)
												TaskWarpPedIntoVehicle(ped, veh, -1)
												SetEntityAsMissionEntity(veh, true, true)
												--TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
												SetVehicleEngineOn(veh, true, true)
												exports["Johnny_Combustivel"]:SetFuel(veh, 100)
												hasVuilniswagen = true
												GarbageLocation = 1
												IsWorking = true
												SetGarbageRoute()
											    exports['Johnny_Notificacoes']:Alert("EMPRESA", "<span style='color:#c7c7c7'>Foi retirada uma caução no valor de <span style='color:#ffc107'>"..Config.LixeiroValorCaucao.."€</span>! \nSerá devolvida se o veículo for entregue em condições.\n Dirige-te para a localização marcada no mapa.", 10000, 'warning')
											end, coords, true)
									    else
											exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>"..Config.LixeiroValorCaucao.."€ (valor da caução)</span>!\nÉ necessário para assegurarmos que terminas o trabalho.", 5000, 'error')   
										end
									end)
								end
							end
						end
					end
					if distance2 < 30.0 then
						canSleep = false
						DrawMarker(2, Config.LixeiroLocations["vestiario"].coords.x, Config.LixeiroLocations["vestiario"].coords.y, Config.LixeiroLocations["vestiario"].coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
						if distance2 < 1.5 then
							DrawText3Ds(Config.LixeiroLocations["vestiario"].coords.x, Config.LixeiroLocations["vestiario"].coords.y, Config.LixeiroLocations["vestiario"].coords.z + 0.2, "~b~E~w~ - Trocar de Roupa")
							if IsControlJustReleased(0, Keys["E"]) then
								VestiarioLixeiro()
							end
						end
					end
					if canSleep then
						Citizen.Wait(2000)
					end
				else
					Citizen.Wait(3000)
				end
			end
        end
    end
end)

function spawnvehicleLixeiro(model, cb, coords, isnetworked)
	local ped = PlayerPedId()
    local model = (type(model)=="number" and model or GetHashKey(model))
    local coords = coords ~= nil and coords or ESX.GetCoords(ped)
    local isnetworked = isnetworked ~= nil and isnetworked or true

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end

    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.a, isnetworked, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)

	SetVehicleHasBeenOwnedByPlayer(vehicle,  true)
	SetNetworkIdCanMigrate(netid, true)
    --SetEntityAsMissionEntity(veh, true, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, "OFF")
	exports["Johnny_Combustivel"]:SetFuel(veh, 100)
    SetModelAsNoLongerNeeded(model)

    if cb ~= nil then
        cb(veh)
    end
end

Citizen.CreateThread(function()
    while PlayerData == nil do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(1)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false

        if ESX ~= nil then
			PlayerJobLixeiroInfo = PlayerData.job
			if PlayerJobLixeiroInfo ~= nil then
				if PlayerJobLixeiroInfo.name == "lixeiro" then
					if IsWorking then
						if GarbageLocation ~= 0 then
							if DeliveryBlip ~= nil then
								local DeliveryData = Config.LixeiroLocations["vuilnisbakken"][GarbageLocation]
								local Distance = GetDistanceBetweenCoords(pos, DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, true)

								if Distance < 20 or hasZak then
									loadAnimDict('missfbi4prepp1')
									DrawMarker(2, DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 55, 22, 255, false, false, false, false, false, false, false)
									if not hasZak then
										if CanTakeBag then
											if Distance < 1.5 then
												DrawText3D(DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, "~g~E~w~ - Pegar no saco")
												if IsControlJustPressed(0, 51) then
													if AmountOfBags == 0 then
														-- Hier zet ie hoeveel zakken er moeten worden afgeleverd als het nog niet bepaald is
														AmountOfBags = math.random(3, 5)
													end 
													hasZak = true
													TakeAnimLixeiro()
												end
											elseif Distance < 10 then
												DrawText3D(DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, "Fica aqui para pegar no saco do lixo.")
											end
										end
									else
										if DoesEntityExist(GarbageVehicle) then
											if Distance < 10 then
												DrawText3D(DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, "Põe o saco no camião..")
											end

											local Coords = GetOffsetFromEntityInWorldCoords(GarbageVehicle, 0.0, -4.5, 0.0)
											local TruckDist = GetDistanceBetweenCoords(pos, Coords.x, Coords.y, Coords.z, true)

											if TruckDist < 2 then
												DrawText3D(Coords.x, Coords.y, Coords.z, "~g~E~w~ - Largar o saco")
												if IsControlJustPressed(0, 51) then
													hasZak = false
													local AmountOfLocations = #Config.LixeiroLocations["vuilnisbakken"]
													-- Kijkt of je alle zakken hebt afgeleverd
													if (AmountOfBags - 1) == 0 then
														-- Alle zakken afgeleverd
														Earnings = Earnings + math.random(Config.LixeiroMin, Config.LixeiroMax)
														if (GarbageLocation + 1) <= AmountOfLocations then
															-- Hier zet ie je volgende locatie en ben je nog niet klaar met werken.
															GarbageLocation = GarbageLocation + 1   
															exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Todos os sacos foram <span style='color:#069a19'>recolhidos</span>!\n Dirige-te para a próxima localização.", 5000, 'success')
															SetGarbageRoute()
														else
															-- Hier ben je klaar met werken.
															exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Terminaste o <span style='color:#069a19'>trabalho</span>!\n Dirige-te para a central.", 5000, 'success')
															IsWorking = false
															RemoveBlip(DeliveryBlip)
															SetRouteBackLixeiro()
														end
														AmountOfBags = 0
														hasZak = false
													else
														-- Hier heb je nog niet alle zakken afgeleverd
														AmountOfBags = AmountOfBags - 1
														if AmountOfBags > 1 then
															exports['mythic_notify']:DoHudText('inform', 'Ainda faltam '..AmountOfBags..' sacos!')
														else
															exports['mythic_notify']:DoHudText('inform', 'Ainda falta '..AmountOfBags..' saco!')
														end
														hasZak = false
													end
													DeliverAnimLixeiro()
												end
											elseif TruckDist < 10 then
												DrawText3D(Coords.x, Coords.y, Coords.z, "Fica aqui...")
											end
										else
											DrawText3D(DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, "Não tens um camião...")
										end
									end
								end
							end
						end
					end
				else
					Citizen.Wait(2000)
				end
			end
        end

        if not IsWorking then
            Citizen.Wait(1000)
        end
    end
end)

function SetGarbageRoute()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local CurrentLocation = Config.LixeiroLocations["vuilnisbakken"][GarbageLocation]
	
    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end

    DeliveryBlip = AddBlipForCoord(CurrentLocation.coords.x, CurrentLocation.coords.y, CurrentLocation.coords.z)
    SetBlipSprite(DeliveryBlip, 1)
    SetBlipDisplay(DeliveryBlip, 2)
    SetBlipScale(DeliveryBlip, 1.0)
    SetBlipAsShortRange(DeliveryBlip, false)
    SetBlipColour(DeliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.LixeiroLocations["vuilnisbakken"][GarbageLocation].name)
    EndTextCommandSetBlipName(DeliveryBlip)
    SetBlipRoute(DeliveryBlip, true)
end

function SetRouteBackLixeiro()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inleverpunt = Config.LixeiroLocations["vehicle"]

    EndBlipLixeiro = AddBlipForCoord(inleverpunt.coords.x, inleverpunt.coords.y, inleverpunt.coords.z)
    SetBlipSprite(EndBlipLixeiro, 1)
    SetBlipDisplay(EndBlipLixeiro, 2)
    SetBlipScale(EndBlipLixeiro, 1.0)
    SetBlipAsShortRange(EndBlipLixeiro, false)
    SetBlipColour(EndBlipLixeiro, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.LixeiroLocations["vehicle"].name)
    EndTextCommandSetBlipName(EndBlipLixeiro)
    SetBlipRoute(EndBlipLixeiro, true)
end

function TakeAnimLixeiro()
    local ped = PlayerPedId()

    loadAnimDict('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    GarbageObject = CreateObject(GetHashKey("prop_cs_rub_binbag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(GarbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)

    AnimCheckLixeiro()
end

function AnimCheckLixeiro()
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if hasZak then
                if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                    ClearPedTasks(ped)
                    loadAnimDict('missfbi4prepp1')
                    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            else
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function DeliverAnimLixeiro()
    local ped = PlayerPedId()

    loadAnimDict('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(GarbageVehicle))
    CanTakeBag = false

    SetTimeout(1250, function()
        DetachEntity(GarbageObject, 1, false)
        DeleteObject(GarbageObject)
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
        FreezeEntityPosition(ped, false)
        GarbageObject = nil
        CanTakeBag = true
    end)
end

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if GarbageObject ~= nil then
            DeleteEntity(GarbageObject)
            GarbageObject = nil
        end
    end
end) 
