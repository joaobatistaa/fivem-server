JAM = {}
ESX = nil

AddEventHandler('onMySQLReady', function(...) JAM.SQLReady = true; end)

JAM.Testing = true

Citizen.CreateThread(function(...)
	while not ESX or not JAM.ESX do
		Citizen.Wait(100)
		ESX = exports['es_extended']:getSharedObject()
		JAM.ESX = exports['es_extended']:getSharedObject()
	end

	if JAM.Testing then 
		Citizen.Wait(3000)
		if not JAM.SQLReady then JAM.SQLReady = true; end
	end
end)
