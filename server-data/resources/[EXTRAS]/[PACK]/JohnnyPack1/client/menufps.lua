--[[ FPS ]]--
RegisterNetEvent('fps:openmenu')
AddEventHandler('fps:openmenu', function()
    OpenFPSMenu()
end)

function OpenFPSMenu() 
    local elements = {
        {label = 'FPS Boost',        value = 'fps'},
        {label = 'Normal',           value = 'fps2'},
    }
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'headbagging',
    {
    title    = 'WorldTuga FPS Menu',
    align    = 'left',
    elements = elements
    }, function(data2, menu2)
        if data2.current.value == 'fps' then
            SetTimecycleModifier('yell_tunnel_nodirect')
        elseif data2.current.value == 'fps2' then
            SetTimecycleModifier()
            ClearTimecycleModifier()
            ClearExtraTimecycleModifier()
        end
    end,function(data2, menu2)
        menu2.close()
    end)
end
--[[ FPS ]]--