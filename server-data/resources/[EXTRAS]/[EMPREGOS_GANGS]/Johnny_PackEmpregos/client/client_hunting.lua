WeaponGroupsHunting = {
    [-1609580060] = "unarmed",
    [-728555052] = "melee",
    [416676503] = "pistol",
    [-957766203] = "subgun",
    [860033945] = "shootgun",
    [970310034] = "rifle",
    [-1212426201] = "snip"
}

local isNearDeadAnimalHunting = false
local searchHunting = {}
local isFirstTime = true
local pedsNearHunting = {}
local pedCoordsHunting = 0


local hasTakeVehicle = false
local stockVeh = nil

local propSpawnedHunting = {}

local isAttachHunting = false

local camHunting = nil

local pedIsOnPlayerHunting = nil

local leatherToGive = nil
local leatherIsBad = false
local specialItemHunting = nil
local dimensionHunting = nil
local bad = nil
local good = nil
local perfect = nil
local WasPedShootedInHead = false

local nearestCampfire = nil
local campfireIndex = nil

local animalModelsHunting = {}
local animalsSpawnedCountHunting = 0

local animalFleeingHunting = {}
local fleeFoundHunting = false

playerHunting = nil
coordsHunting = {}

------------------------------------------------------------[HARVEST]------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
		playerHunting = PlayerPedId()
		coordsHunting = GetEntityCoords(playerHunting)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    if Config.CacadorInfo.NativeAnimal then
        while true do
            Citizen.Wait(1000)
            pedsNearHunting = ESX.Game.GetPeds()
            for i=1, #pedsNearHunting, 1 do
                if IsEntityAPed(pedsNearHunting[i]) and not IsPedAPlayer(pedsNearHunting[i]) and not IsPedHuman(pedsNearHunting[i]) then
                    if (getDistanceHunting(pedsNearHunting[i]) < 50) then
                        if not animalExistsHunting(pedsNearHunting[i]) and animalModelExists(pedsNearHunting[i]) then
                            table.insert(searchHunting, pedsNearHunting[i])
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.CacadorInfo.EnableFootprints then
        SetForcePedFootstepsTracks(true)
    end

    while true do
        Citizen.Wait(400)
        if #searchHunting > 0 then
            for i, ped in pairs(searchHunting) do
                local distancePedPlayer = getDistanceHunting(ped)
                if not Config.CacadorInfo.NativeAnimal and distancePedPlayer < Config.CacadorInfo.PNearAnimalToEscape and not IsPedStill(playerHunting) then
                    for i,pedFlee in pairs(animalFleeingHunting) do
                        if ped == pedFlee then
                            fleeFoundHunting = true
                        else
                            fleeFoundHunting = false
                        end
                    end
                    if not fleeFoundHunting then
                        ClearPedTasks(ped)
                        TaskSmartFleePed(ped, playerHunting, 150.0, 30.0, false, false)
                        table.insert(animalFleeingHunting, ped)
                    end
                elseif distancePedPlayer > 200.0 and Config.CacadorInfo.NativeAnimal then
                    deletePedHunting(ped, i)
                end
            end
        end
    end
end)



function isNearAnAnimalHunting(dist, ped, i)
    if IsControlJustReleased(0, 38) then
        local model = GetEntityModel(ped)
        local animal = getAnimalMatchHunting(model)
        if IsEntityDead(ped) then--GetPedSourceOfDeath(ped) == playerHunting then
            harvestAnimalHunting(ped, animal, i)
        else
            exports["mythic_notify"]:DoHudText("error", Config.CacadorInfo.Text['you_didnt_kill_it'], 10000)
        end
    end  
end

function HasKnifeHunting()
    for i, knife in pairs(Config.CacadorInfo.KnifesForHarvest) do
        if GetHashKey(knife) == GetSelectedPedWeapon(playerHunting) then
            return true
        end
    end
    return false
end

