local ped, model, object, animation = {}, {}, {}, {}
local status = 100
local objCoords
local come = 0
local isAttached, getball, inanimation = false ,false, false

local infoEdenAnimal = {}

infoEdenAnimal.PetShop = {
	{
		pet = 'chien',
		label = 'Cão',
		price = 50000
	},

	{
		pet = 'chat',
		label = 'Gato',
		price = 15000
	},

	{
		pet = 'lapin',
		label = 'Coelho',
		price = 25000
	},

	{
		pet = 'husky',
		label = 'Husky',
		price = 35000
	},

	{
		pet = 'cochon',
		label = 'Porco',
		price = 10000
	},

	{
		pet = 'caniche',
		label = 'Caniche',
		price = 50000
	},

	{
		pet = 'carlin',
		label = 'Pug',
		price = 6000
	},

	{
		pet = 'retriever',
		label = 'Labrador',
		price = 10000
	},

	--{
--		pet = 'berger',
--		label = _U('asatian'),
--		price = 55000
--	},

	{
		pet = 'westie',
		label = 'Westie',
		price = 50000
	}
	
	--{
	--	pet = 'leoa',
	--	label = 'Leôa',
	--	price = 100000000000
	--}

	--{
--		pet = 'chop',
	--	label = _U('chop'),
	--	price = 12000
--	}
}

infoEdenAnimal.Zones = {
	PetShop = {
		Pos = {x = 562.19, y = 2741.30, z = 41.86 },
		Sprite = 463,
		Display = 4,
		Scale = 1.0,
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1
	}
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
	
	DoRequestModel(-1788665315) -- chien
	DoRequestModel(1462895032) -- chat
	DoRequestModel(1682622302) -- loup
	DoRequestModel(-541762431) -- lapin
	DoRequestModel(1318032802) -- husky
	DoRequestModel(-1323586730) -- cochon
	DoRequestModel(1125994524) -- caniche
	DoRequestModel(1832265812) -- carlin
	DoRequestModel(882848737) -- retriever
	DoRequestModel(1126154828) -- berger
	DoRequestModel(-1384627013) -- westie
	DoRequestModel(351016938)  -- rottweiler
	DoRequestModel(307287994)  -- leoa
end)


