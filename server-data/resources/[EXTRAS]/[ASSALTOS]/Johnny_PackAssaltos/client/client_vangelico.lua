VangelicoHeist = {
    ['startPeds'] = {},
    ['painting'] = {},
    ['gasMask'] = false,
    ['globalObject'] = nil,
    ['globalItem'] = nil,
}

Citizen.CreateThread(function()
    for k, v in pairs(Config['VangelicoHeist']['startHeist']['peds']) do
        loadModel(v['ped'])
        VangelicoHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(VangelicoHeist['startPeds'][k], true)
        SetEntityInvincible(VangelicoHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(VangelicoHeist['startPeds'][k], true)
    end
end)

--[[
Citizen.CreateThread(function()
	--for _, heist in pairs(Config.FleecaHeist) do
		local blip = AddBlipForCoord(Config['VangelicoHeist']['startHeist']['pos'])
		SetBlipSprite(blip, 156)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Assalto à Joalharia")
		EndTextCommandSetBlipName(blip)
	--end
end)
--]]

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local dist = #(pedCo - Config['VangelicoHeist']['startHeist']['pos'])

        if dist <= 2.0 then
            sleep = 1
            ShowHelpNotification(StringsVangelico['start_heist'])
            if IsControlJustPressed(0, 38) then
                VangelicoStart()
            end
        end
        Citizen.Wait(sleep)
    end
end)

function VangelicoStart()
    ESX.TriggerServerCallback('vangelicoheist:server:checkPoliceCount', function(status)
        if status then
            ESX.TriggerServerCallback('vangelicoheist:server:checkTime', function(time)
                if time then
                    ShowNotification(StringsVangelico['goto_vangelico'])
                    gasBlip = addBlip(vector3(-622.4311, -233.6548, 58.41259), 570, 1, StringsVangelico['throw_gas_blip'])
                    while true do
                        local ped = PlayerPedId()
                        local pedCo = GetEntityCoords(ped)
                        local dist = #(pedCo - vector3(-622.4311, -233.6548, 58.41259))
                        if dist <= 20.0 then
                            DrawMarker(1, -622.4311, -233.6548, 58.41259, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 1.0, 237, 197, 66, 255, false, false)
                            if IsProjectileTypeWithinDistance(-622.4311, -233.6548, 58.41259, GetHashKey('WEAPON_BZGAS'), 1.0, true) then
                                VangelicoSetup()
                                break
                            end
                        end
                        Wait(1)
                    end
                end
            end)
        end
    end)
end

function VangelicoSetup()
    ShowNotification(StringsVangelico['good_shot'], 'success')
    Wait(5000)
    PlayCutsceneJoalharia('JH_2A_MCS_1')
    RemoveBlip(gasBlip)
    TriggerServerEvent('vangelicoheist:server:startGas')

    local random = math.random(1, 4)
    local glassConfig = Config['VangelicoInside']['glassCutting']
    loadModel(glassConfig['rewards'][random]['object']['model'])
    loadModel(glassConfig['rewards'][random]['displayObj']['model'])
    loadModel('h4_prop_h4_glass_disp_01a')
    local glass = CreateObject(GetHashKey('h4_prop_h4_glass_disp_01a'), -617.4622, -227.4347, 37.057, 1, 1, 0)
    SetEntityHeading(glass, -53.06)
    local reward = CreateObject(GetHashKey(glassConfig['rewards'][random]['object']['model']), glassConfig['rewardPos'].xy, glassConfig['rewardPos'].z + 0.195, 1, 1, 0)
    SetEntityHeading(reward, glassConfig['rewards'][random]['object']['rot'])
    local rewardDisp = CreateObject(GetHashKey(glassConfig['rewards'][random]['displayObj']['model']), glassConfig['rewardPos'], 1, 1, 0)
    SetEntityRotation(rewardDisp, glassConfig['rewards'][random]['displayObj']['rot'])
    TriggerServerEvent('vangelicoheist:server:globalObject', glassConfig['rewards'][random]['object']['model'], random)

    for k, v in pairs(Config['VangelicoInside']['painting']) do
        loadModel(v['object'])
        VangelicoHeist['painting'][k] = CreateObjectNoOffset(GetHashKey(v['object']), v['objectPos'], 1, 0, 0)
        SetEntityRotation(VangelicoHeist['painting'][k], 0, 0, v['objHeading'], 2, true)
    end

    TriggerServerEvent('vangelicoheist:server:insideLoop')
    TriggerServerEvent('vangelicoheist:server:policeAlert', GetEntityCoords(PlayerPedId()))
