RegisterNetEvent('advanced_vehicles:Notify')
AddEventHandler('advanced_vehicles:Notify', function(type,msg)
	exports['Johnny_Notificacoes']:Alert("VEICULO TUNNING", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, type)
end)