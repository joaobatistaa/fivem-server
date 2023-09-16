scriptCFG = {}
scriptCFG.Maximumboundary = 2000.0

scriptCFG.AuthorizedJobShare = {
    ['police'] = true,
    ['sheriff'] = true
}

scriptCFG.RestrictUsage = true -- Set to true. if you want only certain jobs to use the tracker.
scriptCFG.AuthorizedJobsToUseTracker = {'police', 'sheriff'}

scriptCFG.TargetBlipInformations = {
    Sprite = 459,
    Color = 2,
    Scale = 1.4,
    Display = 2
}

scriptCFG.RemoveItemsUponUsage = {Tracker = true, BoltCutter = false}
scriptCFG.ItemNames = {TrackerName = 'pulseiraeletronica', BoltCutter = 'cortadorpulseira'}

scriptCFG.Animations = {
    TrackerSetupAnimation = {
        anim = 'base',
        animDict = 'amb@medic@standing@tendtodead@base'
    },
    BoltCuttingAnimation = {
        anim = 'base',
        animDict = 'amb@medic@standing@tendtodead@base'
    }
}
scriptCFG.InstallTimes = {
    Tracker = 5, -- How Many seconds will take to install the tracker
    BoltCutter = 7 -- how many seconds will take to deattach the tracker
}

scriptCFG.RemoveUponRemoval = true -- inform the Player if the target tracker has been removed.

scriptCFG.EnableCustomBraceletOnSkin = true -- Set to true if you are using Ankle Bracelet Streaming file.

scriptCFG.InformIfTargetLeavedServer = true -- Inform the Player if the target that has tracker bracelet left the server.


PlayerData = nil
IsDead = nil
IsBusy = nil

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) PlayerData.job = job end)
AddEventHandler('playerSpawned', function(spawn) IsDead = nil end)
AddEventHandler('esx:onPlayerDeath', function(data) IsDead = true end)

Bracelets = {}

RegisterNetEvent('Cyber:JobNotAuthorized')
AddEventHandler('Cyber:JobNotAuthorized', function()
    ESX.ShowNotification('Não tens permissão para usar este item')
end)

RegisterNetEvent('Cyber:BraceletAdded')
AddEventHandler('Cyber:BraceletAdded', function()

    TriggerEvent('skinchanger:getSkin', function(skin)
        local targetuni

        if skin.sex == 0 then
            targetuni = {chain_1 = 11, chain_2 = 0}
        else
            targetuni = {chain_1 = 8, chain_2 = 0}
        end

        if targetuni then
            TriggerEvent('skinchanger:loadClothes', skin, targetuni)
        else
            ESX.ShowNotification(
                'You Need to be MP_Freemode in order to get ankle bracelet installed on you')
        end
    end)
    ESX.ShowNotification('Um policial colocou-te uma pulseira eletrónica')

end)
RegisterNetEvent('Cyber:BraceletRemoved')
AddEventHandler('Cyber:BraceletRemoved', function()

    TriggerEvent('skinchanger:getSkin', function(skin)
        local targetuni

        if skin.sex == 0 then
            targetuni = {chain_1 = 0, chain_2 = 0}
        else
            targetuni = {chain_1 = 0, chain_2 = 0}
        end

        if targetuni then
            TriggerEvent('skinchanger:loadClothes', skin, targetuni)
        else
            ESX.ShowNotification(
                'You Need to be MP_Freemode in order to get ankle bracelet removed from you')
        end
    end)
    ESX.ShowNotification('Alguém removeu a tua pulseira eletrónica')

end)