end

RegisterNetEvent('vangelicoheist:client:policeAlert')
AddEventHandler('vangelicoheist:client:policeAlert', function(targetCoords)
    --ShowNotification(StringsVangelico['police_alert'], 'warning')
	local street = GetStreetAndZone()
	TriggerEvent('police:assaltos', 'Assalto a decorrer na Joalharia', targetCoords, street)
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

RegisterNetEvent('vangelicoheist:client:globalObject')
AddEventHandler('vangelicoheist:client:globalObject', function(obj, index)
    VangelicoHeist['globalObject'] = obj
    VangelicoHeist['globalItem'] = Config['VangelicoInside']['glassCutting']['rewards'][index]['item']
end)

RegisterNetEvent('vangelicoheist:client:insideLoop')
AddEventHandler('vangelicoheist:client:insideLoop', function()
    insideLoop = true
    Citizen.CreateThread(function()
        while insideLoop do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local sleep = 1000
            local dist = #(pedCo - vector3(-617.4622, -227.4347, 37.057))

            if dist <= 1.5 and not Config['VangelicoInside']['glassCutting']['loot'] and not busy then
                sleep = 1
                ShowHelpNotification(StringsVangelico['glass_cut'])
                if IsControlJustPressed(0, 38) then
                    OverheatSceneJoalharia()
                end
            end

            if dist >= 40.0 and robberJoalharia then
                OutsideJoalharia()
                break
            end

            for k, v in pairs(Config['VangelicoInside']['painting']) do
                local dist = #(pedCo - v['objectPos'])

                if dist <= 1.5 and not v['loot'] and not busy then
                    sleep = 1
                    ShowHelpNotification(StringsVangelico['start_stealing'])
                    if IsControlJustPressed(0, 38) then
                        PaintingSceneJoalharia(k)
                    end
                end
            end

            for k, v in pairs(Config['VangelicoInside']['smashScenes']) do
                local dist = #(pedCo - v['objPos'])

                if dist <= 1.3 and not v['loot'] and not busy then
                    sleep = 1
                    ShowHelpNotification(StringsVangelico['smash'])
                    if IsControlJustPressed(0, 38) then
                        SmashJoalharia(k)
                    end
                end
            end
            
            Citizen.Wait(1)
        end
    end)
end)

RegisterNetEvent('vangelicoheist:client:lootSync')
AddEventHandler('vangelicoheist:client:lootSync', function(type, index)
    if index then
        Config['VangelicoInside'][type][index]['loot'] = true
    else
        Config['VangelicoInside'][type]['loot'] = true
    end
end)

function PaintingSceneJoalharia(sceneId)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if weapon ~= GetHashKey('WEAPON_SWITCHBLADE') then ShowNotification(StringsVangelico['need_switchblade'], 'error') return end
    ESX.TriggerServerCallback('vangelicoheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            TriggerServerEvent('vangelicoheist:server:lootSync', 'painting', sceneId)
            robberJoalharia = true
            busy = true
            local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
            local scenes = {false, false, false, false}
            local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
            scene = Config['VangelicoInside']['painting'][sceneId]
            sceneObject = GetClosestObjectOfType(scene['objectPos'], 1.0, GetHashKey(scene['object']), 0, 0, 0)
            scenePos = scene['scenePos']
            sceneRot = scene['sceneRot']
            loadAnimDict(animDict)
            
            for k, v in pairs(ArtHeistVangelico['objects']) do
                loadModel(v)
                ArtHeistVangelico['sceneObjects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
            end
            
            for i = 1, 10 do
                ArtHeistVangelico['scenes'][i] = NetworkCreateSynchronisedScene(scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 2, true, false, 1065353216, 0, 1065353216)
                NetworkAddPedToSynchronisedScene(ped, ArtHeistVangelico['scenes'][i], animDict, 'ver_01_' .. ArtHeistVangelico['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(sceneObject, ArtHeistVangelico['scenes'][i], animDict, 'ver_01_' .. ArtHeistVangelico['animations'][i][3], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(ArtHeistVangelico['sceneObjects'][1], ArtHeistVangelico['scenes'][i], animDict, 'ver_01_' .. ArtHeistVangelico['animations'][i][4], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(ArtHeistVangelico['sceneObjects'][2], ArtHeistVangelico['scenes'][i], animDict, 'ver_01_' .. ArtHeistVangelico['animations'][i][5], 1.0, -1.0, 1148846080)
            end

            cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
            SetCamActive(cam, true)
            RenderScriptCams(true, 0, 3000, 1, 0)
            
            ArtHeistVangelico['cuting'] = true
            FreezeEntityPosition(ped, true)
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][1])
            PlayCamAnim(cam, 'ver_01_top_left_enter_cam_ble', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][2])
            PlayCamAnim(cam, 'ver_01_cutting_top_left_idle_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            repeat
                ShowHelpNotification(StringsVangelico['cute_right'])
                if IsControlJustPressed(0, 38) then
                    scenes[1] = true
                end
                Wait(1)
            until scenes[1] == true
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][3])
            PlayCamAnim(cam, 'ver_01_cutting_top_left_to_right_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][4])
            PlayCamAnim(cam, 'ver_01_cutting_top_right_idle_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            repeat
                ShowHelpNotification(StringsVangelico['cute_down'])
                if IsControlJustPressed(0, 38) then
                    scenes[2] = true
                end
                Wait(1)
            until scenes[2] == true
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][5])
            PlayCamAnim(cam, 'ver_01_cutting_right_top_to_bottom_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][6])
            PlayCamAnim(cam, 'ver_01_cutting_bottom_right_idle_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            repeat
                ShowHelpNotification(StringsVangelico['cute_left'])
                if IsControlJustPressed(0, 38) then
                    scenes[3] = true
                end
                Wait(1)
            until scenes[3] == true
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][7])
            PlayCamAnim(cam, 'ver_01_cutting_bottom_right_to_left_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(3000)
            repeat
                ShowHelpNotification(StringsVangelico['cute_down'])
                if IsControlJustPressed(0, 38) then
                    scenes[4] = true
                end
                Wait(1)
            until scenes[4] == true
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][9])
            PlayCamAnim(cam, 'ver_01_cutting_left_top_to_bottom_cam', animDict, scenePos['xy'], scenePos['z'] - 1.0, sceneRot, 0, 2)
            Wait(1500)
            NetworkStartSynchronisedScene(ArtHeistVangelico['scenes'][10])
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            Wait(7500)
            TriggerServerEvent('vangelicoheist:server:rewardItem', scene['rewardItem'])
            ClearPedTasks(ped)
            FreezeEntityPosition(ped, false)
            RemoveAnimDict(animDict)
            for k, v in pairs(ArtHeistVangelico['sceneObjects']) do
                DeleteObject(v)
            end
            DeleteObject(sceneObject)
            DeleteEntity(sceneObject)
            ArtHeistVangelico['sceneObjects'] = {}
            ArtHeistVangelico['scenes'] = {}
            scenes = {false, false, false, false}
            busy = false
        else
            ShowNotification(StringsVangelico['need_this'] .. itemLabel, 'error')
        end
    end, Config['VangelicoHeist']['requiredItems'][2])
