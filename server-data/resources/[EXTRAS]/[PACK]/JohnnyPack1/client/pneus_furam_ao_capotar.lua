local sleep = 2000
local noclip = false

RegisterNetEvent('pneus_furam_ao_capotar:setNoclip')
AddEventHandler('pneus_furam_ao_capotar:setNoclip', function(state)
	noclip = state
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
		local model = GetEntityModel(vehicle)

		if not noclip then
			if IsThisModelACar(model) then
				sleep = 0
				if IsEntityUpsidedown(vehicle) and GetEntitySpeed(vehicle) > 5.0 then
					for i = 0, 7 do
						SetVehicleTyreBurst(vehicle, i, true, 1000.0)
					end
				end
			else
				sleep = 2000
			end
		else
			sleep = 2000
		end
		Citizen.Wait(sleep)
    end
end)
