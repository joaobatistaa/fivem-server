PacificHeist = {
    ['start'] = false,
    ['startPeds'] = {}
}
Stacks = {}
GlassCutting = {
    ['globalObject'] = nil,
    ['globalItem'] = nil
}
VaultCheck = {
    ['laptop'] = false,
    ['drill'] = false
}
Cutting = {
    ['painting'] = {}
}
Trollys = {}
ClientScenes = {
    ['objects'] = {},
    ['scenes'] = {}
}
ClientDoors = {}

Citizen.CreateThread(function()
    for k, v in pairs(Config['PacificHeist']['startHeist']['peds']) do
        loadModel(v['ped'])
        PacificHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(PacificHeist['startPeds'][k], true)
        SetEntityInvincible(PacificHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(PacificHeist['startPeds'][k], true)
    end
end)

--[[
Citizen.CreateThread(function()
	--for _, heist in pairs(Config.FleecaHeist) do
		local blip = AddBlipForCoord(Config['PacificHeist']['startHeist']['pos'])
		SetBlipSprite(blip, 156)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Assalto ao Banco Principal")
		EndTextCommandSetBlipName(blip)
	--end
end)
--]]

RegisterNetEvent('pacificheist:client:startHeist')
AddEventHandler('pacificheist:client:startHeist', function()
    PacificHeist['start'] = true
end)

RegisterNetEvent('pacificheist:client:policeAlert')
AddEventHandler('pacificheist:client:policeAlert', function(targetCoords)
    --ShowNotification(StringsPacific['police_alert'], 'warn')
	local street = GetStreetAndZone()
	TriggerEvent('police:assaltos', 'Assalto a decorrer no Banco Principal', targetCoords, street)
    local alpha = 250
    local pacificBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(pacificBlip, true)
    SetBlipColour(pacificBlip, 1)
    SetBlipAlpha(pacificBlip, alpha)
    SetBlipAsShortRange(pacificBlip, true)

    while alpha ~= 0 do
        Citizen.Wait(500)
        alpha = alpha - 1
        SetBlipAlpha(pacificBlip, alpha)

        if alpha == 0 then
            RemoveBlip(pacificBlip)
            return
        end
    end
end)

function StartHeistPacific()
    ESX.TriggerServerCallback('pacificheist:server:checkPoliceCount', function(status)
        if status then
            ESX.TriggerServerCallback('pacificheist:server:checkTime', function(time)
                if time then
                    ShowNotification(StringsPacific['start_heist'], 'info')
                    ShowNotification(StringsPacific['start_heist2'], 'info')
                    TriggerServerEvent('pacificheist:server:startHeist')
                end
            end)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config['PacificSetup']['freezeDoorList']) do
            ClientDoors[k] = GetClosestObjectOfType(v['pos'], 5.0, v['model'], 0, 0, 0)
        end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local startDist = #(pedCo - Config['PacificHeist']['startHeist']['pos'])
        if startDist <= 2.0 then
            sleep = 1
            ShowHelpNotification(StringsPacific['e_start'])
            if IsControlJustPressed(0, 38) then
                StartHeistPacific()
            end
        end
        for k, v in pairs(Config['PacificSetup']['freezeDoorList']) do
            local dist = #(pedCo - v['pos'])
            if dist <= 25.0 then
                sleep = 1
                if v['lock'] then
                    FreezeEntityPosition(ClientDoors[k], true)
                    if v['heading'] ~= nil then
                        SetEntityHeading(ClientDoors[k], v['heading'])
                    end
                    if PacificHeist['start'] and not busy then
                        if dist <= 2.0 then
                            if v['action'] ~= 'vault' then
                                ShowHelpNotification(StringsPacific[v['action']])
                                if IsControlJustPressed(0, 38) then
                                    SelectPacific(k, v['action'])
                                end
                            else
                                if k == 4 and not VaultCheck['drill'] then
                                    ShowHelpNotification(StringsPacific[v['action']])
                                    if IsControlJustPressed(0, 38) then
                                        SelectPacific(k, v['action'])
                                    end
                                elseif k == 8 and not VaultCheck['laptop'] then
                                    ShowHelpNotification(StringsPacific[v['action']])
                                    if IsControlJustPressed(0, 38) then
                                        SelectPacific(k, v['action'])
                                    end
                                end
                            end
                        end
                    end
                else
                    if v['action'] ~= 'vault' then
                        FreezeEntityPosition(ClientDoors[k], false)
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('pacificheist:client:doorSync')
AddEventHandler('pacificheist:client:doorSync', function(index)
    Config['PacificSetup']['freezeDoorList'][index]['lock'] = false
end)

RegisterNetEvent('pacificheist:client:someoneVault')
AddEventHandler('pacificheist:client:someoneVault', function(action)
    VaultCheck[action] = not VaultCheck[action]
end)

function VaultSetupPacific()
    for k, v in pairs(Config['PacificSetup']['trollys']) do
        if k > 4 then
            loadModel(v['model'])
            Trollys[k] = CreateObject(GetHashKey(v['model']), v['pos'], 1, 1, 0)
            SetEntityHeading(Trollys[k], v['heading'])
        end
    end
    loadModel(Config['PacificSetup']['mainStack']['model'])
    mainStack = CreateObject(GetHashKey(Config['PacificSetup']['mainStack']['model']), Config['PacificSetup']['mainStack']['pos'], 1, 1, 0)
    SetEntityHeading(mainStack, Config['PacificSetup']['mainStack']['heading'])
end

RegisterNetEvent('pacificheist:client:vaultLoop')
AddEventHandler('pacificheist:client:vaultLoop', function()
    vaultLoop = true
    Citizen.CreateThread(function()
        while vaultLoop do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local stackDist = #(pedCo - Config['PacificSetup']['mainStack']['pos'])

            if stackDist >= 150.0 and robberPacific then
                OutsidePacific()
                break
            end

            if stackDist <= 1.5 and not Config['PacificSetup']['mainStack']['taken'] then
                ShowHelpNotification(StringsPacific['grab'])
                if IsControlJustPressed(0, 38) then
                    GrabPacific(false)
                end
            end

            for k, v in pairs(Config['PacificSetup']['trollys']) do
                if k > 4 then
                    if not v['taken'] then
                        local dist = #(pedCo - v['pos'])
                        if dist <= 1.5 then
                            ShowHelpNotification(StringsPacific['grab'])
                            if IsControlJustPressed(0, 38) then
                                TrollyPacific(k)
                            end
                        end
                    end
                end
            end

            for k, v in pairs(Config['PacificSetup']['drills']) do
                if not v['taken'] then
                    local dist = #(pedCo - v['pos'])
                    if dist <= 1.5 then
                        ShowHelpNotification(StringsPacific['drill'])
                        if IsControlJustPressed(0, 38) then
                            DrillPacific(k)
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end)

RegisterNetEvent('pacificheist:client:vaultSync')
AddEventHandler('pacificheist:client:vaultSync', function(action, index)
    if action == 'stacks' then
        Config['PacificSetup']['mainStack']['taken'] = true
    elseif action == 'trollys' then
        Config['PacificSetup']['trollys'][index]['taken'] = true
    elseif action == 'drills' then
        Config['PacificSetup']['drills'][index]['taken'] = not Config['PacificSetup']['drills'][index]['taken']
    end
end)

function ExtendedSetupPacific()
    for k, v in pairs(Config['PacificSetup']['stacks']) do
        loadModel(v['model'])
        Stacks[k] = CreateObject(GetHashKey(v['model']), v['pos'], 1, 1, 0)
        SetEntityHeading(Stacks[k], v['heading'])
    end

    local random = math.random(1, 5)
    local glassConfig = Config['PacificSetup']['glassCutting']
    loadModel(glassConfig['rewards'][random]['object']['model'])
    loadModel('h4_prop_h4_glass_disp_01a')
    local glass = CreateObject(GetHashKey('h4_prop_h4_glass_disp_01a'), glassConfig['displayPos'], 1, 1, 0)
    SetEntityHeading(glass, glassConfig['displayHeading'])
    if glassConfig['rewards'][random]['displayObj'] ~= nil then
        local reward = CreateObject(GetHashKey(glassConfig['rewards'][random]['object']['model']), glassConfig['rewardPos'].xy, glassConfig['rewardPos'].z + 0.195, 1, 1, 0)
        SetEntityHeading(reward, glassConfig['rewards'][random]['object']['rot'])
        loadModel(glassConfig['rewards'][random]['displayObj']['model'])
        local rewardDisp = CreateObject(GetHashKey(glassConfig['rewards'][random]['displayObj']['model']), glassConfig['rewardPos'], 1, 1, 0)
        SetEntityRotation(rewardDisp, glassConfig['rewards'][random]['displayObj']['rot'])
    else
        local reward = CreateObject(GetHashKey(glassConfig['rewards'][random]['object']['model']), glassConfig['rewardPos'].xy, glassConfig['rewardPos'].z, 1, 1, 0)
        SetEntityHeading(reward, glassConfig['rewards'][random]['object']['rot'])
    end
    
    TriggerServerEvent('pacificheist:server:globalObject', glassConfig['rewards'][random]['object']['model'], random)

    for k, v in pairs(Config['PacificSetup']['painting']) do
        loadModel(v['object'])
        Cutting['painting'][k] = CreateObjectNoOffset(GetHashKey(v['object']), v['objectPos'], 1, 0, 0)
        SetEntityRotation(Cutting['painting'][k], 0, 0, v['objHeading'], 2, true)
    end
end

RegisterNetEvent('pacificheist:client:extendedSync')
AddEventHandler('pacificheist:client:extendedSync', function(action, index)
    if action == 'stacks' then
        Config['PacificSetup']['stacks'][index]['taken'] = true
    elseif action == 'trollys' then
        Config['PacificSetup']['trollys'][index]['taken'] = true
    elseif action == 'painting' then
        Config['PacificSetup']['painting'][index]['taken'] = true
    elseif action == 'glassCutting' then
        Config['PacificSetup']['glassCutting']['taken'] = true
    elseif action == 'bomb' then
        Config['PacificSetup']['cellGates'][index]['plant'] = true
    end
end)

RegisterNetEvent('pacificheist:client:extendedLoop')
AddEventHandler('pacificheist:client:extendedLoop', function()
    extendedLoop = true
    Citizen.CreateThread(function()
        while extendedLoop do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local sleep = 1
            local glassDist = #(pedCo - Config['PacificSetup']['glassCutting']['displayPos'])

            if glassDist >= 150.0 and robberPacific then
                OutsidePacific()
                break
            end

            if glassDist <= 1.5 and not Config['PacificSetup']['glassCutting']['taken'] then
                ShowHelpNotification(StringsPacific['glass_cut'])
                if IsControlJustPressed(0, 38) then
                    OverheatScenePacific()
                end
            end

            for k, v in pairs(Config['PacificSetup']['cellGates']) do
                if not v['plant'] and not busy then
                    local dist = #(pedCo - v['pos'])
                    if dist <= 1.5 then
                        ShowHelpNotification(StringsPacific['plant_bomb'])
                        if IsControlJustPressed(0, 38) then
                            PlantingAnimPacific('bomb', k, v['pos'], v['rot'])
                        end
                    end
                end
            end
            
            for k, v in pairs(Config['PacificSetup']['stacks']) do
                if not v['taken'] then
                    local dist = #(pedCo - v['pos'])
                    if dist <= 1.5 then
                        ShowHelpNotification(StringsPacific['grab'])
                        if IsControlJustPressed(0, 38) then
                            GrabPacific(k)
                        end
                    end
                end
            end

            for k, v in pairs(Config['PacificSetup']['painting']) do
                local dist = #(pedCo - v['objectPos'])
                if dist <= 1.5 and not v['taken'] and not busy then
                    sleep = 1
                    ShowHelpNotification(StringsPacific['start_stealing'])
                    if IsControlJustPressed(0, 38) then
                        PaintingScenePacific(k)
                    end
                end
            end

            for k, v in pairs(Config['PacificSetup']['trollys']) do
                if k <= 4 then
                    if not v['taken'] then
                        local dist = #(pedCo - v['pos'])
                        if dist <= 1.5 then
                            ShowHelpNotification(StringsPacific['grab'])
                            if IsControlJustPressed(0, 38) then
                                TrollyPacific(k)
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end)

function nearCellGatesPacific()
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    for k, v in pairs(Config['PacificSetup']['cellGates']) do
        if not v['plant'] then
            local dist = #(pedCo - v['pos'])
            if dist <= 1.5 then
                return true
            end
        end
    end
end

function SelectPacific(index, action)
    if action == 'hacking' then
        HackingPacific(index)
    elseif action == 'vault' then
        VaultPacific(index)
    elseif action == 'plant' then
        PlantingAnimPacific('thermite', index, Config['PacificSetup']['freezeDoorList'][index]['scene']['pos'], Config['PacificSetup']['freezeDoorList'][index]['scene']['rot'])
    end
end

function VaultPacific(index)
    if index == 4 then
        LaserPacific(index)
    else
        LaptopHackPacific(index)
    end
end

function LaptopHackPacific(index)
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            TriggerServerEvent('pacificheist:server:someoneVault', 'laptop')
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = 'anim@heists@ornate_bank@hack'
        
            sceneObject = GetClosestObjectOfType(pedCo, 2.0, -160937700, false, false, false)
            scenePos = GetEntityCoords(sceneObject)
            sceneRot = GetEntityRotation(sceneObject)
        
            for k, v in pairs(LaptopAnimationPacific['objects']) do
                loadModel(v)
                LaptopAnimationPacific['sceneObjects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
            end
        
            for i =1, #LaptopAnimationPacific['animations'] do
                LaptopAnimationPacific['scenes'][i] = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, LaptopAnimationPacific['scenes'][i], animDict, LaptopAnimationPacific['animations'][i][1], 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(LaptopAnimationPacific['sceneObjects'][1], LaptopAnimationPacific['scenes'][i], animDict, LaptopAnimationPacific['animations'][i][2], 4.0, -8.0, 1)
                NetworkAddEntityToSynchronisedScene(LaptopAnimationPacific['sceneObjects'][2], LaptopAnimationPacific['scenes'][i], animDict, LaptopAnimationPacific['animations'][i][3], 4.0, -8.0, 1)
                NetworkAddEntityToSynchronisedScene(LaptopAnimationPacific['sceneObjects'][3], LaptopAnimationPacific['scenes'][i], animDict, LaptopAnimationPacific['animations'][i][4], 4.0, -8.0, 1)
            end
        
            NetworkStartSynchronisedScene(LaptopAnimationPacific['scenes'][1])
            Wait(6300)
            NetworkStartSynchronisedScene(LaptopAnimationPacific['scenes'][2])
            Wait(2000)
            StartComputer()
            while not hackFinished do
                Wait(1)
            end
            hackFinished = false
            NetworkStartSynchronisedScene(LaptopAnimationPacific['scenes'][3])
            Wait(4600)
        
            DeleteObject(LaptopAnimationPacific['sceneObjects'][1])
            DeleteObject(LaptopAnimationPacific['sceneObjects'][2])
            DeleteObject(LaptopAnimationPacific['sceneObjects'][3])
        
            TriggerServerEvent('pacificheist:server:someoneVault', 'laptop')
        
            if hackStatus then
                VaultSetupPacific()
                TriggerServerEvent('pacificheist:server:doorSync', index)
                TriggerServerEvent('pacificheist:server:openVault', 1)
                TriggerServerEvent('pacificheist:server:vaultLoop')
                TriggerServerEvent('pacificheist:server:policeAlert', pedCo)
            end
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][6])
end

function LaserPacific(index)
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            TriggerServerEvent('pacificheist:server:someoneVault', 'drill')
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = 'anim_heist@hs3f@ig9_vault_drill@laser_drill@'
            loadAnimDict(animDict)
            local bagModel = 'hei_p_m_bag_var22_arm_s'
            loadModel(bagModel)
            local laserDrillModel = 'ch_prop_laserdrill_01a'
            loadModel(laserDrillModel)

            cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
            SetCamActive(cam, true)
            RenderScriptCams(true, 0, 3000, 1, 0)

            bag = CreateObject(GetHashKey(bagModel), pedCo, 1, 0, 0)
            laserDrill = CreateObject(GetHashKey(laserDrillModel), pedCo, 1, 0, 0)
            
            vaultPos = Config['PacificSetup']['freezeDoorList'][index]['scene']['pos']
            vaultRot = Config['PacificSetup']['freezeDoorList'][index]['scene']['rot']

            for i = 1, #LaserDrillPacific['animations'] do
                LaserDrillPacific['scenes'][i] = NetworkCreateSynchronisedScene(vaultPos, vaultRot, 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, LaserDrillPacific['scenes'][i], animDict, LaserDrillPacific['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(bag, LaserDrillPacific['scenes'][i], animDict, LaserDrillPacific['animations'][i][2], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(laserDrill, LaserDrillPacific['scenes'][i], animDict, LaserDrillPacific['animations'][i][3], 1.0, -1.0, 1148846080)
            end

            NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][1])
            PlayCamAnim(cam, 'intro_cam', animDict, vaultPos, vaultRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'intro') * 1000)

            TriggerServerEvent('pacificheist:server:doorFix', Config['PacificSetup']['freezeDoorList'][index]['model'], Config['PacificSetup']['freezeDoorList'][index]['heading'], Config['PacificSetup']['freezeDoorList'][index]['pos'])
            
            NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][2])
            PlayCamAnim(cam, 'drill_straight_start_cam', animDict, vaultPos, vaultRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'drill_straight_start') * 1000)

            NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][3])
            PlayCamAnim(cam, 'drill_straight_idle_cam', animDict, vaultPos, vaultRot, 0, 2)
            Drilling.Type = 'VAULT_LASER'
            Drilling.Start(function(status)
                if status then
                    NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][5])
                    PlayCamAnim(cam, 'drill_straight_end_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'drill_straight_end') * 1000)
                    NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][6])
                    PlayCamAnim(cam, 'exit_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'exit') * 1000)
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(cam, false)
                    ClearPedTasks(ped)
                    DeleteObject(bag)
                    DeleteObject(laserDrill)
                    ExtendedSetupPacific()
                    TriggerServerEvent('pacificheist:server:doorSync', index)
                    TriggerServerEvent('pacificheist:server:openVault', 2)
                    TriggerServerEvent('pacificheist:server:extendedLoop')
                    TriggerServerEvent('pacificheist:server:policeAlert', pedCo)
                else
                    NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][4])
                    PlayCamAnim(cam, 'drill_straight_fail_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'drill_straight_fail') * 1000 - 1500)
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(cam, false)
                    ClearPedTasks(ped)
                    DeleteObject(bag)
                    DeleteObject(laserDrill)
                    TriggerServerEvent('pacificheist:server:someoneVault', 'drill')
                end
            end)
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][1])
end