end

function OverheatSceneJoalharia()
    ESX.TriggerServerCallback('vangelicoheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            TriggerServerEvent('vangelicoheist:server:lootSync', 'glassCutting')
            robberJoalharia = true
            busy = true
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = 'anim@scripted@heist@ig16_glass_cut@male@'
            sceneObject = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 1.0, GetHashKey('h4_prop_h4_glass_disp_01a'), 0, 0, 0)
            scenePos = GetEntityCoords(sceneObject)
            sceneRot = GetEntityRotation(sceneObject)
            globalObj = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 5.0, GetHashKey(VangelicoHeist['globalObject']), 0, 0, 0)
            loadAnimDict(animDict)
            RequestScriptAudioBank('DLC_HEI4/DLCHEI4_GENERIC_01', -1)

            cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
            SetCamActive(cam, true)
            RenderScriptCams(true, 0, 3000, 1, 0)

            for k, v in pairs(OverheatVangelico['objects']) do
                loadModel(v)
                OverheatVangelico['sceneObjects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
            end

            local newObj = CreateObject(GetHashKey('h4_prop_h4_glass_disp_01b'), GetEntityCoords(sceneObject), 1, 1, 0)
            SetEntityHeading(newObj, GetEntityHeading(sceneObject))

            for i = 1, #OverheatVangelico['animations'] do
                OverheatVangelico['scenes'][i] = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, OverheatVangelico['scenes'][i], animDict, OverheatVangelico['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(OverheatVangelico['sceneObjects'][1], OverheatVangelico['scenes'][i], animDict, OverheatVangelico['animations'][i][2], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(OverheatVangelico['sceneObjects'][2], OverheatVangelico['scenes'][i], animDict, OverheatVangelico['animations'][i][3], 1.0, -1.0, 1148846080)
                if i ~= 5 then
                    NetworkAddEntityToSynchronisedScene(sceneObject, OverheatVangelico['scenes'][i], animDict, OverheatVangelico['animations'][i][4], 1.0, -1.0, 1148846080)
                else
                    NetworkAddEntityToSynchronisedScene(newObj, OverheatVangelico['scenes'][i], animDict, OverheatVangelico['animations'][i][4], 1.0, -1.0, 1148846080)
                end
            end

            local sound1 = GetSoundId()
            local sound2 = GetSoundId()

            NetworkStartSynchronisedScene(OverheatVangelico['scenes'][1])
            PlayCamAnim(cam, 'enter_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'enter') * 1000)

            NetworkStartSynchronisedScene(OverheatVangelico['scenes'][2])
            PlayCamAnim(cam, 'idle_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'idle') * 1000)

            NetworkStartSynchronisedScene(OverheatVangelico['scenes'][3])
            PlaySoundFromEntity(sound1, "StartCutting", OverheatVangelico['sceneObjects'][2], 'DLC_H4_anims_glass_cutter_Sounds', true, 80)
            loadPtfxAsset('scr_ih_fin')
            UseParticleFxAssetNextCall('scr_ih_fin')
            fire1 = StartParticleFxLoopedOnEntity('scr_ih_fin_glass_cutter_cut', OverheatVangelico['sceneObjects'][2], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1065353216, 0.0, 0.0, 0.0, 1065353216, 1065353216, 1065353216, 0)
            PlayCamAnim(cam, 'cutting_loop_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'cutting_loop') * 1000)
            StopSound(sound1)
            StopParticleFxLooped(fire1)

            NetworkStartSynchronisedScene(OverheatVangelico['scenes'][4])
            PlaySoundFromEntity(sound2, "Overheated", OverheatVangelico['sceneObjects'][2], 'DLC_H4_anims_glass_cutter_Sounds', true, 80)
            UseParticleFxAssetNextCall('scr_ih_fin')
            fire2 = StartParticleFxLoopedOnEntity('scr_ih_fin_glass_cutter_overheat', OverheatVangelico['sceneObjects'][2], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1065353216, 0.0, 0.0, 0.0)
            PlayCamAnim(cam, 'overheat_react_01_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'overheat_react_01') * 1000)
            StopSound(sound2)
            StopParticleFxLooped(fire2)

            DeleteObject(sceneObject)
            NetworkStartSynchronisedScene(OverheatVangelico['scenes'][5])
            Wait(2000)
            DeleteObject(globalObj)
            TriggerServerEvent('vangelicoheist:server:rewardItem', VangelicoHeist['globalItem'])
            PlayCamAnim(cam, 'success_cam', animDict, scenePos, sceneRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'success') * 1000 - 2000)
            DeleteObject(OverheatVangelico['sceneObjects'][1])
            DeleteObject(OverheatVangelico['sceneObjects'][2])
            ClearPedTasks(ped)
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            busy = false
        else
            ShowNotification(StringsVangelico['need_this'] .. itemLabel, 'error')
        end
    end, Config['VangelicoHeist']['requiredItems'][1])
end

local prevAnim = ''
function SmashJoalharia(index)
    local ped = PlayerPedId()
    local weapon = false
    for k, v in pairs(Config['VangelicoHeist']['smashWeapons']) do
        local pedWeapon = GetSelectedPedWeapon(ped)
        if pedWeapon == GetHashKey(v) then
            weapon = true
        end
    end
    if not weapon then ShowNotification(StringsVangelico['need_rifle'], 'error') return end
    ESX.TriggerServerCallback('vangelicoheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            robberJoalharia = true
            busy = true
            TriggerServerEvent('vangelicoheist:server:lootSync', 'smashScenes', index)
            local pedCo = GetEntityCoords(ped)
            local pedRotation = GetEntityRotation(ped)
            local animDict = 'missheist_jewel'
            local ptfxAsset = "scr_jewelheist"
            local particleFx = "scr_jewel_cab_smash"
            loadAnimDict(animDict)
            loadPtfxAsset(ptfxAsset)
            local sceneConfig = Config['VangelicoInside']['smashScenes'][index]
            SetEntityCoords(ped, sceneConfig['scenePos'])
            local anims = {
                {'smash_case_necklace', 300},
                {'smash_case_d', 300},
                {'smash_case_e', 300},
                {'smash_case_f', 300}
            }
            local selected = ''
            repeat
                selected = anims[math.random(1, #anims)]
            until selected ~= prevAnim
            prevAnim = selected
        
            if index == 4 or index == 10 or index == 14 or index == 8 then
                selected = {'smash_case_necklace_skull', 300}
            end
            
            cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
            SetCamActive(cam, true)
            RenderScriptCams(true, 0, 0, 0, 0)
            
            scene = NetworkCreateSynchronisedScene(sceneConfig['scenePos'], sceneConfig['sceneRot'], 2, true, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, scene, animDict, selected[1], 2.0, 4.0, 1, 0, 1148846080, 0)
            NetworkStartSynchronisedScene(scene)
            PlayCamAnim(cam, 'cam_' .. selected[1], animDict, sceneConfig['scenePos'], sceneConfig['sceneRot'], 0, 2)
        
            Wait(300)
        
            TriggerServerEvent('vangelicoheist:server:smashSync', sceneConfig)
            for i = 1, 5 do
                PlaySoundFromCoord(-1, "Glass_Smash", sceneConfig['objPos'], 0, 0, 0)
            end
            SetPtfxAssetNextCall(ptfxAsset)
            StartNetworkedParticleFxNonLoopedAtCoord(particleFx, sceneConfig['objPos'], 0.0, 0.0, 0.0, 2.0, 0, 0, 0)
            Wait(GetAnimDuration(animDict, selected[1]) * 1000 - 1000)
            random = math.random(1, #Config['VangelicoHeist']['smashRewards'])
            TriggerServerEvent('vangelicoheist:server:rewardItem', Config['VangelicoHeist']['smashRewards'][random]['item'])
            ClearPedTasks(PlayerPedId())
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            busy = false
        else
            ShowNotification(StringsVangelico['need_this'] .. itemLabel, 'error')
        end
    end, Config['VangelicoHeist']['requiredItems'][2])
end

RegisterNetEvent('vangelicoheist:client:smashSync')
AddEventHandler('vangelicoheist:client:smashSync', function(sceneConfig)
    CreateModelSwap(sceneConfig['objPos'], 0.3, GetHashKey(sceneConfig['oldModel']), GetHashKey(sceneConfig['newModel']), 1)
end)

--Thanks to d0p3t
function PlayCutsceneJoalharia(cut, coords)
    while not HasThisCutsceneLoaded(cut) do 
        RequestCutscene(cut, 8)
        Wait(0) 
    end
    CreateCutscene(false, coords)
    Finish()
    RemoveCutscene()
    DoScreenFadeIn(500)
end

RegisterNetEvent('vangelicoheist:client:startGas')
AddEventHandler('vangelicoheist:client:startGas', function()
	local notify = false
    local ptfxAsset = "scr_jewelheist"
    local particleFx = "scr_jewel_fog_volume"

    loadPtfxAsset(ptfxAsset)

    SetPtfxAssetNextCall(ptfxAsset)
    ptfx = StartParticleFxLoopedAtCoord(particleFx, -622.0, -231.0, 38.0, 0.0, 0.0, 0.0, 0.5, false, false, false, false)
    gasLoop = true
    Citizen.CreateThread(function()
        while gasLoop do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local cu = vector3(-622.30, -230.82, 38.0570)
            local dist = #(pedCo - cu)

            if dist <= 10.0 and not VangelicoHeist['gasMask'] then
                ApplyDamageToPed(ped, 3, false)
				if notify == false then
					ShowNotification('Estás a ficar intoxicado por conta do gás que lançaste! Coloca uma máscara rapidamente!', 'warn')
					notify = true
				end
                Citizen.Wait(1000)
            end
            Citizen.Wait(1)
        end
    end)
end)

RegisterNetEvent('vangelicoheist:client:wearMask')
AddEventHandler('vangelicoheist:client:wearMask', function()
    VangelicoHeist['gasMask'] = not VangelicoHeist['gasMask']
    if VangelicoHeist['gasMask'] then
        loadAnimDict('mp_masks@standard_car@ds@')
        TaskPlayAnim(PlayerPedId(), 'mp_masks@standard_car@ds@', 'put_on_mask', 8.0, 8.0, 800, 16, 0, false, false, false)
        SetPedComponentVariation(PlayerPedId(), 1, Config['VangelicoHeist']['gasMask']['clothNumber'], 0, 1)
    else
        loadAnimDict('mp_masks@standard_car@ds@')
        TaskPlayAnim(PlayerPedId(), 'mp_masks@standard_car@ds@', 'put_on_mask', 8.0, 8.0, 800, 16, 0, false, false, false)
        SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 1)
    end
end)

RegisterNetEvent('vangelicoheist:client:resetHeist')
AddEventHandler('vangelicoheist:client:resetHeist', function()
    insideLoop = false
    gasLoop = false
    for k, v in pairs(Config['VangelicoInside']['smashScenes']) do
        v['loot'] = false
        CreateModelSwap(v['objPos'], 0.3, GetHashKey(v['newModel']), GetHashKey(v['oldModel']), 1)
    end
    for k, v in pairs(Config['VangelicoInside']['painting']) do
        v['loot'] = false
        object = GetClosestObjectOfType(v['objectPos'], 1.0, GetHashKey(v['object']), 0, 0, 0)
        DeleteObject(object)
    end
    Config['VangelicoInside']['glassCutting']['loot'] = false
    glassObjectDel = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 1.0, GetHashKey('h4_prop_h4_glass_disp_01a'), 0, 0, 0)
    glassObjectDel2 = GetClosestObjectOfType(-617.4622, -227.4347, 37.057, 1.0, GetHashKey('h4_prop_h4_glass_disp_01b'), 0, 0, 0)
    DeleteObject(glassObjectDel)
    DeleteObject(glassObjectDel2)
    StopParticleFxLooped(ptfx, 1)
end)

function OutsideJoalharia(index)
    ShowNotification(StringsVangelico['deliver_to_buyer'], 'info')
    --loadModel('baller')
    buyerBlip = addBlip(Config['VangelicoHeist']['finishHeist']['buyerPos'], 500, 0, StringsVangelico['buyer_blip'])
    --buyerVehicle = CreateVehicle(GetHashKey('baller'), Config['VangelicoHeist']['finishHeist']['buyerPos'].xy + 3.0, Config['VangelicoHeist']['finishHeist']['buyerPos'].z, 269.4, 0, 0)
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['VangelicoHeist']['finishHeist']['buyerPos'])

        if dist <= 15.0 then
            PlayCutsceneJoalharia('hs3f_all_drp3', Config['VangelicoHeist']['finishHeist']['buyerPos'])
            --DeleteVehicle(buyerVehicle)
            RemoveBlip(buyerBlip)
            TriggerServerEvent('vangelicoheist:server:sellRewardItems')
            break
        end
        Wait(1)
    end
end

RegisterNetEvent('vangelicoheist:client:showNotification')
AddEventHandler('vangelicoheist:client:showNotification', function(str, type)
    ShowNotification(str, type)
end)