function harvestAnimalHunting(ped, model, i)
    if HasKnifeHunting() then
        for k, v in pairs(Config.CacadorInfo.Animals) do
            if v.model == model then
                specialItemHunting = v.specialItem
                dimensionHunting = v.dimension
                bad = v.bad
                good = v.good
                perfect = v.perfect
            end
        end
        local a, b = GetPedLastDamageBone(ped)
        if b == 31086 then
            WasPedShootedInHead = true
        else
            WasPedShootedInHead = false
        end
        local groupH = GetWeapontypeGroup(GetPedCauseOfDeath(ped))
        local groupName = WeaponGroupsHunting[groupH]
        for k, v in pairs(Config.CacadorInfo.WeaponDamages) do
            if v.category == groupName then
                dimensionLeather(v.small, v.medium, v.medBig, v.big)
            end
        end
        local r = math.random(Config.CacadorInfo.MinLeather,Config.CacadorInfo.MaxLeather)
        if leatherToGive ~= nil and groupName ~= nil then
            if Config.CacadorInfo.CameraMovement then
				ToggleSlaughterAnimation(true, ped)
				
				exports['progressbar']:Progress({
					name = "unique_action_name",
					duration = Config.CacadorInfo.TimeToHarvest,
					label = Config.CacadorInfo.Text['harvesting'],
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
                Citizen.Wait(Config.CacadorInfo.TimeToHarvest)
				ToggleSlaughterAnimation(false, 0)
            else                
				ToggleSlaughterAnimation(true, ped)
				
				exports['progressbar']:Progress({
					name = "unique_action_name",
					duration = Config.CacadorInfo.TimeToHarvest,
					label = Config.CacadorInfo.Text['harvesting'],
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = false,
					},
					animation = {
						animDict = "anim@gangops@facility@servers@bodysearch@",
						anim = "player_search",
					},
				}, function(status)
					if not status then
						--Do Something If Event Wasn't Cancelled
					end
				end)
                Citizen.Wait(Config.CacadorInfo.TimeToHarvest)
				ToggleSlaughterAnimation(false, 0)
            end
            exports["mythic_notify"]:DoHudText("inform", Config.CacadorInfo.Text['receved_leather'], 10000)
            TriggerServerEvent('fanonx-hunting:server:giveReward', leatherToGive, r)
            if Config.CacadorInfo.CanDropSpecial and not leatherIsBad then
                DropSpecialItem(specialItemHunting)
            end
            if Config.CacadorInfo.CanDropMeat then
                local rMeat = math.random(Config.CacadorInfo.MinMeat,Config.CacadorInfo.MaxMeat)
                TriggerServerEvent('fanonx-hunting:server:giveReward', Config.CacadorInfo.MeatItem, rMeat)
                exports["mythic_notify"]:DoHudText("inform", Config.CacadorInfo.Text['receved_meat'], 10000)
            end
        elseif leatherToGive == nil or groupName == nil then
            exports["mythic_notify"]:DoHudText("error", Config.CacadorInfo.Text['ruined_leather'], 10000)
            Citizen.Wait(2000)
        end
        SetEntityCoords(ped, -7763.0, 8610.0, -100.0)
        Citizen.Wait(1000)
        deletePedHunting(ped, i)
        Citizen.Wait(3000)
    else
        exports['mythic_notify']:DoHudText('error', Config.CacadorInfo.Text['need_knife'], 10000)
        Citizen.Wait(200)
    end
end

function ToggleSlaughterAnimation(toggle, animalEnity)
    local ped = PlayerPedId()
    Wait(250)
    if toggle then
        makeEntityFaceEntity(ped, animalEnity)
        loadAnimDict('amb@medic@standing@kneel@base')
        loadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
        TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 1, 0, false, false, false)
    elseif not toggle then
        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
        ClearPedTasks(ped)
    end
end

function makeEntityFaceEntity(entity1, entity2)
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading(entity1, heading)
end

function dimensionLeather(small, medium, medBig, big)
    if dimensionHunting == "small" then
        categoryLeather(small)
    elseif dimensionHunting == "medium" then
        categoryLeather(medium)
    elseif dimensionHunting == "medBig" then
        categoryLeather(medBig)
    elseif dimensionHunting == "big" then
        categoryLeather(big)
    end
end

function categoryLeather(quality)
    if quality == "bad" then
        leatherToGive = bad
        leatherIsBad = true
    elseif quality == "good" then
        leatherToGive = good
    elseif quality == "perfect" then
        if Config.CacadorInfo.HeadshotForPerfect then
            if WasPedShootedInHead then
                leatherToGive = perfect
            else
                leatherToGive = good
            end
        else
            leatherToGive = perfect
        end
    end
end

function DropSpecialItem(specialItem)
    local specialProbability = math.random(1, 100)
    if specialProbability >= Config.CacadorInfo.SpecialProb then
        if specialItem ~= "" then
            exports["mythic_notify"]:DoHudText("inform", Config.CacadorInfo.Text['special_item'], 10000)
            TriggerServerEvent('fanonx-hunting:server:giveReward', specialItem, 1)
        end
    end
