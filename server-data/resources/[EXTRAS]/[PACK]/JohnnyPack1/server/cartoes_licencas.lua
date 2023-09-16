QS = nil

TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)

ESX = nil

ESX = exports['es_extended']:getSharedObject()

local segunda_via_carta_conducao_preco = 5000
local segunda_via_cartao_cidadao_preco = 5000

local portearma_preco = 100000
local segunda_via_portearma_preco = 20000
local licenca_caca_preco = 50000
local segunda_via_licenca_caca_preco = 5000

RegisterServerEvent('wtrp:segundavia_carta_conducao')
AddEventHandler('wtrp:segundavia_carta_conducao', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local qtd = xPlayer.getInventoryItem('carta_conducao').count
	
	if xPlayer.getMoney() >= segunda_via_carta_conducao_preco then
		if qtd == 0 then
			xPlayer.removeMoney(segunda_via_carta_conducao_preco)
			xPlayer.addInventoryItem('carta_conducao', 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'Foi-te atribuida uma segunda via da carta de condução!' })
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Já possuis a carta de condução contigo!' })
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não tens dinheiro suficiente ('..segunda_via_carta_conducao_preco..'€)!' })
	end
end)

RegisterServerEvent('wtrp:segundavia_cartao_cidadao')
AddEventHandler('wtrp:segundavia_cartao_cidadao', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Player = QS.GetPlayerFromId (_source)
	
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['@identifier'] = xPlayer.identifier
	})

	local firstname = result[1].firstname
	local lastname  = result[1].lastname
	local sex       = result[1].sex
	local dob       = result[1].dateofbirth
	local id_civil  = result[1].numero_cc
	
	info = {
		name = firstname,
		lastname = lastname,
		gender = sex,
		dateofbirth = dob,
		numero_cc = id_civil
	}    
	
	if xPlayer.getMoney() >= segunda_via_cartao_cidadao_preco then
		xPlayer.removeMoney(segunda_via_cartao_cidadao_preco)
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Foi-te atribuida uma segunda via do cartão de cidadão!' })
		Player.addItem("cartao_cidadao", 1, false, info) 
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não tens dinheiro suficiente ('..segunda_via_cartao_cidadao_preco..'€) na carteira!' })
	end
end)

ESX.RegisterServerCallback('suku:buyLicense', function(source, cb, idjogador)
	local xPlayer = ESX.GetPlayerFromId(idjogador)
	local xPlayer2 = ESX.GetPlayerFromId(source)
	local qtdLicenca = xPlayer.getInventoryItem('weapon_license').count
	
	if qtdLicenca == 0 then
		if xPlayer.getMoney() >= LicensePrice then
			xPlayer.removeMoney(portearma_preco)
			
			if xPlayer2.job.name == 'police' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_police', function(j)
					j.addMoney(portearma_preco)
				end)
			elseif xPlayer2.job.name == 'sheriff' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_sheriff', function(j)
					j.addMoney(portearma_preco)
				end)
			end
			
			xPlayer.addInventoryItem('weapon_license', 1)
			TriggerEvent('esx_license:addLicense', idjogador, 'weapon', function()
				TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'success', text = 'Foi-te atribuida uma licença de porte de armas!' })
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Atribuiste uma licença de porte de armas ao jogador!' })
				cb(true)
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil não possui dinheiro suficiente!' })
			TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Não tens dinheiro suficiente ('..portearma_preco..'€)!' })
			cb(false)
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil ja possui um porte de arma com ele!' })
		TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Já tens um porte de arma no inventário!' })
		cb(false)
	end
end)

ESX.RegisterServerCallback('suku:buyLicenseCaca', function(source, cb, idjogador)
	local xPlayer = ESX.GetPlayerFromId(idjogador)
	local xPlayer2 = ESX.GetPlayerFromId(source)
	local qtdLicenca = xPlayer.getInventoryItem('licenca_caca').count
	
	if qtdLicenca == 0 then
		if xPlayer.getMoney() >= licenca_caca_preco then
			xPlayer.removeMoney(licenca_caca_preco)
			
			if xPlayer2.job.name == 'police' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_police', function(j)
					j.addMoney(licenca_caca_preco)
				end)
			elseif xPlayer2.job.name == 'sheriff' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_sheriff', function(j)
					j.addMoney(licenca_caca_preco)
				end)
			end
			
			xPlayer.addInventoryItem('licenca_caca', 1)
			TriggerEvent('esx_license:addLicense', idjogador, 'caca', function()
				TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'success', text = 'Foi-te atribuida uma licença de caça!' })
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Atribuiste uma licença de caça ao jogador!' })
				cb(true)
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil não possui dinheiro suficiente!' })
			TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Não tens dinheiro suficiente ('..licenca_caca_preco..'€)!' })
			cb(false)
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil ja possui um licença de caça no inventário!' })
		TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Já tens uma licença de caça no inventário!' })
		cb(false)
	end
