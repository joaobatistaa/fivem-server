-- ## Variables
local pedDisplaying = {}
local background = {
    enable = true,
    color = { r = 35, g = 35, b = 55, alpha = 200 },
}
-- Settings
local color = { r = 220, g = 220, b = 220, a = 255 } -- Color of the text 
local font = 4 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = {
    enable = true,
    color = { r = 35, g = 35, b = 55, alpha = 200 },
}
local chatMessage = false
local dropShadow = true
-- ## Functions

-- OBJ : draw text in 3d
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display

local function DrawText3D(coords,text)
    local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
	local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100
	
	SetTextColour(color.r, color.g, color.b, color.a)
    SetTextScale(0.0, 0.5 * scale)
    SetTextFont(font)
    SetTextProportional(1)
	SetTextCentre(true)
    
	BeginTextCommandWidth("STRING")
    AddTextComponentString(text)
    local height = GetTextScaleHeight(0.50*scale, font)
    local width = EndTextCommandGetWidth(font)

    SetTextEntry("STRING")  
    AddTextComponentString(text)
	EndTextCommandDisplayText(_x, _y)
	
    DrawRect(_x, _y+scale/60, width+0.008, height+0.004, background.color.r, background.color.g, background.color.b , background.color.alpha)
end

-- OBJ : handle the drawing of text above a ped head
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function Display(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= 250 then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(time)
            display = false
        end)

        -- Display
        local offset = 0.2 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x,y,z), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

-- ## Events

-- Share the display of 3D text
RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text)
    end
end)