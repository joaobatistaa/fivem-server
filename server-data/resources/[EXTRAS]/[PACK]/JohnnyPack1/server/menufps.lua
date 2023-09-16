--[[ FPS ]]--
RegisterCommand('fps', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('fps:openmenu', _source)
end)
--[[ FPS ]]--