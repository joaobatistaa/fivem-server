ArtHeist = {
    ['start'] = false,
    ['cuting'] = false,
    ['startPeds'] = {},
    ['sellPeds'] = {},
    ['cut'] = 0,
    ['objects'] = {},
    ['scenes'] = {},
    ['painting'] = {}
}

Citizen.CreateThread(function()
    for k, v in pairs(Config['ArtHeist']['startHeist']['peds']) do
        loadModel(v['ped'])
        ArtHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(ArtHeist['startPeds'][k], true)
        SetEntityInvincible(ArtHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(ArtHeist['startPeds'][k], true)
    end
    for k, v in pairs(Config['ArtHeist']['sellPainting']['peds']) do
        loadModel(v['ped'])
        ArtHeist['sellPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(ArtHeist['sellPeds'][k], true)
        SetEntityInvincible(ArtHeist['sellPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(ArtHeist['sellPeds'][k], true)
    end
end)
--[[
Citizen.CreateThread(function()
	--for _, heist in pairs(Config.FleecaHeist) do
		local blip = AddBlipForCoord(Config['ArtHeist']['startHeist']['pos'])
		SetBlipSprite(blip, 156)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Assalto à Casa da Arte")
		EndTextCommandSetBlipName(blip)
	--end
end)--]]


Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local heistDist = #(pedCo - Config['ArtHeist']['startHeist']['pos'])
        local sellDist = #(pedCo - Config['ArtHeist']['sellPainting']['pos'])
        if heistDist <= 3.0 then
            sleep = 1
            ShowHelpNotification(StringsArt['start_heist'])
            if IsControlJustPressed(0, 38) then
                StartHeistArt()
            end
        elseif sellDist <= 3.0 then
            sleep = 1
            ShowHelpNotification(StringsArt['sell_painting'])
            if IsControlJustPressed(0, 38) then
                FinishHeistArt()
            end
        end
        if ArtHeist['start'] then
            for k, v in pairs(Config['ArtHeist']['painting']) do
                local dist = #(pedCo - v['scenePos'])
                if dist <= 1.0 then
                    sleep = 1
                    if not v['taken'] then
                        ShowHelpNotification(StringsArt['start_stealing'])
                        if IsControlJustPressed(0, 38) then
                            local weapon = GetSelectedPedWeapon(ped)
                            if weapon == GetHashKey('WEAPON_SWITCHBLADE') then
                                if not ArtHeist['cuting'] then
                                    HeistAnimationArt(k)
                                else
                                    ShowNotification(StringsArt['already_cuting'], 'error')
                                end
                            else
                                ShowNotification('Tens que ter um canivete (Switch_Blade)', 'error')
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('artheist:client:policeAlert')
AddEventHandler('artheist:client:policeAlert', function(targetCoords)
    --ShowNotification(StringsArt['police_alert'], 'warn')
	local street = GetStreetAndZone()
	TriggerEvent('police:assaltos', 'Assalto a decorrer na Casa da Arte', targetCoords, street)
    local alpha = 250
    local artheistBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(artheistBlip, true)
    SetBlipColour(artheistBlip, 1)
    SetBlipAlpha(artheistBlip, alpha)
    SetBlipAsShortRange(artheistBlip, true)

    while alpha ~= 0 do
        Citizen.Wait(125)
        alpha = alpha - 1
        SetBlipAlpha(artheistBlip, alpha)

        if alpha == 0 then
            RemoveBlip(artheistBlip)
            return
        end
    end
end)

RegisterNetEvent('artheist:client:syncHeistStart')
AddEventHandler('artheist:client:syncHeistStart', function()
    ArtHeist['start'] = not ArtHeist['start']
end)

RegisterNetEvent('artheist:client:syncPainting')
AddEventHandler('artheist:client:syncPainting', function(x)
    Config['ArtHeist']['painting'][x]['taken'] = true
end)

RegisterNetEvent('artheist:client:syncAllPainting')
AddEventHandler('artheist:client:syncAllPainting', function(x)
    for k, v in pairs(Config['ArtHeist']['painting']) do
        v['taken'] = false
    end
end)

function FinishHeistArt()
    for k, v in pairs(ArtHeist['sellPeds']) do
        TaskTurnPedToFaceEntity(v, PlayerPedId(), 1000)
    end
    TriggerServerEvent('artheist:server:finishHeist')
    RemoveBlip(sellBlip)
    if DoesBlipExist(stealBlip) then
        RemoveBlip(stealBlip)
    end
end

function StartHeistArt()
    ESX.TriggerServerCallback('artheist:server:checkRobTime', function(time)
        if time then
            if ArtHeist['start'] then ShowNotification(StringsArt['already_heist'], 'error') return end
            for k, v in pairs(ArtHeist['startPeds']) do
                TaskTurnPedToFaceEntity(v, PlayerPedId(), 1000)
            end
            local paintingList = {}
            for k, v in pairs(Config['ArtHeist']['painting']) do
                table.insert(paintingList, {v['object']})
            end
            SendNUIMessage({
                action = 'open',
                list = paintingList
            })
            Wait(3000)
            TriggerServerEvent('artheist:server:syncHeistStart')
            ShowNotification(StringsArt['go_steal'], 'info')
            stealBlip = addBlip(vector3(1397.66, 1140.42, 114.268), 439, 0, StringsArt['steal_blip'])
            repeat
                local ped = PlayerPedId()
                local pedCo = GetEntityCoords(ped)
                local dist = #(pedCo - Config['ArtHeist']['painting'][1]['scenePos'])
                Wait(1)
            until dist <= 100.0
            for k, v in pairs(Config['ArtHeist']['painting']) do
                loadModel(v['object'])
                ArtHeist['painting'][k] = CreateObjectNoOffset(GetHashKey(v['object']), v['objectPos'], 1, 1, 0)
                SetEntityRotation(ArtHeist['painting'][k], 0, 0, v['objHeading'], 2, true)
            end
        end
    end)
end

function HeistAnimationArt(sceneId)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
    local scene = Config['ArtHeist']['painting'][sceneId]
    TriggerServerEvent('artheist:server:syncPainting', sceneId)
    loadAnimDict(animDict)
    
    for k, v in pairs(Config['ArtHeist']['objects']) do
        loadModel(v)
        ArtHeist['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end
    
    ArtHeist['objects'][3] = ArtHeist['painting'][sceneId]
    
    for i = 1, 10 do
        ArtHeist['scenes'][i] = NetworkCreateSynchronisedScene(scene['scenePos']['x'], scene['scenePos']['y'], scene['scenePos']['z'], scene['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][3], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][1], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][4], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][2], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][5], 1.0, -1.0, 1148846080)
    end

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)
    
    ArtHeist['cuting'] = true
    FreezeEntityPosition(ped, true)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][1])
    PlayCamAnim(cam, 'ver_01_top_left_enter_cam_ble', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][2])
    PlayCamAnim(cam, 'ver_01_cutting_top_left_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        ShowHelpNotification(StringsArt['cute_right'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][3])
    PlayCamAnim(cam, 'ver_01_cutting_top_left_to_right_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][4])
    PlayCamAnim(cam, 'ver_01_cutting_top_right_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        ShowHelpNotification(StringsArt['cute_down'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][5])
    PlayCamAnim(cam, 'ver_01_cutting_right_top_to_bottom_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][6])
    PlayCamAnim(cam, 'ver_01_cutting_bottom_right_idle_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    repeat
        ShowHelpNotification(StringsArt['cute_left'])
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][7])
    PlayCamAnim(cam, 'ver_01_cutting_bottom_right_to_left_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(3000)
    repeat
        ShowHelpNotification(StringsArt['cute_down'])
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][9])
    PlayCamAnim(cam, 'ver_01_cutting_left_top_to_bottom_cam', animDict, scene['scenePos'], scene['sceneRot'], 0, 2)
    Wait(1500)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][10])
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    Wait(7500)
    TriggerServerEvent('artheist:server:rewardItem', scene)
    ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
    RemoveAnimDict(animDict)
    for k, v in pairs(ArtHeist['objects']) do
        DeleteObject(v)
    end
    DeleteObject(ArtHeist['painting'][sceneId])
    ArtHeist['objects'] = {}
    ArtHeist['scenes'] = {}
    ArtHeist['cuting'] = false
    ArtHeist['cut'] = ArtHeist['cut'] + 1
    scenes = {false, false, false, false}
    if ArtHeist['cut'] == 1 then
        TriggerServerEvent('artheist:server:policeAlert', GetEntityCoords(PlayerPedId()))
    end
    if ArtHeist['cut'] == #Config['ArtHeist']['painting'] then
        TriggerServerEvent('artheist:server:syncHeistStart')
        TriggerServerEvent('artheist:server:syncAllPainting')
        ShowNotification(StringsArt['go_sell'], 'info')
        RemoveBlip(stealBlip)
        sellBlip = addBlip(Config['ArtHeist']['sellPainting']['pos'], 500, 0, StringsArt['sell_blip'])
        ArtHeist['cut'] = 0
    end
end

RegisterNetEvent('artheist:client:showNotification')
AddEventHandler('artheist:client:showNotification', function(str, type)
    ShowNotification(str, type)
end)

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(ArtHeist['painting']) do
            DeleteObject(v)
        end
        for k, v in pairs(ArtHeist['objects']) do
            DeleteObject(v)
        end
    end
end)