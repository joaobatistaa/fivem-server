ESX = nil

ESX = exports['es_extended']:getSharedObject()

-- A QUE HORAS OS CARROS VAO SER REMOVIDOS AUTOMATICAMENTE
local horasExecucao = {
	{['h'] = 3, ['m'] = 00},
	{['h'] = 16, ['m'] = 00},
}

function DeleteVehTaskCoroutine()
  TriggerClientEvent('okokDelVehicles:delete', -1)
end

for i = 1, #horasExecucao, 1 do
    TriggerEvent('cron:runAt', horasExecucao.h, horasExecucao.m, DeleteVehTaskCoroutine)
end

RegisterCommand('apagarcarros', function(source, args, rawCommand) 
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	
	if identifier=='steam:1100001470baaf7' or identifier=='steam:110000115708986' then 
		TriggerClientEvent('okokDelVehicles:delete', -1)
	end
end)