RegisterNetEvent('pacificheist:client:openVault')
AddEventHandler('pacificheist:client:openVault', function(index)
    if index == 1 then
        local vault = GetClosestObjectOfType(253.92, 224.56, 101.88, 2.0, GetHashKey('v_ilev_bk_vaultdoor'), 0, 0, 0)
        Citizen.CreateThread(function()
            repeat
                SetEntityHeading(vault, GetEntityHeading(vault) - 0.15)
                Wait(10)
            until GetEntityHeading(vault) <= 75.0
        end)
    else
        local vault = GetClosestObjectOfType(256.518, 240.101, 101.701, 2.0, GetHashKey('ch_prop_ch_vaultdoor01x'), 0, 0, 0)
        Citizen.CreateThread(function()
            repeat
                SetEntityHeading(vault, GetEntityHeading(vault) + 0.15)
                Wait(10)
            until GetEntityHeading(vault) >= 250.0
        end)
    end
end)

function GrabPacific(index)
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            busy = true
            robberPacific = true
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict
            local stackModel
            
            if not index then
                stackModel = GetHashKey('h4_prop_h4_cash_stack_01a')
                animDict = 'anim@scripted@heist@ig1_table_grab@cash@male@'
                loadAnimDict(animDict)
                TriggerServerEvent('pacificheist:server:vaultSync', 'stacks', nil)
            else
                TriggerServerEvent('pacificheist:server:extendedSync', 'stacks', index)
                stackModel = GetHashKey(Config['PacificSetup']['stacks'][index]['model'])
                if stackModel == -180074230 then
                    animDict = 'anim@scripted@heist@ig1_table_grab@gold@male@'
                    loadAnimDict(animDict)
                else
                    animDict = 'anim@scripted@heist@ig1_table_grab@cash@male@'
                    loadAnimDict(animDict)
                end
            end

            loadModel('hei_p_m_bag_var22_arm_s')
            bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), pedCo, 1, 1, 0)
            sceneObject = GetClosestObjectOfType(pedCo, 3.0, stackModel, 0, 0, 0)

            scenePos = GetEntityCoords(sceneObject)
            sceneRot = GetEntityRotation(sceneObject)

            for i = 1, #GrabCashPacific['animations'] do
                GrabCashPacific['scenes'][i] = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, GrabCashPacific['scenes'][i], animDict, GrabCashPacific['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(bag, GrabCashPacific['scenes'][i], animDict, GrabCashPacific['animations'][i][2], 1.0, -1.0, 1148846080)
                if i == 2 then
                    if stackModel == -180074230 then
                        NetworkAddEntityToSynchronisedScene(sceneObject, GrabCashPacific['scenes'][i], animDict, 'grab_gold', 1.0, -1.0, 1148846080)
                    else
                        NetworkAddEntityToSynchronisedScene(sceneObject, GrabCashPacific['scenes'][i], animDict, GrabCashPacific['animations'][i][3], 1.0, -1.0, 1148846080)
                    end
                end
            end

            NetworkStartSynchronisedScene(GrabCashPacific['scenes'][1])
            Wait(GetAnimDuration(animDict, 'enter') * 1000)
            NetworkStartSynchronisedScene(GrabCashPacific['scenes'][2])
            Wait(GetAnimDuration(animDict, 'grab') * 1000 - 3000)
            DeleteObjectSync(sceneObject)
            if stackModel == -180074230 then
                TriggerServerEvent('pacificheist:server:rewardItem', Config['PacificHeist']['rewardItems'][1]['itemName'], Config['PacificHeist']['stackRewards']['gold'], 'item')
            else
                TriggerServerEvent('pacificheist:server:rewardItem', 'nil', Config['PacificHeist']['stackRewards']['money'], 'money')
            end
            NetworkStartSynchronisedScene(GrabCashPacific['scenes'][4])
            Wait(GetAnimDuration(animDict, 'exit') * 1000)
            
            DeleteObject(bag)
            ClearPedTasks(ped)
            busy = false
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][2])
end

