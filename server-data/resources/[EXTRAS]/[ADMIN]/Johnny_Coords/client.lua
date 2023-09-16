local display = false

RegisterCommand("coords", function()
	local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local x = string.sub(playerCoords.x, 0, 8) 
    local y = string.sub(playerCoords.y, 0, 8)
    local z = string.sub(playerCoords.z, 0, 6)
	local h = GetEntityHeading(playerPed)
    johnnyCoords('johnny', 'x = ' .. x .. ', y = ' .. y .. ', z = ' .. z)
    johnnyCoords('normal', x .. ', ' .. y .. ', ' .. z)
    johnnyCoords('vector3', 'vector3(' .. x .. ', ' .. y .. ', ' .. z .. ')')
    johnnyCoords('vector4', 'vector4(' .. x .. ', ' .. y .. ', ' .. z .. ', ' .. h ..')')
    SetDisplay(not display)
end)

function johnnyCoords(type, text)
	SendNUIMessage({
        type = type,
		text = text
	})
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("johnnyCloseButton", function(data)
    SetNuiFocus(false, false)
    SetDisplay(false)
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)