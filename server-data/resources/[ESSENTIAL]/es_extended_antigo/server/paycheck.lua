StartPayCheck = function()
	Citizen.CreateThread(function()
		while true do
			Wait(Config.PaycheckInterval)
			local xPlayers = ESX.GetExtendedPlayers()
			for i = 1, #(xPlayers) do
				local xPlayer = xPlayers[i]
				local job = xPlayer.job.grade_name
				local salary = xPlayer.job.grade_salary
				local vip = xPlayer.vip

				if salary > 0 then
					if job == 'unemployed' then -- unemployed
						xPlayer.addAccountMoney('bank', salary)
						TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', salary, "salary", "Rendimento Mínimo", xPlayer.identifier, xPlayer.getName())
						TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "BANCO", "<span style='color:#c7c7c7'>Recebeste o teu Subsídio de Desemprego: <span style='color:#069a19'><b>"..salary.."€</b></span>!", 10000, 'success')
					elseif Config.EnableSocietyPayouts then -- possibly a society
						TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
							if society ~= nil then -- verified society
								TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
									if account.money >= salary then -- does the society money to pay its employees?
										xPlayer.addAccountMoney('bank', salary)
										account.removeMoney(salary)

										TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
									else
										TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_MAZE', 1)
									end
								end)
							else -- not a society
								xPlayer.addAccountMoney('bank', salary)
								TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "BANCO", "<span style='color:#c7c7c7'>Recebeste o teu salário: <span style='color:#069a19'><b>"..salary.."€</b></span>!", 10000, 'success')
							end
						end)
					else -- generic job
						xPlayer.addAccountMoney('bank', salary)
						TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', salary, "salary", "Salário", xPlayer.identifier, xPlayer.getName())
						TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "BANCO", "<span style='color:#c7c7c7'>Recebeste o teu salário: <span style='color:#069a19'><b>"..salary.."€</b></span>!", 10000, 'success')
					end
				end
				
				local precos_vip = {
					[0] = 0,
					[1] = 3500,
					[2] = 5000,
					[3] = 10000,
					[4] = 12000,
					[5] = 27000,
					[6] = 45000,
					[7] = 64000,
					[8] = 10000
				}
				
				if vip > 0 and vip <= 9 then	
					local valor_a_receber = precos_vip[vip-1]
					
					xPlayer.addAccountMoney('bank', valor_a_receber)
					TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', valor_a_receber, "salary_vip_"..vip, "Salário VIP Tier "..vip, xPlayer.identifier, xPlayer.getName())
					TriggerClientEvent('Johnny_Notificacoes:Alert', xPlayer.source, "BANCO", "<span style='color:#c7c7c7'>Recebeste o teu salário VIP: <span style='color:#069a19'><b>"..valor_a_receber.."€</b></span>!", 10000, 'success')
				elseif vip > 9 then
					print("O Jogador "..GetPlayerName(xPlayer.source).." está com um valor vip maior que 9 !!!")
				end
			end
		end
	end)
end