end

function deletePedHunting(entity, i)
    local model = GetEntityModel(entity)
    SetEntityAsNoLongerNeeded(entity)
    SetModelAsNoLongerNeeded(model)
    DeleteEntity(entity)
    table.remove(searchHunting, i)
    animalsSpawnedCountHunting = animalsSpawnedCountHunting - 1
end

function animalExistsHunting(entity)
    for i, ped in pairs(searchHunting) do
        if ped == entity then
            return true 
        end
    end
    return false
end

function animalModelExists(entity)
    for i, ped in pairs(Config.CacadorInfo.Animals) do
        if ped.hash == GetEntityModel(entity) then
            return true
        end
    end
    return false
end

function StartAnimCamHunting()
    ClearFocus()
    camHunting = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coordsHunting, 0, 0, 0, GetGameplayCamFov())
    SetCamActive(camHunting, true)
    RenderScriptCams(true, true, 1000, true, false)
end

function EndAnimCamHunting()
    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(camHunting, false)
    camHunting = nil
end

function ProcessCamControlsHunting(ped)
    local playerCoords = coordsHunting
    local entityCoords = GetEntityCoords(ped)
    DisableFirstPersonCamThisFrame()
    
    SetCamCoord(camHunting, entityCoords.x + 3, entityCoords.y + 3, entityCoords.z)
    PointCamAtCoord(camHunting, playerCoords.x, playerCoords.y, playerCoords.z + 0.9)
end

function SecondProcessCamControlsHunting(ped)
    local playerCoords = coordsHunting
    local entityCoords = GetEntityCoords(ped)
    DisableFirstPersonCamThisFrame()
    
    SetCamCoord(camHunting, entityCoords.x, entityCoords.y, entityCoords.z + 6.0)
    PointCamAtCoord(camHunting, playerCoords.x, playerCoords.y, playerCoords.z)
end

function getAnimalMatchHunting(hash)
    for _, v in pairs(Config.CacadorInfo.Animals) do 
        if (v.hash == hash) then 
            return v.model
        end 
    end
end

