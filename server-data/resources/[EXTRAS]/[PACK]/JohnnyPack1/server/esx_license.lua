ESX = nil

ESX = exports['es_extended']:getSharedObject()

QS = nil

TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)

function AddLicense(target, type, cb, idSource)
	local _source = idSource
	local identifier = GetPlayerIdentifier(target, 0)
	local xPlayer = ESX.GetPlayerFromId(target)
	
	if xPlayer then
		if type == 'boat' or type == 'hunt' or type == 'weapon' or type == 'aviao' then
			local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
				['@identifier'] = identifier
			})
			
			local firstname = result[1].firstname
			local lastname  = result[1].lastname
			local sex       = result[1].sex
			local dob       = result[1].dateofbirth
			local num_licenca = 0
			local sqlName = nil
			
			if type == 'boat' then
				num_licenca = result[1].numero_licenca_barco
				sqlName = 'numero_licenca_barco'
			end
			if type == 'hunt' then
				num_licenca = result[1].numero_licenca_caca
				sqlName = 'numero_licenca_caca'
			end
			if type == 'weapon' then
				num_licenca = result[1].numero_porte_arma
				sqlName = 'numero_porte_arma'
			end
			if type == 'aviao' then
				num_licenca = result[1].numero_licenca_aviao
				sqlName = 'numero_licenca_aviao'
			end
			
			if tonumber(num_licenca) == 0 then

				local numLicenca = generateLicense(type)

				MySQL.Async.execute('UPDATE users SET `'..sqlName..'` = @numero_licenca WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@numero_licenca'] = numLicenca
				}, function(rowsChanged)
					if rowsChanged == 0 then
						print('erro ao adicionar numero carta conducao')
					end
				end)
				
				num_licenca = numLicenca
			end
			
			local items = exports['qs-inventory']:GetInventory(target)
			local temNoInv = false
			local nomeItem = nil
			local labelItem = nil
			
			if type == 'boat' then
				nomeItem = 'licenca_barco'
				labelItem = 'Licença de Navegação'
			end
			if type == 'hunt' then
				nomeItem = 'licenca_caca'
				labelItem = 'Licença de Caça'
			end
			if type == 'weapon' then
				nomeItem = 'licenca_arma'
				labelItem = 'Licença de Porte de Arma'
			end
			if type == 'aviao' then
				nomeItem = 'licenca_aviao'
				labelItem = 'Licença de Avião'
			end
			if nomeItem ~= nil then
				for _, objeto in pairs(items) do
					if objeto.name == nomeItem then
						if objeto.info.numero_licenca == num_licenca then
							temNoInv = true
						end
					end
				end
			else
				print("nomeItem == nil (Corrigir)")
			end
			info = {
				name = firstname,
				lastname = lastname,
				gender = sex,
				dateofbirth = dob,
				numero_licenca = num_licenca
			}  
			
			if temNoInv then
				if labelItem ~= nil then
					TriggerClientEvent('Johnny_Notificacoes:Alert', target, "INFO", "<span style='color:#c7c7c7'>Já tens a tua "..labelItem.." contigo!", 10000, 'info')
					if type == 'hunt' or type == 'weapon' then
						TriggerClientEvent('Johnny_Notificacoes:Alert', _source, "ERRO", "<span style='color:#c7c7c7'>O jogador já tem a sua "..labelItem.." no inventário!", 5000, 'error')
					end
				else
					print('labelItem == nil (Corrigir)')
				end
			else
				exports['qs-inventory']:AddItem(target, nomeItem, 1, nil, info)
				TriggerClientEvent('Johnny_Notificacoes:Alert', target, "SUCESSO", "<span style='color:#c7c7c7'>Recebeste a tua <span style='color:#069a19'>"..labelItem.."</span>! Parabéns!", 5000, 'success')
			end
			
			local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE owner = @owner and type = @type", {
				['@owner'] = identifier,
				['@type'] = type
			})

			if result[1] == nil then
				MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
					['@type']  = type,
					['@owner'] = identifier
				}, function(rowsChanged)
					if cb ~= nil then
						cb()
					end
				end)
			end
		else
			local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE owner = @owner and type = @type", {
				['@owner'] = identifier,
				['@type'] = type
			})
			
			if result[1] == nil then
				MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
					['@type']  = type,
					['@owner'] = identifier
				}, function(rowsChanged)
					if cb ~= nil then
						cb(true)
					end
				end)
			end
		end
	end
end

