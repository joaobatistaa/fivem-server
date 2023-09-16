if Config.Framework ~= "qb" then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(playerData)
	CreateBlips()
end)

function GetJob()
    return QBCore.Functions.GetPlayerData().job.name
end

function Progressbar(id, label, time)
	exports['progressbar']:Progress({
		name = id,
		duration = time,
		label = label,
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(status) end)
end

RegisterNetEvent("qs-licenses:ShowId", function(sourceId, character)
    local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(sourceId)), false)
    local pos = GetEntityCoords(PlayerPedId(), false)
    if sourceId == GetPlayerServerId(PlayerId()) then
        ShowCard()
    end
    local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, sourcePos.x, sourcePos.y, sourcePos.z, true)
    if ((dist > 0 and dist < 2.5) or sourceId == GetPlayerServerId(PlayerId())) then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong style="font-size: 20px">{0}</strong><br>Firstname:</strong> {1} <br><strong>Lastname:</strong> {2} <br><strong>Date of birth:</strong> {3} <br><strong>Gender:</strong> {4}</div></div>',
            args = {character.type, character.firstname, character.lastname, character.birthdate, character.gender}
        })
    end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end