function TrollyPacific(index)
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            busy = true
            robberPacific = true
            TriggerServerEvent('pacificheist:server:extendedSync', 'trollys', index)
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
            local grabModel = Config['PacificSetup']['trollys'][index]['model']
            local animDict = 'anim@heists@ornate_bank@grab_cash'
            if grabModel == 'ch_prop_diamond_trolly_01c' then
                grabModel = 'ch_prop_vault_dimaondbox_01a'
            elseif grabModel == 'ch_prop_gold_trolly_01a' then
                grabModel = 'ch_prop_gold_bar_01a'
            elseif grabModel == 'imp_prop_impexp_coke_trolly' then
                grabModel = 'prop_coke_block_half_a'
            else
                grabModel = 'hei_prop_heist_cash_pile'
            end

            loadAnimDict(animDict)
            loadModel('hei_p_m_bag_var22_arm_s')

            if index <= 4 then
                sceneObject = GetClosestObjectOfType(Config['PacificSetup']['trollys'][index]['pos'], 2.0, GetHashKey(Config['PacificSetup']['trollys'][index]['model']), false, false, false)
                NetworkRegisterEntityAsNetworked(sceneObject)
            else
                sceneObject = GetClosestObjectOfType(Config['PacificSetup']['trollys'][index]['pos'], 2.0, GetHashKey(Config['PacificSetup']['trollys'][index]['model']), false, false, false)
            end

            bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pedCo, true, true, false)

            while not NetworkHasControlOfEntity(sceneObject) do
				print(NetworkHasControlOfEntity(sceneObject))
                Citizen.Wait(1)
                NetworkRequestControlOfEntity(sceneObject)
            end

            for i = 1, #TrollyAnimationPacific['animations'] do
				print('a fazer animacoes')
                TrollyAnimationPacific['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, TrollyAnimationPacific['scenes'][i], animDict, TrollyAnimationPacific['animations'][i][1], 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(bag, TrollyAnimationPacific['scenes'][i], animDict, TrollyAnimationPacific['animations'][i][2], 4.0, -8.0, 1)
                if i == 2 then
                    NetworkAddEntityToSynchronisedScene(sceneObject, TrollyAnimationPacific['scenes'][i], animDict, "cart_cash_dissapear", 4.0, -8.0, 1)
                end
            end
			print('test 1 passed')
			print(TrollyAnimationPacific['scenes'][1])
            NetworkStartSynchronisedScene(TrollyAnimationPacific['scenes'][1])
            Wait(1750)
			print('test 2 passed')
            CashAppearPacific(grabModel)
			print('test 3 passed')
			print(TrollyAnimationPacific['scenes'][2])
            NetworkStartSynchronisedScene(TrollyAnimationPacific['scenes'][2])
			print('test 4 passed')
            Wait(37000)
			print('test 5 passed')
			print(TrollyAnimationPacific['scenes'][3])
            NetworkStartSynchronisedScene(TrollyAnimationPacific['scenes'][3])
            Wait(2000)
			print('test 6 passed')
            DeleteObject(bag)
            ClearPedTasks(ped)
			print('test 7 passed')
            busy = false
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][2])
end

