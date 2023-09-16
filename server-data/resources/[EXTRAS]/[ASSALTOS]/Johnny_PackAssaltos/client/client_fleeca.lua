FleecaHeist = {
    ['scenePed'] = {},
    ['trolly'] = {}
}
grabNowFleeca = false
mainLoopFleeca = {}

Citizen.CreateThread(function()
    for k, v in pairs(Config['FleecaHeist']) do
        local ped = v['scenePed']
        loadModel(ped['model'])
        FleecaHeist['scenePed'][k] = CreatePed(4, GetHashKey(ped['model']), ped['coords'], ped['heading'], 0, 0)
        SetBlockingOfNonTemporaryEvents(FleecaHeist['scenePed'][k], true)
        SetEntityInvincible(FleecaHeist['scenePed'][k], true)
        SetPedCanRagdoll(FleecaHeist['scenePed'][k], false)
    end
end)

--[[
Citizen.CreateThread(function()
	for k, v in pairs(Config['FleecaHeist']) do
		local blip = AddBlipForCoord(v['scenePos'])
		SetBlipSprite(blip, 156)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Banco Roubável")
		EndTextCommandSetBlipName(blip)
	end
end)
--]]

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000

        for k, v in pairs(Config['FleecaHeist']) do
            local dist = #(pedCo - v['scenePos'])
            if dist <= 10.0 then
                sleep = 1
                if IsPedShooting(ped) then
                    StartFleecaHeist(k)
                    Wait(5000)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function StartFleecaHeist(index)
    ESX.TriggerServerCallback('fleecaheist:server:checkPoliceCount', function(status)
        if status then
            ESX.TriggerServerCallback('fleecaheist:server:checkTime', function(time)
                if time then
                    local ped = PlayerPedId()
                    local pedCo = GetEntityCoords(ped)
                    local animDict = 'mp_missheist_ruralbank'
                    local sceneData = Config['FleecaHeist'][index]
                    loadAnimDict(animDict)
        
                    DeletePed(FleecaHeist['scenePed'][index])
                    local scenePed = Config['FleecaHeist'][index]['scenePed']
                    loadModel(scenePed['model'])
                    x = CreatePed(4, GetHashKey(scenePed['model']), scenePed['coords'], scenePed['heading'], 1, 0)
                    SetEntityAsMissionEntity(x, false, true)
                    SetBlockingOfNonTemporaryEvents(x, true)
                    SetEntityInvincible(x, true)
                    SetPedCanRagdoll(x, false)
                    local netid = NetworkGetNetworkIdFromEntity(x)
                    SetNetworkIdCanMigrate(netid, true)
                    SetNetworkIdExistsOnAllMachines(netid, true)
                
                    heistScene = NetworkCreateSynchronisedScene(sceneData['scenePos'], sceneData['sceneRot'], 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(x, heistScene, animDict, 'heist_ruralbank_male', 4.0, -4.0, 1033, 0, 1000.0, 0)
        
                    NetworkStartSynchronisedScene(heistScene)
                    SetupVaultFleeca(index)
                    TriggerServerEvent('fleecaheist:server:doorSync', index)
                    TriggerServerEvent('fleecaheist:server:policeAlert', pedCo)
                    Wait(GetAnimDuration(animDict, 'heist_ruralbank_male') * 1000 - 2000)
                    loadAnimDict('missminuteman_1ig_2')
                    TaskPlayAnim(x, 'missminuteman_1ig_2', 'handsup_enter', 8.0, 8.0, -1, 50, 0, 0, 0, 0)
                    TaskGoToCoordAnyMeans(x, Config['FleecaHeist'][index]['scenePedWalkCoords'], 1.0, 0, 0, 786603, 0xbf800000)
                    Wait(5000)
                    SetEntityCoords(x, Config['FleecaHeist'][index]['scenePedWalkCoords'])
                end
            end, index)
        end
    end)
end

function SetupVaultFleeca(index)
    local randomStack = Config['FleecaMain']['grabReward']()
    if randomStack == 'gold' then
        cash = CreateObject(GetHashKey('h4_prop_h4_gold_stack_01a'), Config['FleecaHeist'][index]['grab']['pos'].x, Config['FleecaHeist'][index]['grab']['pos'].y, Config['FleecaHeist'][index]['grab']['pos'].z +0.1, 1, 0, 0)
        suporte = CreateObject(GetHashKey('prop_gold_trolly'), Config['FleecaHeist'][index]['grab']['pos'].x, Config['FleecaHeist'][index]['grab']['pos'].y, Config['FleecaHeist'][index]['grab']['pos'].z - 0.8, 1, 0, 0)
        --cash = CreateObject(GetHashKey('ch_prop_gold_trolly_01c'), Config['FleecaHeist'][index]['grab']['pos'].x, Config['FleecaHeist'][index]['grab']['pos'].y, Config['FleecaHeist'][index]['grab']['pos'].z - 1.0, 1, 0, 0)
        TriggerServerEvent('fleecaheist:server:grabSync', index, GetHashKey('h4_prop_h4_gold_stack_01a'))
    else
        cash = CreateObject(GetHashKey('h4_prop_h4_cash_stack_01a'), Config['FleecaHeist'][index]['grab']['pos'].x, Config['FleecaHeist'][index]['grab']['pos'].y, Config['FleecaHeist'][index]['grab']['pos'].z +0.1, 1, 0, 0)
		suporte = CreateObject(GetHashKey('hei_prop_hei_cash_trolly_03'), Config['FleecaHeist'][index]['grab']['pos'].x, Config['FleecaHeist'][index]['grab']['pos'].y, Config['FleecaHeist'][index]['grab']['pos'].z - 0.8, 1, 0, 0)
        --cash = CreateObject(GetHashKey('ch_prop_ch_cash_trolly_01c'), Config['FleecaHeist'][index]['grab']['pos'].x, Config['FleecaHeist'][index]['grab']['pos'].y, Config['FleecaHeist'][index]['grab']['pos'].z - 1.0, 1, 0, 0)
        TriggerServerEvent('fleecaheist:server:grabSync', index, GetHashKey('h4_prop_h4_cash_stack_01a'))
    end
    SetEntityHeading(cash, Config['FleecaHeist'][index]['grab']['heading'])
    SetEntityHeading(suporte, Config['FleecaHeist'][index]['grab']['heading'])
	
    for k,v in pairs(Config['FleecaHeist'][index]['trollys']) do
        local randomTrolly = Config['FleecaMain']['trollyReward']()
        if randomTrolly == 'diamond' then
            FleecaHeist['trolly'][k] = CreateObject(881130828, v['coords'], 1, 0, 0)
            TriggerServerEvent('fleecaheist:server:modelSync', index, k, 881130828)
        elseif randomTrolly == 'gold' then
            FleecaHeist['trolly'][k] = CreateObject(2007413986, v['coords'], 1, 0, 0)
            TriggerServerEvent('fleecaheist:server:modelSync', index, k, 2007413986)
        elseif randomTrolly == 'cash' then
            FleecaHeist['trolly'][k] = CreateObject(269934519, v['coords'], 1, 0, 0)
            TriggerServerEvent('fleecaheist:server:modelSync', index, k, 269934519)
        end
        SetEntityHeading(FleecaHeist['trolly'][k], v['heading'])
    end
end

RegisterNetEvent('fleecaheist:client:policeAlert')
AddEventHandler('fleecaheist:client:policeAlert', function(targetCoords)
    --ShowNotification(StringsFleeca['police_alert'], 'warn')
    local street = GetStreetAndZone()
	TriggerEvent('police:assaltos', 'Assalto a decorrer num Banco', targetCoords, street)
	local alpha = 250
    local nappingBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(nappingBlip, true)
    SetBlipColour(nappingBlip, 1)
    SetBlipAlpha(nappingBlip, alpha)
    SetBlipAsShortRange(nappingBlip, true)

    while alpha ~= 0 do
        Citizen.Wait(500)
        alpha = alpha - 1
        SetBlipAlpha(nappingBlip, alpha)

        if alpha == 0 then
            RemoveBlip(nappingBlip)
            return
        end
    end
end)

RegisterNetEvent('fleecaheist:client:grabSync')
AddEventHandler('fleecaheist:client:grabSync', function(index, model)
    Config['FleecaHeist'][index]['grab']['model'] = model
end)

RegisterNetEvent('fleecaheist:client:modelSync')
AddEventHandler('fleecaheist:client:modelSync', function(index, k, model)
    Config['FleecaHeist'][index]['trollys'][k]['model'] = model
end)

RegisterNetEvent('fleecaheist:client:doorSync')
AddEventHandler('fleecaheist:client:doorSync', function(index)
    local object1 = GetClosestObjectOfType(Config['FleecaHeist'][index]['scenePos'], 50.0, GetHashKey('v_ilev_gb_teldr'), 1, 0, 0)
    local object2 = GetClosestObjectOfType(Config['FleecaHeist'][index]['scenePos'], 50.0, GetHashKey('hei_prop_heist_sec_door'), 1, 0, 0)
    if object2 == 0 then
        object2 = GetClosestObjectOfType(Config['FleecaHeist'][index]['scenePos'], 50.0, GetHashKey('v_ilev_gb_vauldr'), 1, 0, 0)
    end
    Wait(8000)
    repeat
        SetEntityHeading(object1, GetEntityHeading(object1) - 0.5)
        Wait(10)
    until GetEntityHeading(object1) <= Config['FleecaHeist'][index]['doorHeading'][1]
    Wait(11500)
    repeat
        SetEntityHeading(object2, GetEntityHeading(object2) - 0.5)
        Wait(10)
    until GetEntityHeading(object2) <= Config['FleecaHeist'][index]['doorHeading'][2]
    mainLoopFleeca = true
    while mainLoopFleeca do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local bankDist = #(pedCo - Config['FleecaHeist'][index]['scenePos'])
        local grabDist = #(pedCo - Config['FleecaHeist'][index]['grab']['pos'])

        if bankDist >= 30.0 and robberFleeca then
            OutsideFleeca(index)
            break
        end
        if not Config['FleecaHeist'][index]['grab']['loot'] then
            if grabDist <= 1.0 then
                if not grabNowFleeca then
                    ShowHelpNotification(StringsFleeca['grab'])
                    if IsControlJustPressed(0, 38) then
                        GrabFleeca(index)
                    end
                end
            end
        end
        for k,v in pairs(Config['FleecaHeist'][index]['trollys']) do
            if not v['loot'] then
                local trollyDist = #(pedCo - v['coords'])
                if trollyDist <= 1.5 then
                    if not grabNowFleeca then
                        ShowHelpNotification(StringsFleeca['grab_trolly'])
                        if IsControlJustPressed(0, 38) then
                            GrabTrollyFleeca(index, k)
                        end
                    end
                end
            end
        end
        for k,v in pairs(Config['FleecaHeist'][index]['drills']) do
            if not v['loot'] then
                local drillDist = #(pedCo - v['coords'])
                if drillDist <= 1.0 then
                    if not grabNowFleeca then
                        ShowHelpNotification(StringsFleeca['drill'])
                        if IsControlJustPressed(0, 38) then
                            DrillFleeca(index, k)
                        end
                    end
                end
            end
        end
        Wait(1)
    end
end)

RegisterNetEvent('fleecaheist:client:lootSync')
AddEventHandler('fleecaheist:client:lootSync', function(index, type, k)
    if k then 
        Config['FleecaHeist'][index][type][k]['loot'] = not Config['FleecaHeist'][index][type][k]['loot']
    else
        Config['FleecaHeist'][index][type]['loot'] = not Config['FleecaHeist'][index][type]['loot']
    end
end)

function OutsideFleeca(index)
    ShowNotification(StringsFleeca['deliver_to_buyer'], 'info')
    --loadModel('baller')
    buyerBlip = addBlip(Config['FleecaMain']['finishHeist']['buyerPos'], 500, 0, StringsFleeca['buyer_blip'])
    --buyerVehicle = CreateVehicle(GetHashKey('baller'), Config['FleecaMain']['finishHeist']['buyerPos'].xy + 5.0, Config['FleecaMain']['finishHeist']['buyerPos'].z, 269.4, 0, 0)
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['FleecaMain']['finishHeist']['buyerPos'])

        if dist <= 15.0 then
            PlayCutsceneFleeca('hs3f_all_drp3', Config['FleecaMain']['finishHeist']['buyerPos'])
            --DeleteVehicle(buyerVehicle)
            RemoveBlip(buyerBlip)
            TriggerServerEvent('fleecaheist:server:sellRewardItems')
            break
        end
        Wait(1)
    end
