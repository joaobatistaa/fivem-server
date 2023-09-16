TrainHeist = {
    ['startPeds'] = {},
    ['guardPeds'] = {},
    ['containers'] = {},
    ['collisions'] = {},
    ['locks'] = {},
    ['desks'] = {},
    ['golds'] = {}
}

Citizen.CreateThread(function()
    for k, v in pairs(Config['TrainHeist']['startHeist']['peds']) do
        loadModel(v['ped'])
        TrainHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(TrainHeist['startPeds'][k], true)
        SetEntityInvincible(TrainHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(TrainHeist['startPeds'][k], true)
    end
end)

--[[
Citizen.CreateThread(function()
	--for _, heist in pairs(Config.FleecaHeist) do
		local blip = AddBlipForCoord(Config['TrainHeist']['startHeist']['pos'])
		SetBlipSprite(blip, 156)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Assalto ao Comboio")
		EndTextCommandSetBlipName(blip)
	--end
end)
--]]

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['TrainHeist']['startHeist']['pos'])
        local sleep = 1000
        if dist <= 3.0 then 
            sleep = 1
            ShowHelpNotification(StringsTrain['start_heist'])
            if IsControlJustPressed(0, 38) then
                StartTrainHeist()
            end
        end
        Citizen.Wait(sleep)
    end
end)

function StartTrainHeist()
    ESX.TriggerServerCallback('trainheist:server:checkPoliceCount', function(status)
        if status then
            ESX.TriggerServerCallback('trainheist:server:checkTime', function(time)
                if time then
                    ShowNotification(StringsTrain['goto_ambush'], 'info')
                    ambushBlip = addBlip(Config['TrainHeist']['setupTrain']['pos'], 570, 1, StringsTrain['ambush_blip'])
                    repeat
                        local ped = PlayerPedId()
                        local pedCo = GetEntityCoords(ped)
                        local dist = #(pedCo - Config['TrainHeist']['setupTrain']['pos'])
                        Wait(1)
                    until dist <= 150.0
                    SpawnGuardsTrain()
                    SetupTrain()
                    TriggerServerEvent('trainheist:server:trainLoop')
                    TriggerServerEvent('trainheist:server:policeAlert', Config['TrainHeist']['setupTrain']['pos'])
                end
            end)
        end
    end)
end

RegisterNetEvent('trainheist:client:policeAlert')
AddEventHandler('trainheist:client:policeAlert', function(targetCoords)
    --ShowNotification(StringsTrain['police_alert'], 'warn')
	local street = GetStreetAndZone()
	TriggerEvent('police:assaltos', 'Assalto a decorrer num Comboio', targetCoords, street)
    local alpha = 250
    local trainAlert = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(trainAlert, true)
    SetBlipColour(trainAlert, 1)
    SetBlipAlpha(trainAlert, alpha)
    SetBlipAsShortRange(trainAlert, true)

    while alpha ~= 0 do
        Citizen.Wait(500)
        alpha = alpha - 1
        SetBlipAlpha(trainAlert, alpha)

        if alpha == 0 then
            RemoveBlip(trainAlert)
            return
        end
    end
end)

RegisterNetEvent('trainheist:client:trainLoop')
AddEventHandler('trainheist:client:trainLoop', function()
    trainLoop = true
    while trainLoop do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)

        if robberTrain then
            local trainDist = #(pedCo - Config['TrainHeist']['setupTrain']['pos'])
            if trainDist >= 50.0 then
                TriggerServerEvent('trainheist:server:resetHeist')
                FinishHeistTrain()
                break
            end
        end

        if IsEntityDead(ped) then
            break
        end

        for k, v in pairs(Config['TrainHeist']['setupTrain']['containers']) do
            local dist = #(pedCo - v['lock']['pos'])
            if dist <= 1.5 and not v['lock']['taken'] then
                ShowHelpNotification(StringsTrain['cutting'])
                if IsControlJustPressed(0, 38) then
                    OpenContainerTrain(k)
                end
            end
            for x, y in pairs(v['golds']) do
                local dist = #(pedCo - y['pos'])
                if dist <= 1.1 and not y['taken'] and not grabNowTrain then
                    ShowHelpNotification(StringsTrain['grab'])
                    if IsControlJustPressed(0, 38) then
                        GrabTrain(k, x)
                    end
                end
            end
        end
        Wait(1)
    end
end)