function OpenPetMenu()
	local elements = {}
	if come == 1 then

		table.insert(elements, {label = 'Fome: ' ..status.. '/100', value = nil})
		table.insert(elements, {label = 'Dar comida', value = 'graille'})
		table.insert(elements, {label = 'Pegar numa bola', value = 'bola'})
		table.insert(elements, {label = 'Atrelar/Desatrelar animal', value = 'attached_animal'})

		if isInVehicle then
			table.insert(elements, {label = 'Mandar o teu animal sair do veículo', value = 'vehicle'})
		else
			table.insert(elements, {label = 'Mandar o teu animal entrar no veículo', value = 'vehicle'})
		end

		table.insert(elements, {label = 'Dar uma ordem', value = 'give_orders'})

	else
		table.insert(elements, {label = 'Chamar o teu animal', value = 'come_animal'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pet_menu', {
		title    = 'Gestão do Animal',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'come_animal' and come == 0 then
			ESX.TriggerServerCallback('eden_animal:getPet', function(pet)
				if pet == 'chien' then
					model = -1788665315
					come = 1
					openchien()
				elseif pet == 'chat' then
					model = 1462895032
					come = 1
					openchien()
				elseif pet == 'loup' then
					model = 1682622302
					come = 1
					openchien()
				elseif pet == 'lapin' then
					model = -541762431
					come = 1
					openchien()
				elseif pet == 'husky' then
					model = 1318032802
					come = 1
					openchien()
				elseif pet == 'cochon' then
					model = -1323586730
					come = 1
					openchien()
				elseif pet == 'caniche' then
					model = 1125994524
					come = 1
					openchien()
				elseif pet == 'carlin' then
					model = 1832265812
					come = 1
					openchien()
				elseif pet == 'retriever' then
					model = 882848737
					come = 1
					openchien()
				elseif pet == 'berger' then
					model = 1126154828
					come = 1
					openchien()
				elseif pet == 'westie' then
					model = -1384627013
					come = 1
					openchien()
				elseif pet == 'rottweiler' then
					model = 351016938
					come = 1
					openchien()
				elseif pet == 'leoa' then
					model = 307287994
					come = 1
					openchien()
				else
					print('eden_animal: unknown pet ' .. pet)
				end
			end)
			menu.close()
		elseif data.current.value == 'attached_animal' then
			if not IsPedSittingInAnyVehicle(ped) then
				if isAttached == false then
					attached()
					isAttached = true
				else
					detached()
					isAttached = false
				end
				else
				ESX.ShowNotification('Não podes atrelar o teu animal num veículo!')
			end
		elseif data.current.value == 'give_orders' then
			GivePetOrders()
		elseif data.current.value == 'graille' then
			local inventory = ESX.GetPlayerData().inventory
			local coords1   = GetEntityCoords(PlayerPedId())
			local coords2   = GetEntityCoords(ped)
			local distance  = GetDistanceBetweenCoords(coords1, coords2, true)

			local count = 0
			for i=1, #inventory, 1 do
				if inventory[i].name == 'croquettes' then
					count = inventory[i].count
				end
			end
			if distance < 5 then
				if count >= 1 then
					if status < 100 then
						status = status + math.random(2, 15)
						ESX.ShowNotification('Deste comida ao teu animal')
						TriggerServerEvent('eden_animal:consumePetFood')
						if status > 100 then
							status = 100
						end
						menu.close()
					else
						ESX.ShowNotification('O teu animal já não tem fome!')
					end
				else
					ESX.ShowNotification('Não tens comida para o teu animal!')
				end
			else
				ESX.ShowNotification('O teu animal está muito longe!')
			end
		elseif data.current.value == 'vehicle' then
			local playerPed = PlayerPedId()
			local vehicle  = GetVehiclePedIsUsing(playerPed)
			local coords   = GetEntityCoords(playerPed)
			local coords2  = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(coords, coords2, true)

			if not isInVehicle then
				if IsPedSittingInAnyVehicle(playerPed) then
					if distance < 8 then
						attached()
						Citizen.Wait(200)
						if IsVehicleSeatFree(vehicle, 1) then
							SetPedIntoVehicle(ped, vehicle, 1)
							isInVehicle = true
						elseif IsVehicleSeatFree(vehicle, 2) then
							isInVehicle = true
							SetPedIntoVehicle(ped, vehicle, 2)
						elseif IsVehicleSeatFree(vehicle, 0) then
							isInVehicle = true
							SetPedIntoVehicle(ped, vehicle, 0)
						end

						menu.close()
					else
						ESX.ShowNotification('O teu animal está muito longe do veículo!')
					end

				else
					ESX.ShowNotification('Precisas de estar dentro de um veículo!')
				end
			else
				if not IsPedSittingInAnyVehicle(playerPed) then
					SetEntityCoords(ped, coords,1,0,0,1)
					Citizen.Wait(100)
					detached()
					isInVehicle = false
					menu.close()
				else
					ESX.ShowNotification('Ainda estás dentro de um veículo!')
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function GivePetOrders()
	ESX.TriggerServerCallback('eden_animal:getPet', function(pet)
		local elements = {}

		if not inanimation then
			
			table.insert(elements, {label = 'Vir para perto de mim',     value = 'pied'})
			table.insert(elements, {label = 'Mandar o cão ir para a casota', value = 'return_doghouse'})

			if pet == 'chien' then
				table.insert(elements, {label = 'Sentar', value = 'assis'})
				table.insert(elements, {label = 'Deitar', value = 'coucher'})
			elseif pet == 'chat' then
				table.insert(elements, {label ='Deitar', value = 'coucher2'})
			elseif pet == 'loup' then
				table.insert(elements, {label = 'Deitar', value = 'coucher3'})
			elseif pet == 'carlin' then
				table.insert(elements, {label = 'Sentar', value = 'assis2'})
			elseif pet == 'retriever' then
				table.insert(elements, {label = 'Sentar', value = 'assis3'})
			elseif pet == 'rottweiler' then
				table.insert(elements, {label = 'Sentar', value = 'assis4'})
			end
		else
			table.insert(elements, {label = 'Levantar', value = 'debout'})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_orders', {
			title    = 'Dar Ordens ao Animal',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'return_doghouse' then
				local GroupHandle = GetPlayerGroup(PlayerId())
				local coords      = GetEntityCoords(PlayerPedId())

				ESX.ShowNotification('O teu cão está a ir para a casota')

				SetGroupSeparationRange(GroupHandle, 1.9)
				SetPedNeverLeavesGroup(ped, false)
				TaskGoToCoordAnyMeans(ped, coords.x + 40, coords.y, coords.z, 5.0, 0, 0, 786603, 0xbf800000)

				Citizen.Wait(5000)
				DeleteEntity(ped)
				come = 0

				ESX.UI.Menu.CloseAll()
			elseif data.current.value == 'pied' then
				local coords = GetEntityCoords(PlayerPedId())
				TaskGoToCoordAnyMeans(ped, coords, 5.0, 0, 0, 786603, 0xbf800000)
				menu.close()
			elseif data.current.value == 'assis' then -- [chien ]
				DoRequestAnimSet('creatures@rottweiler@amb@world_dog_sitting@base')
				TaskPlayAnim(ped, 'creatures@rottweiler@amb@world_dog_sitting@base', 'base' ,8.0, -8, -1, 1, 0, false, false, false)
				inanimation = true
				menu.close()
			elseif data.current.value == 'coucher' then -- [chien ]
				DoRequestAnimSet('creatures@rottweiler@amb@sleep_in_kennel@')
				TaskPlayAnim(ped, 'creatures@rottweiler@amb@sleep_in_kennel@', 'sleep_in_kennel' ,8.0, -8, -1, 1, 0, false, false, false)
				inanimation = true
				menu.close()
			elseif data.current.value == 'coucher2' then -- [chat ]
				DoRequestAnimSet('creatures@cat@amb@world_cat_sleeping_ground@idle_a')
				TaskPlayAnim(ped, 'creatures@cat@amb@world_cat_sleeping_ground@idle_a', 'idle_a' ,8.0, -8, -1, 1, 0, false, false, false)
				inanimation = true
				menu.close()
			elseif data.current.value == 'coucher3' then -- [loup ]
				DoRequestAnimSet('creatures@coyote@amb@world_coyote_rest@idle_a')
				TaskPlayAnim(ped, 'creatures@coyote@amb@world_coyote_rest@idle_a', 'idle_a' ,8.0, -8, -1, 1, 0, false, false, false)
				inanimation = true
				menu.close()
			elseif data.current.value == 'assis2' then -- [carlin ]
				DoRequestAnimSet('creatures@carlin@amb@world_dog_sitting@idle_a')
				TaskPlayAnim(ped, 'creatures@carlin@amb@world_dog_sitting@idle_a', 'idle_b' ,8.0, -8, -1, 1, 0, false, false, false)
				inanimation = true
				menu.close()
			elseif data.current.value == 'assis3' then -- [retriever ]
				DoRequestAnimSet('creatures@retriever@amb@world_dog_sitting@idle_a')
				TaskPlayAnim(ped, 'creatures@retriever@amb@world_dog_sitting@idle_a', 'idle_c' ,8.0, -8, -1, 1, 0, false, false, false)
				inanimation = true
				menu.close()
			elseif data.current.value == 'assis4' then -- [rottweiler ]
				DoRequestAnimSet('creatures@rottweiler@amb@world_dog_sitting@idle_a')
				TaskPlayAnim(ped, 'creatures@rottweiler@amb@world_dog_sitting@idle_a', 'idle_c' ,8.0, -8, -1, 1, 0, false, false, false)
				inanimation = true
				menu.close()
			elseif data.current.value == 'debout' then
				ClearPedTasks(ped)
				inanimation = false
				menu.close()
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function attached()
	local GroupHandle = GetPlayerGroup(PlayerId())
	SetGroupSeparationRange(GroupHandle, 1.9)
	SetPedNeverLeavesGroup(ped, false)
	FreezeEntityPosition(ped, true)
end

function detached()
	local GroupHandle = GetPlayerGroup(PlayerId())
	SetGroupSeparationRange(GroupHandle, 999999.9)
	SetPedNeverLeavesGroup(ped, true)
	SetPedAsGroupMember(ped, GroupHandle)
	FreezeEntityPosition(ped, false)
end

function openchien()
	local playerPed = PlayerPedId()
	local LastPosition = GetEntityCoords(playerPed)
	local GroupHandle = GetPlayerGroup(PlayerId())

	DoRequestAnimSet('rcmnigel1c')

	TaskPlayAnim(playerPed, 'rcmnigel1c', 'hailing_whistle_waive_a' ,8.0, -8, -1, 120, 0, false, false, false)

	Citizen.SetTimeout(5000, function()
		ped = CreatePed(28, model, LastPosition.x +1, LastPosition.y +1, LastPosition.z -1, 1, 1)

		SetPedAsGroupLeader(playerPed, GroupHandle)
		SetPedAsGroupMember(ped, GroupHandle)
		SetPedNeverLeavesGroup(ped, true)
		SetPedCanBeTargetted(ped, false)
		SetEntityAsMissionEntity(ped, true,true)

		status = math.random(40, 90)
		Citizen.Wait(5)
		attached()
		Citizen.Wait(5)
		detached()
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(math.random(60000, 120000))

		if come == 1 then
			status = status - 1
		end

		if status == 0 then
			TriggerServerEvent('eden_animal:petDied')
			DeleteEntity(ped)
			ESX.ShowNotification('Infelizmente o teu animal morreu...')
			come = 3
			status = "die"
		end
	end
end)

-- Key Controls

RegisterCommand("animal", function()
	ESX.TriggerServerCallback('eden_animal:getPet', function(pet)
		if pet then	
			OpenPetMenu()
		else
			ESX.ShowNotification("Não tens nenhum animal, compra um na loja de animais!")
		end
	end)
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(infoEdenAnimal.Zones.PetShop.Pos.x, infoEdenAnimal.Zones.PetShop.Pos.y, infoEdenAnimal.Zones.PetShop.Pos.z)

	SetBlipSprite (blip, infoEdenAnimal.Zones.PetShop.Sprite)
	SetBlipDisplay(blip, infoEdenAnimal.Zones.PetShop.Display)
	SetBlipScale  (blip, infoEdenAnimal.Zones.PetShop.Scale)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Loja de Animais')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coord = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coord, infoEdenAnimal.Zones.PetShop.Pos.x, infoEdenAnimal.Zones.PetShop.Pos.y, infoEdenAnimal.Zones.PetShop.Pos.z, true) < 5 then
			ESX.ShowHelpNotification('Pressiona ~INPUT_CONTEXT~ para ver a loja de animais')

			if IsControlJustReleased(0, 38) then
				OpenPetShop()
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

function OpenPetShop()
	local elements = {}

	for i=1, #infoEdenAnimal.PetShop, 1 do
		table.insert(elements, {
			label = ('%s - <span style="color:green;">%s</span>'):format(infoEdenAnimal.PetShop[i].label,  ESX.Math.GroupDigits(infoEdenAnimal.PetShop[i].price)..'€'),
			pet = infoEdenAnimal.PetShop[i].pet,
			price = infoEdenAnimal.PetShop[i].price
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pet_shop', {
		title    = 'Loja de Animais',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		ESX.TriggerServerCallback('eden_animal:buyPet', function(boughtPed)
			if boughtPed then
				menu.close()
			end
		end, data.current.pet)
	end, function(data, menu)
		menu.close()
	end)
end

function DoRequestModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
end

function DoRequestAnimSet(anim)
	RequestAnimDict(anim)
	while not HasAnimDictLoaded(anim) do
		Citizen.Wait(1)
	end
end
