KidNapping = {
    ['objects'] = {},
    ['scenes'] = {},
    ['bossPed'] = nil,
    ['kidnappedPed'] = nil,
    ['sceneFinish'] = false,
    ['checkVideo'] = false,
    ['kidnapped'] = false,
}

Citizen.CreateThread(function()
    local pedConfig = Config['Kidnapping']['start']['ped']
    loadModel(pedConfig['model'])
    KidNapping['bossPed'] = CreatePed(4, GetHashKey(pedConfig['model']), pedConfig['pos']['x'], pedConfig['pos']['y'], pedConfig['pos']['z'] - 0.95, pedConfig['heading'], false, true)
    FreezeEntityPosition(KidNapping['bossPed'], true)
    SetEntityInvincible(KidNapping['bossPed'], true)
    SetBlockingOfNonTemporaryEvents(KidNapping['bossPed'], true)
    TaskStartScenarioInPlace(KidNapping['bossPed'], 'WORLD_HUMAN_SMOKING', 0, true)
end)

--[[
Citizen.CreateThread(function()
	--for _, heist in pairs(Config.FleecaHeist) do
		local blip = AddBlipForCoord(Config['Kidnapping']['start']['ped'].pos)
		SetBlipSprite(blip, 156)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Trabalho de Sequestro")
		EndTextCommandSetBlipName(blip)
	--end
end)
--]]


