CasinoHeist = {
    ['start'] = true,
    ['finish'] = false,
    ['guardPeds'] = {}
}
Rappel = {
    ['rope'] = nil,
    ['ropeHook'] = nil,
    ['hookPos'] = nil,
    ['randomObject'] = nil,
    ['start'] = false,
}
LockboxAnimation = {
    ['objects'] = {},
    ['scenes'] = {},
}
TrollyAnimation = {
    ['objects'] = {},
    ['scenes'] = {}
}
lockboxs = {}
trollys = {}
hackKeypads = {}
keypadDoors = {}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local dist = #(pedCo - Config['CasinoHeist']['startHeist']['cardSwipe']['scenePos'])

        if dist <= 5.0 then
            sleep = 1
            DrawMarker(1, Config['CasinoHeist']['startHeist']['cardSwipe']['scenePos'].x, Config['CasinoHeist']['startHeist']['cardSwipe']['scenePos'].y + 0.7, Config['CasinoHeist']['startHeist']['cardSwipe']['scenePos'].z - 1.5, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 1.0, 237, 197, 66, 255, false, false)
            if dist <= 3.0 then
                ShowHelpNotification(StringsCasino['start_heist'])
                if IsControlJustPressed(0, 38) then
                    CardSwipeCasino()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end) 


Citizen.CreateThread(function()
	--[[for _, heist in pairs(Config.FleecaHeist) do
		local blip = AddBlipForCoord(Config['CasinoHeist']['startHeist']['cardSwipe'].scenePos)
		SetBlipSprite(blip, 156)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Assalto ao Casino")
		EndTextCommandSetBlipName(blip)
	--end
	--]]
	
	TriggerServerEvent('casinoheist:server:vaultSync')
	TriggerServerEvent('casinoheist:server:lockboxSync')
	TriggerEvent('casinoheist:client:spawnTrollys')
	TriggerEvent('casinoheist:client:spawnVaultKeypads')
end)


function CardSwipeCasino()
    ESX.TriggerServerCallback('casinoheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            ESX.TriggerServerCallback('casinoheist:server:checkTime', function(time)
                if time then
                    local ped = PlayerPedId()
                    local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
                    local animDict = 'anim_heist@hs3f@ig3_cardswipe@male@'
                    local card = 'ch_prop_swipe_card_01a'
                    local scenePos = Config['CasinoHeist']['startHeist']['cardSwipe']['scenePos']
                    local sceneRot = Config['CasinoHeist']['startHeist']['cardSwipe']['sceneRot']
                    loadAnimDict(animDict)
                    loadModel(card)
        
                    cardObj = CreateObject(GetHashKey(card), pedCo, 1, 1, 0)
        
                    cardSwipe = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, cardSwipe, animDict, 'success_var01', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(cardObj, cardSwipe, animDict, 'success_var01_card', 4.0, -8.0, 1)
        
                    NetworkStartSynchronisedScene(cardSwipe)
                    Wait(3000)
                    DeleteObject(cardObj)
                    TriggerServerEvent('casinoheist:server:startHeist', scenePos)
                end
            end)
        else
            ShowNotification(StringsCasino['need_item'] .. itemLabel, 'error')
        end
    end, Config['CasinoHeist']['requiredItems']['startKey'])
end

RegisterNetEvent('casinoheist:client:startHeist')
AddEventHandler('casinoheist:client:startHeist', function()
    ShowNotification(StringsCasino['go_rappel'], 'info')
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config['CasinoHeist']['startHeist']['cardSwipe']['swipeTeleport'], 1, 1, 1, 0)
    CasinoHeist['start'] = true
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local dist = #(pedCo - Config['CasinoHeist']['startHeist']['cardSwipe']['startRappel'])
            if dist <= 5.0 then
                DrawMarker(1, Config['CasinoHeist']['startHeist']['cardSwipe']['startRappel'], 0, 0, 0, 0, 0, 0, 0.8, 0.8, 1.0, 237, 197, 66, 255, false, false)
                if dist <= 2.0 then
                    ShowHelpNotification(StringsCasino['rappel_start'])
                    if IsControlJustPressed(0, 38) then
                        for k, v in pairs(Config['CasinoHeist']['startHeist']['rappel']) do
                            if not v['busy'] then
								TriggerServerEvent('casinoheist:server:rappelBusy', k)
                                PlayCutsceneCasino('hs3f_mul_rp1')
                                TriggerEvent('casinoheist:client:startRappel', v['coords'], k)
                                found = true
                                index = k
                                break
                            else
                                found = false
                            end
                        end
                        if found then
                            RappelLoopCasino(index)
                            PlayCutsceneCasino('hs3f_mul_rp2')
							-- retira freeze que foi colocado (anti bug queda livre)
							FreezeEntityPosition(ped, false)
                            SetEntityCoords(ped, Config['CasinoHeist']['startHeist']['cardSwipe']['rappelTeleport'], 1, 1, 1, 0)
                            break
                        else
                            ShowNotification(StringsCasino['rappels_busy'], 'info')
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end)

