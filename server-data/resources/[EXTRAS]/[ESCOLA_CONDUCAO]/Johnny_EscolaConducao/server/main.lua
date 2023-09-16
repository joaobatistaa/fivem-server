QS = nil
TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)

ESX = nil

ESX = exports['es_extended']:getSharedObject()

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterCommand('atualizarlicencas', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:johnny:addLicence')
AddEventHandler('esx_dmvschool:johnny:addLicence', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local firstname, lastname, dob, sex
	
	if type ~= 'dmv' then
		MySQL.Async.fetchAll("SELECT firstname, lastname, dateofbirth, sex, numero_carta_conducao FROM `users` WHERE `identifier` = @identifier",
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			
			if result[1] then
				firstname  = result[1].firstname
				lastname = result[1].lastname
				dob  = result[1].dateofbirth
				sex = result[1].sex
				numero_licenca = result[1].numero_carta_conducao
			end
		end)
		
		if tonumber(num_licenca) == 0 then
			local numLicenca = generateLicense()

			MySQL.Async.execute('UPDATE users SET `numero_carta_conducao` = @numcc WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@numcc'] = numLicenca
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print('erro ao adicionar numero carta conducao')
				end
			end)
			numero_licenca = numLicenca
		end
		TriggerEvent('esx_license:addLicense', _source, type, function()
			TriggerEvent('esx_license:getLicenses', _source, function(licenses)
				TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
				dadosLicencas = licenses
				local tempTipo = '<br>'
				
				for i=1, #dadosLicencas, 1 do
					if dadosLicencas[i].label ~= nil and dadosLicencas[i].type ~= nil then
						if dadosLicencas[i].type == 'drive_bike' then
							tempTipo = tempTipo.. ' | A - Motas'
						end
						if dadosLicencas[i].type == 'drive' then
							tempTipo = tempTipo..' | B - Veículos Ligeiros'
						end				
						if dadosLicencas[i].type == 'drive_truck' then
							tempTipo = tempTipo..' | CE - Camiões'
						end
					end
				end
				
				info = {
					name = firstname,
					lastname = lastname,
					gender = sex,
					dateofbirth = dob,
					numero_licenca = numero_licenca,
					type = tempTipo
				}  
				
				local temInv = false
				local items = exports['qs-inventory']:GetInventory(_source)
				
				for _, objeto in pairs(items) do
					if objeto.name == 'carta_conducao' then
						if objeto.info.numero_licenca == numero_licenca then
							exports['qs-inventory']:RemoveItem(_source, objeto.name, 1, objeto.slot, objeto.info)
							exports['qs-inventory']:AddItem(_source, "carta_conducao", 1, nil, info)							
							TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "SUCESSO", "<span style='color:#c7c7c7'>Recebeste a tua nova <span style='color:#069a19'>carta de condução</span> com o tipo <span style='color:#069a19'>"..tempTipo.."</span> atualizado.", 7000, 'success')
							temInv = true
						end
					end
				end
				if not temInv then
					exports['qs-inventory']:AddItem(_source, "carta_conducao", 1, nil, info)	
					TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "SUCESSO", "<span style='color:#c7c7c7'>Recebeste a tua nova <span style='color:#069a19'>carta de condução</span> com o tipo <span style='color:#069a19'>"..tempTipo.."</span> atualizado.", 7000, 'success')
				end	
			end)
		end)
	else
		TriggerEvent('esx_license:addLicense', _source, 'dmv', function(adicionado)
			if adicionado then
				TriggerEvent('esx_license:getLicenses', _source, function(licenses)
					TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
				end)
			end
		end)
	end
end)

RegisterNetEvent('esx_dmvschool:johnny:segundaVia')
AddEventHandler('esx_dmvschool:johnny:segundaVia', function(preco)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local dadosLicencas = {}
	local temLicenca = false
	local temNoInv = false
	
	if xPlayer then
		local identifier = xPlayer.identifier
		local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local num_licenca = result[1].numero_carta_conducao

		if tonumber(num_licenca) == 0 then

			local numLicenca = generateLicense()

			MySQL.Async.execute('UPDATE users SET `numero_carta_conducao` = @numcc WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@numcc'] = numLicenca
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print('erro ao adicionar numero carta conducao')
				end
			end)
			
			num_licenca = numLicenca
		end
		
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			dadosLicencas = licenses
			local tempTipo = '<br>'
			
			for i=1, #dadosLicencas, 1 do
				if dadosLicencas[i].label ~= nil and dadosLicencas[i].type ~= nil then
					if dadosLicencas[i].type == 'drive_bike' then
						tempTipo = tempTipo.. ' | A - Motas'
						temLicenca = true
					end
					if dadosLicencas[i].type == 'drive' then
						tempTipo = tempTipo..' | B - Veículos Ligeiros'
						temLicenca = true
					end				
					if dadosLicencas[i].type == 'drive_truck' then
						tempTipo = tempTipo..' | CE - Camiões'
						temLicenca = true
					end
				end
			end

			info = {
				name = firstname,
				lastname = lastname,
				gender = sex,
				dateofbirth = dob,
				numero_licenca = num_licenca,
				type = tempTipo
			}  
			
			local items = exports['qs-inventory']:GetInventory(_source)
				
			for _, objeto in pairs(items) do
				if objeto.name == 'carta_conducao' then
					if objeto.info.numero_licenca == num_licenca then
						temNoInv = true
					end
				end
			end
			
			if temLicenca then
				if temNoInv then
					TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "INFO", "<span style='color:#c7c7c7'>Já tens a tua carta de condução contigo!", 5000, 'info')
				else
					exports['qs-inventory']:AddItem(_source, "carta_conducao", 1, nil, info)
					xPlayer.removeAccountMoney('bank', preco)
					
					TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "SUCESSO", "<span style='color:#c7c7c7'>Recebeste a <span style='color:#069a19'>segunda via</span> da tua carta de condução!", 5000, 'success')
				end
			else
				TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "ERRO", "<span style='color:#c7c7c7'>Não estás  <span style='color:#ff0000'>apto</span> para conduzir nenhum veículo!", 5000, 'error')
			end
		end)
	end
end)

-- Gera um novo número de licença exclusivo
function generateLicense()
  local numLicenca = ''
  repeat
    -- Código para gerar um número aleatório ou sequencial
	numLicenca = math.random(1000000, 9999999)

  until not licenseExists(numLicenca)
  return numLicenca
end

function licenseExists(number)
  local result = MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM users WHERE numero_carta_conducao = @number', {['@number'] = number})
  return tonumber(result) > 0
end

RegisterNetEvent('esx_dmvschool:johnny:payLicense')
AddEventHandler('esx_dmvschool:johnny:payLicense', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(price)
	TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Pagaste <span style='color:#069a19'>"..ESX.Math.GroupDigits(price).."€</span> pela carta de condução!", 5000, 'success')
end)

ESX.RegisterServerCallback("esx_dmvschool:server:checkmoney", function(source, cb, ammount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getAccount('bank').money > ammount then
		xPlayer.removeAccountMoney('bank', ammount)
		cb(true)
	else
		cb(false)
	end
end)