function CashAppearPacific(grabModel)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    if grabModel == 'ch_prop_vault_dimaondbox_01a' then
        reward = Config['PacificHeist']['rewardItems'][2]['itemName']
    elseif grabModel == 'ch_prop_gold_bar_01a' then
        reward = Config['PacificHeist']['rewardItems'][1]['itemName']
    elseif grabModel == 'prop_coke_block_half_a' then
        reward = Config['PacificHeist']['rewardItems'][3]['itemName']
    elseif grabModel == 'hei_prop_heist_cash_pile' then
        reward = 'money'
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
                    if reward == 'money' then
                        TriggerServerEvent('pacificheist:server:rewardItem', nil, Config['PacificHeist']['trollyMoneyReward'], 'money')
                    else
                        TriggerServerEvent('pacificheist:server:rewardItem', reward, 1, 'item')
                    end
                end
            end
        end
        DeleteObject(grabobj)
    end)
end

RegisterNetEvent('pacificheist:client:globalObject')
AddEventHandler('pacificheist:client:globalObject', function(object, index)
    GlassCutting['globalObject'] = object
    GlassCutting['globalItem'] = Config['PacificSetup']['glassCutting']['rewards'][index]['item']
end)

function OverheatScenePacific()
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            TriggerServerEvent('pacificheist:server:extendedSync', 'glassCutting', nil)
            robberPacific = true
            busy = true
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = 'anim@scripted@heist@ig16_glass_cut@male@'
            sceneObject = GetClosestObjectOfType(263.925, 260.656, 100.633, 1.0, GetHashKey('h4_prop_h4_glass_disp_01a'), 0, 0, 0)
            scenePos = GetEntityCoords(sceneObject)
            sceneRot = GetEntityRotation(sceneObject)
            globalObj = GetClosestObjectOfType(263.925, 260.656, 100.633, 5.0, GetHashKey(GlassCutting['globalObject']), 0, 0, 0)
            loadAnimDict(animDict)
            RequestScriptAudioBank('DLC_HEI4/DLCHEI4_GENERIC_01', -1)

            cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
            SetCamActive(cam, true)
            RenderScriptCams(true, 0, 3000, 1, 0)

            for k, v in pairs(OverheatPacific['objects']) do
                loadModel(v)
                OverheatPacific['sceneObjects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
            end

            local newObj = CreateObject(GetHashKey('h4_prop_h4_glass_disp_01b'), GetEntityCoords(sceneObject), 1, 1, 0)
            SetEntityHeading(newObj, GetEntityHeading(sceneObject))

            for i = 1, #OverheatPacific['animations'] do
                OverheatPacific['scenes'][i] = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, OverheatPacific['scenes'][i], animDict, OverheatPacific['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(OverheatPacific['sceneObjects'][1], OverheatPacific['scenes'][i], animDict, OverheatPacific['animations'][i][2], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(OverheatPacific['sceneObjects'][2], OverheatPacific['scenes'][i], animDict, OverheatPacific['animations'][i][3], 1.0, -1.0, 1148846080)
                if i ~= 5 then
                    NetworkAddEntityToSynchronisedScene(sceneObject, OverheatPacific['scenes'][i], animDict, OverheatPacific['animations'][i][4], 1.0, -1.0, 1148846080)
                else
                    NetworkAddEntityToSynchronisedScene(newObj, OverheatPacific['scenes'][i], animDict, OverheatPacific['animations'][i][4], 1.0, -1.0, 1148846080)
                end
            end

            local sound1 = GetSoundId()
            local sound2 = GetSoundId()

            NetworkStartSynchronisedScene(OverheatPacific['scenes'][1])
            PlayCamAnim(cam, 'enter_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'enter') * 1000)

            NetworkStartSynchronisedScene(OverheatPacific['scenes'][2])
            PlayCamAnim(cam, 'idle_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'idle') * 1000)

            NetworkStartSynchronisedScene(OverheatPacific['scenes'][3])
            PlaySoundFromEntity(sound1, "StartCutting", OverheatPacific['sceneObjects'][2], 'DLC_H4_anims_glass_cutter_Sounds', true, 80)
            loadPtfxAsset('scr_ih_fin')
            UseParticleFxAssetNextCall('scr_ih_fin')
            fire1 = StartParticleFxLoopedOnEntity('scr_ih_fin_glass_cutter_cut', OverheatPacific['sceneObjects'][2], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1065353216, 0.0, 0.0, 0.0, 1065353216, 1065353216, 1065353216, 0)
            PlayCamAnim(cam, 'cutting_loop_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'cutting_loop') * 1000)
            StopSound(sound1)
            StopParticleFxLooped(fire1)

            NetworkStartSynchronisedScene(OverheatPacific['scenes'][4])
            PlaySoundFromEntity(sound2, "Overheated", OverheatPacific['sceneObjects'][2], 'DLC_H4_anims_glass_cutter_Sounds', true, 80)
            UseParticleFxAssetNextCall('scr_ih_fin')
            fire2 = StartParticleFxLoopedOnEntity('scr_ih_fin_glass_cutter_overheat', OverheatPacific['sceneObjects'][2], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1065353216, 0.0, 0.0, 0.0)
            PlayCamAnim(cam, 'overheat_react_01_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'overheat_react_01') * 1000)
            StopSound(sound2)
            StopParticleFxLooped(fire2)

            DeleteObject(sceneObject)
            NetworkStartSynchronisedScene(OverheatPacific['scenes'][5])
            Wait(2000)
            DeleteObject(globalObj)
            TriggerServerEvent('pacificheist:server:rewardItem', GlassCutting['globalItem'], nil, 'item')
            PlayCamAnim(cam, 'success_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'success') * 1000 - 2000)
            DeleteObject(OverheatPacific['sceneObjects'][1])
            DeleteObject(OverheatPacific['sceneObjects'][2])
            ClearPedTasks(ped)
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            busy = false
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][3])
end

function PaintingScenePacific(sceneId)
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            local ped = PlayerPedId()
            local weapon = GetSelectedPedWeapon(ped)
            if weapon ~= GetHashKey('WEAPON_SWITCHBLADE') then ShowNotification(StringsPacific['need_switchblade'], 'error') return end
            TriggerServerEvent('pacificheist:server:extendedSync', 'painting', sceneId)
            robberPacific = true
            busy = true
            local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
            local scenes = {false, false, false, false}
            local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
            scene = Config['PacificSetup']['painting'][sceneId]
            sceneObject = GetClosestObjectOfType(scene['objectPos'], 1.0, GetHashKey(scene['object']), 0, 0, 0)
            scenePos = scene['scenePos']
            sceneRot = scene['sceneRot']
            loadAnimDict(animDict)
            
            for k, v in pairs(ArtHeistPacific['objects']) do
                loadModel(v)
                ArtHeistPacific['sceneObjects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
            end
            
            for i = 1, 10 do
                ArtHeistPacific['scenes'][i] = NetworkCreateSynchronisedScene(scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 2, true, false, 1065353216, 0, 1065353216)
                NetworkAddPedToSynchronisedScene(ped, ArtHeistPacific['scenes'][i], animDict, 'ver_01_' .. ArtHeistPacific['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(sceneObject, ArtHeistPacific['scenes'][i], animDict, 'ver_01_' .. ArtHeistPacific['animations'][i][3], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(ArtHeistPacific['sceneObjects'][1], ArtHeistPacific['scenes'][i], animDict, 'ver_01_' .. ArtHeistPacific['animations'][i][4], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(ArtHeistPacific['sceneObjects'][2], ArtHeistPacific['scenes'][i], animDict, 'ver_01_' .. ArtHeistPacific['animations'][i][5], 1.0, -1.0, 1148846080)
            end

            cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
            SetCamActive(cam, true)
            RenderScriptCams(true, 0, 3000, 1, 0)
            
            ArtHeistPacific['cuting'] = true
            -- FreezeEntityPosition(ped, true)
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][1])
            PlayCamAnim(cam, 'ver_01_top_left_enter_cam_ble', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][2])
            PlayCamAnim(cam, 'ver_01_cutting_top_left_idle_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            repeat
                ShowHelpNotification(StringsPacific['cute_right'])
                if IsControlJustPressed(0, 38) then
                    scenes[1] = true
                end
                Wait(1)
            until scenes[1] == true
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][3])
            PlayCamAnim(cam, 'ver_01_cutting_top_left_to_right_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][4])
            PlayCamAnim(cam, 'ver_01_cutting_top_right_idle_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            repeat
                ShowHelpNotification(StringsPacific['cute_down'])
                if IsControlJustPressed(0, 38) then
                    scenes[2] = true
                end
                Wait(1)
            until scenes[2] == true
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][5])
            PlayCamAnim(cam, 'ver_01_cutting_right_top_to_bottom_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][6])
            PlayCamAnim(cam, 'ver_01_cutting_bottom_right_idle_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            repeat
                ShowHelpNotification(StringsPacific['cute_left'])
                if IsControlJustPressed(0, 38) then
                    scenes[3] = true
                end
                Wait(1)
            until scenes[3] == true
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][7])
            PlayCamAnim(cam, 'ver_01_cutting_bottom_right_to_left_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            repeat
                ShowHelpNotification(StringsPacific['cute_down'])
                if IsControlJustPressed(0, 38) then
                    scenes[4] = true
                end
                Wait(1)
            until scenes[4] == true
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][9])
            PlayCamAnim(cam, 'ver_01_cutting_left_top_to_bottom_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(1500)
            NetworkStartSynchronisedScene(ArtHeistPacific['scenes'][10])
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            Wait(7500)
            TriggerServerEvent('pacificheist:server:rewardItem', scene['rewardItem'], nil, 'item')
            ClearPedTasks(ped)
            -- FreezeEntityPosition(ped, false)
            RemoveAnimDict(animDict)
            for k, v in pairs(ArtHeistPacific['sceneObjects']) do
                DeleteObject(v)
            end
            DeleteObjectSync(sceneObject)
            ArtHeistPacific['sceneObjects'] = {}
            ArtHeistPacific['scenes'] = {}
            scenes = {false, false, false, false}
            busy = false
            TriggerServerEvent('pacificheist:server:sceneSync', scene['object'], animDict, 'ver_01_with_painting_exit_ch_prop_vault_painting_01a', scenePos, sceneRot)
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][2])
end

function DrillPacific(index)
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            busy = true
            robberPacific = true
            TriggerServerEvent('pacificheist:server:vaultSync', 'drills', index)
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
            
            vaultPos = Config['PacificSetup']['drills'][index]['pos']
            vaultRot = Config['PacificSetup']['drills'][index]['rotation']

            for i = 1, #LaserDrillPacific['animations'] do
                LaserDrillPacific['scenes'][i] = NetworkCreateSynchronisedScene(vaultPos, vaultRot, 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, LaserDrillPacific['scenes'][i], animDict, LaserDrillPacific['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(bag, LaserDrillPacific['scenes'][i], animDict, LaserDrillPacific['animations'][i][2], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(laserDrill, LaserDrillPacific['scenes'][i], animDict, LaserDrillPacific['animations'][i][3], 1.0, -1.0, 1148846080)
            end

            NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][1])
            PlayCamAnim(cam, 'intro_cam', animDict, vaultPos, vaultRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'intro') * 1000)
            
            NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][2])
            PlayCamAnim(cam, 'drill_straight_start_cam', animDict, vaultPos, vaultRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'drill_straight_start') * 1000)
            
            NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][3])
            PlayCamAnim(cam, 'drill_straight_idle_cam', animDict, vaultPos, vaultRot, 0, 2)
            PlaySoundFromEntity(soundId, "Drill", laserDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
            Drilling.Type = 'VAULT_DRILL'
            Drilling.Start(function(status)
                if status then
                    StopSound(soundId)
                    NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][5])
                    PlayCamAnim(cam, 'drill_straight_end_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'drill_straight_end') * 1000)
                    NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][6])
                    rewardItem, rewardCount = Config['PacificHeist']['drillReward']()
                    TriggerServerEvent('pacificheist:server:rewardItem', rewardItem, rewardCount, 'item')
                    PlayCamAnim(cam, 'exit_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'exit') * 1000)
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(cam, false)
                    ClearPedTasks(ped)
                    DeleteObject(bag)
                    DeleteObject(laserDrill)
                    busy = false
                else
                    StopSound(soundId)
                    NetworkStartSynchronisedScene(LaserDrillPacific['scenes'][4])
                    PlayCamAnim(cam, 'drill_straight_fail_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'drill_straight_fail') * 1000 - 1500)
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(cam, false)
                    ClearPedTasks(ped)
                    DeleteObject(bag)
                    DeleteObject(laserDrill)
                    TriggerServerEvent('pacificheist:server:vaultSync', 'drills', index)
                    busy = false
                end
            end)
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][1])
end