RegisterNetEvent('kidnapping:client:policeAlert')
AddEventHandler('kidnapping:client:policeAlert', function(targetCoords)
    --ShowNotification(StringsKidnapping['police_alert'], 'warn')
	local street = GetStreetAndZone()
	TriggerEvent('police:assaltos', 'Um civil alertou para um Sequestro', targetCoords, street)
    local alpha = 250
    local nappingBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(nappingBlip, true)
    SetBlipColour(nappingBlip, 1)
    SetBlipAlpha(nappingBlip, alpha)
    SetBlipAsShortRange(nappingBlip, true)

    while alpha ~= 0 do
        Citizen.Wait(125)
        alpha = alpha - 1
        SetBlipAlpha(nappingBlip, alpha)

        if alpha == 0 then
            RemoveBlip(nappingBlip)
            return
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local dist = #(pedCo - Config['Kidnapping']['start']['ped']['pos'])
        if dist <= 3.0 then
            sleep = 1
            if not KidNapping['kidnapped'] then
                ShowHelpNotification(StringsKidnapping['get_job'])
                if IsControlJustPressed(0, 38) then
                    KidnappingStart()
                end
            else
                ShowHelpNotification(StringsKidnapping['finish_job'])
                if IsControlJustPressed(0, 38) then
                    KidnappingFinish()
                end
            end
        end
        if KidNapping['sceneFinish'] then
            local cameraDist = #(pedCo - Config['Kidnapping']['query']['cameraPos'])
            if cameraDist <= 3.0 then
                sleep = 1
                ShowHelpNotification(StringsKidnapping['get_videorecord'])
                if IsControlJustPressed(0, 38) then
                    KidNapping['sceneFinish'] = false
                    KidNapping['checkVideo'] = true
                    ShowNotification(StringsKidnapping['go_laptop'], 'info')
                end
            end
        end
        if KidNapping['checkVideo'] then
            local laptopDist = #(pedCo - Config['Kidnapping']['query']['laptopScenePos'])
            if laptopDist <= 3.0 then
                sleep = 1
                ShowHelpNotification(StringsKidnapping['check_videorecord'])
                if IsControlJustPressed(0, 38) then
                    KidNapping['checkVideo'] = false
                    LaptopAnimationKidnapping()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function KidnappingFinish()
    TriggerServerEvent('kidnapping:server:finish')
    KidNapping['kidnapped'] = false
    attached = false
    if DoesBlipExist(finishBlip) then
        RemoveBlip(finishBlip)
    end
end

local query = false
function CloseEyesKidnapping()
    ESX.TriggerServerCallback('kidnapping:server:checkQueryRoom', function(status)
        if not status then
            query = false
            DoScreenFadeOut(5000)
            while not IsScreenFadedOut() do
                Citizen.Wait(50)
            end
            loadModel('ch_prop_tunnel_tripod_lampa')
            loadModel('prop_ing_camera_01')
            tripod = CreateObject(GetHashKey('ch_prop_tunnel_tripod_lampa'), Config['Kidnapping']['query']['tripodPos'], 1, 1, 0)
            camera = CreateObject(GetHashKey('prop_ing_camera_01'), Config['Kidnapping']['query']['cameraPos'], 1, 1, 0)
            FreezeEntityPosition(tripod, true)
            FreezeEntityPosition(camera, true)
            SetEntityRotation(camera, 0, 0, Config['Kidnapping']['query']['cameraHeading'], 2, true)
            DoScreenFadeIn(5000)
            FirstAnimationKidnapping()
        else
            ShowNotification(StringsKidnapping['query_room_busy'], 'info')
        end
    end)
end

function KidnappingStart()
    ESX.TriggerServerCallback('kidnapping:server:checkTime', function(time)
        if time then
            query = true
            ShowNotification(StringsKidnapping['info_1'], 'info')
            ShowNotification(StringsKidnapping['info_2'], 'info')
            ShowNotification(StringsKidnapping['info_3'], 'info')
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
            local pedModel = Config['Kidnapping']['pedToKidnapped']
            local random = math.random(1, #Config['Kidnapping']['randomSpawnCoords'])
            local pedCoords = Config['Kidnapping']['randomSpawnCoords'][random]
            kidnappingBlip = addBlip(pedCoords['pos'], 456, 0, StringsKidnapping['kidnap_blip'])
            repeat
                local ped = PlayerPedId()
                local pedCo = GetEntityCoords(ped)
                local dist = #(pedCo - pedCoords['pos'])
                Wait(1)
            until dist <= 100.0
            loadModel(pedModel)
            KidNapping['kidnappedPed'] = CreatePed(4,GetHashKey(pedModel), pedCoords['pos']['x'], pedCoords['pos']['y'], pedCoords['pos']['z'], pedCoords['heading'], 1, 0)
            DecorSetBool(KidNapping['kidnappedPed'], 'ScriptedPed', true)
            SetPedMaxHealth(KidNapping['kidnappedPed'], 200) 
		    SetEntityHealth(KidNapping['kidnappedPed'], 200)
            SetPedDiesWhenInjured(KidNapping['kidnappedPed'], true)
            SetBlockingOfNonTemporaryEvents(KidNapping['kidnappedPed'], true)
            SetEntityInvincible(KidNapping['kidnappedPed'], true)
            local netid = NetworkGetNetworkIdFromEntity(KidNapping['kidnappedPed'])
            Citizen.Wait(1000)
            SetNetworkIdCanMigrate(netid, false)
            Citizen.CreateThread(function()
                while query do
                    local player = PlayerId()
                    local ped = PlayerPedId()
                    local pedCo = GetEntityCoords(ped)
                    local dist = #(pedCo - Config['Kidnapping']['query']['scenePos'])
                    local dist2 = #(pedCo - GetEntityCoords(KidNapping['kidnappedPed']))
                    if dist2 >= 150.0 then
                        ShowNotification(StringsKidnapping['mission_failed2'], 'error')
                        break
                    end
                    if IsPlayerFreeAimingAtEntity(player, KidNapping['kidnappedPed']) then
                        if not IsEntityPlayingAnim(KidNapping['kidnappedPed'], 'missminuteman_1ig_2', 'handsup_enter', 1) then
                            loadAnimDict('missminuteman_1ig_2')
                            TaskPlayAnim(KidNapping['kidnappedPed'], 'missminuteman_1ig_2', 'handsup_enter', 8.0, 8.0, -1, 50, 0, 0, 0, 0)
                            TaskTurnPedToFaceEntity(KidNapping['kidnappedPed'], ped, 1000)
                        end
                    end
                    if IsEntityPlayingAnim(KidNapping['kidnappedPed'], 'missminuteman_1ig_2', 'handsup_enter', 1) then
                        if not attached then
                            ShowHelpNotification(StringsKidnapping['blindfold'])
                            if IsControlJustPressed(0, 38) then
                                BlindfoldKidnapping()
                            end
                        end
                        local x, y = GetEntityPlayerIsFreeAimingAt(player)
                        if GetEntityType(y) == 2 then
                            ShowNotification(StringsKidnapping['go_query'], 'info')
                            TaskEnterVehicle(KidNapping['kidnappedPed'], y, -1, 1, 2.0001, 1)
                            if DoesBlipExist(kidnappingBlip) then
                                RemoveBlip(kidnappingBlip)
                            end
                            if not DoesBlipExist(queryBlip) then
                                queryBlip = addBlip(Config['Kidnapping']['query']['scenePos'], 364, 0, 'Sala de Interrogatório')
                            end
							Citizen.Wait(2000)
                        end
                    end
                    if IsPedInAnyVehicle(KidNapping['kidnappedPed'], false) and not IsPedInAnyVehicle(ped, false) then
                        local vehicle = GetVehiclePedIsIn(ped, true)
                        ShowHelpNotification(StringsKidnapping['leave_vehicle'])
                        if IsControlJustPressed(0, 38) then
                            TaskLeaveVehicle(KidNapping['kidnappedPed'], vehicle, 256)
                        end
                    end
                    if IsEntityDead(KidNapping['kidnappedPed']) then
                        if DoesBlipExist(kidnappingBlip) then
                            RemoveBlip(kidnappingBlip)
                        end
                        if DoesBlipExist(queryBlip) then
                            RemoveBlip(queryBlip)
                        end
                        ShowNotification(StringsKidnapping['mission_failed'], 'error')
                        break
                    end
                    if dist <= 60.0 and not IsPedInAnyVehicle(KidNapping['kidnappedPed'], false) then
                        ShowHelpNotification(StringsKidnapping['start_query'])
                        if IsControlJustPressed(0, 38) then
                            CloseEyesKidnapping()
                            if DoesBlipExist(queryBlip) then
                                RemoveBlip(queryBlip)
                            end
                        end
                    end
                    Citizen.Wait(0)
                end
            end)
        end
    end)
end

function BlindfoldKidnapping()
    if not attached then
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local npcCo = GetEntityCoords(KidNapping['kidnappedPed'])
        local dist = #(pedCo - npcCo)
        if dist <= 2.0 then
            attached = true
            loadAnimDict("random@shop_robbery")
            TaskPlayAnim(ped, "random@shop_robbery", "robbery_action_b", 8.0, -8, -1, 16, 0, 0, 0, 0)
            loadModel('prop_money_bag_01')
            blindfoldObject = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
            AttachEntityToEntity(blindfoldObject, KidNapping['kidnappedPed'], GetPedBoneIndex(KidNapping['kidnappedPed'], 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
            Wait(2000)
            ClearPedTasks(ped)
        else
            ShowNotification(StringsKidnapping['cant_blindfold'], 'error')
        end
    end
end

function KnockoutKidnapping()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local animDict = 'misschinese1leadinoutchinese_1_int'
    loadAnimDict(animDict)

    scene = NetworkCreateSynchronisedScene(pedCo.xy, pedCo.z - 1.0, pedRotation, 2, false, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, scene, animDict, 'husb_leadin_action', 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], scene, animDict, 'russ_leadin_action', 4.0, -4.0, 1033, 0, 1000.0, 0)

    NetworkStartSynchronisedScene(scene)
    Wait(6000)
    SetPedToRagdoll(KidNapping['kidnappedPed'], 30000, 30000, 0, false, false, false)
end

local chair = nil
function FirstAnimationKidnapping()
    TriggerServerEvent('kidnapping:server:syncQueryRoom')
    DeleteObject(blindfoldObject)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "missfbi3_wrench"
    loadAnimDict(animDict)

    for k, v in pairs(Config['Kidnapping']['objects_1']) do
        loadModel(v)
        KidNapping['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end

    loadModel('prop_torture_ch_01')
    chair = CreateObject(GetHashKey('prop_torture_ch_01'), pedCo, 1, 1, 0)

    for i = 1, #Config['Kidnapping']['animations_1'] do
        KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'], Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, false, true, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][2], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(chair, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][1], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][4], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(KidNapping['scenes'][1])
    repeat
        ShowHelpNotification(StringsKidnapping['attack_left'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][2])
    Wait(5000)
    repeat
        ShowHelpNotification(StringsKidnapping['attack_mid'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][3])
    Wait(5000)
    repeat
        ShowHelpNotification(StringsKidnapping['attack_right'])
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][4])
    Wait(5000)
    repeat
        ShowHelpNotification(StringsKidnapping['switch_jerrycan'])
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    DeleteObject(KidNapping['objects'][1])
    TriggerServerEvent('kidnapping:server:policeAlert', GetEntityCoords(PlayerPedId()))
    SecondAnimationKidnapping()
end

function SecondAnimationKidnapping()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "missfbi3_waterboard"
    loadAnimDict(animDict)

    for k, v in pairs(Config['Kidnapping']['objects_2']) do
        loadModel(v)
        KidNapping['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end

    for i = 1, #Config['Kidnapping']['animations_2'] do
        if i == 3 then
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'], Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, false, true, 1065353216, 0, 1065353216)
        else
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'], Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        end
        NetworkAddPedToSynchronisedScene(ped, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][2], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(chair, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][1], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][4], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][2], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][5], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(KidNapping['scenes'][1])
    repeat
        ShowHelpNotification(StringsKidnapping['drop_chair'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][2])
    Wait(15000)
    repeat
        ShowHelpNotification(StringsKidnapping['pour_gasoline'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][3])
    Wait(7500)
    repeat
        ShowHelpNotification(StringsKidnapping['up_chair'])
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][4])
    Wait(5000)
    repeat
        ShowHelpNotification(StringsKidnapping['switch_pliers'])
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    DeleteObject(KidNapping['objects'][1])
    DeleteObject(KidNapping['objects'][2])
    ThirdAnimationKidnapping()
