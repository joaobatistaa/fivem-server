local coordsentregas = {
	vector3(2563.99, 4692.7, 35.02),
	vector3(1967.33, 4640.92, 41.88),
	vector3(2030.39, 4980.46, 42.1),
	vector3(1717.86, 4676.93, 43.66),
	vector3(1689.25, 4818.3, 43.06),
	vector3(2505.48, 4095.73, 39.2), 
	vector3(2570.87, 4282.84, 43.0),
	vector3(2721.19, 4285.98, 48.6),
	vector3(2727.59, 4145.46, 45.69),
	vector3(3322.6, 5166.06, 19.92),
	vector3(2216.42, 5612.49, 55.69), 
	vector3(2434.51, 4976.82, 47.07),
	vector3(2300.36, 4871.94, 42.06),
	vector3(1962.36, 5184.98, 47.98),
	vector3(1698.97, 4921.18, 42.56),
	vector3(1655.87, 4874.38, 42.04), 
	vector3(2159.72, 4789.8, 41.67),
	vector3(2121.77, 4784.71, 41.97),
	vector3(2639.04, 4246.56, 44.77),
	vector3(2455.85, 4058.3, 38.06),
	vector3(3680.06, 4497.93, 25.11), 
	vector3(3807.8, 4478.6, 6.37),
	vector3(1986.69824, 3815.02490, 33.32370),
	vector3(1446.34997, 3649.69384, 35.48260),
	vector3(228.27, 3165.8, 43.61),
	vector3(170.36, 3113.28, 43.51),
	vector3(179.76, 3033.1, 43.98),
	vector3(1990.57141, 3057.46801, 48.06378), 
	vector3(2201.01, 3318.25, 46.77),
	vector3(2368.38, 3155.96, 48.61),
	vector3(1881.07,3888.5,34.25),
	vector3(1889.76,3810.71,33.75),
	vector3(1638.8,3734.17,34.41), 
	vector3(2630.27,3262.88,56.25),
	vector3(2622.43,3275.56,56.3),
	vector3(2633.7,3287.4,56.45),
	vector3(2389.48, 3341.64, 47.72), 
	vector3(2393.01, 3320.62, 48.24),
	vector3(2163.38, 3374.63, 46.07),
	vector3(1959.95, 3741.99, 33.24),
	vector3(1931.55, 3727.6, 33.84),
	vector3(1850.68, 3690.03, 35.5), 
	vector3(1707.92, 3585.29, 36.57),
	vector3(1756.33, 3659.54, 35.39),
	vector3(1825.41, 3718.35, 34.42),
	vector3(1899.13, 3764.68, 33.79),
	vector3(1923.37, 3797.43, 33.44), 
	vector3(1914.69, 3813.37, 33.44),
	vector3(1913.61, 3868.06, 33.37),
	vector3(1942.34, 3885.42, 33.67),
	vector3(1728.66, 3851.46, 34.78),
	vector3(903.67, 3560.82, 33.81),
	vector3(910.93, 3644.29, 32.68),
	vector3(1393.15,3673.4, 34.79),
	vector3(1435.18, 3682.92, 34.84),
	vector3(-291.14, 6199.27, 32.49),
	vector3(-96.43, 6324.47, 32.08),
	vector3(-390.28, 6300.23, 30.75),
	vector3(-360.8, 6320.98, 30.76),
	vector3(-303.41, 6329.00, 32.99),
	vector3(-215.5, 6431.99, 32.49), 
	vector3(-46.21,6595.62,31.55),
	vector3(0.46, 6546.92, 32.37),
	vector3(-1.09, 6512.9, 33.04),
	vector3(99.35, 6618.56, 33.47),
	vector3(-774.31, 5597.84, 34.61), 
	vector3(-696.1, 5802.36, 17.83),
	vector3(-448.77, 6009.95, 32.22),
	vector3(-326.55,6083.95,31.96),
	vector3(-341.66, 6212.46,32.59),
	vector3(-247.15,6331.02,32.93), 
	vector3(-394.74,6272.52,30.94),
	vector3(35.18,6662.39,32.19),
	vector3(-130.66,6551.98,29.87),
	vector3(-106.06,6469.6,32.63),
	vector3(-94.5, 6408.86, 32.14), 
	vector3(-25.2,6472.25,31.98),
	vector3(-105.28,6528.96,30.17),
	vector3(150.41,6647.58,32.11),
	vector3(161.68,6636.1,32.17),
	vector3(-9.37,6653.93,31.98),
	vector3(-40.15,6637.23,31.09),
	vector3(-5.97,6623.07,32.32),
	vector3(-113.22, 6538.18, 30.6),
}

RegisterServerEvent('gopostal:caasdfjasjlfsash')
AddEventHandler('gopostal:caasdfjasjlfsash', function(currentJobPay, onjob)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifierlist = ExtractIdentifiers(_source)

	if not ESX.playerInsideLocation(_source, coordsentregas, 10.0) then
		TriggerEvent("WorldTuga:BanThisCheater", _source, "Tentativa de Spawnar Dinheiro")
		return
	end

	
	if xPlayer.job.name == 'ctt' and onjob then
		xPlayer.addAccountMoney('bank', currentJobPay)
		local dataLog = {
			emprego = 'CTT',
			playerid = _source,
			identifier = identifierlist.steam:gsub("steam:", ""),
			playername = GetPlayerName(_source),
			pagamento = currentJobPay,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}
		
		sendToDiscordEmpregos(dataLog)
		TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "CTT", "<span style='color:#c7c7c7'>Recebeste <span style='color:#069a19'>"..currentJobPay.."€</span> pela entrega!", 5000, 'success')
	end
end)