end)

ESX.RegisterServerCallback('suku:verificalicenca', function(source, cb, idjogador)
	if idjogador == 'verifica' then
		idjogador = source
	else
		idjogador = idjogador
	end
	local portearma = false 
	local identifier = ESX.GetPlayerFromId(idjogador).identifier

	local _source 	 = ESX.GetPlayerFromId(idjogador)
	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				for i=1, #licenses, 1 do
					if licenses[i].type == 'weapon' then
						portearma = true
					end
				end
				if portearma then
					cb(true)
				else
					cb(false)
				end
			end)		
		end
	end)
end)

ESX.RegisterServerCallback('suku:verificaLicencaCaca', function(source, cb, idjogador)
	if idjogador == 'verifica' then
		idjogador = source
	else
		idjogador = idjogador
	end
	local licenca_caca = false 
	local identifier = ESX.GetPlayerFromId(idjogador).identifier

	local _source 	 = ESX.GetPlayerFromId(idjogador)
	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				for i=1, #licenses, 1 do
					if licenses[i].type == 'caca' then
						licenca_caca = true
					end
				end
				if licenca_caca then
					cb(true)
				else
					cb(false)
				end
			end)		
		end
	end)
end)


RegisterServerEvent("suku:segundavia")
AddEventHandler("suku:segundavia",function(idjogador)
	local xPlayer = ESX.GetPlayerFromId(idjogador)
	local xPlayer2 = ESX.GetPlayerFromId(source)
	local porte = xPlayer.getInventoryItem('weapon_license').count
	
	if porte == 0 then
		if xPlayer.getMoney() >= segunda_via_portearma_preco then
			xPlayer.removeMoney(segunda_via_portearma_preco)
			if xPlayer2.job.name == 'police' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_police', function(j)
					j.addMoney(segunda_via_portearma_preco)
				end)
			elseif xPlayer2.job.name == 'sheriff' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_sheriff', function(j)
					j.addMoney(segunda_via_portearma_preco)
				end)
			end
			
			xPlayer.addInventoryItem('weapon_license', 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Atribuiste uma segunda via ao jogador com o ID:' ..idjogador..'!' })
			TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'success', text = 'Foi-te atribuida uma segunda via do porte de arma e pagaste '..segunda_via_portearma_preco.. '€!' })
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil não tem dinheiro suficiente!' })
			TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Não tens dinheiro suficiente ('..segunda_via_portearma_preco..'€)!' })
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil já possui um porte de arma com ele!' })
		TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Já possuis um porte de arma no inventário!' })
	end
end)

RegisterServerEvent("suku:segundaviaCaca")
AddEventHandler("suku:segundaviaCaca",function(idjogador)
	local xPlayer = ESX.GetPlayerFromId(idjogador)
	local xPlayer2 = ESX.GetPlayerFromId(source)
	local porte = xPlayer.getInventoryItem('licenca_caca').count
	
	if porte == 0 then
		if xPlayer.getMoney() >= segunda_via_licenca_caca_preco then
			xPlayer.removeMoney(segunda_via_licenca_caca_preco)
			
			if xPlayer2.job.name == 'police' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_police', function(j)
					j.addMoney(segunda_via_licenca_caca_preco)
				end)
			elseif xPlayer2.job.name == 'sheriff' then
				TriggerEvent("esx_addonaccount:getSharedAccount", 'society_sheriff', function(j)
					j.addMoney(segunda_via_licenca_caca_preco)
				end)
			end
			
			xPlayer.addInventoryItem('licenca_caca', 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Atribuiste uma segunda via ao jogador com o ID:' ..idjogador..'!' })
			TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'success', text = 'Foi-te atribuida uma segunda via da licença de caça e pagaste '..segunda_via_licenca_caca_preco..'€!' })
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil não tem dinheiro suficiente!' })
			TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Não tens dinheiro suficiente ('..segunda_via_licenca_caca_preco..'€)!' })
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'O civil já possui uma licença de caça com ele!' })
		TriggerClientEvent('mythic_notify:client:SendAlert', idjogador, { type = 'error', text = 'Já possuis uma licença de caça no inventário!' })
	end
end)

ESX.RegisterServerCallback('wtrp:verifica_carta_conducao', function(source, cb)
	local idjogador = source
	local identifier = ESX.GetPlayerFromId(idjogador).identifier
	local _source 	 = ESX.GetPlayerFromId(idjogador)
	local licenca = false
	
	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				for i=1, #licenses, 1 do
					if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
						licenca = true
					end
				end
				if licenca then
					cb(true)
				else
					cb(false)
				end
			end)
		end
	end)
	
end)