local remote = {}
local remoteLoop = false
function PlantingAnimPacific(type, index, pos, rot)
    local itemIndex
    if type == 'bomb' then
        itemIndex = 4
    else
        itemIndex = 5
    end
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            busy = true
            TriggerServerEvent('pacificheist:server:removeItem', Config['PacificHeist']['requiredItems'][itemIndex])
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = 'anim@heists@ornate_bank@thermal_charge'
            loadAnimDict(animDict)
            loadModel(PlantingPacific['objects'][1])
            if type == 'bomb' then
                sceneObjectModel = 'prop_bomb_01'
            else
                sceneObjectModel = 'hei_prop_heist_thermite'
            end
            loadModel(sceneObjectModel)

            bag = CreateObject(GetHashKey(PlantingPacific['objects'][1]), pedCo, 1, 1, 0)
            SetEntityCollision(bag, false, true)
            PlantingPacific['scenes'][1] = NetworkCreateSynchronisedScene(pos, rot, 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, PlantingPacific['scenes'][1], animDict, PlantingPacific['animations'][1][1], 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, PlantingPacific['scenes'][1], animDict, PlantingPacific['animations'][1][2], 4.0, -8.0, 1)

            NetworkStartSynchronisedScene(PlantingPacific['scenes'][1])
            Wait(1500)
            plantObject = CreateObject(GetHashKey(sceneObjectModel), pedCo, 1, 1, 0)
            SetEntityCollision(plantObject, false, true)
            AttachEntityToEntity(plantObject, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0.0, 0.0, 200.0, true, true, false, true, 1, true)
            if type == 'bomb' then
                Wait(3000)
                TriggerServerEvent('pacificheist:server:extendedSync', 'bomb', index)
                DeleteObject(bag)
                DetachEntity(plantObject, 1, 1)
                FreezeEntityPosition(plantObject, true)
                table.insert(remote, {object = plantObject, coords = GetEntityCoords(plantObject)})
                busy = false
                if not remoteLoop then
                    remoteLoop = true
                    Citizen.CreateThread(function()
                        pressed = false
                        repeat
                            if not nearCellGatesPacific() then
                                ShowHelpNotification(StringsPacific['detonate_bombs'])
                                if IsControlJustPressed(0, 38) then
                                    loadAnimDict('anim@mp_player_intmenu@key_fob@')
                                    TaskPlayAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                    Wait(500)
                                    for i =1, #remote do
                                        AddExplosion(remote[i].coords, 2, 300.0, 1)
                                        DeleteObject(remote[i].object)
                                    end
                                    remote = {}
                                    pressed = true
                                    remoteLoop = false
                                end
                            end
                            Citizen.Wait(1)
                        until pressed == true
                    end)
                end
            else
                Wait(4000)
                DeleteObject(bag)
                DetachEntity(plantObject, 1, 1)
                FreezeEntityPosition(plantObject, true)
                TriggerServerEvent('pacificheist:server:particleFx', Config['PacificSetup']['freezeDoorList'][index]['scene']['ptfx'])
                TriggerServerEvent('pacificheist:server:doorFix', Config['PacificSetup']['freezeDoorList'][index]['model'], Config['PacificSetup']['freezeDoorList'][index]['heading'], Config['PacificSetup']['freezeDoorList'][index]['pos'])
                TaskPlayAnim(ped, animDict, "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
                TaskPlayAnim(ped, animDict, "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
                Wait(2000)
                ClearPedTasks(ped)
                Wait(2000)
                DeleteObject(plantObject)
                Wait(9000)
                TriggerServerEvent('pacificheist:server:doorSync', index)
                Wait(250)
                if index == 1 then
                    TriggerServerEvent('pacificheist:server:modelSwap', pos, 5.0, GetHashKey('hei_v_ilev_bk_gate_pris'), GetHashKey('hei_v_ilev_bk_gate_molten'))
                elseif index == 2 then
                    TriggerServerEvent('pacificheist:server:modelSwap', pos, 5.0, GetHashKey('hei_v_ilev_bk_gate2_pris'), GetHashKey('hei_v_ilev_bk_gate2_molten'))
                elseif index == 6 then
                    TriggerServerEvent('pacificheist:server:modelSwap', pos, 5.0, GetHashKey('hei_v_ilev_bk_safegate_pris'), GetHashKey('hei_v_ilev_bk_safegate_molten'))
                elseif index == 7 then
                    TriggerServerEvent('pacificheist:server:modelSwap', pos, 5.0, GetHashKey('hei_v_ilev_bk_safegate_pris'), GetHashKey('hei_v_ilev_bk_safegate_molten'))
                end
                busy = false
            end
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][itemIndex])
end

