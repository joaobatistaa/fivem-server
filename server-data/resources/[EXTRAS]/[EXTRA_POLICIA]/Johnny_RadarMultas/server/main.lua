ESX = nil

ESX = exports['es_extended']:getSharedObject()

-- BILLS WITHOUT ESX_BILLING (START)
RegisterServerEvent('esx_speedcamera:PayBill60Zone')
AddEventHandler('esx_speedcamera:PayBill60Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(5000)
end)

RegisterServerEvent('esx_speedcamera:PayBill80Zone')
AddEventHandler('esx_speedcamera:PayBill80Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(5000)	
end)

RegisterServerEvent('esx_speedcamera:PayBill120Zone')
AddEventHandler('esx_speedcamera:PayBill120Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(5000)
end)
-- BILLS WITHOUT ESX_BILLING (END)

-- FLASHING EFFECT (START)
RegisterServerEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
	TriggerClientEvent('esx_speedcamera:openGUI', source)
end)

RegisterServerEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
	TriggerClientEvent('esx_speedcamera:closeGUI', source)
end)
-- FLASHING EFFECT (END)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end