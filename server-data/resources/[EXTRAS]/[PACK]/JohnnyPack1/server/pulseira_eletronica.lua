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

ESX = nil

ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()

    local PlayersWithBracelet = {}
    local PlayersBracelet = {}

    ESX.RegisterUsableItem(scriptCFG.ItemNames.TrackerName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local jobname = xPlayer.getJob().name
        if scriptCFG.RestrictUsage and jobname and not IsJobAuthorized(jobname) then

            TriggerClientEvent('Cyber:JobNotAuthorized', source)
            return
        end
        TriggerClientEvent('Cyber:OnTrackerUsage', source)
    end)

    ESX.RegisterUsableItem(scriptCFG.ItemNames.BoltCutter, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('Cyber:OnBoltCutterUsage', source)
    end)

    IsJobAuthorized = function(job)
        if not job or job == '' then return false end
        for _, v in pairs(scriptCFG.AuthorizedJobsToUseTracker) do
            if job == v then return true end
        end
        return false
    end

    AddEventHandler('playerDropped', function()
        local src = source
        if PlayersWithBracelet[src] then
            for i, v in pairs(PlayersBracelet) do
                for ii, vv in pairs(v) do
                    if vv == src then
                        TriggerClientEvent('Cyber:BoltCutterUsedForPlayer', i,
                                           vv)
                        PlayersBracelet[i][ii] = nil
                    end
                end
            end
        end
        PlayersWithBracelet[src] = nil
        PlayersBracelet[src] = nil
    end)
    AddEventHandler('playerConnecting', function()
        local src = source
        PlayersWithBracelet[src] = nil
        PlayersBracelet[src] = {}
    end)

    ESX.RegisterServerCallback('CyberCheckForBraceletStatus',
                               function(source, cb, serverid)
        local src = source
        if PlayersWithBracelet[serverid] then
            cb(true)
        else
            cb(false)
        end
    end)

    RegisterNetEvent('Cyber:TrackedUsedOnPlayer')
    AddEventHandler('Cyber:TrackedUsedOnPlayer',
                    function(target, boundary, label, sharejob)
        local src = source
        if PlayersWithBracelet[target] then return end
        if not PlayersBracelet[src] then PlayersBracelet[src] = {} end
        if sharejob then

            if not PlayersBracelet[src][label] then
                TriggerClientEvent('Cyber:AddBraceletTrackerForPlayer', src,
                                   target, boundary, label)

                TriggerClientEvent('Cyber:BraceletAdded', target)
                PlayersBracelet[src][label] = target
                PlayersWithBracelet[target] = true
                zPlayer = ESX.GetPlayerFromId(src)
                if scriptCFG.RemoveItemsUponUsage.Tracker then

                    zPlayer.removeInventoryItem(scriptCFG.ItemNames.TrackerName,
                                                math.floor(1))
                end

                for _, v in pairs(ESX.GetPlayers()) do
                    if v then

                        xPlayer = ESX.GetPlayerFromId(v)
                        if not PlayersBracelet[v] then
                            PlayersBracelet[v] = {}
                        end
                        if xPlayer and xPlayer.getJob().name == sharejob and v ~=
                            src then

                            if not PlayersBracelet[v][label] then
                                PlayersBracelet[v][label] = target
                                TriggerClientEvent(
                                    'Cyber:AddBraceletTrackerForPlayer', v,
                                    target, boundary, label, sharejob)

                            else
                                TriggerClientEvent(
                                    'Cyber:LabelIsAlreadyBeingUsed', v, true,
                                    zPlayer.getName())
                            end
                        end
                    end
                end
            else
                TriggerClientEvent('Cyber:LabelIsAlreadyBeingUsed', src)
                -- add item

                return
            end

        else
            if not PlayersBracelet[src][label] then
                TriggerClientEvent('Cyber:AddBraceletTrackerForPlayer', src,
                                   target, boundary, label)
                PlayersBracelet[src][label] = target
                PlayersWithBracelet[target] = true
                if scriptCFG.RemoveItemsUponUsage.Tracker then
                    local zPlayer = ESX.GetPlayerFromId(src)
                    zPlayer.removeInventoryItem(scriptCFG.ItemNames.TrackerName,
                                                math.floor(1))
                end
                TriggerClientEvent('Cyber:BraceletAdded', target)
            else
                TriggerClientEvent('Cyber:LabelIsAlreadyBeingUsed', src)
                -- add item
            end
        end

    end)

    RegisterNetEvent('Cyber:BoltCutterUsedOnPlayer')
    AddEventHandler('Cyber:BoltCutterUsedOnPlayer', function(target)
        local src = source
        if not PlayersWithBracelet[target] then return end
        if PlayersWithBracelet[target] then
            for i, v in pairs(PlayersBracelet) do
                for ii, vv in pairs(v) do
                    if vv == target then
                        TriggerClientEvent('Cyber:BoltCutterUsedForPlayer', i,
                                           vv)
                        PlayersBracelet[i][ii] = nil
                    end
                end
            end
        end
        if scriptCFG.RemoveItemsUponUsage.BoltCutter then
            local zPlayer = ESX.GetPlayerFromId(src)
            zPlayer.removeInventoryItem(scriptCFG.ItemNames.BoltCutter,
                                        math.floor(1))
        end
        PlayersWithBracelet[target] = nil
        TriggerClientEvent('Cyber:BraceletRemoved', target)

    end)
end)

