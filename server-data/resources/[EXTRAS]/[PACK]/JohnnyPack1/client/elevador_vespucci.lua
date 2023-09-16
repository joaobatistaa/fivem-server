local stages = {
	[-1] = vector3(-1097.81,-849.9,4.88),
	[-2] = vector3(-1097.81,-849.9,10.28),
    [-3] = vector3(-1097.81,-849.9,13.69),
    [1] = vector3(-1097.81,-849.9,19.0),
    [2] = vector3(-1097.81,-849.9,23.04),
    [3] = vector3(-1097.72,-850.0,26.83),
    [4] = vector3(-1097.72,-850.0,30.76),
    [5] = vector3(-1097.72,-850.0,34.24),
	[6] = vector3(-1097.72,-850.0,38.24)
    
}
	
local PlayerData = {}

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
    
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
    
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job     
end)
    
CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
		local canSleep = true
        for i,v in pairs(stages) do
			local dist = Vdist2(coords,v)
            if dist < 3 then -- and PlayerData.job.name == 'police' then
                canSleep = false	
				if dist < 3 then
					DrawText3D(v.x,v.y,v.z, "~b~E~w~ - Elevador")
					if IsControlJustPressed(1,51) then
						MenuElevador()
					end
				else
					DrawText3D(v.x,v.y,v.z, "Elevador")
                end
            end
        end
		if canSleep then
			Wait(1000)
			--ESX.UI.Menu.CloseAll()
		end
    end
end)
    
function DrawText3D(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
            
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
    end
end
    
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 
    
function MenuElevador()
		
	local elements = {}
	table.insert(elements, {label = 'Andar: -1', value = -1})
	table.insert(elements, {label = 'Andar: -2', value = -2})
	table.insert(elements, {label = 'Andar: -3', value = -3})
	table.insert(elements, {label = 'Andar: 1', value = 1})
	table.insert(elements, {label = 'Andar: 2', value = 2})
	table.insert(elements, {label = 'Andar: 3', value = 3})
	table.insert(elements, {label = 'Andar: 4', value = 4})
	table.insert(elements, {label = 'Andar: 5', value = 5})
	table.insert(elements, {label = 'Andar: 6', value = 6})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'elevador_vespucci', {
		title    = 'Elevador',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		ChangeStage(stages[tonumber(data.current.value)]) 
	end, function(data, menu)
		menu.close()
	end)
end
    
function ChangeStage(coords)
    local ped = PlayerPedId()
    Wait(750)
    DoScreenFadeOut(100)
    Wait(750)
    ESX.Game.Teleport(ped, coords)
    DoScreenFadeIn(100)
end