function FinishHeistTrain()
    RemoveBlip(ambushBlip)
    DeleteVehicle(mainTrain)
    DeleteVehicle(trainPart)
    DeleteObject(TrainHeist['desks'][1])
    DeleteObject(TrainHeist['desks'][2])
    DeleteObject(TrainHeist['containers'][1])
    DeleteObject(TrainHeist['containers'][2])
    DeleteObject(TrainHeist['locks'][1])
    DeleteObject(TrainHeist['locks'][2])
    ShowNotification(StringsTrain['deliver_to_buyer'], 'info')
   -- loadModel('baller')
    buyerBlip = addBlip(Config['TrainHeist']['finishHeist']['buyerPos'], 500, 0, StringsTrain['buyer_blip'])
    --buyerVehicle = CreateVehicle(GetHashKey('baller'), Config['TrainHeist']['finishHeist']['buyerPos'].xy + 3.0, Config['TrainHeist']['finishHeist']['buyerPos'].z, 269.4, 0, 0)
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['TrainHeist']['finishHeist']['buyerPos'])

        if dist <= 15.0 then
            PlayCutsceneTrain('hs3f_all_drp3', Config['TrainHeist']['finishHeist']['buyerPos'])
            --DeleteVehicle(buyerVehicle)
            RemoveBlip(buyerBlip)
            TriggerServerEvent('trainheist:server:sellRewardItems')
            break
        end
        Wait(1)
    end
end

RegisterNetEvent('trainheist:client:resetHeist')
AddEventHandler('trainheist:client:resetHeist', function()
    DeleteObject(clientContainer)
    DeleteObject(clientLock)
    DeleteObject(clientContainer2)
    DeleteObject(clientLock2)
    clientContainer, clientContainer2, clientLock, clientLock2 = nil, nil, nil, nil
    ClearArea(2885.97, 4560.83, 48.0551, 50.0)
	notified = false
	count = 0
    trainLoop = false
    for k, v in pairs(Config['TrainHeist']['setupTrain']['containers']) do
        v['lock']['taken'] = false
        for x, y in pairs(v['golds']) do
            y['taken'] = false
        end
    end
end)