RegisterNetEvent('Cyber:AddBraceletTrackerForPlayer')
AddEventHandler('Cyber:AddBraceletTrackerForPlayer',
                function(target, boundary, labell, isjobshare)
      
    local blip = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(target)))
    SetBlipSprite(blip, scriptCFG.TargetBlipInformations.Sprite)
    SetBlipDisplay(blip, scriptCFG.TargetBlipInformations.Display)
    SetBlipColour(blip, scriptCFG.TargetBlipInformations.Color)
    SetBlipScale(blip, scriptCFG.TargetBlipInformations.Scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(labell)
    EndTextCommandSetBlipName(blip)
    Bracelets[target] = {
        blip = blip,
        boundary = boundary,
        startpoint = GetEntityCoords(PlayerPedId()),
        label = labell,
        breakboundary = false
    }
    PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
    if isjobshare then
        ESX.ShowNotification('Um dos teus colegas colocou uma pulseira eletrónica. Verifica o Mapa. Etiqueta: '..labell)
                
    else
        ESX.ShowNotification('Pulseira eletrónica ativada. Verifica o Mapa. Etiqueta: '.. labell)
    end
end)

RegisterNetEvent('Cyber:OnTrackerUsage')
AddEventHandler('Cyber:OnTrackerUsage', function()
    if not IsBusy and not IsDead then
        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestPlayerDistance > 3.0 then
            ESX.ShowNotification('Não há jogadores por perto!')
            return
        end
        ESX.TriggerServerCallback('CyberCheckForBraceletStatus',
                                  function(status)
            if not status then
                local jobshare = false
                if scriptCFG.AuthorizedJobShare[PlayerData.job.name] then
                    local goforrjobshare =
                        GetUserInput(
                            'Queres partilhar a informação da pulseira com os teus colegas? sim-nao',
                            30)
                    if goforrjobshare == 'sim' or goforrjobshare == 'nao' then
                        if goforrjobshare == 'sim' then
                            jobshare = PlayerData.job.name
                        else
                            jobshare = false
                        end
                    else
                        return ESX.ShowNotification(
                                   'Por favor indica uma resposta válida! (sim / nao)')
                    end
                end
                local label = GetUserInput('Insira a etiqueta', 15)
                if label and label ~= '' then
                    local boundary = GetUserInput(
                                         'Insira o limite 0-' ..
                                             tostring(scriptCFG.Maximumboundary),
                                         15)
                    if not boundary or not tonumber(boundary) then
                        return ESX.ShowNotification(
                                   'Insira um limite válido!')
                    end
                    if tonumber(boundary) >= scriptCFG.Maximumboundary then
                        return ESX.ShowNotification(
                                   'Inseriste um limite acima do máximo permitido. Máximo: ' ..
                                       tostring(scriptCFG.Maximumboundary))
                    end

                    -- Progress Bar
                    IsBusy = true
					exports['progressbar']:Progress({
						name = "Installing",
						duration = scriptCFG.InstallTimes.Tracker * 1000,
						label = "A colocar Pulseira Eletrónica...",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							animDict = scriptCFG.Animations.TrackerSetupAnimation.animDict,
                            anim = scriptCFG.Animations.TrackerSetupAnimation.anim
						},
						prop = {model = nil}
					}, function(status)
						IsBusy = nil
                        if not status then

                            local closestPlayertwo, closestPlayerDistancetwo =
                            ESX.Game.GetClosestPlayer()
							if closestPlayertwo ~= closestPlayer or
								closestPlayerDistancetwo > 3.0 then
								ESX.ShowNotification('Player Got Far Away From You')
								return
							end
							TriggerServerEvent('Cyber:TrackedUsedOnPlayer',GetPlayerServerId(closestPlayer), boundary, label, jobshare)               
                        end
					end)
					Citizen.Wait(scriptCFG.InstallTimes.Tracker * 1000)
					StopAnimTask(PlayerPedId(), scriptCFG.Animations.TrackerSetupAnimation.animDict, scriptCFG.Animations.TrackerSetupAnimation.anim, 1.0)
                else
                    return ESX.ShowNotification('Insira uma etiqueta válida!')
                end

            else
                return ESX.ShowNotification('O civil já tem uma pulseira eletrónica ativa!')
            end
        end, GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('Cyber:OnBoltCutterUsage')
AddEventHandler('Cyber:OnBoltCutterUsage', function()
    if not IsBusy and not IsDead then
        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestPlayerDistance > 3.0 then
            ESX.ShowNotification('Não há jogadores por perto!')
            return
        end
        ESX.TriggerServerCallback('CyberCheckForBraceletStatus',
                                  function(status)
            if status then

                -- Progress Bar
                IsBusy = true
				exports['progressbar']:Progress({
					name = "Installing",
					duration = scriptCFG.InstallTimes.BoltCutter * 1000,
					label = "A remover Pulseira Eletrónica...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = scriptCFG.Animations.BoltCuttingAnimation.animDict,
                        anim = scriptCFG.Animations.BoltCuttingAnimation.anim
					},
					prop = {model = nil}
				}, function(status)
					IsBusy = nil
                    if not status then
                        local closestPlayertwo, closestPlayerDistancetwo = ESX.Game.GetClosestPlayer()
                        if closestPlayertwo ~= closestPlayer or
                            closestPlayerDistancetwo > 3.0 then
                            ESX.ShowNotification('O civil afastou-se de ti!')
                            return
                        end
                        TriggerServerEvent('Cyber:BoltCutterUsedOnPlayer',
                                           GetPlayerServerId(closestPlayer))
                        ESX.ShowNotification('Pulseira eletrónica removida!')
                    end
				end)
				Citizen.Wait(scriptCFG.InstallTimes.BoltCutter * 1000)
				StopAnimTask(PlayerPedId(), scriptCFG.Animations.BoltCuttingAnimation.animDict, scriptCFG.Animations.BoltCuttingAnimation.anim, 1.0)

            else
                return ESX.ShowNotification('O jogador não tem uma pulseira eletrónica ativa.')
            end
        end, GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('Cyber:BoltCutterUsedForPlayer')
AddEventHandler('Cyber:BoltCutterUsedForPlayer', function(trgt)
   local target = trgt
    if Bracelets[target] then
        ESX.ShowNotification('Alguém removeu a pulseira eletrónica de um civil. Etiqueta : ' ..Bracelets[target].label)
        RemoveBlip(Bracelets[target].blip)
        Bracelets[target] = nil
        PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
    end
end)
RegisterNetEvent('Cyber:PlayerLeftTheServer')
AddEventHandler('Cyber:PlayerLeftTheServer', function(target)
    if Bracelets[target] then
        if scriptCFG.InformIfTargetLeavedServer then
            ESX.ShowNotification('Um civil com uma pulseira eletrónica saiu da cidade. Etiqueta : ' ..
                    Bracelets[target].label)
        end
        RemoveBlip(Bracelets[target].blip)
        Bracelets[target] = nil
        PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
    end
end)

GetUserInput = function(forwhat, maxchar)
    local textresult = nil

    AddTextEntry('FMMC_KEY_TIP1', forwhat)
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', "", '', "", "", "", maxchar)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        textresult = GetOnscreenKeyboardResult()
    end
    return textresult
end

Citizen.CreateThread(function()
    while true do
        if GetTableCount(Bracelets) > 0 then

            Wait(500)
            for i, v in pairs(Bracelets) do
                if not v.breakboundary then
                    local coords = GetEntityCoords(
                                       GetPlayerPed(GetPlayerFromServerId(i)))
                    local distance = GetDistanceBetweenCoords(coords,
                                                              v.startpoint)
                    if distance > tonumber(v.boundary) then
                        ESX.ShowNotification(
                            '' .. v.label ..' saiu do limite definido com a pulseira eletrónica')
                        PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
                        Bracelets[i].breakboundary = true
                    end
                end
            end
        else
            Wait(3000)
        end
    end
end)

GetTableCount = function(tbl)
    local count = 0
    for i, v in pairs(tbl) do if v ~= nil then count = count + 1 end end
    return count
end

RegisterNetEvent('Cyber:LabelIsAlreadyBeingUsed')
AddEventHandler('Cyber:LabelIsAlreadyBeingUsed', function(isjobshare, name)
    local msg
    if isjobshare then
        msg = '' .. name ..' um colega tentou adicionar uma pulseira eletrónica com a mesma etiqueta de um civil adicionado por ti'
    else
        msg =
            'Essa etiqueta já está em uso. Experimenta outra!'
    end
    ESX.ShowNotification(msg)

end)