end

RegisterNetEvent('fleecaheist:client:nearBank')
AddEventHandler('fleecaheist:client:nearBank', function()
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    local index = nil
    for k, v in pairs(Config['FleecaHeist']) do
        local dist = #(pedCo - v['scenePos'])
        if dist <= 20.0 then
            index = k
        end
    end

    if index ~= nil then
        TriggerServerEvent('fleecaheist:server:resetHeist', index)
    else
        ShowNotification('Não estás em nenhum Banco Fleeca!', 'error')
    end
end)

RegisterNetEvent('fleecaheist:client:resetHeist')
AddEventHandler('fleecaheist:client:resetHeist', function(index)
    local object1 = GetClosestObjectOfType(Config['FleecaHeist'][index]['scenePos'], 50.0, GetHashKey('v_ilev_gb_teldr'), 1, 0, 0)
    local object2 = GetClosestObjectOfType(Config['FleecaHeist'][index]['scenePos'], 50.0, GetHashKey('hei_prop_heist_sec_door'), 1, 0, 0)
    if object2 == 0 then
        object2 = GetClosestObjectOfType(Config['FleecaHeist'][index]['scenePos'], 50.0, GetHashKey('v_ilev_gb_vauldr'), 1, 0, 0)
    end
    SetEntityHeading(object1, Config['FleecaHeist'][index]['doorHeading'][1] + 55.0)
    SetEntityHeading(object2, Config['FleecaHeist'][index]['doorHeading'][2] + 55.0)
    if DoesEntityExist(x) then
        DeletePed(x)
    end
    for k, v in pairs(Config['FleecaHeist'][index]['trollys']) do
        local object =  GetClosestObjectOfType(v['coords'], 1.0, 881130828, false, false, false)
        local object2 = GetClosestObjectOfType(v['coords'], 1.0, 2007413986, false, false, false)
        local object3 = GetClosestObjectOfType(v['coords'], 1.0, 269934519, false, false, false)
        local object4 = GetClosestObjectOfType(v['coords'], 1.0, 769923921, false, false, false)

        if DoesEntityExist(object) then 
            DeleteEntity(object)
        end
        if DoesEntityExist(object2) then 
            DeleteEntity(object2)
        end
        if DoesEntityExist(object3) then 
            DeleteEntity(object3)
        end
        if DoesEntityExist(object4) then 
            DeleteEntity(object4)
        end
    end
    for k, v in pairs(Config['FleecaHeist'][index]['drills']) do
        v['loot'] = false
    end
    for k, v in pairs(Config['FleecaHeist'][index]['trollys']) do
        v['loot'] = false
    end
    Config['FleecaHeist'][index]['grab']['loot'] = false
    mainLoopFleeca = false
end)

