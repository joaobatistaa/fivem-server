local JVS = JAM.VehicleShop

function JVS:Start()
    if not self then return; end
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    while not JUtils do Citizen.Wait(0); end

    self.started = true
    self.tick = 0
    self:GetIPL()
    self:UpdateBlips()
    self:SpawnVehicles()

    print("JAM_VehicleShop:Start() - Succesful")

    while not self.IPLLoaded do Citizen.Wait(0); end
    Citizen.CreateThread(function(...) self:Update(); end)
end

function JVS:UpdateBlips()
    if not self or not self.Blips then return; end

    for key,val in pairs(self.Blips) do
        local blip = AddBlipForCoord(val.Pos.x, val.Pos.y, val.Pos.z)
        SetBlipHighDetail           (blip, true)
        SetBlipSprite               (blip, val.Sprite)
        SetBlipDisplay              (blip, val.Display)
        SetBlipScale                (blip, val.Scale)
        SetBlipColour               (blip, val.Color)
        SetBlipAsShortRange         (blip, true)
        BeginTextCommandSetBlipName ("STRING")
        AddTextComponentString      (val.Zone)
        EndTextCommandSetBlipName   (blip)
    end
end

RegisterNetEvent("qs-luckywheel:winCar")
AddEventHandler("qs-luckywheel:winCar", function() 
    
    ESX.Game.SpawnVehicle("2019chiron", { x = 933.29 , y = -2.82 , z = 78.76 }, 144.6, function (vehicle)
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)
		
		TriggerServerEvent('d3x_vehicleshop:setVehicleOwned', vehicleProps, 'Bugatti Chiron (JACKPOT CASINO)', '2019chiron', 0)
		--TriggerServerEvent('vehiclekeys:server:givekey', vehicleProps.plate, '2019chiron')
		exports['qs-vehiclekeys']:GiveKeysAuto()
		exports['Johnny_Notificacoes']:Alert("JACKPOT", "<span style='color:#c7c7c7'>Ganhaste um <span style='color:#069a19'><b>Bugatti Chiron</b></span>! PARABÉNS!!!", 5000, 'success')
		
	end)

    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)


function JVS:GetIPL()
	--RequestIpl('shr_int') -- Load walls and floor
	--local interiorID = 7170
	--LoadInterior(interiorID)
	--EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	--RefreshInterior(interiorID)
 -- Wait(1000)
  self.IPLLoaded = true
end

