
if Config.Framework == "qbcore" then
	QBCore = exports[Config.QBCoreName]:GetCoreObject()
	
	QBCore.Functions.CreateUseableItem("drone", function(source, item)
		local src = source
		TriggerClientEvent('dz-drone:client:InitiateDrone', src)
	end)
	
	QBCore.Functions.CreateUseableItem("drone_lspd", function(source, item)
		local src = source
		TriggerClientEvent('dz-drone:client:InitiateDroneLSPD', src)
	end)
elseif Config.Framework == "esx" then
	if Config.IsESXLegacy then
		ESX = exports[Config.ESXLegacyName]:getSharedObject()
	else
		ESX = nil
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	end
	
	ESX.RegisterUsableItem("drone", function(source)
		local src = source
		TriggerClientEvent('dz-drone:client:InitiateDrone', src)
	end)
	
	ESX.RegisterUsableItem("drone_policia", function(source)
		local src = source
		TriggerClientEvent('dz-drone:client:InitiateDroneLSPD', src)
	end)
end

RegisterNetEvent('dz-drone:server:DoSyncDrone', function(drone)
	TriggerClientEvent('dz-drone:server:DoSyncDrone', -1, drone)
end)

RegisterNetEvent('dz-drone:server:GetTargetPlayerInformations', function(target)
	local src = source
	local Target = tonumber(target)
	local TargetInfo = {
		Title = "Desconhecido",
		SubTitle = "O alvo não foi encontrado na base de dados",
		Infos = {}
	}
	if (Config.Framework == "qbcore") and (QBCore ~= nil) then
		local Player = QBCore.Functions.GetPlayer(Target)
		if Player then
			TargetInfo = {
				Title = Player.PlayerData.charinfo.firstname,
				SubTitle = "Target ID: "..Target,
				Infos = {
					'Firstname: '..Player.PlayerData.charinfo.firstname,
					'Lastname: '..Player.PlayerData.charinfo.lastname,
					'Birthdate: '..Player.PlayerData.charinfo.birthdate,
					'Gender: '..(Player.PlayerData.charinfo.gender == 0 and "Male" or "Female"),
					'Nationality: '..Player.PlayerData.charinfo.nationality,
				}
			}
			TriggerClientEvent('dz-drone:client:TargetPlayerInformations', src, TargetInfo)
		end
	elseif (Config.Framework == "esx") and (ESX ~= nil) then
		local Player = ESX.GetPlayerFromId(Target)
		if Player then
			if Config.SQL == "oxmysql" then
				MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = ?', {Player.identifier}, function(result)
					if result[1] and result[1].firstname then
						TargetInfo = {
							Title = result[1].firstname,
							SubTitle = "ID do Alvo: "..Target,
							Infos = {
								'Nome: '..result[1].firstname,
								'Apelido: '..result[1].lastname,
								'Data Nasc.: '..result[1].dateofbirth,
								'Género: '..(result[1].sex == "m" and "Masculino" or "Feminino"),
								'Altura: '..result[1].height,
							}
						}
					end
					TriggerClientEvent('dz-drone:client:TargetPlayerInformations', src, TargetInfo)
				end)
			elseif Config.SQL == "mysql-async" then
				MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier', {
					['@identifier'] = Player.identifier
				}, function(result)
					if result[1] and result[1].firstname then
						TargetInfo = {
							Title = result[1].firstname,
							SubTitle = "ID do Alvo: "..Target,
							Infos = {
								'Nome: '..result[1].firstname,
								'Apelido: '..result[1].lastname,
								'Data Nasc.: '..result[1].dateofbirth,
								'Género: '..(result[1].sex == "m" and "Masculino" or "Feminino"),
								'Altura: '..result[1].height,
							}
						}
					end
					TriggerClientEvent('dz-drone:client:TargetPlayerInformations', src, TargetInfo)
				end)
			else
				print('^2[dz-drone] ^1Wrong SQL, script allows only \'oxmysql\' or \'mysql-async\'')
				print('^2[dz-drone] ^1Wrong SQL, script allows only \'oxmysql\' or \'mysql-async\'')
				print('^2[dz-drone] ^1Wrong SQL, script allows only \'oxmysql\' or \'mysql-async\'')
				print('^2[dz-drone] ^1Wrong SQL, script allows only \'oxmysql\' or \'mysql-async\'')
				print('^2[dz-drone] ^1Wrong SQL, script allows only \'oxmysql\' or \'mysql-async\'')
			end
		end
	else
		TargetInfo = {
			Title = GetPlayerName(Target),
			SubTitle = "ID do Alvo: "..Target,
			Infos = {}
		}
		TriggerClientEvent('dz-drone:client:TargetPlayerInformations', src, TargetInfo)
	end
end)

RegisterNetEvent('dz-drone:server:RemoveItem', function(item)
	local src = source
	local ItemName = item
	if ItemName == nil then return end
	if (Config.Framework == "qbcore") and (QBCore ~= nil) then
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.RemoveItem(ItemName, 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemName], "remove", 1)
	elseif (Config.Framework == "esx") and (ESX ~= nil) then
		local Player = ESX.GetPlayerFromId(src)
		Player.removeInventoryItem(ItemName, 1)
	end
end)