Citizen.CreateThread(function()
    if not Config.CacadorInfo.NativeAnimal then
        for i, animal in pairs(Config.CacadorInfo.Animals) do
            table.insert(animalModelsHunting, animal.model)
        end
        while true do
            Citizen.Wait(100)
            local pos = coordsHunting
            local land = false
            local X,Y,ZLoc = 0

            if IsInSpawnAnimalZoneHunting(pos) then
                if animalsSpawnedCountHunting < Config.CacadorInfo.SpawnAnimalNumber then
                    for k, v in pairs(Config.CacadorInfo.huntPoint) do
                        if GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < Config.CacadorInfo.huntRadious then
                            X = v.x
                            Y = v.y
                            ZLoc = v.z
                        end
                    end
                    local r = math.random(1, #animalModelsHunting)
                    local pedModel = GetHashKey(animalModelsHunting[r])
                    RequestModel(pedModel)
                    while not HasModelLoaded(pedModel) or not HasCollisionForModelLoaded(pedModel) do
                        Wait(100)
                    end
                    posX = X + math.random(-Config.CacadorInfo.huntRadious,Config.CacadorInfo.huntRadious)
                    posY = Y + math.random(-Config.CacadorInfo.huntRadious,Config.CacadorInfo.huntRadious)
                    Z = ZLoc + 999.0
                    land,posZ = GetGroundZFor_3dCoord(posX + .0, posY + .0, Z, 1)
                    if land then
                        entity = CreatePed(5, pedModel, posX, posY, posZ, 0.0, true, false)
                        animalsSpawnedCountHunting = animalsSpawnedCountHunting + 1
                        TaskWanderStandard(entity, true, true)
                        SetEntityAsMissionEntity(entity, true, true)
                        table.insert(searchHunting, entity)
                        if Config.CacadorInfo.BlipOnEntity then
                            local blip = AddBlipForEntity(entity)
                            SetBlipSprite(blip,442)
                            SetBlipColour(blip,1)
                            SetBlipScale(blip, 0.8)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString("Animal")
                            EndTextCommandSetBlipName(blip)
                        end
                    end
                end
            else
                for i, entity in pairs(searchHunting) do
                    deletePedHunting(entity, i)
                end
                animalsSpawnedCountHunting = 0
            end

            for i, entity in pairs(searchHunting) do
                if IsEntityInWater(entity) then
                    deletePedHunting(entity, i)
                end
            end
        end
    end
end)
------------------------------------------------------------[LOCATIONS]------------------------------------------------------------

Citizen.CreateThread(function()
    --local SellZone = Config.CacadorInfo.Locations.SellZone
    while true do
        Citizen.Wait(2)
        
        for i = 1, #searchHunting, 1 do
            local ped = searchHunting[i]
            local distancePedPlayer = getDistanceHunting(ped)
            if distancePedPlayer < 3.0 and not IsPedInAnyVehicle(playerHunting, false) and IsPedDeadOrDying(ped, true) then
                if Config.CacadorInfo.huntAllMap then
                    DrawText3Ds23(pedCoordsHunting.x, pedCoordsHunting.y, pedCoordsHunting.z + 0.5, Config.CacadorInfo.Text['before_harvest'])
                    isNearAnAnimalHunting(distancePedPlayer, ped, i)
                elseif IsInSpawnAnimalZoneHunting(pedCoordsHunting) then
                    DrawText3Ds23(pedCoordsHunting.x, pedCoordsHunting.y, pedCoordsHunting.z + 0.5, Config.CacadorInfo.Text['before_harvest'])
                    isNearAnAnimalHunting(distancePedPlayer, ped, i)
                end
            end
        end
		--[[
        local distanceBetweenSellZone = GetDistanceBetweenCoords(coordsHunting, SellZone.x, SellZone.y, SellZone.z, true)
        if distanceBetweenSellZone < 10 and not IsPedInAnyVehicle(playerHunting, false) then
            DrawMarker(27, SellZone.x, SellZone.y, SellZone.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 255, 255, 255, 150, false, false, 2, false, false, false, false)
            if distanceBetweenSellZone < 3 then 
                DrawText3Ds23(SellZone.x, SellZone.y, SellZone.z + 0.5, Config.CacadorInfo.Text['sell_items'])
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenHuntingSellActionsMenu()
                end
            end
        end
		--]]
        if #propSpawnedHunting > 0 then
            for i, prop in pairs(propSpawnedHunting) do
                if GetDistanceBetweenCoords(coordsHunting, GetEntityCoords(prop), true) < 3 and not IsPedInAnyVehicle(playerHunting, false) then
                    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(prop))
                    DrawText3Ds23(x, y, z + 0.5, Config.CacadorInfo.Text['campfire'])
                    if IsControlJustReleased(0, Keys[Config.CacadorInfo.KeyCampfireMenu]) then
                        OpenCampfireMenu()
                    elseif IsControlJustReleased(0, Keys[Config.CacadorInfo.KeyDestroyCampfire]) then
                        nearestCampfire = prop
                        campfireIndex = i
                        deleteCampfire(coordsHunting)
                    end
                end
            end
        end
		--[[
        if IsNearIllegalNPC(coordsHunting) then
            
			if IsControlJustReleased(0, Keys["E"]) then
                OpenIllegalSellActionsMenuHunting()
            end
        end
		--]]
    end
end)

function IsInSpawnAnimalZoneHunting(coords)
    for k, v in pairs(Config.CacadorInfo.huntPoint) do
        if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.CacadorInfo.huntRadious then
            return true
        end
    end
    return false
end

function IsInSellZoneHuntingIsInSellZoneHunting(coords)
    local SellZone = Config.CacadorInfo.Locations.SellZone
    if GetDistanceBetweenCoords(coords, SellZone.x, SellZone.y, SellZone.z, true) < 3 then
        return true
    end
    return false
end

function getDistanceHunting(pedToGetCoords)
    pedCoordsHunting = GetEntityCoords(pedToGetCoords, true)
    local dist = GetDistanceBetweenCoords(coordsHunting.x, coordsHunting.y, coordsHunting.z, pedCoordsHunting.x, pedCoordsHunting.y, pedCoordsHunting.z)
    return dist
end

function IsNearIllegalNPC(coords)
    local illegalNPC = Config.CacadorInfo.Locations.IllegalNPC
    if GetDistanceBetweenCoords(coords, illegalNPC.x, illegalNPC.y, illegalNPC.z, true) < 3 then
        DrawText3Ds23(illegalNPC.x, illegalNPC.y, illegalNPC.z + 1, Config.CacadorInfo.Text['sell_items'])
		return true
    end
    return false