function GrabFleeca(index)
    ESX.TriggerServerCallback('fleecaheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            grabNowFleeca = true
            robberFleeca = true
            TriggerServerEvent('fleecaheist:server:lootSync', index, 'grab')
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = ''

            local stackModel = Config['FleecaHeist'][index]['grab']['model']
			
            if stackModel == -180074230 then
                animDict = 'anim@scripted@heist@ig1_table_grab@gold@male@'
                loadAnimDict(animDict)
            else
                animDict = 'anim@scripted@heist@ig1_table_grab@cash@male@'
                loadAnimDict(animDict)
            end
            
            loadModel('hei_p_m_bag_var22_arm_s')
            bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pedCo, 1, 1, 0)
            sceneObject = GetClosestObjectOfType(Config['FleecaHeist'][index]['grab']['pos'], 2.0, stackModel, false, false, false)

            for i = 1, #GrabCashFleeca['animations'] do
                GrabCashFleeca['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, GrabCashFleeca['scenes'][i], animDict, GrabCashFleeca['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(bag, GrabCashFleeca['scenes'][i], animDict, GrabCashFleeca['animations'][i][2], 1.0, -1.0, 1148846080)
                if i == 2 then
                    if stackModel == -180074230 then
                        NetworkAddEntityToSynchronisedScene(sceneObject, GrabCashFleeca['scenes'][i], animDict, 'grab_gold', 1.0, -1.0, 1148846080)
                    else
                        NetworkAddEntityToSynchronisedScene(sceneObject, GrabCashFleeca['scenes'][i], animDict, GrabCashFleeca['animations'][i][3], 1.0, -1.0, 1148846080)
                    end
                end
            end

            NetworkStartSynchronisedScene(GrabCashFleeca['scenes'][1])
            Wait(GetAnimDuration(animDict, 'enter') * 1000)
            NetworkStartSynchronisedScene(GrabCashFleeca['scenes'][2])
            Wait(GetAnimDuration(animDict, 'grab') * 1000 - 3000)
            DeleteObject(sceneObject)
            if stackModel == -180074230 then
                TriggerServerEvent('fleecaheist:server:rewardItem', Config['FleecaMain']['rewardItems']['goldTrolly'], Config['FleecaMain']['rewardItems']['goldTrolly']['multiGrabCount'])
            else
                TriggerServerEvent('fleecaheist:server:rewardItem', Config['FleecaMain']['rewardItems']['cashTrolly'], Config['FleecaMain']['rewardItems']['cashTrolly']['multiGrabCount'])
            end
            NetworkStartSynchronisedScene(GrabCashFleeca['scenes'][4])
            Wait(GetAnimDuration(animDict, 'exit') * 1000)
            
            ClearPedTasks(ped)
            DeleteObject(bag)
            grabNowFleeca = false
        else
            ShowNotification(StringsFleeca['need_item'] .. itemLabel, 'error')
        end
    end, Config['FleecaMain']['requiredItems'][2])
