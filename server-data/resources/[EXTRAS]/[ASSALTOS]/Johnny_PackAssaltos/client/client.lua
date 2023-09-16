ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

function almostEqual(var1, var2, threshold)
    return math.abs(var1 - var2) <= threshold
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

function loadPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Citizen.Wait(50)
	end
end

function loadModel(model)
	if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
	
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(50)
    end
end

function DrawBusySpinner(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function GetStreetAndZone()
  local plyPos = GetEntityCoords(PlayerPedId(), true)
  local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
  local street1 = GetStreetNameFromHashKey(s1)
  local street2 = GetStreetNameFromHashKey(s2)
  local zone = GetLabelText(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
  local street = street1 .. ", " .. zone
  return street
end

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
	SetNewWaypoint(coords)
	
    return blip
end

function ShowNotification(msg, type)
	if type == 'success' then
		exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'success')
	elseif type == 'info' then
		exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..msg.."", 8000, 'info')
	elseif type == 'error' then
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'error')
	else
		exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'warning')
	end
end

function CreateCutscene(change, coords)
	local ped = PlayerPedId()
		
	local clone = ClonePedEx(ped, 0.0, false, true, 1)
	local clone2 = ClonePedEx(ped, 0.0, false, true, 1)
	local clone3 = ClonePedEx(ped, 0.0, false, true, 1)
	local clone4 = ClonePedEx(ped, 0.0, false, true, 1)
	local clone5 = ClonePedEx(ped, 0.0, false, true, 1)

	SetBlockingOfNonTemporaryEvents(clone, true)
	SetEntityVisible(clone, false, false)
	SetEntityInvincible(clone, true)
	SetEntityCollision(clone, false, false)
	FreezeEntityPosition(clone, true)
	SetPedHelmet(clone, false)
	RemovePedHelmet(clone, true)
    
    if change then
        SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
        RegisterEntityForCutscene(ped, 'MP_2', 0, GetEntityModel(ped), 64)
        
        SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
        RegisterEntityForCutscene(clone2, 'MP_1', 0, GetEntityModel(clone2), 64)
    else
        SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
        RegisterEntityForCutscene(ped, 'MP_1', 0, GetEntityModel(ped), 64)

        SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
        RegisterEntityForCutscene(clone2, 'MP_2', 0, GetEntityModel(clone2), 64)
    end

	SetCutsceneEntityStreamingFlags('MP_3', 0, 1)
	RegisterEntityForCutscene(clone3, 'MP_3', 0, GetEntityModel(clone3), 64)
	
	SetCutsceneEntityStreamingFlags('MP_4', 0, 1)
	RegisterEntityForCutscene(clone4, 'MP_4', 0, GetEntityModel(clone4), 64)
	
	SetCutsceneEntityStreamingFlags('MP_5', 0, 1)
	RegisterEntityForCutscene(clone5, 'MP_5', 0, GetEntityModel(clone5), 64)
	
	Wait(10)
    if coords then
        StartCutsceneAtCoords(coords, 0)
    else
	    StartCutscene(0)
    end
	Wait(10)
	ClonePedToTarget(clone, ped)
	Wait(10)
	DeleteEntity(clone)
	DeleteEntity(clone2)
	DeleteEntity(clone3)
	DeleteEntity(clone4)
	DeleteEntity(clone5)
	Wait(50)
	DoScreenFadeIn(250)
	
	-- freeze anti bug queda livre
	FreezeEntityPosition(ped, true)
end

function Finish(timer)
	local tripped = false
	repeat
		Wait(0)
		if (timer and (GetCutsceneTime() > timer))then
			DoScreenFadeOut(250)
			tripped = true
		end
		if (GetCutsceneTotalDuration() - GetCutsceneTime() <= 250) then
		DoScreenFadeOut(250)
		tripped = true
		end
	until not IsCutscenePlaying()
	if (not tripped) then
		DoScreenFadeOut(100)
		Wait(150)
	end
	return
end
