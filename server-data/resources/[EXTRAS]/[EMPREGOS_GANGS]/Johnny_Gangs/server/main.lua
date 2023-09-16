ESX = nil

ESX = exports['es_extended']:getSharedObject()

-------------------------------------------------------------------------------------------------
-------------------------------- REGISTAR NUMEROS DAS EMPRESAS ----------------------------------
-------------------------------------------------------------------------------------------------

TriggerEvent('esx_society:registerSociety', 'redline', 'Redline', 'society_redline', 'society_redline', 'society_redline', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'bahamas', 'Bahamas', 'society_bahamas', 'society_bahamas', 'society_bahamas', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'peakyblinders', 'Peaky Blinders', 'society_peakyblinders', 'society_peakyblinders', 'society_peakyblinders', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'pear', 'Pear', 'society_pear', 'society_pear', 'society_pear', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'ballas', 'Ballas', 'society_ballas', 'society_ballas', 'society_ballas', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'vagos', 'Vagos', 'society_vagos', 'society_vagos', 'society_vagos', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'cartel', 'Cartel', 'society_cartel', 'society_cartel', 'society_cartel', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'grove', 'Grove', 'society_grove', 'society_grove', 'society_grove', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'mafia', 'Máfia', 'society_mafia', 'society_mafia', 'society_mafia', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'yakuza', 'Yakuza', 'society_yakuza', 'society_yakuza', 'society_yakuza', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'vanilla', 'Vanilla', 'society_vanilla', 'society_vanilla', 'society_vanilla', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'advogado', 'Advogado', 'society_advogado', 'society_advogado', 'society_advogado', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'juiz', 'Juíz', 'society_juiz', 'society_juiz', 'society_juiz', {type = 'public'})

--TriggerEvent('esx_society:registerSociety', 'remax', 'Remax', 'society_remax', 'society_remax', 'society_remax', {type = 'public'}) -- QUASAR HOUSING

------------------------------------------------------------------------------------------------------
----------------------------------- FUNÇÕES DE INTERAÇÃO DO MENU F6 ----------------------------------
------------------------------------------------------------------------------------------------------

RegisterNetEvent('esx_gangsjob:handcuff')
AddEventHandler('esx_gangsjob:handcuff', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local qtd = xPlayer.getInventoryItem('handcuffs').count
	
	if (xPlayer.job.name == 'redline' or xPlayer.job.name == 'bahamas' or xPlayer.job.name == 'peakyblinders' or xPlayer.job.name == 'pear' or xPlayer.job.name == 'ballas' or xPlayer.job.name == 'vagos' or xPlayer.job.name == 'cartel'
		or xPlayer.job.name == 'grove' or xPlayer.job.name == 'mafia' or xPlayer.job.name == 'yakuza' or xPlayer.job.name == 'vanilla' or xPlayer.job.name == 'advogado' or xPlayer.job.name == 'juiz') then
		
		if qtd > 0 then
			TriggerClientEvent('esx_gangsjob:handcuff', target)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não tens algemas no inventário!', length = 4000})
		end
	else
		print(('esx_gangsjob: %s attempted to handcuff a player (not cop or gang)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_gangsjob:message')
AddEventHandler('esx_gangsjob:message', function(target, msg)
	TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = msg, length = 4000})
end)

RegisterNetEvent('esx_gangsjob:drag')
AddEventHandler('esx_gangsjob:drag', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if (xPlayer.job.name == 'redline' or xPlayer.job.name == 'bahamas' or xPlayer.job.name == 'peakyblinders' or xPlayer.job.name == 'pear' or xPlayer.job.name == 'ballas' or xPlayer.job.name == 'vagos' or xPlayer.job.name == 'cartel'
		or xPlayer.job.name == 'grove' or xPlayer.job.name == 'mafia' or xPlayer.job.name == 'yakuza' or xPlayer.job.name == 'vanilla' or xPlayer.job.name == 'advogado' or xPlayer.job.name == 'juiz') then
		
		TriggerClientEvent('esx_gangsjob:drag', target, _source)
	else
		print(('esx_gangsjob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_gangsjob:putInVehicle')
AddEventHandler('esx_gangsjob:putInVehicle', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if (xPlayer.job.name == 'redline' or xPlayer.job.name == 'bahamas' or xPlayer.job.name == 'peakyblinders' or xPlayer.job.name == 'pear' or xPlayer.job.name == 'ballas' or xPlayer.job.name == 'vagos' or xPlayer.job.name == 'cartel'
		or xPlayer.job.name == 'grove' or xPlayer.job.name == 'mafia' or xPlayer.job.name == 'yakuza' or xPlayer.job.name == 'vanilla' or xPlayer.job.name == 'advogado' or xPlayer.job.name == 'juiz') then
		
		TriggerClientEvent('esx_gangsjob:putInVehicle', target)
	else
		print(('esx_gangsjob: %s attempted to put in vehicle (not cop or gang)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_gangsjob:OutVehicle')
AddEventHandler('esx_gangsjob:OutVehicle', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if (xPlayer.job.name == 'redline' or xPlayer.job.name == 'bahamas' or xPlayer.job.name == 'peakyblinders' or xPlayer.job.name == 'pear' or xPlayer.job.name == 'ballas' or xPlayer.job.name == 'vagos' or xPlayer.job.name == 'cartel'
		or xPlayer.job.name == 'grove' or xPlayer.job.name == 'mafia' or xPlayer.job.name == 'yakuza' or xPlayer.job.name == 'vanilla' or xPlayer.job.name == 'advogado' or xPlayer.job.name == 'juiz') then
		
		TriggerClientEvent('esx_gangsjob:OutVehicle', target)
	else
		print(('esx_gangsjob: %s attempted to drag out from vehicle (not cop or gang)!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('esx_gangsjob:getOtherPlayerData', function(source, cb, target)

	local xPlayer = ESX.GetPlayerFromId(target)

	local identifier = GetPlayerIdentifiers(target)[1]

	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['@identifier'] = identifier
	})

	local firstname = result[1].firstname
	local lastname  = result[1].lastname
	local sex       = result[1].sex
	local dob       = result[1].dateofbirth
	local height    = result[1].height

	local data = {
		name      = GetPlayerName(target),
		job       = xPlayer.job,
		inventory = xPlayer.inventory,
		accounts  = xPlayer.accounts,
		weapons   = xPlayer.loadout,
		firstname = firstname,
		lastname  = lastname,
		sex       = sex,
		dob       = dob,
		height    = height
	}

	TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
		if status ~= nil then
			data.drunk = math.floor(status.percent)
		end
	end)

	TriggerEvent('esx_license:getLicenses', target, function(licenses)
		data.licenses = licenses
		cb(data)
	end)

end)