RegisterNetEvent('casinoheist:client:rappelBusy')
AddEventHandler('casinoheist:client:rappelBusy', function(index)
    Config['CasinoHeist']['startHeist']['rappel'][tonumber(index)]['busy'] = not Config['CasinoHeist']['startHeist']['rappel'][tonumber(index)]['busy']
end)

RegisterNetEvent('casinoheist:client:startRappel')
AddEventHandler('casinoheist:client:startRappel', function(coords, index)
    local ped = PlayerPedId()
    local pedCo = coords
    SetEntityCoords(ped, pedCo.x, pedCo.y, pedCo.z, 1, 1, 1, 0)
	--FreezeEntityPosition(ped, true)

    Wait(250)
    loadModel('prop_ashtray_01')
    loadModel('prop_rope_hook_01')
    SetEntityCoords(ped, pedCo.x, pedCo.y - 1.5, pedCo.z, 1, 1, 1, 0)
    SetEntityHeading(ped, 1.15)
	-- retira freeze que foi colocado (anti bug queda livre)
	FreezeEntityPosition(ped, false)
    Rappel['randomObject'] = CreateObject(GetHashKey('prop_ashtray_01'), pedCo.x, pedCo.y - 1.5, pedCo.z - 1, 0, 1, 0)
    SetEntityCompletelyDisableCollision(Rappel['randomObject'], true, true)
    SetEntityAlpha(Rappel['randomObject'], 0, 0)
    FreezeEntityPosition(Rappel['randomObject'], true)
    ropeHookSpawn = vector3(coords.x, coords.y - 0.43, coords.z - 0.46)
    Rappel['ropeHook'] = CreateObject(GetHashKey('prop_rope_hook_01'), ropeHookSpawn, 0, 1, 0)
    SetEntityRotation(Rappel['ropeHook'], -90.0, 0, 0, 1, 1)
    FreezeEntityPosition(Rappel['ropeHook'], true)
    Rappel['hookPos'] = GetEntityCoords(Rappel['ropeHook'])
    Rappel['start'] = true
    RopeLoadTextures()
    Rappel['rope'] = AddRope(Rappel['hookPos'].x, Rappel['hookPos'].y, Rappel['hookPos'].z, 0.0, 0.0, 0.0, 99.0, 2, 1.5, 0.0, 0.0, 0, 0, 1, 0.0, false)
    StartRopeWinding(Rappel['rope'])
    AttachEntitiesToRope(Rappel['rope'], ped, Rappel['ropeHook'], pedCo.x + 0.03, pedCo.y - 1.34, pedCo.z, Rappel['hookPos'].x, Rappel['hookPos'].y - 0.3, Rappel['hookPos'].z, 10.0, 0, 0, 18905, nil)
    NightvisionCasino()
end)

function RappelLoopCasino(index)
    loadAnimDict('missrappel')
    while true do
        ShowHelpNotification(StringsCasino['rappel_action'])
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local exit = Config['CasinoHeist']['startHeist']['cardSwipe']['finishRappel']
        local dist = #(pedCo - exit)
        if Rappel['start'] and not IsEntityPlayingAnim(PlayerPedId(), 'missrappel', 'rappel_idle', 3) and not slide and not down then
            TaskPlayAnim(ped, 'missrappel', 'rappel_idle', 1.0, -1.0, -1, 1, 0.1, 0, 0, 0)
        end
        if slide and not IsEntityPlayingAnim(ped, 'missrappel', 'rope_slide', 3) then
            TaskPlayAnim(ped, 'missrappel', 'rope_slide', 4.0, 1.0, -1, 1, 32, 0.8, 0, 0)
        end
        if down and not IsEntityPlayingAnim(ped, 'missrappel', 'rappel_walk', 3) then
            TaskPlayAnim(ped, 'missrappel', 'rappel_walk', 4.0, 1.0, -1, 1, 32, 0.8, 0, 0)
        end
        if Rappel['start'] and Rappel['rope'] then
            if IsControlPressed(0, 33) and not slide then
                down = true
                RopeForceLength(Rappel['rope'], RopeGetDistanceBetweenEnds(Rappel['rope']) + 0.1)
                SetEntityCoords(Rappel['randomObject'], pedCo.xy, pedCo.z - 1.5)
            end
            if IsControlPressed(0, 38) and not down then
                slide = true
                RopeForceLength(Rappel['rope'], RopeGetDistanceBetweenEnds(Rappel['rope']) + 0.3)
                SetEntityCoords(Rappel['randomObject'], pedCo.xy, pedCo.z - 1.5)
            end
            if IsControlReleased(0, 33) then
                down = false
            end
            if IsControlReleased(0, 38) then
                slide = false
            end
        end
        if dist <= 3.0 then
            Rappel['start'] = false
            TriggerServerEvent('casinoheist:server:npcSync')
            ClearPedTasks(ped)
            DetachRopeFromEntity(Rappel['rope'], ped)
            RopeUnloadTextures()
            DeleteRope(Rappel['rope'])
            ShowNotification(StringsCasino['go_base'], 'info')
            break
        end
        Citizen.Wait(1)
    end
    TriggerServerEvent('casinoheist:server:rappelBusy', index)
