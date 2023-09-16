local PlayerData                = {}
local PracaPolice 				= 'police'	-- Job needed to arrest

local Aresztuje					= false		-- Zostaw na False innaczej bedzie aresztowac na start Skryptu
local Aresztowany				= false		-- Zostaw na False innaczej bedziesz Arresztowany na start Skryptu
 
local SekcjaAnimacji			= 'mp_arrest_paired'	-- Sekcja Katalogu Animcji
local AnimAresztuje 			= 'cop_p2_back_left'	-- Animacja Aresztujacego
local AnimAresztowany			= 'crook_p2_back_left'	-- Animacja Aresztowanego
local OstatnioAresztowany		= 0						-- Mozna sie domyslec ;)

local ArrestDistance = 3.0

RegisterNetEvent('esx_ruski_areszt:aresztowany')
AddEventHandler('esx_ruski_areszt:aresztowany', function(target)
	Aresztowany = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(SekcjaAnimacji)

	while not HasAnimDictLoaded(SekcjaAnimacji) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, SekcjaAnimacji, AnimAresztowany, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)

	Aresztowany = false
end)

RegisterNetEvent('esx_ruski_areszt:aresztuj')
AddEventHandler('esx_ruski_areszt:aresztuj', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(SekcjaAnimacji)

	while not HasAnimDictLoaded(SekcjaAnimacji) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, SekcjaAnimacji, AnimAresztuje, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)

	Aresztuje = false

end)
--[[
-- Glówna Funkcja Animacji
Citizen.CreateThread(function()
	while true do
		Wait(0)

		if IsControlPressed(0, Keys['LEFTSHIFT']) and IsControlPressed(0, Keys['N6']) and not Aresztuje and GetGameTimer() - OstatnioAresztowany > 10 * 1000 and PlayerData.job.name == PracaPolice then	-- Mozesz tutaj zmienic przyciski
			Citizen.Wait(10)
			local closestPlayer, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= Config.ArrestDistance and not Aresztuje and not Aresztowany and not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
				Aresztuje = true
				OstatnioAresztowany = GetGameTimer()

				ESX.ShowNotification("~b~Aresztujesz Obywatela~r~ " .. GetPlayerServerId(closestPlayer) .. "")						-- Drukuje Notyfikacje
				TriggerServerEvent('esx_ruski_areszt:startAreszt', GetPlayerServerId(closestPlayer))									-- Rozpoczyna Funkcje na Animacje (Cala Funkcja jest Powyzej^^^)

				Citizen.Wait(2100)																									-- Czeka 2.1 Sekund
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'cuffseffect', 0.7)									-- Daje Effekt zakuwania (Wgrywasz Plik .ogg do InteractSound'a i ustawiasz nazwe "cuffseffect.ogg")

				Citizen.Wait(3100)																									-- Czeka 3.1 Sekund
				ESX.ShowNotification("~b~Zaresztowano Obywatela ~r~ " .. GetPlayerServerId(closestPlayer) .. "")					-- Drukuje Notyfikacje
				TriggerServerEvent('esx_policejob:handscfhwechtnbuoiwperyndcuff', GetPlayerServerId(closestPlayer))									-- Zakuwa Poprzez Prace esx_policejob, Mozna zmienic Funkcje na jaka kolwiek inna.
			end
		end
	end
end)
--]]