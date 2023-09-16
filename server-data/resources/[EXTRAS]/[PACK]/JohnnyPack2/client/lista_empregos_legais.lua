local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

local infoJobListing = {}

ESX = nil
local PlayerData = {}

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


---- CENTRO EMPREGO EMPREGOS -----

infoJobListing.Zones = {
	{x = -265.01, y = -963.6, z = 31.2}
}

infoJobListing.DrawDistance2 = 20.0
infoJobListing.MarkerType2   = 2

------- FIM CENTRO EMPREGO EMPREGOS -----

local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local isInMarker = false

function ShowJobListingMenu()
	ESX.TriggerServerCallback('esx_joblisting:getJobsList', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			table.insert(elements, {
				label = jobs[i].label,
				job   = jobs[i].job
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = 'Centro de Emprego',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('esx_joblisting:setJob', data.current.job)
			--ESX.ShowNotification('Tens um novo emprego!')
			exports['Johnny_Notificacoes']:Alert("CENTRO DE EMPREGO", "<span style='color:#c7c7c7'>Tens um novo emprego: <span style='color:#069a19'><br>"..data.current.label.."</span>", 5000, 'success')
			menu.close()
		end, function(data, menu)
			menu.close()
		end)

	end)
end

AddEventHandler('esx_joblisting:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

function DrawText3Ds(x, y, z, text)
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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		local letSleep = true
		isInMarker = false

		for i=1, #infoJobListing.Zones, 1 do
			local distance = GetDistanceBetweenCoords(coords, infoJobListing.Zones[i].x, infoJobListing.Zones[i].y, infoJobListing.Zones[i].z, true)

			if distance < infoJobListing.DrawDistance2 then
				letSleep = false
				DrawMarker(2, infoJobListing.Zones[i].x, infoJobListing.Zones[i].y, infoJobListing.Zones[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.1, 71, 181, 255, 120, false, true, 2, true, false, false, false)
			end

			if distance < 3 then
				isInMarker = true
				DrawText3Ds(infoJobListing.Zones[i].x, infoJobListing.Zones[i].y, infoJobListing.Zones[i].z + 0.2, '~b~E~s~ - Centro de Emprego', 0.3)
			end
		end

		if isInMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_joblisting:hasExitedMarker')
		end
		
		if IsControlJustReleased(0, Keys["E"]) and isInMarker and not menuIsShowed then
			ESX.UI.Menu.CloseAll()
			ShowJobListingMenu()
		end

		if letSleep then
			Citizen.Wait(2000)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for i=1, #infoJobListing.Zones, 1 do
		local blip = AddBlipForCoord(infoJobListing.Zones[i].x, infoJobListing.Zones[i].y, infoJobListing.Zones[i].z)

		SetBlipSprite (blip, 407)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 27)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('Centro de Emprego')
		EndTextCommandSetBlipName(blip)
	end
end)