end

-------------------------------------------------------------[BLIPS]------------------------------------------------------------

function addBlipCacador(coords, sprite, colour, text, scale)
    local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
	SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.CacadorInfo.Blips) do
        addBlipCacador(v.coords, v.sprite, v.colour, v.name, v.scale)
    end
end)

-----------------------------------------------------------[CAMPFIRE]------------------------------------------------------------

if Config.CacadorInfo.EnableCampfire then
    RegisterCommand(Config.CacadorInfo.CampfireCommand, function(source, args, rawCommand)
        if not IsNearNOCampfire(coordsHunting) and not IsEntityInWater(playerHunting) and not IsPedInAnyVehicle(playerHunting) then
            ESX.TriggerServerCallback('fanonx-hunting:server:campfire', function(success)
                if success then
                    local land = false
                    local Z = nil
					exports['progressbar']:Progress({
						name = "unique_action_name",
						duration = Config.CacadorInfo.CampPlacingTime,
						label = Config.CacadorInfo.Text['placing_campfire'],
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
                    TaskStartScenarioInPlace(playerHunting, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                    Citizen.Wait(Config.CacadorInfo.CampPlacingTime)
                    ClearPedTasks(playerHunting)
                    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1),0.0,3.0,5.0))
                    repeat 
                        Citizen.Wait(100)
                        land,NewZ = GetGroundZFor_3dCoord(x,y,z,1)
                    until land

                    print(land) --don't delete
                    
                    if land then
                        prop = CreateObjectNoOffset(GetHashKey(Config.CacadorInfo.CampfireProp),x,y,NewZ+.15, true, true, true)
                        table.insert(propSpawnedHunting, prop)
                    end
                end
            end, Config.CacadorInfo.CampfireNameItem1, Config.CacadorInfo.CampfireNameItem2, Config.CacadorInfo.CampfireCountItem1, Config.CacadorInfo.CampfireCountItem2)
        else
            exports['mythic_notify']:DoHudText('error', Config.CacadorInfo.Text['cant_place_camp'], 10000)
        end
        
    end, false)
end

function IsNearCampfire(coords)
    for i, prop in pairs(propSpawnedHunting) do
        if GetDistanceBetweenCoords(coords, GetEntityCoords(prop), true) < 3 then
            nearestCampfire = prop
            campfireIndex = i
            return true
        end
    end
    return false
end

function IsNearNOCampfire(coords)
    for k, v in pairs(Config.CacadorInfo.noCampfireZone) do
        if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.CacadorInfo.noCampfireZoneRadious then
            return true
        end
    end
    return false
end

function deleteCampfire(coords)
    if GetDistanceBetweenCoords(coords, GetEntityCoords(nearestCampfire), true) < 3.0 then
        DeleteObject(nearestCampfire)
        table.remove(propSpawnedHunting, campfireIndex)
    end
end