end

RegisterNetEvent('casinoheist:client:policeAlert')
AddEventHandler('casinoheist:client:policeAlert', function(targetCoords)
    --ShowNotification(StringsCasino['police_alert'], 'warn')
    local street = GetStreetAndZone()
	TriggerEvent('police:assaltos', 'Assalto a decorrer no Casino', targetCoords, street)
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

RegisterNetEvent('casinoheist:client:npcSync')
AddEventHandler('casinoheist:client:npcSync', function()
    GuardPedsCasino()
    TriggerServerEvent('casinoheist:server:policeAlert', Config['CasinoHeist']['startHeist']['cardSwipe']['scenePos'])
end)

function GuardPedsCasino()
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)

    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    AddRelationshipGroup('GuardPeds')

    for k, v in pairs(Config['CasinoHeist']['middleHeist']['guardPeds']) do
        loadModel(v['model'])
        CasinoHeist['guardPeds'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(CasinoHeist['guardPeds'][k])
        networkID = NetworkGetNetworkIdFromEntity(CasinoHeist['guardPeds'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetEntityAsMissionEntity(CasinoHeist['guardPeds'][k])
        SetEntityVisible(CasinoHeist['guardPeds'][k], true)
        SetPedRelationshipGroupHash(CasinoHeist['guardPeds'][k], GetHashKey("GuardPeds"))
        SetPedAccuracy(CasinoHeist['guardPeds'][k], 50)
        SetPedArmour(CasinoHeist['guardPeds'][k], 100)
        SetPedCanSwitchWeapon(CasinoHeist['guardPeds'][k], true)
        SetPedDropsWeaponsWhenDead(CasinoHeist['guardPeds'][k], false)
		SetPedFleeAttributes(CasinoHeist['guardPeds'][k], 0, false)
        GiveWeaponToPed(CasinoHeist['guardPeds'][k], GetHashKey('WEAPON_PISTOL'), 255, false, false)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(CasinoHeist['guardPeds'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))
	SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))
end

local nightvision = false
function NightvisionCasino()
    baseBlip = addBlip(Config['CasinoHeist']['middleHeist']['nightvision']['startPos'], 128, 70, StringsCasino['base_blip'])
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['CasinoHeist']['middleHeist']['nightvision']['startPos'])
        if dist <= 3.0 and not nightvision then
            for k, v in pairs(CasinoHeist['guardPeds']) do
                SetPedSeeingRange(v, 3.0)
            end
            TriggerServerEvent('casinoheist:server:nightVision')
            nightvision = true
        end
        if nightvision then
            break
        end
        Citizen.Wait(1)
    end
end

local doors = {}
local keypads = {}
local syncDoor = {false, false}
local vaultLoop = false
RegisterNetEvent('casinoheist:client:nightVision')
AddEventHandler('casinoheist:client:nightVision', function(value)
    ShowNotification(StringsCasino['emp_activated'], 'info')
    nightvision = true
    SetNightvision(true)
    time = Config['CasinoHeist']['middleHeist']['nightvision']['time']
    doors[1] = GetClosestObjectOfType(Config['CasinoHeist']['middleHeist']['nightvision']['baseDoors'][1]['coords'], 50.0, 187642590, 0, 0, 0)
    doors[2] = GetClosestObjectOfType(Config['CasinoHeist']['middleHeist']['nightvision']['baseDoors'][2]['coords'], 50.0, 187642590, 0, 0, 0)
	SetEntityProofs(doors[1], true, true, true, true, true, true, true, true)
	SetEntityProofs(doors[2], true, true, true, true, true, true, true, true)
    FreezeEntityPosition(doors[1], true)
    FreezeEntityPosition(doors[2], true)
    loadModel('ch_prop_casino_keypad_01')
    keypads[1] = CreateObject(GetHashKey('ch_prop_casino_keypad_01'), Config['CasinoHeist']['middleHeist']['nightvision']['baseKeypads'][1]['coords'], 0, 1, 0)
    keypads[2] = CreateObject(GetHashKey('ch_prop_casino_keypad_01'), Config['CasinoHeist']['middleHeist']['nightvision']['baseKeypads'][2]['coords'], 0, 1, 0)
    SetEntityHeading(keypads[1], Config['CasinoHeist']['middleHeist']['nightvision']['baseKeypads'][1]['heading'])
    SetEntityHeading(keypads[2], Config['CasinoHeist']['middleHeist']['nightvision']['baseKeypads'][2]['heading'])
    RemoveBlip(baseBlip)
    middleDoors = addBlip(Config['CasinoHeist']['middleHeist']['nightvision']['baseDoors'][1]['coords'], 128, 70, StringsCasino['middle_doors_blip'])
    repeat
        time = time - 1
        Wait(1000)
    until time <= 0
    ShowNotification(StringsCasino['emp_deactivated'], 'info')
    SetNightvision(false)
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - GetEntityCoords(keypads[1]))
        local dist2 = #(pedCo - GetEntityCoords(keypads[2]))
        if dist <= 2.0 and not syncDoor[1] then
            ShowHelpNotification(StringsCasino['swipe_card_base'])
            if IsControlJustPressed(0, 38) then
                CardSwipeMiddleCasino(keypads[1], 1)
            end
        elseif dist2 <= 2.0 and not syncDoor[2] then
            ShowHelpNotification(StringsCasino['swipe_card_base'])
            if IsControlJustPressed(0, 38) then
                CardSwipeMiddleCasino(keypads[2], 2)
            end
        end
        if syncDoor[1] and syncDoor[2] then
            ShowNotification(StringsCasino['door_opened'], 'info')
            FreezeEntityPosition(doors[1], false)
            FreezeEntityPosition(doors[2], false)
            vaultLoop = true
            TriggerEvent('casinoheist:client:vaultAction')
            break
        end
        Wait(1)
    end