end

function GrabTrollyFleeca(index, k)
    ESX.TriggerServerCallback('fleecaheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            grabNowFleeca = true
            robberFleeca = true
            TriggerServerEvent('fleecaheist:server:lootSync', index, 'trollys', k)
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
            local trollyModel = Config['FleecaHeist'][index]['trollys'][k]['model']
            local animDict = 'anim@heists@ornate_bank@grab_cash'
            if trollyModel == 881130828 then
                grabModel = 'ch_prop_vault_dimaondbox_01a'
            elseif trollyModel == 2007413986 then
                grabModel = 'ch_prop_gold_bar_01a'
            else
                grabModel = 'hei_prop_heist_cash_pile'
            end
            loadAnimDict(animDict)
            loadModel('hei_p_m_bag_var22_arm_s')

            sceneObject = GetClosestObjectOfType(Config['FleecaHeist'][index]['trollys'][k]['coords'], 2.0, trollyModel, 0, 0, 0)
            bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pedCo, true, false, false)

            while not NetworkHasControlOfEntity(sceneObject) do
                Citizen.Wait(1)
                NetworkRequestControlOfEntity(sceneObject)
            end

            for i = 1, #TrollyFleeca['animations'] do
                TrollyFleeca['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, TrollyFleeca['scenes'][i], animDict, TrollyFleeca['animations'][i][1], 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(bag, TrollyFleeca['scenes'][i], animDict, TrollyFleeca['animations'][i][2], 4.0, -8.0, 1)
                if i == 2 then
                    NetworkAddEntityToSynchronisedScene(sceneObject, TrollyFleeca['scenes'][i], animDict, "cart_cash_dissapear", 4.0, -8.0, 1)
                end
            end

            NetworkStartSynchronisedScene(TrollyFleeca['scenes'][1])
            Wait(1750)
            CashAppearFleeca(grabModel)
            NetworkStartSynchronisedScene(TrollyFleeca['scenes'][2])
            Wait(37000)
            NetworkStartSynchronisedScene(TrollyFleeca['scenes'][3])
            Wait(2000)

            local emptyobj = 769923921
            newTrolly = CreateObject(emptyobj, Config['FleecaHeist'][index]['trollys'][k]['coords'], true, false, false)
            SetEntityRotation(newTrolly, 0, 0, GetEntityHeading(sceneObject), 1, 0)
            DeleteObject(sceneObject)
            DeleteObject(bag)
            grabNowFleeca = false
        else
            ShowNotification(StringsFleeca['need_item'] .. itemLabel, 'error')
        end
    end, Config['FleecaMain']['requiredItems'][2])
