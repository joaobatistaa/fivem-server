-------------------------------------------------------------
--------------         REPARAR VEICULO         --------------
-------------------------------------------------------------


RegisterNetEvent('wtrp:fix')
AddEventHandler('wtrp:fix', function()
	local ped = PlayerPedId()
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        if (IsPedSittingInAnyVehicle(ped)) then
            local vehicle = GetVehiclePedIsIn( ped, false)

            if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                SetVehicleEngineHealth(vehicle, 1000)
                SetVehicleEngineOn(vehicle, true, true)
                SetVehicleFixed(vehicle)
				exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Veículo reparado com <span style='color:#069a19'>sucesso</span>!", 3000, 'success')
            end
        end
    end
end)

-------------------------------------------------------------
--------------         LIMPAR VEICULO          --------------
-------------------------------------------------------------


RegisterNetEvent('wtrp:clean')
AddEventHandler('wtrp:clean', function()
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDirtLevel(vehicle, 0)
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Veículo limpo com <span style='color:#069a19'>sucesso</span>!", 3000, 'success')
	end
end)

-------------------------------------------------------------
--------------             ID GUN              --------------
-------------------------------------------------------------

function DrawText3D(x, y, z, text, lines)
    -- Amount of lines default 1
    if lines == nil then
        lines = 1
    end

	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125 * lines, 0.017+ factor, 0.03 * lines, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('wtrp:idgun')
AddEventHandler('wtrp:idgun', function()
	deleteLazer = not deleteLazer
	if deleteLazer then
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Modo Edição do Mapa: <span style='color:#069a19'>ATIVADO</span>", 5000, 'success')
	else
		exports['Johnny_Notificacoes']:Alert("WTRP ADMIN", "<span style='color:#c7c7c7'>Modo Edição do Mapa: <span style='color:#ff0000'>DESATIVADO</span>", 5000, 'error')
	end
end)

-- Draws boundingbox around the object with given color parms
function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim = 
	{ 
		x = 0.5*(max.x - min.x), 
		y = 0.5*(max.y - min.y), 
		z = 0.5*(max.z - min.z)
	}

    local FUR = 
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x, 
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y, 
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL = 
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 = 
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 = 
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 = 
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 = 
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 = 
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 = 
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end

-- Embed direction in rotation vector
function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

-- Raycast function for "Admin Lazer"
function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end


Citizen.CreateThread(function()	
	while true do
		Citizen.Wait(0)

        if deleteLazer then
            local color = {r = 255, g = 255, b = 255, a = 200}
            local position = GetEntityCoords(GetPlayerPed(-1))
            local hit, coords, entity = RayCastGamePlayCamera(1000.0)
            
            -- If entity is found then verifie entity
            if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                local entityCoord = GetEntityCoords(entity)
                local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                
                DrawEntityBoundingBox(entity, color)
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                DrawText3D(entityCoord.x, entityCoord.y, entityCoord.z, "Obj: " .. entity .. " Modelo: " .. GetEntityModel(entity).. " \nPressiona [~g~E~s~] para remover!", 2)

                -- When E pressed then remove targeted entity
                if IsControlJustReleased(0, 38) then
                    -- Set as missionEntity so the object can be remove (Even map objects)
                    SetEntityAsMissionEntity(entity, true, true)
                    --SetEntityAsNoLongerNeeded(entity)
                    --RequestNetworkControl(entity)
                    DeleteEntity(entity)
                end
            -- Only draw of not center of map
            elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                -- Draws line to targeted position
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
            end
        else
            Citizen.Wait(1000)
        end
	end
end)

-------------------------------------------------------------
--------------         APAGAR VEICULOS         --------------
-------------------------------------------------------------


local distanceToCheck = 5.0
local numRetries = 5
RegisterNetEvent( "wtrp:apagarveiculo" )
AddEventHandler( "wtrp:apagarveiculo", function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            end 
        else
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( ped, pos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            end 
        end 
    end
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then

        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            timeout = timeout + 1 
            Citizen.Wait( 500 )

        end 
    end 
end 

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end