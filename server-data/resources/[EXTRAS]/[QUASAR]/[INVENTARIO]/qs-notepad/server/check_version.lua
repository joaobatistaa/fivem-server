Citizen.CreateThread(function()
    Citizen.Wait(500)
    local resource_name = GetCurrentResourceName()
    local current_version = GetResourceMetadata(resource_name, 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/quasar-scripts/quasar_resources_check/main/notepad',function(error, result, headers)
        if not result then return end
        local new_version = result:sub(1, -2)
        if new_version ~= current_version then
            print('^4[Quasar Bot] ^2Quasar Notepad ^4'..new_version..' ^2version is now available, your current version is ^4'..current_version..'^2.')
        end
    end,'GET')
end)