RegisterNetEvent('pacificheist:client:doorFix')
AddEventHandler('pacificheist:client:doorFix', function(hash, heading, pos)
    local doorObject = GetClosestObjectOfType(pos, 5.0, hash, 0, 0, 0)
    Wait(250)
    SetEntityHeading(doorObject, heading)
    FreezeEntityPosition(doorObject, true)
end)

function HackingPacific(index)
    ESX.TriggerServerCallback('pacificheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            busy = true
            hacking = true
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = 'anim_heist@hs3f@ig1_hack_keypad@arcade@male@'
            local usbModel = 'ch_prop_ch_usb_drive01x'
            local phoneModel = 'prop_phone_ing'
            loadAnimDict(animDict)
            loadModel(usbModel)
            loadModel(phoneModel)

            usb = CreateObject(GetHashKey(usbModel), pedCo, 1, 1, 0)
            phone = CreateObject(GetHashKey(phoneModel), pedCo, 1, 1, 0)
            keypad = GetClosestObjectOfType(pedCo, 2.0, GetHashKey('ch_prop_fingerprint_scanner_01e'), false, false, false)

            for i = 1, #HackKeypadPacific['animations'] do
                HackKeypadPacific['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, HackKeypadPacific['scenes'][i], animDict, HackKeypadPacific['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(usb, HackKeypadPacific['scenes'][i], animDict, HackKeypadPacific['animations'][i][2], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(phone, HackKeypadPacific['scenes'][i], animDict, HackKeypadPacific['animations'][i][3], 1.0, -1.0, 1148846080)
            end

            NetworkStartSynchronisedScene(HackKeypadPacific['scenes'][1])
            Wait(4000)
            NetworkStartSynchronisedScene(HackKeypadPacific['scenes'][2])
            Wait(2000)
            TriggerEvent("utk_fingerprint:Start", 4, 6, 2, function(outcome, reason)
                if outcome == true then 
                    Wait(5000)
                    NetworkStartSynchronisedScene(HackKeypadPacific['scenes'][3])
                    Wait(4000)
                    DeleteObject(usb)
                    DeleteObject(phone)
                    ClearPedTasks(ped)
                    hacking = false
                    busy = false
                    TriggerServerEvent('pacificheist:server:doorSync', index)
                elseif outcome == false then
                    Wait(5000)
                    NetworkStartSynchronisedScene(HackKeypadPacific['scenes'][4])
                    Wait(4000)
                    DeleteObject(usb)
                    DeleteObject(phone)
                    ClearPedTasks(ped)
                    busy = false    
                    hacking = false
                end
            end)
        else
            ShowNotification(StringsPacific['need_this'] .. itemLabel, 'error')
        end
    end, Config['PacificHeist']['requiredItems'][7])
end

function OutsidePacific(index)
    if robberPacific then
        robberPacific = false
        ShowNotification(StringsPacific['deliver_to_buyer'], 'info')
       -- loadModel('baller')
        buyerBlip = addBlip(Config['PacificHeist']['finishHeist']['buyerPos'], 500, 0, StringsPacific['buyer_blip'])
       -- buyerVehicle = CreateVehicle(GetHashKey('baller'), Config['PacificHeist']['finishHeist']['buyerPos'].xy + 3.0, Config['PacificHeist']['finishHeist']['buyerPos'].z, 269.4, 0, 0)
        while true do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local dist = #(pedCo - Config['PacificHeist']['finishHeist']['buyerPos'])

            if dist <= 15.0 then
                PlayCutscenePacific('hs3f_all_drp3', Config['PacificHeist']['finishHeist']['buyerPos'])
               -- DeleteVehicle(buyerVehicle)
                RemoveBlip(buyerBlip)
                TriggerServerEvent('pacificheist:server:sellRewardItems')
                break
            end
            Wait(1)
        end
    end
end

RegisterNetEvent('pacificheist:client:resetHeist')
AddEventHandler('pacificheist:client:resetHeist', function()
    PacificHeist['start'] = false
    vaultLoop = false
    extendedLoop = false
    VaultCheck = {
        ['laptop'] = false,
        ['drill'] = false
    }
    CreateModelSwap(257.10, 220.30, 106.28, 5.0, GetHashKey('hei_v_ilev_bk_gate_molten'), GetHashKey('hei_v_ilev_bk_gate_pris'), 0)
    CreateModelSwap(262.35, 223.00, 107.05, 5.0, GetHashKey('hei_v_ilev_bk_gate2_molten'), GetHashKey('hei_v_ilev_bk_gate2_pris'), 0)
    CreateModelSwap(252.72, 220.95, 101.68, 5.0, GetHashKey('hei_v_ilev_bk_safegate_molten'), GetHashKey('hei_v_ilev_bk_safegate_pris'), 0)
    CreateModelSwap(261.01, 215.01, 101.68, 5.0, GetHashKey('hei_v_ilev_bk_safegate_molten'), GetHashKey('hei_v_ilev_bk_safegate_pris'), 0)
    for k, v in pairs(Config['PacificSetup']['freezeDoorList']) do
        v['lock'] = true
    end
    for k, v in pairs(Config['PacificSetup']['cellGates']) do
        v['plant'] = false
    end
    for k, v in pairs(Config['PacificSetup']['drills']) do
        v['taken'] = false
    end
    for k, v in pairs(Config['PacificSetup']['trollys']) do
        v['taken'] = false
        if k > 4 then
            local object = GetClosestObjectOfType(v['pos'], 2.0, GetHashKey(v['model']), 0, 0, 0)
            DeleteObject(object)
        end
    end
    for k, v in pairs(Config['PacificSetup']['painting']) do
        v['taken'] = false
        object = GetClosestObjectOfType(v['objectPos'], 1.0, GetHashKey(v['object']), 0, 0, 0)
        DeleteObject(object)
    end
    for k, v in pairs(Config['PacificSetup']['stacks']) do
        v['taken'] = false
    end
    for k, v in pairs(ClientScenes['objects']) do
        DeleteObject(v)
    end
    Config['PacificSetup']['mainStack']['taken'] = false
    Config['PacificSetup']['glassCutting']['taken'] = false
    mainBankVault = GetClosestObjectOfType(253.154, 228.344, 101.683, 5.0, 961976194, 0, 0, 0)
    SetEntityHeading(mainBankVault, 160.0)
    glassObjectDel = GetClosestObjectOfType(263.925, 260.656, 100.633, 2.0, GetHashKey('h4_prop_h4_glass_disp_01a'), 0, 0, 0)
    glassObjectDel2 = GetClosestObjectOfType(263.925, 260.656, 100.633, 2.0, GetHashKey('h4_prop_h4_glass_disp_01b'), 0, 0, 0)
    DeleteObject(glassObjectDel)
    DeleteObject(glassObjectDel2)
    ClearArea(253.154, 228.344, 101.683, 100.0)
end)

--Thanks to d0p3t
function PlayCutscenePacific(cut, coords)
    while not HasThisCutsceneLoaded(cut) do 
        RequestCutscene(cut, 8)
        Wait(0) 
    end
    CreateCutscene(false, coords)
    Finish()
    RemoveCutscene()
    DoScreenFadeIn(500)
end

RegisterNetEvent('pacificheist:client:showNotification')
AddEventHandler('pacificheist:client:showNotification', function(str, type)
    ShowNotification(str, type)
end)

RegisterNetEvent('pacificheist:client:sceneSync')
AddEventHandler('pacificheist:client:sceneSync', function(model, animDict, animName, pos, rotation)
    loadAnimDict(animDict)

    ClientScenes['objects'][#ClientScenes['objects'] + 1] = CreateObject(GetHashKey(model), pos, 0, 0, 0)
    ClientScenes['scenes'][#ClientScenes['scenes'] + 1] = CreateSynchronizedScene(pos['xy'], pos['z'] - 1.0, rotation, 2, true, false, 1065353216, 0, 1065353216)

    PlaySynchronizedEntityAnim(ClientScenes['objects'][#ClientScenes['objects']], ClientScenes['scenes'][#ClientScenes['scenes']], animName, animDict, 1.0, -1.0, 0, 1148846080)
    ForceEntityAiAndAnimationUpdate(ClientScenes['objects'][#ClientScenes['objects']])

    SetSynchronizedScenePhase(ClientScenes['scenes'][#ClientScenes['scenes']], 0.99)
    FreezeEntityPosition(ClientScenes['objects'][#ClientScenes['objects']], true)
end)

RegisterNetEvent('pacificheist:client:particleFx')
AddEventHandler('pacificheist:client:particleFx', function(pos)
    loadPtfxAsset('scr_ornate_heist')
    UseParticleFxAssetNextCall('scr_ornate_heist')
    ptfx = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", pos, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(13000)
    StopParticleFxLooped(ptfx, 0)
end)

RegisterNetEvent('pacificheist:client:modelSwap')
AddEventHandler('pacificheist:client:modelSwap', function(pos, radius, model, newModel)
    CreateModelSwap(pos, radius, model, newModel, 0)
end)

function DeleteObjectSync(entity)
    TriggerServerEvent('pacificheist:server:objectSync', NetworkGetNetworkIdFromEntity(entity))
end

RegisterNetEvent('pacificheist:client:objectSync')
AddEventHandler('pacificheist:client:objectSync', function(e)
    local entity = NetworkGetEntityFromNetworkId(e)
    DeleteEntity(entity)
end)