------------------------------------------------------------------------
----------------------------- GERAR MATRICULA --------------------------
------------------------------------------------------------------------

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
		ESX.TriggerServerCallback('JAM_VehicleShop:isPlateTaken', function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('JAM_VehicleShop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

RegisterNetEvent("vehicleshop:spawnStandVehicles")
AddEventHandler("vehicleshop:spawnStandVehicles", function()
	JVS:SpawnVehicles()
end)

function JVS:SpawnVehicles()
  if not self or not ESX or not JUtils then return; end
  while not self.IPLLoaded do Citizen.Wait(0); end
  local range = 20
  SetAllVehicleGeneratorsActiveInArea(vector3(-43.763 - range, -1097.911 - range, 26.422 - range), vector3(-43.763 + range, -1097.911 + range, 26.422 + range), false, false);

  ESX.TriggerServerCallback('JAM_VehicleShop:GetShopData', function(shopData) self.ShopData = shopData; end)
  while not self.ShopData do Citizen.Wait(0); end

  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local newPos = vector3(plyPos.x, plyPos.y, plyPos.z + 100.0)
	while JUtils:GetVecDist(GetEntityCoords(GetPlayerPed(-1)), self.DealerMarkerPos) > self.SpawnVehDist do Citizen.Wait(500); end
  Citizen.Wait(500)
	self.DisplayVehicles = {}
    for k,v in pairs(self.DisplayPositions) do
        local vehHash = JUtils.GetHashKey(self.ShopData.Displays[k].model)  
        while not HasModelLoaded(vehHash) do Citizen.Wait(10); RequestModel(vehHash); end
        ESX.Game.SpawnLocalVehicle(vehHash, newPos, v.w, function(cbVeh)
            Citizen.Wait(10)
            SetEntityCoords(cbVeh, v.xyz, 0.0, 0.0, 0.0, true)
            SetEntityHeading(cbVeh, v.w)
            SetEntityAsMissionEntity(cbVeh, true, true)
            SetVehicleOnGroundProperly(cbVeh)
            Citizen.Wait(10)
            FreezeEntityPosition(cbVeh, true)
            SetEntityInvincible(cbVeh, true)
            SetVehicleDoorsLocked(cbVeh, 2)
            self.DisplayVehicles[k] = cbVeh
        end)
        SetModelAsNoLongerNeeded(vehHash)
    end

    local veh = self.SmallSpawnVeh
    local vehHash = JUtils.GetHashKey(veh)
    while not HasModelLoaded(vehHash) do Citizen.Wait(10); RequestModel(vehHash); end
    ESX.Game.SpawnLocalVehicle(vehHash, newPos, self.SmallSpawnPos.w, function(cbVeh)
        Citizen.Wait(10)
        SetEntityCoords(cbVeh, self.SmallSpawnPos.xyz, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, self.SmallSpawnPos.w)
        SetEntityAsMissionEntity(cbVeh, true, true)
        SetVehicleOnGroundProperly(cbVeh)
        self.SmallDisplay = cbVeh
        Citizen.Wait(10)
        FreezeEntityPosition(cbVeh, true)
        SetEntityInvincible(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
    	self.SmallVeh = cbVeh
    end)
    SetModelAsNoLongerNeeded(vehHash) 

    local veh = self.LargeSpawnVeh
    local vehHash = JUtils.GetHashKey(veh)
    while not HasModelLoaded(vehHash) do Citizen.Wait(10); RequestModel(vehHash); end
    ESX.Game.SpawnLocalVehicle(vehHash, newPos, self.LargeSpawnPos.w, function(cbVeh)
        Citizen.Wait(10)
        SetEntityCoords(cbVeh, self.LargeSpawnPos.xyz, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, self.LargeSpawnPos.w)
        SetEntityAsMissionEntity(cbVeh, true, true)
        SetVehicleOnGroundProperly(cbVeh)
        self.LargeDisplay = cbVeh
        Citizen.Wait(10)
        FreezeEntityPosition(cbVeh, true)
        SetEntityInvincible(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
    	self.LargeVeh = cbVeh
    end)
    SetModelAsNoLongerNeeded(vehHash)   
end

function JVS:Update()
	if not self or not JUtils then return; end
  while not self.IPLLoaded do Citizen.Wait(0); end

  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local plyData = ESX.GetPlayerData()

  local nearestDist,nearestVeh,nearestPos,listType = self:GetNearestDisplay(plyPos)

	while true do
		Citizen.Wait(0)
		self.tick = (self.tick or 0) + 1
		local plyPed = GetPlayerPed(-1)
		local plyPos = GetEntityCoords(plyPed)
		local dist = JUtils:GetVecDist(plyPos, self.DealerMarkerPos)
		if dist < self.SpawnVehDist then
			nearestDist,nearestVeh,nearestPos,listType = self:GetNearestDisplay(plyPos)
			if self.tick % 1000 == 0 then        
				plyData = ESX.GetPlayerData()
			end
			--print(nearestDist)
			if nearestDist < self.DrawTextDist then
				local vehName = ""
				local vehPrice = ""
				local extraStr = ""				
				local plyJob = plyData.job.name
				if listType == 1 then
					for k,v in pairs(self.ShopData.Displays) do 
						if v.model == nearestVeh then 
							vehName = v.name
							vehPrice = tostring(v.price)
							nearestModel = v.model
							nearestPrice = v.price
							nearestProfit = v.profit
							extraStr = v.profit
						end
					end
				elseif listType == 2 or listType == 3 then
					for k,v in pairs(self.ShopData.Vehicles) do 
						if v.model == nearestVeh then 
							vehName = v.name
							vehPrice = tostring(v.price)
							extraStr = "Pressione [G] para alterar o veículo."
							nearestModel = v.model
							nearestPrice = v.price
						end
					end
				end
				if (IsControlJustPressed(0, JUtils.Keys["E"], IsDisabledControlJustPressed(0, JUtils.Keys["E"]))) then 
					local istrue = true
					local timer = GetGameTimer()
					while istrue do
						Citizen.Wait(0)
						local plyPos = GetEntityCoords(GetPlayerPed(-1))
						local nearestDistB,nearestVehB,nearestPosB,listTypeB = self:GetNearestDisplay(plyPos)
						if (nearestDistB < self.DrawTextDist and nearestVehB == nearestVeh) then 
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, "Pressione [K] novamente para confirmar a compra.")
						if type(extraStr) == "number" then
							if plyJob == self.CarDealerJobLabel then
								self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ " .. math.floor(vehPrice + (extraStr * vehPrice) / 100) .. "€ ] : [ "..extraStr.."% ]")
							else
								self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ " .. math.floor(vehPrice + (extraStr * vehPrice) / 100) .. "€ ]")
							end
						else            
							if plyJob == self.CarDealerJobLabel then
								self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ " .. vehPrice .. "€ ] : " .. extraStr)
							else
								self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ " .. vehPrice .. "€ ]")
							end
						end
							if (IsControlJustPressed(0, JUtils.Keys["K"], IsDisabledControlJustPressed(0, JUtils.Keys["K"]))) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not self.CurBuying then
								timer = GetGameTimer()
								ESX.TriggerServerCallback('JAM_VehicleShop:PurchaseVehicle', function(valid)
									local safetycheck = nearestModel
									self.CurBuying = true
									if valid then 
										local closest,closestDist
										for k,v in pairs(self.DisplayVehicles) do
											local dist = JUtils:GetVecDist(GetEntityCoords(v), GetEntityCoords(GetPlayerPed(-1)))
											if not dist or not closest or dist < closestDist then closest = v; closestDist = dist; end
										end
										local spawnPos
										if listType == 1 or listType == 3 then spawnPos = self.PurchasedCarPos; else spawnPos = self.PurchasedUtilPos; end
										local hash = GetHashKey(nearestModel)

										if not HasModelLoaded(hash) then
											RequestModel(hash)
											while not HasModelLoaded(hash) do
												Citizen.Wait(10)
											end
										end

										local vehicleBuy = CreateVehicle(hash, spawnPos, 1, 1)
										local newPlate = GeneratePlate()
										SetVehicleNumberPlateText(vehicleBuy, newPlate)
										SetVehicleOnGroundProperly(vehicleBuy)
										SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
										SetVehicleDirtLevel(vehicleBuy, 0.0)
										exports["Johnny_Combustivel"]:SetFuel(vehicleBuy, 100)
										local vehProps = ESX.Game.GetVehicleProperties(vehicleBuy)
										
										if safetycheck == nearestModel then
											TriggerServerEvent('JAM_VehicleShop:CompletePurchase', vehProps, nearestModel, vehName, vehPrice)
											--TriggerServerEvent('vehiclekeys:server:givekey', newPlate, nearestModel)
											exports['qs-vehiclekeys']:GiveKeysAuto()
											exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Compraste o veículo <span style='color:#069a19'><b>"..vehName.."</b></span> com a matricula <span style='color:#069a19'><b>"..newPlate.."</b></span> por <span style='color:#069a19'><b>"..vehPrice.."€</b></span>.", 5000, 'success')
											
										else
											--mensagemerro = " tentou usar exploit na compra de carro"
											--TriggerServerEvent('el_bwh:talk', mensagemerro)
											--ESX.ShowNotification("~r~Erro! Abre um ticket no discord...")
											exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Ocorreu um <span style='color:#ff0000'>erro</span> ao comprar o veículo! Abre ticket!", 5000, 'error')
										end
										
										self.CurBuying = false
									else
										exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>Não tens <span style='color:#ff0000'>dinheiro</span> suficiente!", 5000, 'error')
										Citizen.CreateThread(function()
											Wait(1000)
											JVS.CurBuying = false
										end)
									end
									istrue = false
								end, nearestModel,nearestPrice)
							end
						else 
							istrue = false
						end						
					end
				elseif (IsControlJustPressed(0, JUtils.Keys["G"], IsDisabledControlJustPressed(0, JUtils.Keys["G"]))) then 
					if listType == 3 then self:OpenSalesMenu(); end
					if listType == 2 then self:OpenUtilityMenu(); end
				elseif (IsControlJustPressed(0, JUtils.Keys["H"], IsDisabledControlJustPressed(0, JUtils.Keys["H"]))) then
					self:TestDriveVehicle(nearestModel,listType)
				else
					if type(extraStr) == "number" then
						self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ ~r~"..vehName.." ~s~] : [ ~g~" .. math.floor(vehPrice + (extraStr * vehPrice) / 100) .. " ~s~€]")
						self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, "Pressione [E] para comprar. Pressione [H] para um test drive.")
					else						
						self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ ~r~"..vehName.." ~s~] : [ ~g~" .. vehPrice .. " ~s~€] : " .. extraStr)
						self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, "Pressione [E] para comprar. Pressione [H] para um test drive.")
					end
				end
			else
				Citizen.Wait(1000)
			end
		end
	end