function RemoveLicense(target, type, cb, idSource)
	local _source = idSource
	local identifier = GetPlayerIdentifier(target, 0)
	local xPlayer = ESX.GetPlayerFromId(target)
	
	local numeroLicencaCaca = 0
	local numeroPorteArma = 0
	local numeroCartaConducao = 0
	local numeroLicencaBarco = 0
	local numeroLicencaAviao = 0
	
	local items = exports['qs-inventory']:GetInventory(target)
	
	if type == 'hunt' then
		local result = MySQL.Sync.fetchAll("SELECT numero_licenca_caca FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})
		if result[1] then
			numeroLicencaCaca = result[1].numero_licenca_caca
		end
	end
	
	if type == 'weapon' then
		local result = MySQL.Sync.fetchAll("SELECT numero_porte_arma FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})
		if result[1] then
			numeroPorteArma = result[1].numero_porte_arma
		end
	end
	
	if type == 'boat' then
		local result = MySQL.Sync.fetchAll("SELECT numero_licenca_barco FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})
		if result[1] then
			numeroLicencaBarco = result[1].numero_licenca_barco
		end
	end
	
	if type == 'aviao' then
		local result = MySQL.Sync.fetchAll("SELECT numero_licenca_aviao FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})
		if result[1] then
			numeroLicencaAviao = result[1].numero_licenca_aviao
		end
	end
	
	if type == 'dmv' or type == 'drive' or type == 'drive_bike' or type == 'drive_truck' then
		local result = MySQL.Sync.fetchAll("SELECT numero_carta_conducao FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})
		if result[1] then
			numeroCartaConducao = result[1].numero_carta_conducao
		end
	end
	
	MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(rowsChanged)
		if rowsChanged > 0 then
			if type == 'weapon' then
				for _, objeto in pairs(items) do
					if objeto.name == 'licenca_arma' then
						if tonumber(objeto.info.numero_licenca) == tonumber(numeroPorteArma) then
							exports['qs-inventory']:RemoveItem(target, objeto.name, 1, objeto.slot, objeto.info)
						end
					end
				end
			end
			if type == 'dmv' or type == 'drive' or type == 'drive_bike' or type == 'drive_truck' then
				for _, objeto in pairs(items) do
					if objeto.name == 'carta_conducao' then
						if tonumber(objeto.info.numero_licenca) == tonumber(numeroCartaConducao) then
							exports['qs-inventory']:RemoveItem(target, objeto.name, 1, objeto.slot, objeto.info)
						end
					end
				end
			end
			if type == 'hunt' then
				for _, objeto in pairs(items) do
					if objeto.name == 'licenca_caca' then
						if tonumber(objeto.info.numero_licenca) == tonumber(numeroLicencaCaca) then
							exports['qs-inventory']:RemoveItem(target, objeto.name, 1, objeto.slot, objeto.info)
						end
					end
				end
			end
			
			if type == 'boat' then
				for _, objeto in pairs(items) do
					if objeto.name == 'licenca_barco' then
						if tonumber(objeto.info.numero_licenca) == tonumber(numeroLicencaBarco) then
							exports['qs-inventory']:RemoveItem(target, objeto.name, 1, objeto.slot, objeto.info)
						end
					end
				end
			end
			
			if type == 'aviao' then
				for _, objeto in pairs(items) do
					if objeto.name == 'licenca_aviao' then
						if tonumber(objeto.info.numero_licenca) == tonumber(numeroLicencaAviao) then
							exports['qs-inventory']:RemoveItem(target, objeto.name, 1, objeto.slot, objeto.info)
						end
					end
				end
			end
			cb()
		end
	end)
end

function GetLicense(type, cb)
	MySQL.Async.fetchAll('SELECT * FROM licenses WHERE type = @type', {
		['@type'] = type
	}, function(result)
		local data = {
			type  = type,
			label = result[1].label
		}

		cb(data)
	end)
end

function GetLicenses(target, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
		['@owner'] = identifier
	}, function(result)
		local licenses   = {}
		local asyncTasks = {}

		for i=1, #result, 1 do

			local scope = function(type)
				table.insert(asyncTasks, function(cb)
					MySQL.Async.fetchAll('SELECT * FROM licenses WHERE type = @type', {
						['@type'] = type
					}, function(result2)
						table.insert(licenses, {
							type  = type,
							label = result2[1].label
						})

						cb()
					end)
				end)
			end

			scope(result[i].type)

		end

		Async.parallel(asyncTasks, function(results)
			cb(licenses)
		end)

	end)
end

function CheckLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end

	end)
end

function GetLicensesList(cb)
	MySQL.Async.fetchAll('SELECT * FROM licenses', {
		['@type'] = type
	}, function(result)
		local licenses = {}

		for i=1, #result, 1 do
			table.insert(licenses, {
				type  = result[i].type,
				label = result[i].label
			})
		end

		cb(licenses)
	end)
end

RegisterNetEvent('esx_license:addLicense')
AddEventHandler('esx_license:addLicense', function(target, type, cb)
	local _source = source
	AddLicense(target, type, cb, _source)
end)

RegisterNetEvent('esx_license:removeLicense')
AddEventHandler('esx_license:removeLicense', function(target, type, cb)
	local _source = source
	RemoveLicense(target, type, cb, _source)
end)

AddEventHandler('esx_license:getLicense', function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler('esx_license:getLicenses', function(target, cb)
	GetLicenses(target, cb)
end)

AddEventHandler('esx_license:checkLicense', function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicensesList', function(cb)
	GetLicensesList(cb)
end)

ESX.RegisterServerCallback('esx_license:getLicense', function(source, cb, type)
	GetLicense(type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicenses', function(source, cb, target)
	GetLicenses(target, cb)
end)

ESX.RegisterServerCallback('esx_license:checkLicense', function(source, cb, target, type)
	CheckLicense(target, type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicensesList', function(source, cb)
	GetLicensesList(cb)
end)

-- Gera um novo número de licença exclusivo
function generateLicense(type)
  local numLicenca = ''
  repeat
    -- Código para gerar um número aleatório ou sequencial
	numLicenca = math.random(1000000, 9999999)

  until not licenseExists(numLicenca, type)
  return numLicenca
end

function licenseExists(number, type)
	local sqlName = nil
	if type == 'boat' then
		sqlName = 'numero_licenca_barco'
	end
	if type == 'hunt' then
		sqlName = 'numero_licenca_caca'
	end
	if type == 'weapon' then
		sqlName = 'numero_porte_arma'
	end
	if type == 'aviao' then
		sqlName = 'numero_licenca_aviao'
	end
	
	if sqlName ~= nil then
		local result = MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM users WHERE '..sqlName..' = @number', {['@number'] = number})
		return tonumber(result) > 0
	else
		return true
	end
end