end

function CashAppearFleeca(grabModel)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    if grabModel == 'ch_prop_vault_dimaondbox_01a' then
        reward = Config['FleecaMain']['rewardItems']['diamondTrolly']
    elseif grabModel == 'ch_prop_gold_bar_01a' then
        reward = Config['FleecaMain']['rewardItems']['goldTrolly']
    elseif grabModel == 'hei_prop_heist_cash_pile' then
        reward = Config['FleecaMain']['rewardItems']['cashTrolly']
    end

    local grabmodel = GetHashKey(grabModel)

    loadModel(grabmodel)
    local grabobj = CreateObject(grabmodel, pedCoords, true)

    FreezeEntityPosition(grabobj, true)
    SetEntityInvincible(grabobj, true)
    SetEntityNoCollisionEntity(grabobj, ped)
    SetEntityVisible(grabobj, false, false)
    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local startedGrabbing = GetGameTimer()

    Citizen.CreateThread(function()
        while GetGameTimer() - startedGrabbing < 37000 do
            Citizen.Wait(1)
            DisableControlAction(0, 73, true)
            if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
                if not IsEntityVisible(grabobj) then
                    SetEntityVisible(grabobj, true, false)
                end
            end
            if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                if IsEntityVisible(grabobj) then
                    SetEntityVisible(grabobj, false, false)
                    TriggerServerEvent('fleecaheist:server:rewardItem', reward)
                end
            end
        end
        DeleteObject(grabobj)
    end)
