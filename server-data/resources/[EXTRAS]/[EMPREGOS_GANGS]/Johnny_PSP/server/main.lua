ESX = nil

ESX = exports['es_extended']:getSharedObject()

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
end

TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterServerEvent('esx_policejob:giveWeapon')
AddEventHandler('esx_policejob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		xPlayer.addWeapon(weapon, ammo)
	end
end)

RegisterServerEvent('esx_policejob:darItemsArmario')
AddEventHandler('esx_policejob:darItemsArmario', function(item, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	sourceXPlayer.addInventoryItem(item,amount)		
end)

RegisterServerEvent('esx_policejob:daruniforme')
AddEventHandler('esx_policejob:daruniforme', function()
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	
	sourceXPlayer.addInventoryItem('sacouniforme',1)	
end)

RegisterServerEvent('esx_policejob:darclip')
AddEventHandler('esx_policejob:darclip', function(item)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	
	sourceXPlayer.addInventoryItem(item, 1)
end)

RegisterServerEvent('esx_policejob:daralgemas')
AddEventHandler('esx_policejob:daralgemas', function()
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	
	sourceXPlayer.addInventoryItem('handcuffs',1)	
end)

ESX.RegisterUsableItem('sacouniforme', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx:policejob:sacouniforme', _source)
	elseif xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx:sheriffjob:sacouniforme', _source)
	elseif xPlayer.job.name == 'pj' then
		TriggerClientEvent('esx:pjjob:sacouniforme', _source)
	end
end)

RegisterServerEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem('handcuffs').count
	
	if (xPlayer.job.name == 'vanilla' or xPlayer.job.name == 'tequila' or xPlayer.job.name == 'chatarreros' or xPlayer.job.name == 'peakyblinders' or xPlayer.job.name == 'cartelmedellin' or xPlayer.job.name == 'mafia' 
	or xPlayer.job.name == 'hacker' or xPlayer.job.name == 'miner' or xPlayer.job.name == 'grove' or xPlayer.job.name == 'worldcostumers' or xPlayer.job.name == 'badjoraz' or xPlayer.job.name == 'casino'
	or xPlayer.job.name == 'cartel' or xPlayer.job.name == 'blackpistons' or xPlayer.job.name == 'vagos' or xPlayer.job.name == 'thelostmc' or xPlayer.job.name == 'ballas' or xPlayer.job.name == 'bahamas' or xPlayer.job.name == 'police' 
	or xPlayer.job.name == 'sheriff') then
		if sourceItem > 0 then
			TriggerClientEvent('esx_policejob:handcuff', target)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Não tens algemas no inventário!')
		end
	else
		print(('esx_policejob: %s attempted to handcuff a player (not cop neither gang)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:algemar1')
AddEventHandler('esx_policejob:algemar1', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem('handcuffs').count
	
	if sourceItem > 0 then
		TriggerClientEvent('esx_policejob:algemar1', target)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', 'error', { type = 'inform', text = 'Não tens algemas no inventário!', length = 4000})
	end
end)

RegisterServerEvent('esx_policejob:desalgemar1')
AddEventHandler('esx_policejob:desalgemar1', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem('handcuffs').count
	
	if sourceItem > 0 then
		TriggerClientEvent('esx_policejob:desalgemar1', target)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', 'error', { type = 'inform', text = 'Não tens algemas no inventário!', length = 4000})
	end
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	TriggerClientEvent('esx_policejob:drag', target, source)
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	TriggerClientEvent('esx_policejob:putInVehicle', target)
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	TriggerClientEvent('esx_policejob:OutVehicle', target)
end)


ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

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

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function(result)

		local retrievedInfo = {
			plate = plate,
			insurance = nil
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrievedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrievedInfo.owner = result2[1].name
				end
				retrievedInfo.insurance = result[1].insurance
				cb(retrievedInfo)
			end)
		else
			cb(retrievedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

QS = nil
TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)


RegisterServerEvent('esx_policejob:server:giveLicenseArma')
AddEventHandler('esx_policejob:server:giveLicenseArma', function(id)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(id)
	local dadosLicencas = {}
	local temPorteArma = false
	
	if xPlayer then
		TriggerEvent('esx_license:getLicenses', id, function(licenses)
            dadosLicencas = licenses

            for i=1, #dadosLicencas, 1 do
                if dadosLicencas[i].label ~= nil and dadosLicencas[i].type ~= nil then
                    if dadosLicencas[i].type == 'weapon' then
                        temPorteArma = true
                    end
                end
            end

            if not temPorteArma then
				TriggerEvent('esx_license:addLicense', id, 'weapon')
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Emitiste uma Licença de Porte e Uso de Armas!' })
            else
                TriggerEvent('esx_license:addLicense', id, 'weapon')
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Renovaste a Licença de Porte e Uso de Armas do Civil!' })
            end
        end)
        
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não existe nenhum jogador no servidor com esse ID!' })
	end
end)

RegisterServerEvent('esx_policejob:server:giveLicenseCaca')
AddEventHandler('esx_policejob:server:giveLicenseCaca', function(id)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(id)
	local dadosLicencas = {}
	local temPorteArma = false
	
	if xPlayer then
		TriggerEvent('esx_license:getLicenses', id, function(licenses)
            dadosLicencas = licenses

            for i=1, #dadosLicencas, 1 do
                if dadosLicencas[i].label ~= nil and dadosLicencas[i].type ~= nil then
                    if dadosLicencas[i].type == 'hunt' then
                        temPorteArma = true
                    end
                end
            end

            if not temPorteArma then
				TriggerEvent('esx_license:addLicense', id, 'hunt')
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Emitiste uma Licença de Caça!' })
            else
                TriggerEvent('esx_license:addLicense', id, 'hunt')
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Renovaste a Licença de Caça do Civil!' })
            end
        end)
        
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não existe nenhum jogador no servidor com esse ID!' })
	end
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff') then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_policejob:spawned')
AddEventHandler('esx_policejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff') then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_policejob:forceBlip')
AddEventHandler('esx_policejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	TriggerClientEvent('Johnny_Notificacoes:Alert', target, "INFO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'info')
end)

ESX.RegisterServerCallback('esx_policejob:hasLocator', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	local localizador = xPlayer.getInventoryItem('locator')
	
	if localizador then
		local item = xPlayer.getInventoryItem('locator').count
		if item > 0 then
			cb(true)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.getJob().name
	if (job == "police" or job == "sheriff") and item.name == "locator" then
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)


AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.getJob().name
	if (job == "police" or job == "sheriff") and item.name == "locator" then
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)