Heap = {
    Medics = {}
}

local isBusy = false

Citizen.CreateThread(function()
    while not ESX do
        ESX = exports["es_extended"]:getSharedObject()

        Citizen.Wait(100)
    end

    SpawnMedics()
end)

Citizen.CreateThread(function()
    while true do
        local sleepThread = 5000

        local newPed = PlayerPedId()

        if Heap.Ped ~= newPed then
            Heap.Ped = newPed
        end

        Citizen.Wait(sleepThread)
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
    ESX.PlayerData = response
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)

    while true do
        local sleepThread = 500

        local ped = Heap.Ped
        local pedCoords = GetEntityCoords(ped)

        for medicIndex, medic in ipairs(Config.Medics) do
            local dstCheck = #(pedCoords - medic.Location)

            if dstCheck <= 2.0 then
                sleepThread = 1

                local usable = not Heap.Medics[medicIndex]

                local displayText = usable and "[~y~E~s~] para ser ~b~atendido~s~ (~g~" .. medic.Price .. "€~s~)" or "~b~O médico~s~ está ~r~indisponível~s~, por favor aquarde."

                if usable and IsControlJustPressed(0, 38) then
                    isBusy = true
					TryToGetMedicalTreatment(medicIndex)
                end

                DrawScriptText(medic.Location, displayText)
            end
        end

        Citizen.Wait(sleepThread)
    end
end)

RegisterNetEvent("chames_ambulance_medic:eventHandler")
AddEventHandler("chames_ambulance_medic:eventHandler", function(event, eventData)
    Trace(event, json.encode(eventData))

    if event == "MEDIC_UNAVAILABLE" then
        Heap.Medics[eventData.Medic] = eventData.Bool

        local ped = GetPed(eventData.Medic)

        if ped then
            SetEntityVisible(ped.Handle, not eventData.Bool)
        end
    elseif event == "SYNC_ANIMATION" then
        if not NetworkDoesNetworkIdExist(eventData.Ped) then
            return
        end

        local pedHandle = NetToPed(eventData.Ped)

        if DoesEntityExist(pedHandle) then
            PlayAnimation(pedHandle, "anim@heists@box_carry@", "idle", {
                flag = 49
            })
        end
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for _, pedData in pairs(Heap.Peds) do
            if DoesEntityExist(pedData.Handle) then
                DeleteEntity(pedData.Handle)
            end
        end
    end
end)

GlobalFunction = function(event, data)
    local options = {
        event = event,
        data = data
    }

    TriggerServerEvent("chames_ambulance_medic:globalEvent", options)
end

TryToGetMedicalTreatment = function(medicIndex)
    if not Config.OnlyAllowHelpWhenThereIsNoMedicsAvailable then return GetMedicalTreatment(medicIndex) end

    ESX.TriggerServerCallback("chames_ambulance_medic:requiredAmount", function(required)
        if required then
            GetMedicalTreatment(medicIndex)
        else
            ESX.ShowNotification("Estão INEM's em serviço! Fale primeiro com eles.")
        end
    end)
end