end

local IsDead = false


AddEventHandler('esx:onPlayerSpawn', function()
	IsDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    IsDead = true
end)

local startCountDown = false

function JVS:TestDriveVehicle(model, listtype)
	startCountDown = true
	local hash = GetHashKey(model)
	
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(10)
		end
	end
	
	if self.TestingCar ~= nil then
		DeleteEntity(self.TestingCar)
	end
	
	self.TestingCar = CreateVehicle(hash, JVS.TestCarPos, 1, 1)
	SetVehicleNumberPlateText(self.TestingCar, 'TESTE')
	SetVehicleOnGroundProperly(self.TestingCar)
	SetPedIntoVehicle(PlayerPedId(), self.TestingCar, -1)
	SetVehicleDirtLevel(self.TestingCar, 0.0)
	exports["Johnny_Combustivel"]:SetFuel(self.TestingCar, 100)
	--TriggerServerEvent('vehiclekeys:server:givekey', 'TESTE', model)
	exports['qs-vehiclekeys']:GiveKeysAuto()
	local timeGG = GetGameTimer()
	
	while startCountDown do
		local countTime
		Citizen.Wait(1)
		if IsDead then
			IsDead = false
			TriggerServerEvent('esx_ambulancejob:revLoureivero', nil)
		end
		if GetGameTimer() < timeGG+tonumber(1000*60) then
			local secondsLeft = GetGameTimer() - timeGG
			drawTxt('Tempo restante: ' .. math.ceil(60 - secondsLeft/1000),4,0.5,0.93,0.50,255,255,255,180)
		else
			exports['qs-vehiclekeys']:RemoveKeysAuto()
			DeleteEntity(self.TestingCar)
			--TriggerServerEvent('vehiclekeys:server:removekey', 'TESTE', model)
			SetEntityCoords(PlayerPedId(), -48.12, -1099.36, 27.27)
			startCountDown = false
		end
	end
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName('A carregar veículo...')
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

