function openDoor()
    --trigger to open door room
end

function openCloset()
    if Config.Framework == "esx" then
        ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
			local elements = {}

			for i=1, #dressing, 1 do
			  table.insert(elements, {label = dressing[i], value = i})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
				title    = 'Guarda-Roupa',
				align    = 'top-left',
				elements = elements,
			}, function(data, menu)

				TriggerEvent('skinchanger:getSkin', function(skin)

					ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)

					  TriggerEvent('skinchanger:loadClothes', skin, clothes)
					  TriggerEvent('esx_skin:setLastSkin', skin)

					  TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
					  end)
					  
					--  ESX.ShowNotification(_U('loaded_outfit'))
					  HasLoadCloth = true
					end, data.current.value)
				end)
			end, function(data, menu)
				menu.close()
			end)
		end)
    else
        TriggerEvent("qb-clothing:client:openOutfitMenu")
    end
end

function openDeposit()
    if Config.Framework == "esx" then
        local playerID = GetPlayerServerId(PlayerId())
        TriggerServerEvent("bit-motels:registerStash", playerID)
        local lockerID = math.round(1, 999999)
        local other = {}
        other.maxweight = 500000 -- Custom weight statsh.
        other.slots = 100 -- Custom slots spaces.
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Motel_"..ESX.GetPlayerData().identifier, other)
        TriggerEvent("inventory:client:SetCurrentStash", "Motel_"..ESX.GetPlayerData().identifier)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "motelstash" .. QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "motelstash_" .. QBCore.Functions.GetPlayerData().citizenid)
    end
end

function loadAnimation(dict)
    if IsPedArmed(GetPlayerPed(-1), 7) then
        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
    end
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function startWashFace()
    SetEntityHeading(PlayerPedId(), 188.07)
    loadAnimation("missmic2_washing_face")                                     
    TaskPlayAnim(PlayerPedId(), "missmic2_washing_face","michael_washing_face", 2.0, 2.0, 5000, 0, 0, false, false, false)
    ClearPedBloodDamage(PlayerPedId())
    RemoveAnimDict("missmic2_washing_face")
    updateShowText(false)
    Citizen.Wait(5000)
    updateShowText(true)
end

function startShower()
    updateShowText(false)
    ExecuteCommand("shirt")
    ExecuteCommand("pants")
    ExecuteCommand("shoes")
    SetEntityHeading(PlayerPedId(), 97.89)
    loadAnimation("anim@mp_player_intmenu@key_fob@")                                     
    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@","fob_click", 2.0, 2.0, 2500, 0, 0, false, false, false)
    RemoveAnimDict("anim@mp_player_intmenu@key_fob@")
    Citizen.Wait(2500)
    loadAnimation("switch@franklin@bed")                                     
    TaskPlayAnim(PlayerPedId(), "switch@franklin@bed","stretch_long", 2.0, 2.0, 2500, 0, 0, false, false, false)
    RemoveAnimDict("switch@franklin@bed")
    Citizen.Wait(2500)
    loadAnimation("clothingtie")                                     
    TaskPlayAnim(PlayerPedId(), "clothingtie","try_tie_neutral_c", 2.0, 2.0, 2500, 0, 0, false, false, false)
    RemoveAnimDict("clothingtie")
    Citizen.Wait(2500)
    DoScreenFadeOut(1000)
    ClearPedBloodDamage(PlayerPedId())
    Citizen.Wait(1500)
    DoScreenFadeIn(1000)
    ExecuteCommand("shirt")
    ExecuteCommand("pants")
    ExecuteCommand("shoes")
    DoScreenFadeOut(1000)
    Citizen.Wait(1500)
    DoScreenFadeIn(1000)
    updateShowText(true)
end

function startSleep()
    local initialposition = vector3(-378.22, 150.57, 61.12)
    local bedposition = vector3(-379.13, 150.31, 62.63)
    local bedpositionheading = 8.43
    ExecuteCommand("shoes")
    DoScreenFadeOut(1000)
    Citizen.Wait(1500)
    local entityCam = {use=false, ped=nil, coords=Config.sleepCameraCoord, distance=nil, rotation=330, fovpoint=nil}
    Camera(entityCam)
    SetEntityCoords(PlayerPedId(),bedposition.x, bedposition.y, bedposition.z, false, false, false, true)
    SetEntityHeading(PlayerPedId(), bedpositionheading)
    loadAnimation("missheistfbi3b_ig8_2")                                     
    TaskPlayAnim(PlayerPedId(), "missheistfbi3b_ig8_2","cower_loop_victim", 2.0, 2.0, 10000, 0, 0, false, false, false)
    Citizen.Wait(2000)
    DoScreenFadeIn(1000)
    Citizen.Wait(6000)
    DoScreenFadeOut(1000)
    Citizen.Wait(2500)
    EndCam()
    DoScreenFadeIn(1000)
    ExecuteCommand("shoes")
    SetEntityCoords(PlayerPedId(),initialposition.x, initialposition.y, initialposition.z, false, false, false, true)
    RemoveAnimDict("missheistfbi3b_ig8_2")
end