end

function ThirdAnimationKidnapping()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "missfbi3_toothpull"
    loadAnimDict(animDict)

    for k, v in pairs(Config['Kidnapping']['objects_3']) do
        loadModel(v)
        KidNapping['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end

    for i = 1, #Config['Kidnapping']['animations_3'] do
        if i == 3 then
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'] + 0.25, Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, false, true, 1065353216, 0, 1065353216)
        else
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'] + 0.25, Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        end
        NetworkAddPedToSynchronisedScene(ped, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_3'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_3'][i][2], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][1], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_3'][i][3], 1.0, -1.0, 1148846080)
    end
    
    NetworkStartSynchronisedScene(KidNapping['scenes'][1])
    Wait(2000)
    NetworkStartSynchronisedScene(KidNapping['scenes'][2])
    Wait(5000)
    repeat
        ShowHelpNotification(StringsKidnapping['tooth_pull'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][3])
    Wait(7500)
    repeat
        ShowHelpNotification(StringsKidnapping['tooth_rip'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][4])
    Wait(10000)
    DeleteObject(KidNapping['objects'][1])
    ClearPedTasks(ped)
    ClearPedTasks(KidNapping['kidnappedPed'])
    local entity = KidNapping['kidnappedPed']
    local entityCo = GetEntityCoords(KidNapping['kidnappedPed'])
    SetEntityCoords(entity, entityCo.x + 0.5, entityCo.y, entityCo.z - 0.95, 1, 1, 1, 0)
    Wait(250)
    KnockoutKidnapping()
    KidNapping['sceneFinish'] = true