end

function DrillFleeca(index, k)
    ESX.TriggerServerCallback('fleecaheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            ESX.TriggerServerCallback('fleecaheist:server:hasItem', function(hasItem2, itemLabel2)
                if hasItem2 then
                    grabNowFleeca = true
                    robberFleeca = true
                    TriggerServerEvent('fleecaheist:server:lootSync', index, 'drills', k)
                    local ped = PlayerPedId()
                    local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
                    local animDict = 'anim_heist@hs3f@ig9_vault_drill@laser_drill@'
                    loadAnimDict(animDict)
                    local bagModel = 'hei_p_m_bag_var22_arm_s'
                    loadModel(bagModel)
                    local laserDrillModel = 'hei_prop_heist_drill'
                    loadModel(laserDrillModel)

                    RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
                    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
                    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)

                    soundId = GetSoundId()

                    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
                    SetCamActive(cam, true)
                    RenderScriptCams(true, 0, 3000, 1, 0)

                    bag = CreateObject(GetHashKey(bagModel), pedCo, 1, 0, 0)
                    laserDrill = CreateObject(GetHashKey(laserDrillModel), pedCo, 1, 0, 0)
                    
                    vaultPos = Config['FleecaHeist'][index]['drills'][k]['coords']
                    vaultRot = Config['FleecaHeist'][index]['drills'][k]['rotation']

                    for i = 1, #LaserDrillFleeca['animations'] do
                        LaserDrillFleeca['scenes'][i] = NetworkCreateSynchronisedScene(vaultPos, vaultRot, 2, true, false, 1065353216, 0, 1.3)
                        NetworkAddPedToSynchronisedScene(ped, LaserDrillFleeca['scenes'][i], animDict, LaserDrillFleeca['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                        NetworkAddEntityToSynchronisedScene(bag, LaserDrillFleeca['scenes'][i], animDict, LaserDrillFleeca['animations'][i][2], 1.0, -1.0, 1148846080)
                        NetworkAddEntityToSynchronisedScene(laserDrill, LaserDrillFleeca['scenes'][i], animDict, LaserDrillFleeca['animations'][i][3], 1.0, -1.0, 1148846080)
                    end

                    NetworkStartSynchronisedScene(LaserDrillFleeca['scenes'][1])
                    PlayCamAnim(cam, 'intro_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'intro') * 1000)
                    
                    NetworkStartSynchronisedScene(LaserDrillFleeca['scenes'][2])
                    PlayCamAnim(cam, 'drill_straight_start_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'drill_straight_start') * 1000)
                    
                    NetworkStartSynchronisedScene(LaserDrillFleeca['scenes'][3])
                    PlayCamAnim(cam, 'drill_straight_idle_cam', animDict, vaultPos, vaultRot, 0, 2)
                    PlaySoundFromEntity(soundId, "Drill", laserDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
                    Drilling.Start(function(status)
                        if status then
                            StopSound(soundId)
                            NetworkStartSynchronisedScene(LaserDrillFleeca['scenes'][5])
                            PlayCamAnim(cam, 'drill_straight_end_cam', animDict, vaultPos, vaultRot, 0, 2)
                            Wait(GetAnimDuration(animDict, 'drill_straight_end') * 1000)
                            NetworkStartSynchronisedScene(LaserDrillFleeca['scenes'][6])
                            TriggerServerEvent('fleecaheist:server:rewardItem', Config['FleecaMain']['rewardItems']['lockbox']())
                            PlayCamAnim(cam, 'exit_cam', animDict, vaultPos, vaultRot, 0, 2)
                            Wait(GetAnimDuration(animDict, 'exit') * 1000)
                            RenderScriptCams(false, false, 0, 1, 0)
                            DestroyCam(cam, false)
                            ClearPedTasks(ped)
                            DeleteObject(bag)
                            DeleteObject(laserDrill)
                            grabNowFleeca = false
                        else
                            StopSound(soundId)
                            NetworkStartSynchronisedScene(LaserDrillFleeca['scenes'][4])
                            PlayCamAnim(cam, 'drill_straight_fail_cam', animDict, vaultPos, vaultRot, 0, 2)
                            Wait(GetAnimDuration(animDict, 'drill_straight_fail') * 1000 - 1500)
                            RenderScriptCams(false, false, 0, 1, 0)
                            DestroyCam(cam, false)
                            ClearPedTasks(ped)
                            DeleteObject(bag)
                            DeleteObject(laserDrill)
                            TriggerServerEvent('fleecaheist:server:lootSync', index, 'drills', k)
                            grabNowFleeca = false
                        end
                    end)
                else
                    ShowNotification(StringsFleeca['need_item'] .. itemLabel2, 'error')
                end
            end, Config['FleecaMain']['requiredItems'][2])
        else
            ShowNotification(StringsFleeca['need_item'] .. itemLabel, 'error')
        end
    end, Config['FleecaMain']['requiredItems'][1])
end

RegisterNetEvent('fleecaheist:client:showNotification')
AddEventHandler('fleecaheist:client:showNotification', function(str, type)
    ShowNotification(str, type)
end)

--Thanks to d0p3t
function PlayCutsceneFleeca(cut, coords)
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
        for k, v in pairs(FleecaHeist['scenePed']) do
            DeletePed(v)
        end
    end
end)