function OpenCampfireMenu()
	local elements = {{label = "Carne Cozinhada", item = Config.CacadorInfo.MeatName, type = 'slider', min = 1, max = 3, value = 1}}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'hunting_actions', {
		title    = 'Campfire',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
        if data.current.item == Config.CacadorInfo.MeatName then
			ESX.TriggerServerCallback('fanonx-hunting:server:cook', function(success)
                if success then
					exports['progressbar']:Progress({
						name = "unique_action_name",
						duration = Config.CacadorInfo.CookingTime,
						label = Config.CacadorInfo.Text['cooking'],
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
                    Citizen.Wait(Config.CacadorInfo.CookingTime)
                    TriggerServerEvent('fanonx-hunting:server:giveReward', Config.CacadorInfo.CookedMeatName, data.current.value)
                end
            end, data.current.item, data.current.value)
            menu.close()
        end
	end, function(data, menu)
		menu.close()
	end)
end


-----------------------------------------------------------[BAITS]------------------------------------------------------------

local trapSpawnedHunting = nil
RegisterNetEvent('fanonx:client:canPlaceBait')
AddEventHandler('fanonx:client:canPlaceBait', function()
    if IsEntityInWater(playerHunting) then
        TriggerServerEvent('fanonx-hunting:server:canPlaceBaitS', true)
    elseif not Config.CacadorInfo.huntAllMap and not IsInSpawnAnimalZoneHunting(GetEntityCoords(playerHunting)) then
        TriggerServerEvent('fanonx-hunting:server:canPlaceBaitS', true)
    else
        TriggerServerEvent('fanonx-hunting:server:canPlaceBaitS', false)
    end
end)

RegisterNetEvent('fanonx:client:bait')
AddEventHandler('fanonx:client:bait', function()
	exports['progressbar']:Progress({
		name = "unique_action_name",
		duration = Config.CacadorInfo.BaitPlacingTime,
		label = Config.CacadorInfo.Text['placing_bait'],
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
    TaskStartScenarioInPlace(playerHunting, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    Citizen.Wait(Config.CacadorInfo.BaitPlacingTime)
    ClearPedTasks(playerHunting)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(playerHunting, 0.0, 0.5, 0))
    local prop = CreateObject(GetHashKey("prop_food_burg1"), x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(prop)
    trapSpawnedHunting = prop
    TrapPlacedHunting(x, y, z)
end)

function TrapPlacedHunting(x,y,z)
    local pos = coordsHunting
    local land = false
    local blipBait = nil

    local r = math.random(1, #Config.CacadorInfo.BaitAnimals)
    local pedModel = GetHashKey(Config.CacadorInfo.BaitAnimals[r])
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) or not HasCollisionForModelLoaded(pedModel) do
        Citizen.Wait(10)
    end

    while true do
        Citizen.Wait(5)
        baitRandX = math.random(-Config.CacadorInfo.BaitSpawnRadious, Config.CacadorInfo.BaitSpawnRadious)
        baitRandY = math.random(-Config.CacadorInfo.BaitSpawnRadious, Config.CacadorInfo.BaitSpawnRadious)
        if baitRandX > (Config.CacadorInfo.BaitSpawnRadious / 2) or baitRandX < (-Config.CacadorInfo.BaitSpawnRadious / 2) then
            if baitRandY > (Config.CacadorInfo.BaitSpawnRadious / 2) or baitRandY < (-Config.CacadorInfo.BaitSpawnRadious / 2) then
                break
            end
        end
    end

    X = pos.x + baitRandX
    Y = pos.y + baitRandY
    Z = pos.z + 999.0
    land, spawnZ = GetGroundZFor_3dCoord(X + .0, Y + .0, Z, 1)
    
    if land then
        trapEntity = CreatePed(5, pedModel, X, Y, spawnZ, 0.0, true, false)
        TaskWanderStandard(trapEntity, true, true)
        SetEntityAsMissionEntity(trapEntity, true, true)
        table.insert(searchHunting, trapEntity)
        TaskGoToEntity(trapEntity, trapSpawnedHunting, -1, 1.0, 1.0, 0, 0)
        if Config.CacadorInfo.BlipOnBaitAnimal then
            blipBait = AddBlipForEntity(trapEntity)
            SetBlipSprite(blipBait,442)
            SetBlipColour(blipBait,1)
            SetBlipScale(blipBait, 0.8)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Bait de Animal")
            EndTextCommandSetBlipName(blipBait)
        end
        while true do 
            if not IsPedDeadOrDying(trapEntity, true) then
                Citizen.Wait(200)
                if getTrapDistance(trapEntity, x, y, z) < 1.5 then
                    ensureAnimDict("amb@lo_res_idles@")
                    TaskPlayAnim(trapEntity, "amb@lo_res_idles@", "creatures_world_deer_grazing_lo_res_base", 1.0, -1.0, -1, 1, 0, false, false, false)
                    Citizen.Wait(Config.CacadorInfo.TimeForAnimalToLeave)
                    ClearPedTasks(trapEntity)
                    TaskWanderStandard(trapEntity, true, true)
                    break
                elseif getDistanceHunting(trapEntity) < Config.CacadorInfo.PNearAnimalToEscape and not IsPedStill(playerHunting) then
                    ClearPedTasks(trapEntity)
                    TaskSmartFleePed(trapEntity, playerHunting, 150.0, 20.0, false, false)
                    break
                end
            else
                if not IsPedAPlayer(GetPedCauseOfDeath(trapEntity)) and not IsPedHuman(GetPedCauseOfDeath(trapEntity)) and GetWeapontypeGroup(GetPedCauseOfDeath(ped)) == nil then
                    Citizen.Wait(10000)
                    exports["mythic_notify"]:DoHudText("error", Config.CacadorInfo.Text['no_effects_bait'], 5000)
                end    
                break
            end
        end
        if Config.CacadorInfo.BlipOnBaitAnimal then
            RemoveBlip(blipBait)
        end
        DeleteEntity(trapSpawnedHunting)
        trapSpawnedHunting = nil
    end
end

function getTrapDistance(pedToGetCoords, x, y, z)
    return GetDistanceBetweenCoords(x, y, z, GetEntityCoords(pedToGetCoords, true))
end

----------------------------------------------------------[SELL]------------------------------------------------------------
local leatherElements = {}
local illegalLeatherElements = {}

RegisterNetEvent('fanonx:client:addElement')
AddEventHandler('fanonx:client:addElement', function(element, illegalMarket)
    if illegalMarket then
        table.insert(illegalLeatherElements, element)
    else
        table.insert(leatherElements, element)
    end
end)


Citizen.CreateThread(function()
    local illegalNPC = Config.CacadorInfo.SellHunting[2].pos
    local isIllegalNPCSpawned = false
    while true do
        Citizen.Wait(1000)
        if GetDistanceBetweenCoords(coordsHunting, illegalNPC[1], illegalNPC[2], illegalNPC[3], true) < 60.0 then
            if not isIllegalNPCSpawned then
                CreateIllegalNPCHunting(illegalNPC)
                isIllegalNPCSpawned = true
            end
        elseif isIllegalNPCSpawned then
            DeleteEntity(illegalPed)
            illegalPed = nil
            isIllegalNPCSpawned = false
        end
    end
end)

function CreateIllegalNPCHunting(illegalNPC)
    local illegalModel = GetHashKey("a_m_m_og_boss_01")
    RequestModel(illegalModel)
    while not HasModelLoaded(illegalModel) do
        Citizen.Wait(100)
    end
    illegalPed = CreatePed(5, illegalModel, illegalNPC[1], illegalNPC[2], illegalNPC[3], illegalNPC[4], true, false)
    FreezeEntityPosition(illegalPed, true)
    SetEntityInvincible(illegalPed, true)
    SetEntityAsMissionEntity(illegalPed, true, true)
    SetBlockingOfNonTemporaryEvents(illegalPed, true)
    SetPedDefaultComponentVariation(illegalPed)
    ensureAnimDict("amb@code_human_cross_road@male@idle_a")
    TaskPlayAnim(illegalPed, "amb@code_human_cross_road@male@idle_a", "idle_b", 1.0, -1.0, -1, 1, 0, false, false, false)
end

local plySellingHunting = false
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		local sleep = true
		for k,v in pairs(Config.CacadorInfo.SellHunting) do
			local distance = GetDistanceBetweenCoords(coordsHunting.x, coordsHunting.y, coordsHunting.z, v.pos[1], v.pos[2], v.pos[3], false)
			local mk = v.marker
			if distance <= mk.drawDist and not plySellingHunting then
				sleep = false 
				if distance >= 1.25 and mk.enable then 
					DrawMarker(mk.type, v.pos[1], v.pos[2], v.pos[3] - 0.975, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
				elseif distance < 1.25 then
					DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], v.drawText)
					if IsControlJustPressed(0, v.keybind) then
						plySellingHunting = true
						OpenSellHuntingFunction(k,v, v.ilegal)
					end
				end
			end
		end
		if sleep then Citizen.Wait(1000) end
    end
end)

-- Function to smelth wash stone:
function OpenSellHuntingFunction(id,val, ilegal)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance >= 0.7 then
		ESX.TriggerServerCallback('fanonx-hunting:server:temItemsParaVender', function(itemsParaVender)
			Citizen.Wait(200)
			if itemsParaVender then
				FreezeEntityPosition(playerHunting, true)
				SetEntityHeading(PlayerPedId(),  val.pos[4])
				SetCurrentPedWeapon(playerHunting, GetHashKey('WEAPON_UNARMED'))
				
				if Config.ProgressBars then 
					exports['progressbar']:Progress({
						name = "unique_action_name",
						duration = 10000,
						label = LangHunting['pb_selling'],
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
							
						end
					end)
				end
				Citizen.Wait(10000)

				TriggerServerEvent('fanonx-hunting:server:sellAllItems')
			else
				ShowNotification(LangHunting['not_enough_items'], 'error')
			end

			ClearPedTasks(playerHunting)
			FreezeEntityPosition(playerHunting, false)
			plySellingHunting = false
		end, ilegal)

	else
		ShowNotification(LangHunting['player_too_close'], 'error')
		plySellingHunting = false
	end	
end
--]]