function JVS:OpenUtilityMenu()
	local elements = {}
	local busy2 = false
	for k,v in pairs(self.ShopData.Vehicles) do if v.category == "pesados" then table.insert(elements, {label = v.name .. " : ["..v.price.."€]", model = v.model, price = v.price}); end; end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Utility_Menu", { title = "Veículos Pesados", align = 'top-left', elements = elements }, 
		function(data,menu)
			--menu.close()
			if not busy2 then
				busy2 = true
				local vehicle = data.current
				if not IsModelInCdimage(vehicle.model) then
					print('Modelo de veículo inválido: ' .. vehicle.model)
					exports['Johnny_Notificacoes']:Alert("INVÁLIDO", "<span style='color:#c7c7c7'>Modelo de veículo inválido: <span style='color:#ffc107'>"..vehicle.model.."</span>", 5000, 'warning')
					busy2 = false
					return
				end
				
				local hash = GetHashKey(vehicle.model)
	
				if not HasModelLoaded(hash) then
					RequestModel(hash)
					while not HasModelLoaded(hash) do
						Citizen.Wait(10)
					end
				end
				
				-- Verifica se o veículo anterior existe e o apaga
				if DoesEntityExist(self.LargeVeh) then
					DeleteEntity(self.LargeVeh)
					Citizen.Wait(300)
				end

				ESX.Game.SpawnLocalVehicle(vehicle.model, self.LargeSpawnPos.xyz, self.LargeSpawnPos.w, function(cbVeh)
					if cbVeh ~= nil then
						Citizen.Wait(10)
						SetEntityCoords(cbVeh, self.LargeSpawnPos.xyz, 0.0, 0.0, 0.0, true)
						SetEntityHeading(cbVeh, self.LargeSpawnPos.w)
						SetEntityAsMissionEntity(cbVeh, true, true)
						SetVehicleOnGroundProperly(cbVeh)
						Citizen.Wait(10)
						FreezeEntityPosition(cbVeh, true)
						SetVehicleDoorsLocked(cbVeh, 2)
						Citizen.Wait(10)
						self.LargeVeh = cbVeh
						self.LargeSpawnVeh = vehicle.model
						Citizen.Wait(500)
						busy2 = false
					else
						exports['Johnny_Notificacoes']:Alert("INVÁLIDO", "<span style='color:#c7c7c7'>Erro ao carregar o <span style='color:#ffc107'>veículo</span>!", 5000, 'warning')
						busy2 = false
					end
				end)
			end
		end,		
		function(data,menu)
			menu.close()
			ESX.UI.Menu.CloseAll()
		end
	)