GetMedicalTreatment = function(medicIndex)
    local medic = Config.Medics[medicIndex]

    if not medic.Sequence then return ESX.ShowNotification("There are no route available for the medic, contact a staff or developer.") end
    if not medic.Beds then return ESX.ShowNotification("There are no beds available, contact a staff or developer.") end

    if IsEntityDead(Heap.Ped) then
        TreatPlayer()

        Citizen.Wait(500)
    end

    if IsEntityAttached(Heap.Ped) then
        DetachEntity(Heap.Ped, true, true)
    end

    GlobalFunction("MEDIC_UNAVAILABLE", {
        Medic = medicIndex,
        Bool = true
    })

    local ped = GetPed(medicIndex)

    if ped then
        SetEntityVisible(ped.Handle, false)
    end

    LoadModels({
        medic.Hash
    })

    local pedHandle = CreatePed(5, medic.Hash, medic.Location - vector3(0.0, 0.0, 0.985), medic.Heading, true)

    while not DoesEntityExist(pedHandle) do
        Citizen.Wait(0)
    end

    if ped then
        SetEntityNoCollisionEntity(pedHandle, ped.Handle)
        SetEntityNoCollisionEntity(ped.Handle, pedHandle)
    end

    TaskSetBlockingOfNonTemporaryEvents(pedHandle, true)
    SetNetworkIdCanMigrate(PedToNet(pedHandle), false)

    PlayAnimation(Heap.Ped, "amb@world_human_bum_slumped@male@laying_on_right_side@base", "base", {
        flag = 9
    })

    AttachEntityToEntity(Heap.Ped, pedHandle, GetPedBoneIndex(pedHandle, 57005), -0.32, -0.6, -0.35, 240.0, 35.0, 149.0, true, true, false, true, 1, true)

    PlayAnimation(pedHandle, "anim@heists@box_carry@", "idle", {
        flag = 49
    })

    GlobalFunction("SYNC_ANIMATION", {
        Ped = PedToNet(pedHandle)
    })

    for _, sequence in ipairs(medic.Sequence) do
        local isAtPos = _TaskGoStraightToCoord(pedHandle, sequence.Location - vector3(0.0, 0.0, 0.985), 1.0, 15000, sequence.Heading, 2.0)

        if isAtPos then
            if not IsEntityPlayingAnim(pedHandle, "anim@heists@box_carry@", "idle", 3) then
                PlayAnimation(pedHandle, "anim@heists   @box_carry@", "idle", {
                    flag = 49
                })
            end
        end
    end

    local bed = medic.Beds[math.random(#medic.Beds)]

    if not bed then return end

    local bedHandle = GetClosestObjectOfType(bed.Location, 2.0, bed.Hash)

    if DoesEntityExist(bedHandle) then
        local standingLocation = GetOffsetFromEntityInWorldCoords(bedHandle, vector3(0.0, -2.0, 0.0))
        local standingHeading = GetEntityHeading(bedHandle)

        local _ = _TaskGoStraightToCoord(pedHandle, standingLocation - vector3(0.0, 0.0, 0.985), 1.0, 10000, standingHeading, 2.0)
    end

    GlobalFunction("MEDIC_UNAVAILABLE", {
        Medic = medicIndex,
        Bool = false
    })

    DetachEntity(Heap.Ped, true, true)

    DeleteEntity(pedHandle)

    CleanupModels({
        medic.Hash
    })

    BedThread(medicIndex, bed, bedHandle)
end

BedThread = function(medicIndex, bed, bedHandle)
    Heap.InBed = GetGameTimer()

    local standingLocation = bed.Location
    local standingHeading = bed.Heading

    if DoesEntityExist(bedHandle) then
        standingLocation = GetOffsetFromEntityInWorldCoords(bedHandle, vector3(0.0, -2.0, 0.0))
        standingHeading = GetEntityHeading(bedHandle)
    end

    SetEntityCoords(Heap.Ped, bed.Location - vector3(0.0, 0.0, 0.985))
    SetEntityHeading(Heap.Ped, bed.Heading)

    Citizen.Wait(500)

    PlayAnimation(Heap.Ped, "dead", "dead_a", {
        flag = 1
    })
	
	--[[
    while GetGameTimer() - Heap.InBed < Config.HelpTime do
        Citizen.Wait(0)

        DisableAllControlActions(0)

        local timePercent = math.floor((GetGameTimer() - Heap.InBed) / Config.HelpTime * 100)

        DisableFControls()

        DrawScriptText(bed.Location, "A receber ~b~cuidados médicos~s~ " .. timePercent .. "%")
    end
	--]]
	
	exports['progressbar']:Progress({
		name = "unique_action_name",
		duration = Config.HelpTime,
		label = "A receber cuidados médicos...",
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
	Citizen.Wait(Config.HelpTime)
	
    SetEntityCoordsNoOffset(Heap.Ped, standingLocation, false, false, false, true)
    SetEntityHeading(Heap.Ped, standingHeading - 180.0)
    SetPlayerInvincible(PlayerId(), false)

    SetEntityHealth(Heap.Ped, GetEntityMaxHealth(Heap.Ped))
	--TriggerEvent('mythic_hospital:client:RemoveBleed')
   -- TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('esx_ambulancejob:revLoureivero')
    TriggerServerEvent("esx_ambulancejob:setDeathStatus", false)
    
	
	--local data = {
		--society = 'society_ambulance',
		--society_name = 'INEM',
		--target = GetPlayerServerId(PlayerId()),
		--targetName = -1,
		--invoice_value = 10000,
		--author_name = 'INEM',
		--invoice_item = 'Tratamento Médico',
		--invoice_notes = 'Fatura emitida após receberes tratamento médico no Hospital'					
	--}

	--TriggerServerEvent("okokBilling:createInvoicePlayer", data)
	--TriggerServerEvent("okokBilling:CreateCustomInvoice", GetPlayerServerId(PlayerId()), 10000, 'Fatura emitida após receberes tratamento médico no Hospital', 'Tratamento Médico', 'society_ambulance', 'INEM')

    -- Here would you add all events that would remove damage if you have any custom resource handling that.
	
	TriggerServerEvent("esx_ambulancejob:pagarAtendimentoMedico")
	
	exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>Recebestes cuidados medicos e pagaste uma fatura no valor de 10000€, tem mais cuidado, podes sempre voltar ao hospital se precisares.</span>", 5000, 'success')
	
	isBusy = false
end

TreatPlayer = function()
    StopScreenEffect("DeathFailOut")
    NetworkResurrectLocalPlayer(GetEntityCoords(Heap.Ped) - vector3(0.0, 0.0, 0.985), 180.0, true, false)
    SetPlayerInvincible(PlayerId(), false)
    ClearPedBloodDamage(Heap.Ped)

	TriggerServerEvent("esx:onPlayerSpawn")
	TriggerEvent("esx:onPlayerSpawn")
	TriggerEvent("playerSpawned")
end

SpawnMedics = function()
    Heap.Peds = {}

    for pedIndex, pedData in ipairs(Config.Medics) do
        LoadModels({ pedData.Hash })

        local pedHandle = CreatePed(5, pedData.Hash, pedData.Location - vector3(0.0, 0.0, 0.985), pedData.Heading, false)

        SetEntityAsMissionEntity(pedHandle, true, true)
        SetBlockingOfNonTemporaryEvents(pedHandle, true)
        SetPedDefaultComponentVariation(pedHandle)
		FreezeEntityPosition(pedHandle, true)
		SetPedCanBeTargetted(pedHandle, false)

        PlayAnimation(pedHandle, "amb@code_human_cross_road@female@idle_a", math.random(5) > 2 and "idle_a" or "idle_b", {
            flag = 11
        })

        table.insert(Heap.Peds, {
            Index = pedIndex,
            Data = pedData,
            Handle = pedHandle
        })

        --local blipHandle = AddBlipForCoord(pedData.Location)

        --SetBlipSprite(blipHandle, 61)
        --SetBlipColour(blipHandle, 2)
        --SetBlipScale(blipHandle, 0.4)
        --SetBlipAsShortRange(blipHandle, true)

        --BeginTextCommandSetBlipName("STRING")
        --AddTextComponentString("Medic")
        --EndTextCommandSetBlipName(blipHandle)

        CleanupModels({
            pedData.Hash
        })
    end
end

GetPed = function(pedIndex)
    for _, ped in ipairs(Heap.Peds) do
        if ped.Index == pedIndex then
            return ped
        end
    end

    return false
end

DrawButtons = function(buttonsToDraw)
	local instructionScaleform = RequestScaleformMovie("instructional_buttons")

	while not HasScaleformMovieLoaded(instructionScaleform) do
		Wait(0)
	end

	PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
	PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
	PushScaleformMovieFunctionParameterBool(0)
	PopScaleformMovieFunctionVoid()

	for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
		PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(buttonIndex - 1)

		PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
		PushScaleformMovieFunctionParameterString(buttonValues["label"])
		PopScaleformMovieFunctionVoid()
	end

	PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PushScaleformMovieFunctionParameterInt(-1)
	PopScaleformMovieFunctionVoid()
	DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        if settings == nil then
            TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
        else 
            local speed = 1.0
            local speedMultiplier = -1.0
            local duration = 1.0
            local flag = 0
            local playbackRate = 0

            if settings["speed"] then
                speed = settings["speed"]
            end

            if settings["speedMultiplier"] then
                speedMultiplier = settings["speedMultiplier"]
            end

            if settings["duration"] then
                duration = settings["duration"]
            end

            if settings["flag"] then
                flag = settings["flag"]
            end

            if settings["playbackRate"] then
                playbackRate = settings["playbackRate"]
            end

            TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)

            while not IsEntityPlayingAnim(ped, dict, anim, 3) do
                Citizen.Wait(0)
            end
        end
    
        RemoveAnimDict(dict)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

LoadModels = function(models)
	for index, model in ipairs(models) do
		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

CleanupModels = function(models)
	for index, model in ipairs(models) do
		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)  
		end
	end
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["size"] or vector3(1.0, 1.0, 1.0), markerData["rgb"] or vector3(255, 255, 255), 100, markerData["bob"] and true or false, true, 2, false, false, false, false)
end

DrawScriptText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

_TaskGoStraightToCoord = function(ped, coords, speed, timeout, heading, distanceToSlide)
    TaskGoStraightToCoord(ped, coords.x, coords.y, coords.z, speed, timeout, heading, distanceToSlide)

    while GetScriptTaskStatus(ped, 0x7d8f4411) ~= 7 do
        Citizen.Wait(0)
    end

    return true
end

ClaimNetwork = function(handle)
    local timeout = 0

    NetworkRequestControlOfEntity(handle)

    while not NetworkHasControlOfEntity(handle) or timeout > 250 do
        Citizen.Wait(0)

        timeout = timeout + 1
    end
end

OpenInput = function(label, type)
	AddTextEntry(type, label)

	DisplayOnscreenKeyboard(1, type, "", "", "", "", "", 30)

	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Wait(0)
	end

	if GetOnscreenKeyboardResult() then
	  	return GetOnscreenKeyboardResult()
	end
end

DisableFControls = function()
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 21, true) -- SHIFT
    DisableControlAction(0, 22, true) -- SPACE
    DisableControlAction(0, 288, true) -- F1
    DisableControlAction(0, 289, true) -- F2
    DisableControlAction(0, 170, true) -- F3
    DisableControlAction(0, 167, true) -- F6
    DisableControlAction(0, 168, true) -- F7
    DisableControlAction(0, 57, true) -- F10
    DisableControlAction(0, 71, true) -- W
    DisableControlAction(0, 72, true) -- S
    DisableControlAction(0, 73, true) -- X
    DisableControlAction(0, 63, true) -- A
    DisableControlAction(0, 64, true) -- D