end

function LaptopAnimationKidnapping()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local animDict = "switch@franklin@on_laptop"
    local laptopScenes = {}
    local laptopObject = 'p_laptop_02_s'
    local laptopAnims = {
        {'001927_01_fras_v2_4_on_laptop_idle', '001927_01_fras_v2_4_on_laptop_idle_laptop'},
        {'001927_01_fras_v2_4_on_laptop_exit', '001927_01_fras_v2_4_on_laptop_exit_laptop'}
    }
    loadModel(laptopObject)
    loadAnimDict(animDict)

    sceneObject = CreateObject(GetHashKey(laptopObject), pedCo, 1, 1, 0)

    for i = 1, 2 do
        laptopScenes[i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['laptopScenePos']['x'], Config['Kidnapping']['query']['laptopScenePos']['y'], Config['Kidnapping']['query']['laptopScenePos']['z'] - 0.05, Config['Kidnapping']['query']['laptopSceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, laptopScenes[i], animDict, laptopAnims[i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(sceneObject, laptopScenes[i], animDict, laptopAnims[i][2], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(laptopScenes[1])
    Wait(5000)
    NetworkStartSynchronisedScene(laptopScenes[2])
    Wait(5000)
    DeleteObject(sceneObject)
    ClearPedTasks(ped)
    TriggerServerEvent('kidnapping:server:giveVideoRecord')
	ShowNotification('Conseguiste a gravação de vídeo!', 'success')
    finishBlip = addBlip(Config['Kidnapping']['start']['ped']['pos'], 500, 0, StringsKidnapping['boss_blip'])
    KidNapping['kidnapped'] = true
	ShowNotification('Dirige-te para a localização marcada no GPS para finalizares o trabalho!', 'info')
    TriggerServerEvent('kidnapping:server:syncQueryRoom')
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local npcCo = GetEntityCoords(KidNapping['kidnappedPed'])
            local dist = #(pedCo - npcCo)
            if dist >= 10.0 then
                DeleteObject(chair)
                DeleteObject(tripod)
                DeleteObject(camera)
                DeletePed(KidNapping['kidnappedPed'])
                break
            end
            Citizen.Wait(1)
        end
    end)
end

RegisterNetEvent('kidnapping:client:showNotification')
AddEventHandler('kidnapping:client:showNotification', function(str, type)
    ShowNotification(str, type)
end)