end	

function JVS:OpenUtilPurchase(vehicle)
	if not IsModelInCdimage(vehicle.model) then
		print('Modelo de veículo inválido: ' .. vehicle.model)
		exports['Johnny_Notificacoes']:Alert("INVÁLIDO", "<span style='color:#c7c7c7'>Modelo de veículo inválido: <span style='color:#ffc107'>"..vehicle.model.."</span>", 5000, 'warning')
		return
	end
	
	local hash = GetHashKey(vehicle.model)
	
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(10)
		end
	end
	
	if DoesEntityExist(self.LargeVeh) then
		DeleteEntity(self.LargeVeh)
		Citizen.Wait(300)
	end
	
	ESX.Game.SpawnLocalVehicle(vehicle.model, self.LargeSpawnPos.xyz, self.LargeSpawnPos.w, function(cbVeh)
		Citizen.Wait(10)
		SetEntityCoords(cbVeh, self.LargeSpawnPos.xyz, 0.0, 0.0, 0.0, true)
		SetEntityHeading(cbVeh, self.LargeSpawnPos.w)
		SetEntityAsMissionEntity(cbVeh, true, true)
		SetVehicleOnGroundProperly(cbVeh)
		Citizen.Wait(10)
		FreezeEntityPosition(cbVeh, true)
		SetVehicleDoorsLocked(cbVeh, 2)
    	Citizen.Wait(10)
    	self.LargeVeh = cbVeh
    	self.LargeSpawnVeh = vehicle.model
	end)
end

function JVS:OpenCategoryMenu(category)
	local elements = {}
	local busy = false
	for k,v in pairs(self.ShopData.Vehicles) do if v.category == category.name then table.insert(elements, { label = v.name .. " : ["..v.price.."€]", model = v.model, price = v.price }); end; end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Category_Menu", { title = "Stand: "..category.label, align = 'top-left', elements = elements }, 
	function(data,menu)
		--menu.close()
		--if busy then return end
		if not busy then
			busy = true
			local vehicle = data.current

			if not IsModelInCdimage(vehicle.model) then
				print('Modelo de veículo inválido: ' .. vehicle.model)
				exports['Johnny_Notificacoes']:Alert("INVÁLIDO", "<span style='color:#c7c7c7'>Modelo de veículo inválido: <span style='color:#ffc107'>"..vehicle.model.."</span>", 5000, 'warning')
				busy = false
				return
			end
			
			local hash = GetHashKey(vehicle.model)
	
			if not HasModelLoaded(hash) then
				RequestModel(hash)
				while not HasModelLoaded(hash) do
					Citizen.Wait(10)
				end
			end
			
			-- Verifica se o veículo anterior existe e o apaga
			if DoesEntityExist(self.SmallVeh) then
				DeleteEntity(self.SmallVeh)
				Citizen.Wait(300)
			end
					
			ESX.Game.SpawnLocalVehicle(vehicle.model, self.SmallSpawnPos.xyz, self.SmallSpawnPos.w, function(cbVeh)
				if cbVeh ~= nil then
					Citizen.Wait(10)
					SetEntityCoords(cbVeh, self.SmallSpawnPos.xyz, 0.0, 0.0, 0.0, true)
					SetEntityHeading(cbVeh, self.SmallSpawnPos.w)
					SetEntityAsMissionEntity(cbVeh, true, true)
					SetVehicleOnGroundProperly(cbVeh)
					Citizen.Wait(10)
					FreezeEntityPosition(cbVeh, true)
					SetVehicleDoorsLocked(cbVeh, 2)
					Citizen.Wait(10)
					self.SmallVeh = cbVeh
					self.SmallSpawnVeh = vehicle.model
					Citizen.Wait(500)
					busy = false
				else
					exports['Johnny_Notificacoes']:Alert("INVÁLIDO", "<span style='color:#c7c7c7'>Erro ao carregar o <span style='color:#ffc107'>veículo</span>!", 5000, 'warning')
					busy = false
				end
			end)
			
		end
	end,
	function(data,menu)
		--menu.close()
		self:OpenSalesMenu()
	end)