end)

RegisterNetEvent('casinoheist:client:syncDoor')
AddEventHandler('casinoheist:client:syncDoor', function(index)
    syncDoor[index] = true
end)

function CardSwipeMiddleCasino(door, index)
    ESX.TriggerServerCallback('casinoheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            syncDoor[index] = true
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
            local animDict = 'anim_heist@hs3f@ig3_cardswipe@male@'
            local card = 'ch_prop_swipe_card_01d'
            loadAnimDict(animDict)
            loadModel(card)
        
            cardObj = CreateObject(GetHashKey(card), pedCo, 1, 1, 0)
        
            cardSwipe = NetworkCreateSynchronisedScene(GetEntityCoords(door), GetEntityRotation(door), 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, cardSwipe, animDict, 'success_var01', 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(cardObj, cardSwipe, animDict, 'success_var01_card', 4.0, -8.0, 1)
        
            NetworkStartSynchronisedScene(cardSwipe)
            Wait(3000)
            TriggerServerEvent('casinoheist:server:syncDoor', index)
            DeleteObject(cardObj)
        else
            ShowNotification(StringsCasino['need_item'] .. itemLabel, 'error')
        end
    end, Config['CasinoHeist']['requiredItems']['basementKey'])
end

local someoneDrill = false
local vault = nil
RegisterNetEvent('casinoheist:client:vaultAction')
AddEventHandler('casinoheist:client:vaultAction', function()
    RemoveBlip(middleDoors)
    vaultBlip = addBlip(Config['CasinoHeist']['middleHeist']['vaultAction']['pos'], 128, 70, StringsCasino['vault'])
    while vaultLoop do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['CasinoHeist']['middleHeist']['vaultAction']['pos'])
        vault = GetClosestObjectOfType(Config['CasinoHeist']['middleHeist']['vaultAction']['pos'], 50.0, -1520917551, 0, 0, 0)
        SetEntityHeading(vault, 90.0)
        FreezeEntityPosition(vault, true)
        if not someoneDrill then
            if dist <= 5.0 then
                DrawMarker(1, Config['CasinoHeist']['middleHeist']['vaultAction']['pos'].xy, Config['CasinoHeist']['middleHeist']['vaultAction']['pos'].z - 1.0, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 1.0, 237, 197, 66, 255, false, false)
                if dist <= 2.0 then
                    ShowHelpNotification(StringsCasino['laser_drill'])
                    if IsControlJustPressed(0, 38) then
                        OpenVaultCasino()
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('casinoheist:client:drillSync')
AddEventHandler('casinoheist:client:drillSync', function()
    someoneDrill = not someoneDrill
end)

RegisterNetEvent('casinoheist:client:vaultSync')
AddEventHandler('casinoheist:client:vaultSync', function()
    vaultLoop = false
    repeat
        SetEntityHeading(vault, GetEntityHeading(vault) + 0.25)
        Wait(10)
    until GetEntityHeading(vault) >= 180.0
end)

function OpenVaultCasino()
    ESX.TriggerServerCallback('casinoheist:server:hasItem', function(hasItem, itemLabel)
        if hasItem then
            TriggerServerEvent('casinoheist:server:drillSync')
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
            
            vaultPos = Config['CasinoHeist']['middleHeist']['vaultAction']['vaultScenePos']
            vaultRot = Config['CasinoHeist']['middleHeist']['vaultAction']['vaultSceneRot']

            for i = 1, #LaserDrillCasino['animations'] do
                LaserDrillCasino['scenes'][i] = NetworkCreateSynchronisedScene(vaultPos, vaultRot, 2, true, false, 1065353216, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, LaserDrillCasino['scenes'][i], animDict, LaserDrillCasino['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                NetworkAddEntityToSynchronisedScene(bag, LaserDrillCasino['scenes'][i], animDict, LaserDrillCasino['animations'][i][2], 1.0, -1.0, 1148846080)
                NetworkAddEntityToSynchronisedScene(laserDrill, LaserDrillCasino['scenes'][i], animDict, LaserDrillCasino['animations'][i][3], 1.0, -1.0, 1148846080)
            end

            NetworkStartSynchronisedScene(LaserDrillCasino['scenes'][1])
            PlayCamAnim(cam, 'intro_cam', animDict, vaultPos, vaultRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'intro') * 1000)

            NetworkStartSynchronisedScene(LaserDrillCasino['scenes'][2])
            PlayCamAnim(cam, 'drill_straight_start_cam', animDict, vaultPos, vaultRot, 0, 2)
            Wait(GetAnimDuration(animDict, 'drill_straight_start') * 1000)

            NetworkStartSynchronisedScene(LaserDrillCasino['scenes'][3])
            PlayCamAnim(cam, 'drill_straight_idle_cam', animDict, vaultPos, vaultRot, 0, 2)
            Drilling.Start(function(status)
                if status then
                    NetworkStartSynchronisedScene(LaserDrillCasino['scenes'][5])
                    PlayCamAnim(cam, 'drill_straight_end_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'drill_straight_end') * 1000)
                    NetworkStartSynchronisedScene(LaserDrillCasino['scenes'][6])
                    PlayCamAnim(cam, 'exit_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'exit') * 1000)
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(cam, false)
                    ClearPedTasks(ped)
                    DeleteObject(bag)
                    DeleteObject(laserDrill)
                    SetEntityAlpha(vault, 0, 0)
                    TriggerServerEvent('casinoheist:server:vaultSync')
                    TriggerServerEvent('casinoheist:server:lockboxSync')
                    TriggerEvent('casinoheist:client:spawnTrollys')
                    TriggerEvent('casinoheist:client:spawnVaultKeypads')
                    PlayCutsceneCasino('hs3f_mul_vlt')
                    SetEntityAlpha(vault, 255, 0)
                    vaultLoop = false
                else
                    NetworkStartSynchronisedScene(LaserDrillCasino['scenes'][4])
                    PlayCamAnim(cam, 'drill_straight_fail_cam', animDict, vaultPos, vaultRot, 0, 2)
                    Wait(GetAnimDuration(animDict, 'drill_straight_fail') * 1000 - 1500)
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(cam, false)
                    ClearPedTasks(ped)
                    DeleteObject(bag)
                    DeleteObject(laserDrill)
                    TriggerServerEvent('casinoheist:server:drillSync')
                end
            end)
        else
            ShowNotification(StringsCasino['need_item'] .. itemLabel, 'error')
        end
    end, Config['CasinoHeist']['requiredItems']['drill'])
end

RegisterNetEvent('casinoheist:client:lockboxSync')
AddEventHandler('casinoheist:client:lockboxSync', function()
    RemoveBlip(vaultBlip)
    exitBlip = addBlip(Config['CasinoHeist']['finishHeist']['pos'], 128, 70, StringsCasino['exit_blip'])
    ShowNotification(StringsCasino['vault_open'], 'info')
    for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects']) do
        if v['oldModel'] ~= nil and v['type'] == 'lockbox' then
            local object = GetClosestObjectOfType(v['coords'], 100.0, v['oldModel'], 0, 0, 0)
            local objHeading = GetEntityHeading(object)
            local objCoords = GetEntityCoords(object)
            SetEntityVisible(object, false, 0)
            SetEntityAlpha(object, 0, 0)
            SetEntityCollision(object, false, false)
            loadModel(v['newModel'])
            lockboxs[k] = CreateObject(v['newModel'], GetEntityCoords(object), 0, 0, 0)
            SetEntityHeading(lockboxs[k], GetEntityHeading(object))
        end
    end
    Citizen.CreateThread(function()
        for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['keypads']) do
            keypadDoors[k] = GetClosestObjectOfType(v['coords'], 5.0, -219532439, 0, 0, 0)
            FreezeEntityPosition(keypadDoors[k], true)
        end
        while true do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local exitDist = #(pedCo - Config['CasinoHeist']['finishHeist']['pos'])
            for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects']) do
                if not v['grab'] then
                    local dist = #(pedCo - v['coords'])
                    if dist <= 1.5 then
                        if v['type'] == 'trolly' then
                            ShowHelpNotification(StringsCasino['grab'])
                            if IsControlJustPressed(0, 38) then
                                TriggerServerEvent('casinoheist:server:lootSync', k)
                                GrabCasino(k)
                            end
                        else
                            ShowHelpNotification(StringsCasino['lockbox_drill'])
                            if IsControlJustPressed(0, 38) then
                                TriggerServerEvent('casinoheist:server:lootSync', k)
                                LockboxDrillCasino(lockboxs[k], k)
                            end
                        end
                    end
                end
            end

            for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['keypads']) do
                if not v['hacked'] then
                    if not hacking then
                        local dist = #(pedCo - v['coords'])
                        if dist <= 1.5 then
                            ShowHelpNotification(StringsCasino['hack_keypad'])
                            if IsControlJustPressed(0, 38) then
                                HackingCasino(k)
                            end
                        end
                    end
                else
                    FreezeEntityPosition(keypadDoors[k], false)
                end
            end

            if exitDist <= 5.0 then
                DrawMarker(1, Config['CasinoHeist']['finishHeist']['pos'], 0, 0, 0, 0, 0, 0, 0.8, 0.8, 1.0, 237, 197, 66, 255, false, false)
                if exitDist <= 2.0 then
                    ShowHelpNotification(StringsCasino['exit_casino'])
                    if IsControlJustPressed(0, 38) then
                        OutsideCasino()
                        break
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end)

function OutsideCasino()
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    ResetHeistCasino()
    ShowNotification(StringsCasino['deliver_to_buyer'], 'info')
    SetEntityCoords(ped, Config['CasinoHeist']['finishHeist']['outsidePos'])
    --loadModel('baller')
    RemoveBlip(exitBlip)
    buyerBlip = addBlip(Config['CasinoHeist']['finishHeist']['buyerPos'], 500, 0, StringsCasino['buyer_blip'])
    --buyerVehicle = CreateVehicle(GetHashKey('baller'), Config['CasinoHeist']['finishHeist']['buyerPos'].xy + 10.0, Config['CasinoHeist']['finishHeist']['buyerPos'].z, 269.4, 0, 0)
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - Config['CasinoHeist']['finishHeist']['buyerPos'])

        if dist <= 15.0 then
            PlayCutsceneCasino('hs3f_all_drp3', Config['CasinoHeist']['finishHeist']['buyerPos'])
            --DeleteVehicle(buyerVehicle)
            RemoveBlip(buyerBlip)
            TriggerServerEvent('casinoheist:server:sellRewardItems')
            break
        end
        Wait(1)
    end
end

function ResetHeistCasino()
    for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects']) do
        v['grab'] = false
    end

    for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['keypads']) do
        v['hacked'] = false
    end

    for k, v in pairs(Config['CasinoHeist']['startHeist']['rappel']) do
        v['busy'] = false
    end

    for k, v in pairs(lockboxs) do
        DeleteObject(v)
    end

    nightvision = false
    syncDoor = {false, false}
    someoneDrill = false
    lockboxs = {}
    trollys = {}
    hackKeypads = {}
    keypadDoors = {}
end

RegisterNetEvent('casinoheist:client:lootSync')
AddEventHandler('casinoheist:client:lootSync', function(index)
    Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects'][index]['grab'] = true
end)

RegisterNetEvent('casinoheist:client:spawnTrollys')
AddEventHandler('casinoheist:client:spawnTrollys', function()
    for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects']) do
        if v['oldModel'] ~= nil and v['type'] == 'trolly' then
			loadModel(v['newModel'])
            trollys[k] = CreateObject(v['newModel'], v['coords'], 1, 0, 0)
            SetEntityHeading(trollys[k], v['heading'])
        end
    end
end)

RegisterNetEvent('casinoheist:client:deleteLockbox')
AddEventHandler('casinoheist:client:deleteLockbox', function(index)
    DeleteObject(lockboxs[index])
end)

RegisterNetEvent('casinoheist:client:spawnVaultKeypads')
AddEventHandler('casinoheist:client:spawnVaultKeypads', function()
    for k, v in pairs(Config['CasinoHeist']['middleHeist']['vaultInside']['keypads']) do
        loadModel('ch_prop_casino_keypad_01')
        hackKeypads[k] = CreateObject('ch_prop_casino_keypad_01', v['coords'], 1, 0, 0)
        SetEntityHeading(hackKeypads[k], v['heading'])
    end
end)

RegisterNetEvent('casinoheist:client:vaultKeypadsSync')
AddEventHandler('casinoheist:client:vaultKeypadsSync', function(index)
    Config['CasinoHeist']['middleHeist']['vaultInside']['keypads'][index]['hacked'] = true
end)

function HackingCasino(index)
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
    keypad = GetClosestObjectOfType(Config['CasinoHeist']['middleHeist']['vaultInside']['keypads'][index]['coords'], 2.0, GetHashKey('ch_prop_casino_keypad_01'), false, false, false)

    for i = 1, #HackKeypadCasino['animations'] do
        HackKeypadCasino['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, HackKeypadCasino['scenes'][i], animDict, HackKeypadCasino['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(usb, HackKeypadCasino['scenes'][i], animDict, HackKeypadCasino['animations'][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(phone, HackKeypadCasino['scenes'][i], animDict, HackKeypadCasino['animations'][i][3], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(HackKeypadCasino['scenes'][1])
    Wait(4000)
    NetworkStartSynchronisedScene(HackKeypadCasino['scenes'][2])
    Wait(2000)
    TriggerEvent("utk_fingerprint:Start", 4, 6, 2, function(outcome, reason)
        if outcome == true then 
            Wait(5000)
            NetworkStartSynchronisedScene(HackKeypadCasino['scenes'][3])
            Wait(4000)
            DeleteObject(usb)
            DeleteObject(phone)
            ClearPedTasks(ped)
            TriggerServerEvent('casinoheist:server:vaultKeypadsSync', index)
            hacking = false
        elseif outcome == false then
            Wait(5000)
            NetworkStartSynchronisedScene(HackKeypadCasino['scenes'][4])
            Wait(4000)
            DeleteObject(usb)
            DeleteObject(phone)
            ClearPedTasks(ped)
            hacking = false
        end
    end)
end

function GrabCasino(index)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
    local grabModel = Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects'][index]['newModel']
    local animDict = 'anim@heists@ornate_bank@grab_cash'
    if grabModel == 881130828 then
        grabModel = 'ch_prop_vault_dimaondbox_01a'
    elseif grabModel == 2007413986 then
        grabModel = 'ch_prop_gold_bar_01a'
    elseif grabModel == 3031213828 then
        grabModel = 'prop_coke_block_half_a'
    else
        grabModel = 'hei_prop_heist_cash_pile'
    end
    loadAnimDict(animDict)
    loadModel('hei_p_m_bag_var22_arm_s')

    sceneObject = GetClosestObjectOfType(Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects'][index]['coords'], 2.0, Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects'][index]['newModel'], false, false, false)
    bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pedCo, true, false, false)

    while not NetworkHasControlOfEntity(sceneObject) do
        Citizen.Wait(1)
        NetworkRequestControlOfEntity(sceneObject)
    end

    for i = 1, #TrollyCasino['animations'] do
        TrollyAnimation['scenes'][i] = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, TrollyAnimation['scenes'][i], animDict, TrollyCasino['animations'][i][1], 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, TrollyAnimation['scenes'][i], animDict, TrollyCasino['animations'][i][2], 4.0, -8.0, 1)
        if i == 2 then
            NetworkAddEntityToSynchronisedScene(sceneObject, TrollyAnimation['scenes'][i], animDict, "cart_cash_dissapear", 4.0, -8.0, 1)
        end
    end

    NetworkStartSynchronisedScene(TrollyAnimation['scenes'][1])
    Wait(1750)
    CashAppearCasino(grabModel)
    NetworkStartSynchronisedScene(TrollyAnimation['scenes'][2])
    Wait(37000)
    NetworkStartSynchronisedScene(TrollyAnimation['scenes'][3])
    Wait(2000)

    local emptyobj = 769923921
    newTrolly = CreateObject(emptyobj, Config['CasinoHeist']['middleHeist']['vaultInside']['changeObjects'][index]['coords'],  true, false, false)
    SetEntityRotation(newTrolly, 0, 0, GetEntityHeading(sceneObject), 1, 0)
    DeleteObject(sceneObject)
    DeleteObject(bag)
end

function CashAppearCasino(grabModel)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    if grabModel == 'ch_prop_vault_dimaondbox_01a' then
        reward = Config['CasinoHeist']['rewardItems']['diamondTrolly']
    elseif grabModel == 'ch_prop_gold_bar_01a' then
        reward = Config['CasinoHeist']['rewardItems']['goldTrolly']
    elseif grabModel == 'prop_coke_block_half_a' then
        reward = Config['CasinoHeist']['rewardItems']['cokeTrolly']
    elseif grabModel == 'hei_prop_heist_cash_pile' then
        reward = Config['CasinoHeist']['rewardItems']['cashTrolly']
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
                    TriggerServerEvent('casinoheist:server:rewardItem', reward)
                end
            end
        end
        DeleteObject(grabobj)
    end)
end

function LockboxDrillCasino(closest, index)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
    local animDict = {
        'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@',
        'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@',
        'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@',
        'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_04@male@',
    }

    for i = 1, #animDict do
        loadAnimDict(animDict[i])
    end

    local test = CreateObject(-2110344306, GetEntityCoords(closest), 1, 0, 0)
    SetEntityHeading(test, GetEntityHeading(closest))
    PlaceObjectOnGroundProperly(test)
    FreezeEntityPosition(test, true)
    SetEntityCompletelyDisableCollision(test, false, false)
    TriggerServerEvent('casinoheist:server:deleteLockbox', index)

    for k, v in pairs(LockboxCasino['objects']) do
        loadModel(v)
        if k ~= 3 then
            LockboxAnimation['objects'][k] = CreateObject(GetHashKey(v), GetEntityCoords(test), 1, 0, 0)
        else
            LockboxAnimation['objects'][k] = CreateObject(GetHashKey(v), GetEntityCoords(test).xy, GetEntityCoords(test).z, - 5.0, 1, 0, 0)
        end
    end

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)

    while not NetworkHasControlOfEntity(test) do
        Citizen.Wait(1)
        NetworkRequestControlOfEntity(test)
    end

    for j = 1, #animDict do
        for i = 1, #LockboxCasino['animations'] do
            LockboxAnimation['scenes'][j..i] = NetworkCreateSynchronisedScene(GetEntityCoords(test), GetEntityRotation(test), 2, true, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, LockboxAnimation['scenes'][j..i], animDict[j], LockboxCasino['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(test, LockboxAnimation['scenes'][j..i], animDict[j], LockboxCasino['animations'][i][2], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(LockboxAnimation['objects'][1], LockboxAnimation['scenes'][j..i], animDict[j], LockboxCasino['animations'][i][3], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(LockboxAnimation['objects'][2], LockboxAnimation['scenes'][j..i], animDict[j], LockboxCasino['animations'][i][4], 1.0, -1.0, 1148846080)
            if i == 3 then
                NetworkAddEntityToSynchronisedScene(LockboxAnimation['objects'][3], LockboxAnimation['scenes'][j..i], animDict[j], LockboxCasino['animations'][i][5], 1.0, -1.0, 1148846080)
            end
        end
    end

    NetworkStartSynchronisedScene(LockboxAnimation['scenes']['11'])
    PlayCamAnim(cam, 'enter_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
    Wait(GetAnimDuration(animDict[1], 'enter') * 1000)
    NetworkStartSynchronisedScene(LockboxAnimation['scenes']['12'])
    PlayCamAnim(cam, 'action_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
    Wait(GetAnimDuration(animDict[1], 'action') * 1000 - 1000)
    local random = math.random(1, 100)
    if random >= 40 then
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['13'])
        PlayCamAnim(cam, 'reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[1], 'reward') * 1000)
        local reward = Config['CasinoHeist']['rewardItems']['lockbox']()
        TriggerServerEvent('casinoheist:server:rewardItem', reward)
		ShowNotification('Encontraste algo neste cofre!', 'success')
    else
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['14'])
        PlayCamAnim(cam, 'no_reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[1], 'no_reward') * 1000)
		ShowNotification('Este cofre estava vazio!', 'error')
    end
    NetworkStartSynchronisedScene(LockboxAnimation['scenes']['22'])
    PlayCamAnim(cam, 'action_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
    Wait(GetAnimDuration(animDict[2], 'action') * 1000 - 1000)
    local random = math.random(1, 100)
    if random >= 40 then
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['23'])
        PlayCamAnim(cam, 'reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[2], 'reward') * 1000)
        local reward = Config['CasinoHeist']['rewardItems']['lockbox']()
        TriggerServerEvent('casinoheist:server:rewardItem', reward)
		ShowNotification('Encontraste algo neste cofre!', 'success')
    else
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['24'])
        PlayCamAnim(cam, 'no_reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[2], 'no_reward') * 1000)
		ShowNotification('Este cofre estava vazio!', 'error')
    end
    NetworkStartSynchronisedScene(LockboxAnimation['scenes']['32'])
    PlayCamAnim(cam, 'action_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
    Wait(GetAnimDuration(animDict[3], 'action') * 1000 - 1000)
    local random = math.random(1, 100)
    if random >= 40 then
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['33'])
        PlayCamAnim(cam, 'reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[3], 'reward') * 1000)
        local reward = Config['CasinoHeist']['rewardItems']['lockbox']()
        TriggerServerEvent('casinoheist:server:rewardItem', reward)
		ShowNotification('Encontraste algo neste cofre!', 'success')
    else
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['34'])
        PlayCamAnim(cam, 'no_reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[3], 'no_reward') * 1000)
		ShowNotification('Este cofre estava vazio!', 'error')
    end
    NetworkStartSynchronisedScene(LockboxAnimation['scenes']['42'])
    PlayCamAnim(cam, 'action_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_04@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
    Wait(GetAnimDuration(animDict[4], 'action') * 1000 - 1000)
    local random = math.random(1, 100)
    if random >= 40 then
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['43'])
        PlayCamAnim(cam, 'reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_04@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[4], 'reward') * 1000)
        local reward = Config['CasinoHeist']['rewardItems']['lockbox']()
        TriggerServerEvent('casinoheist:server:rewardItem', reward)
		ShowNotification('Encontraste algo neste cofre!', 'success')
    else
        NetworkStartSynchronisedScene(LockboxAnimation['scenes']['44'])
        PlayCamAnim(cam, 'no_reward_cam', 'anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_04@male@', GetEntityCoords(test), GetEntityRotation(test), 0, 2)
        Wait(GetAnimDuration(animDict[4], 'no_reward') * 1000)
		ShowNotification('Este cofre estava vazio!', 'error')
    end
    ClearPedTasks(ped)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    for k, v in pairs(LockboxAnimation['objects']) do
        DeleteObject(v)
    end
end

RegisterNetEvent('casinoheist:client:showNotification')
AddEventHandler('casinoheist:client:showNotification', function(str, type)
    ShowNotification(str, type)
end)

--Thanks to d0p3t
function PlayCutsceneCasino(cut, coords)
	while not HasThisCutsceneLoaded(cut) do 
        RequestCutscene(cut, 8)
        Wait(0) 
    end

    if cut == 'hs3f_mul_vlt' then
	    CreateCutscene(false, false)
    elseif cut == 'hs3f_all_drp3' then
        CreateCutscene(false, coords)
    else
        CreateCutscene(true, false)
	end
    Finish()
    RemoveCutscene()
    DoScreenFadeIn(500)
end