end

local using = false
local lastPos = nil
local anim = "back"
local animscroll = 0
local oPlayer = false

CreateThread(function()
	while true do
		Wait(1000)
		oPlayer = PlayerPedId()
		local pedPos = GetEntityCoords(oPlayer)
		for k,v in pairs(Config.objects.locations) do
			local oSelectedObject = GetClosestObjectOfType(pedPos.x, pedPos.y, pedPos.z, 0.8, GetHashKey(v.object), 0, 0, 0)
			local oEntityCoords = GetEntityCoords(oSelectedObject)
			local objectexits = DoesEntityExist(oSelectedObject)
			if objectexits then
				if GetDistanceBetweenCoords(oEntityCoords.x, oEntityCoords.y, oEntityCoords.z,pedPos) < 15.0 then
					if oSelectedObject ~= 0 then
						local objects = Config.objects
						if oSelectedObject ~= objects.object then
							objects.object = oSelectedObject
							objects.ObjectVertX = v.verticalOffsetX
							objects.ObjectVertY = v.verticalOffsetY
							objects.ObjectVertZ = v.verticalOffsetZ
							objects.OjbectDir = v.direction
							objects.isBed = v.bed
						end
					end
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1)
		local objects = Config.objects
		if objects.object ~= nil and objects.ObjectVertX ~= nil and objects.ObjectVertY ~= nil and objects.ObjectVertZ ~= nil and objects.OjbectDir ~= nil and objects.isBed ~= nil then
			local player = oPlayer
			local getPlayerCoords = GetEntityCoords(player)
			local objectcoords = GetEntityCoords(objects.object)
			if GetDistanceBetweenCoords(objectcoords.x, objectcoords.y, objectcoords.z,getPlayerCoords) < 1.8 and not using and not isBusy then
				if objects.isBed == true then
					DrawText3Ds(objectcoords.x, objectcoords.y, objectcoords.z+0.30, "~ g ~ E ~ w ~ - Deitar")
					--DrawText3Ds(objectcoords.x, objectcoords.y, objectcoords.z+0.20, "~w~")
					if IsControlJustPressed(0, 175) then -- right
						animscroll = animscroll+1
						if animscroll == 0 then
							anim = "back"
						elseif animscroll == 1 then
							anim = "stomach"
						elseif animscroll == 2 then
							animscroll = 1
						end
					end

					if IsControlJustPressed(0, 174) then -- left
						animscroll = animscroll-1
						if animscroll == -1 then
							animscroll = 0
						elseif animscroll == 0 then
							anim = "back"
						elseif animscroll == 1 then
							anim = "stomach"
						elseif animscroll == 2 then
							animscroll = 0
							anim = "back"
						end
					end
					if IsControlJustPressed(0, 38) then
						PlayAnimOnPlayer(objects.object,objects.ObjectVertX,objects.ObjectVertY,objects.ObjectVertZ,objects.OjbectDir, objects.isBed, player, objectcoords)
					end
				else
					DrawText3Ds(objectcoords.x, objectcoords.y, objectcoords.z+0.30, " ~ g ~ G ~ w ~ sentar")
					if IsControlJustPressed(0, 58) then
						PlayAnimOnPlayer(objects.object,objects.ObjectVertX,objects.ObjectVertY,objects.ObjectVertZ,objects.OjbectDir, objects.isBed, player, objectcoords)
					end
				end
			end
			if using == true then
				Draw2DText("~ g ~ F ~ w ~ - Levantar",0,1,0.5,0.92,0.6,255,255,255,255)

				if IsControlJustPressed(0, 23) or IsControlJustPressed(0, 48) or IsControlJustPressed(0, 20) then
					ClearPedTasks(player)
					using = false
					local x,y,z = table.unpack(lastPos)
					if GetDistanceBetweenCoords(x, y, z,getPlayerCoords) < 10 then
						SetEntityCoords(player, lastPos)
					end
					FreezeEntityPosition(player, false)
				end
			end
		end
	end
end)

function PlayAnimOnPlayer(object,vertx,verty,vertz,dir, isBed, ped, objectcoords)
	lastPos = GetEntityCoords(ped)
	FreezeEntityPosition(object, true)
	SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z+-1.4)
	FreezeEntityPosition(ped, true)
	using = true
	if isBed == false then
		TaskStartScenarioAtPosition(ped, Config.objects.SitAnimation, objectcoords.x+vertx, objectcoords.y-verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
	else
		if anim == "back" then
			TaskStartScenarioAtPosition(ped, Config.objects.LayBackAnimation, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
		elseif anim == "stomach" then
			TaskStartScenarioAtPosition(ped, Config.objects.LayStomachAnimation, objectcoords.x+vertx, objectcoords.y+verty, objectcoords.z-vertz, GetEntityHeading(object)+dir, 0, true, true)
		end
	end
end




function DrawText3Ds(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 350
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	end
end

function Draw2DText(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(6)
	SetTextProportional(6)
	SetTextScale(scale/1.0, scale/1.0)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