end

function JVS:OpenSalesMenu()
	local elements = {}
	for k,v in pairs(self.ShopData.Categories) do if v.name ~= "utility" then table.insert(elements, { label = v.label, name = v.name } ); end; end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Sales_Menu", { title = "Veículos", align = 'top-left', elements = elements }, 
		function(data,menu)
			menu.close()
			self:OpenCategoryMenu(data.current)
		end,		
		function(data,menu)
			menu.close()
			ESX.UI.Menu.CloseAll()
		end
	)
end

function JVS:ChangeSpawnedVehicle(vehicle, category)
	if not IsModelInCdimage(vehicle.model) then
		print('Modelo de veículo inválido: ' .. vehicle.model)
		exports['Johnny_Notificacoes']:Alert("INVÁLIDO", "<span style='color:#c7c7c7'>Modelo de veículo inválido: <span style='color:#ffc107'>"..vehicle.model.."</span>", 5000, 'warning')
		return
	end
	
	local hash = GetHashKey(vehicle.model)
	
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(10)
		end
	end
	
	-- Verifica se o veículo anterior existe e o apaga
	if DoesEntityExist(self.SmallVeh) then
		self.LastVeh = self.SmallVeh
		DeleteEntity(self.SmallVeh)
		self.SmallVeh = nil
		Citizen.Wait(1000)
	end

	ESX.Game.SpawnLocalVehicle(vehicle.model, self.SmallSpawnPos.xyz, self.SmallSpawnPos.w, function(cbVeh)
		Citizen.Wait(10)
		SetEntityCoords(cbVeh, self.SmallSpawnPos.xyz, 0.0, 0.0, 0.0, true)
		SetEntityHeading(cbVeh, self.SmallSpawnPos.w)
		SetEntityAsMissionEntity(cbVeh, true, true)
		SetVehicleOnGroundProperly(cbVeh)
		Citizen.Wait(10)
		FreezeEntityPosition(cbVeh, true)
		SetVehicleDoorsLocked(cbVeh, 2)
		Citizen.Wait(10)
		self.SmallVeh = cbVeh
		self.SmallSpawnVeh = vehicle.model
	end)
end

RegisterNetEvent('JAM_VehicleShop:ClientReplace')
AddEventHandler('JAM_VehicleShop:ClientReplace', function(model, key, docar)
	if not JVS or not ESX or not ESX.IsPlayerLoaded() then return; end
	if docar then JVS:ReplaceDisplayVehicle(model, key)
	else JVS:ReplaceDisplayComission(model,key)
	end
end)

function JVS:ReplaceDisplayComission(model,key)
    ESX.TriggerServerCallback('JAM_VehicleShop:GetShopData', function(shopData) self.ShopData = shopData; end)
end