function SpawnGuardsTrain()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    AddRelationshipGroup('GuardPeds')

    for k, v in pairs(Config['TrainHeist']['guardPeds']) do
        loadModel(v['model'])
        TrainHeist['guardPeds'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(TrainHeist['guardPeds'][k])
        networkID = NetworkGetNetworkIdFromEntity(TrainHeist['guardPeds'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(TrainHeist['guardPeds'][k], 0)
        SetPedRandomProps(TrainHeist['guardPeds'][k])
        SetEntityAsMissionEntity(TrainHeist['guardPeds'][k])
        SetEntityVisible(TrainHeist['guardPeds'][k], true)
        SetPedRelationshipGroupHash(TrainHeist['guardPeds'][k], GetHashKey("GuardPeds"))
        SetPedAccuracy(TrainHeist['guardPeds'][k], 50)
        SetPedArmour(TrainHeist['guardPeds'][k], 100)
        SetPedCanSwitchWeapon(TrainHeist['guardPeds'][k], true)
        SetPedDropsWeaponsWhenDead(TrainHeist['guardPeds'][k], false)
		SetPedFleeAttributes(TrainHeist['guardPeds'][k], 0, false)
        GiveWeaponToPed(TrainHeist['guardPeds'][k], GetHashKey('WEAPON_CARBINERIFLE'), 255, false, false)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(TrainHeist['guardPeds'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))
	SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))
end

function SetupTrain()
    loadModel('freight')
    loadModel('freightcar')
    loadModel('tr_prop_tr_container_01a')
    loadModel('prop_ld_container')
    loadModel('tr_prop_tr_lock_01a')
    loadModel('xm_prop_lab_desk_02')
    loadModel('h4_prop_h4_gold_stack_01a')
    mainTrain = CreateVehicle(GetHashKey('freight'), Config['TrainHeist']['setupTrain']['pos'], Config['TrainHeist']['setupTrain']['heading'], 1, 0)
    trainPart = CreateVehicle(GetHashKey('freightcar'), Config['TrainHeist']['setupTrain']['part'], Config['TrainHeist']['setupTrain']['heading'], 1, 0)
    FreezeEntityPosition(mainTrain, true)
    FreezeEntityPosition(trainPart, true)
    for k, v in pairs(Config['TrainHeist']['setupTrain']['containers']) do
        TrainHeist['containers'][k] = CreateObject(GetHashKey('tr_prop_tr_container_01a'), v['pos'], 1, 1, 0)
        SetEntityHeading(TrainHeist['containers'][k], v['heading'])
        FreezeEntityPosition(TrainHeist['containers'][k], true)
        Wait(math.random(100, 500))
        TrainHeist['collisions'][k] = CreateObject(GetHashKey('prop_ld_container'), v['pos'], 1, 1, 0)
        SetEntityHeading(TrainHeist['collisions'][k], v['heading'])
        SetEntityVisible(TrainHeist['collisions'][k], false)
        FreezeEntityPosition(TrainHeist['collisions'][k], true)
        Wait(math.random(100, 500))
        TrainHeist['locks'][k] = CreateObject(GetHashKey('tr_prop_tr_lock_01a'), v['lock']['pos'], 1, 1, 0)
        SetEntityHeading(TrainHeist['locks'][k], v['heading'])
        TrainHeist['desks'][k] = CreateObject(GetHashKey('xm_prop_lab_desk_02'), v['table'], 1, 1, 0)
        SetEntityHeading(TrainHeist['desks'][k], v['heading'])
        Wait(math.random(100, 500))
        for x, y in pairs(v['golds']) do
            TrainHeist['golds'][k..x] = CreateObject(GetHashKey('h4_prop_h4_gold_stack_01a'), y['pos'], 1, 1, 0)
            SetEntityHeading(TrainHeist['golds'][k..x], v['heading'])
        end
        Wait(math.random(1000, 5000))
    end
end

function OpenContainerTrain(index)
    ESX.TriggerServerCallback('trainheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local pedRotation = GetEntityRotation(ped)
            local animDict = 'anim@scripted@player@mission@tunf_train_ig1_container_p1@male@'
            loadAnimDict(animDict)
            loadPtfxAsset('scr_tn_tr')
            TriggerServerEvent('trainheist:server:lockSync', index)
            
            for i = 1, #TrainAnimation['objects'] do
                loadModel(TrainAnimation['objects'][i])
                TrainAnimation['sceneObjects'][i] = CreateObject(GetHashKey(TrainAnimation['objects'][i]), pedCo, 1, 1, 0)
            end

            sceneObject = GetClosestObjectOfType(pedCo, 2.5, GetHashKey('tr_prop_tr_container_01a'), 0, 0, 0)
            lockObject = GetClosestObjectOfType(pedCo, 2.5, GetHashKey('tr_prop_tr_lock_01a'), 0, 0, 0)
            NetworkRegisterEntityAsNetworked(sceneObject)
            NetworkRegisterEntityAsNetworked(lockObject)

            scene = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1065353216)

            NetworkAddPedToSynchronisedScene(ped, scene, animDict, TrainAnimation['animations'][1][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(sceneObject, scene, animDict, TrainAnimation['animations'][1][2], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(lockObject, scene, animDict, TrainAnimation['animations'][1][3], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(TrainAnimation['sceneObjects'][1], scene, animDict, TrainAnimation['animations'][1][4], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(TrainAnimation['sceneObjects'][2], scene, animDict, TrainAnimation['animations'][1][5], 1.0, -1.0, 1148846080)

            SetEntityCoords(ped, GetEntityCoords(sceneObject))
            NetworkStartSynchronisedScene(scene)
            Wait(4000)
            UseParticleFxAssetNextCall('scr_tn_tr')
            sparks = StartParticleFxLoopedOnEntity("scr_tn_tr_angle_grinder_sparks", TrainAnimation['sceneObjects'][1], 0.0, 0.25, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, 1065353216, 1065353216, 1065353216, 1)
            Wait(1000)
            StopParticleFxLooped(sparks, 1)
            Wait(GetAnimDuration(animDict, 'action') * 1000 - 5000)
            TriggerServerEvent('trainheist:server:containerSync', GetEntityCoords(sceneObject), GetEntityRotation(sceneObject))
            TriggerServerEvent('trainheist:server:objectSync', NetworkGetNetworkIdFromEntity(sceneObject))
            TriggerServerEvent('trainheist:server:objectSync', NetworkGetNetworkIdFromEntity(lockObject))
            DeleteObject(TrainAnimation['sceneObjects'][1])
            DeleteObject(TrainAnimation['sceneObjects'][2])
            ClearPedTasks(ped)
        else
            ShowNotification(StringsTrain['need_this'] .. itemLabel, 'error')
        end
    end, Config['TrainHeist']['requiredItems'][1])
end

RegisterNetEvent('trainheist:client:lockSync')
AddEventHandler('trainheist:client:lockSync', function(index)
    Config['TrainHeist']['setupTrain']['containers'][index]['lock']['taken'] = not Config['TrainHeist']['setupTrain']['containers'][index]['lock']['taken']
end)

RegisterNetEvent('trainheist:client:grabSync')
AddEventHandler('trainheist:client:grabSync', function(index, index2)
    Config['TrainHeist']['setupTrain']['containers'][index]['golds'][index2]['taken'] = not Config['TrainHeist']['setupTrain']['containers'][index]['golds'][index2]['taken']
end)

RegisterNetEvent('trainheist:client:objectSync')
AddEventHandler('trainheist:client:objectSync', function(e)
    local entity = NetworkGetEntityFromNetworkId(e)
    DeleteEntity(entity)
    DeleteObject(entity)
end)

RegisterNetEvent('trainheist:client:containerSync')
AddEventHandler('trainheist:client:containerSync', function(coords, rotation)
    animDict = 'anim@scripted@player@mission@tunf_train_ig1_container_p1@male@'
    loadAnimDict(animDict)

    if clientContainer and clientLock then
        clientContainer2 = CreateObject(GetHashKey('tr_prop_tr_container_01a'), coords, 0, 0, 0)
        clientLock2 = CreateObject(GetHashKey('tr_prop_tr_lock_01a'), coords, 0, 0, 0)
        
        clientScene = CreateSynchronizedScene(coords, rotation, 2, true, false, 1065353216, 0, 1065353216)
        PlaySynchronizedEntityAnim(clientContainer2, clientScene, TrainAnimation['animations'][1][2], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientContainer2)
        PlaySynchronizedEntityAnim(clientLock2, clientScene, TrainAnimation['animations'][1][3], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientLock2)

        SetSynchronizedScenePhase(clientScene, 0.99)
        SetEntityCollision(clientContainer2, false, true)
        FreezeEntityPosition(clientContainer2, true)
    else
        clientContainer = CreateObject(GetHashKey('tr_prop_tr_container_01a'), coords, 0, 0, 0)
        clientLock = CreateObject(GetHashKey('tr_prop_tr_lock_01a'), coords, 0, 0, 0)
        
        clientScene = CreateSynchronizedScene(coords, rotation, 2, true, false, 1065353216, 0, 1065353216)
        PlaySynchronizedEntityAnim(clientContainer, clientScene, TrainAnimation['animations'][1][2], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientContainer)
        PlaySynchronizedEntityAnim(clientLock, clientScene, TrainAnimation['animations'][1][3], animDict, 1.0, -1.0, 0, 1148846080)
        ForceEntityAiAndAnimationUpdate(clientLock)

        SetSynchronizedScenePhase(clientScene, 0.99)
        SetEntityCollision(clientContainer, false, true)
        FreezeEntityPosition(clientContainer, true)
    end
end)

local count = 0
local notified = false

function GrabTrain(index, index2)
    ESX.TriggerServerCallback('trainheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            grabNowTrain = true
            robberTrain = true
			count = count + 1
            TriggerServerEvent('trainheist:server:grabSync', index, index2)
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            animDict = 'anim@scripted@heist@ig1_table_grab@gold@male@'
            loadAnimDict(animDict)
            
            loadModel('hei_p_m_bag_var22_arm_s')
            bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pedCo, 1, 1, 0)
            sceneObject = GetClosestObjectOfType(pedCo, 2.0, GetHashKey('h4_prop_h4_gold_stack_01a'), false, false, false)
            NetworkRegisterEntityAsNetworked(sceneObject)
        
            for i = 1, #GrabGoldTrain['animations'] do
                GrabGoldTrain['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, GrabGoldTrain['scenes'][i], animDict, GrabGoldTrain['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(bag, GrabGoldTrain['scenes'][i], animDict, GrabGoldTrain['animations'][i][2], 1.0, -1.0, 1148846080)
                if i == 2 then
                    NetworkAddEntityToSynchronisedScene(sceneObject, GrabGoldTrain['scenes'][i], animDict, 'grab_gold', 1.0, -1.0, 1148846080)
                end
            end
        
            NetworkStartSynchronisedScene(GrabGoldTrain['scenes'][1])
            Wait(GetAnimDuration(animDict, 'enter') * 1000)
            NetworkStartSynchronisedScene(GrabGoldTrain['scenes'][2])
            Wait(GetAnimDuration(animDict, 'grab') * 1000 - 2250)
            TriggerServerEvent('trainheist:server:objectSync', NetworkGetNetworkIdFromEntity(sceneObject))
            TriggerServerEvent('trainheist:server:rewardItems')
            NetworkStartSynchronisedScene(GrabGoldTrain['scenes'][4])
            Wait(GetAnimDuration(animDict, 'exit_bag') * 1000)
            
            ClearPedTasks(ped)
            DeleteObject(bag)
            grabNowTrain = false
			if not notified and count == 4 then
				ShowNotification(StringsTrain['foge_do_local'], 'info')
				notified = true
				count = 0
			end
        else
            ShowNotification(StringsTrain['need_this'] .. itemLabel, 'error')
        end
    end, Config['TrainHeist']['requiredItems'][2])
end

RegisterNetEvent('trainheist:client:showNotification')
AddEventHandler('trainheist:client:showNotification', function(str, type)
    ShowNotification(str, type)
end)

--Thanks to d0p3t
function PlayCutsceneTrain(cut, coords)
    while not HasThisCutsceneLoaded(cut) do 
        RequestCutscene(cut, 8)
        Wait(0) 
    end
    CreateCutscene(false, coords)
    Finish()
    RemoveCutscene()
    DoScreenFadeIn(500)
end

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        DeleteVehicle(mainTrain)
        DeleteVehicle(trainPart)
        ClearArea(2885.97, 4560.83, 48.0551, 50.0)
    end
end)