function JVS:ReplaceDisplayVehicle(model, key)
	local canCont = false
    ESX.TriggerServerCallback('JAM_VehicleShop:GetShopData', function(shopData) self.ShopData = shopData; canCont = true; end)
    while not canCont do Citizen.Wait(0); end
	local startPos = GetEntityCoords(GetPlayerPed(-1))
	local newPos = vector3(startPos.x, startPos.y, startPos.z + 100.0)
	local spawnPos = self.DisplayPositions[key]
	local vehHash = JUtils.GetHashKey(model)
	self.DisplayVehicles = self.DisplayVehicles or {}
	if self.DisplayVehicles and self.DisplayVehicles[key] then ESX.Game.DeleteVehicle(self.DisplayVehicles[key]); end
	while not HasModelLoaded(vehHash) do Citizen.Wait(10); RequestModel(vehHash); end
	
	ESX.Game.SpawnLocalVehicle(vehHash, spawnPos.xyz, spawnPos.w, function(cbVeh)
		Citizen.Wait(10)
		SetEntityCoords(cbVeh, spawnPos.xyz, 0.0, 0.0, 0.0, true)
		SetEntityHeading(cbVeh, spawnPos.w)
		SetEntityAsMissionEntity(cbVeh, true, true)
		SetVehicleOnGroundProperly(cbVeh)
		Citizen.Wait(10)
		FreezeEntityPosition(cbVeh, true)
		SetEntityInvincible(cbVeh, true)
		SetVehicleDoorsLocked(cbVeh, 2)
		self.DisplayVehicles[key] = cbVeh
		Citizen.Wait(10)
		SetModelAsNoLongerNeeded(vehHash)
		if self.DoOpen then self:OpenRearrangeMenu(); self.DoOpen = false; end
	end)
	
	if self.DoOpen then self:OpenRearrangeMenu(); self.DoOpen = false; end

end

function JVS:GetNearestDisplay(plyPos)
	if not self or not self.ShopData then return false; end
	local nearestDist,nearestVeh,nearestPos,listType,key
	for k,v in pairs(self.DisplayPositions) do
		if self.ShopData.Displays[k] then
			local curDist = JUtils:GetVecDist(plyPos, v.xyz)
			if not nearestDist or curDist < nearestDist then
				nearestDist = curDist
				nearestPos = v
				nearestVeh = self.ShopData.Displays[k].model
				listType = 1
				key = k
			end
		end
	end

	local curDistA = JUtils.GetXYDist(plyPos.x, plyPos.y, plyPos.z, self.LargeSpawnPos.x, self.LargeSpawnPos.y, self.LargeSpawnPos.z)
	if not nearestDist or curDistA < nearestDist then
		nearestDist = curDistA 
		nearestPos = self.LargeSpawnPos
		nearestVeh = self.LargeSpawnVeh
		listType = 2
	end

	local curDistB = JUtils.GetXYDist(plyPos.x, plyPos.y, plyPos.z, self.SmallSpawnPos.x, self.SmallSpawnPos.y, self.SmallSpawnPos.z)
	if not nearestDist or curDistB < nearestDist then
		nearestDist = curDistB
		nearestPos = self.SmallSpawnPos
		nearestVeh = self.SmallSpawnVeh
		listType = 3
	end
	if not nearestDist or not nearestVeh then return false; end
	return nearestDist,nearestVeh,nearestPos,listType,key
end


local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text 
local font = 4 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = { enable = true, color = { r = 35, g = 35, b = 35, alpha = 200 }, }
local chatMessage = true
local dropShadow = false

-- Don't touch
local nbrDisplaying = 1

function JVS:DrawText3D(x,y,z, text)
  if not self.Drawing then
    self.Drawing = true
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then
      -- Formalize the text
      SetTextColour(color.r, color.g, color.b, color.alpha)
      SetTextScale(0.0*scale, 0.40*scale)
      SetTextFont(font)
      SetTextProportional(1)
      SetTextCentre(true)
      if dropShadow then
          SetTextDropshadow(10, 100, 100, 100, 255)
      end

      -- Calculate width and height
      BeginTextCommandWidth("STRING")
      --AddTextComponentString(text)
      local height = GetTextScaleHeight(0.45*scale, font)
      local width = EndTextCommandGetWidth(font)

      -- Diplay the text
      SetTextEntry("STRING")
      AddTextComponentString(text)
      EndTextCommandDisplayText(_x, _y)

      if background.enable then
          DrawRect(_x, _y+scale/73, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
      end
    end
    self.Drawing = false
  end
end

Citizen.CreateThread(function(...) JVS:Start(...); end)