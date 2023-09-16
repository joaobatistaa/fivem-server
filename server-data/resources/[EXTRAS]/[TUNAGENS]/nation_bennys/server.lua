local using_bennys = {}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('nation:checkPermission',function(source, cb)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == config.permissao then
        cb(true)
	elseif xPlayer.job.name == config.permissao2 then
		cb(true)
    elseif config.mechaniconly then
        cb(false)
        TriggerClientEvent("Notify",source,"negado","Tens que ser mecânico para tunar um veículo!",7000)
    elseif not config.mechaniconly then
        cb(true)
    end
end)

ESX.RegisterServerCallback('nation:checkPayment',function(source, cb, amount, modoadmin)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local bankey = xPlayer.getAccount('bank').money
    local cash = xPlayer.getMoney()

    if not modoadmin then
        if not config.mechaniconly and bankey >= amount then
            if config.societymoney then
                local societyAccount = nil
                TriggerEvent(
                    "esx_addonaccount:getSharedAccount",
                    config.society_name,
                    function(account)
                        societyAccount = account
                    end)
                    societyAccount.addMoney(amount)
            end
            xPlayer.removeAccountMoney('bank', amount)
            TriggerClientEvent("Notify",source,"sucesso","Tunagem aplicada com <b>sucesso</b>!<br>Custo Total: <b>"..tonumber(amount).."€ <b>",7000)
            cb(true)
        elseif not config.mechaniconly and cash >= amount then
            if config.societymoney then
                local societyAccount = nil
                TriggerEvent(
                    "esx_addonaccount:getSharedAccount",
                    config.society_name,
                    function(account)
                        societyAccount = account
                    end)
                    societyAccount.addMoney(amount)
            end
            xPlayer.removeMoney(amount)
            TriggerClientEvent("Notify",source,"sucesso","Tunagem aplicada com <b>sucesso</b>!<br>Custo Total: <b>"..tonumber(amount).."€ <b>",7000)
            cb(true)
        elseif config.mechaniconly then
            if config.societymoney then
				if xPlayer.job.name == 'mechanic' then
					local societyAccount = nil
					TriggerEvent("esx_addonaccount:getSharedAccount", config.society_name, function(account)
						societyAccount = account
					end)
					societyAccount.removeMoney(amount)
					TriggerClientEvent("Notify",source,"sucesso","Tunagem aplicada com <b>sucesso</b>!<br>Custo Total: <b>"..tonumber(amount).."€ <b>",7000)
					cb(true)
				elseif xPlayer.job.name == 'redline' then
					local societyAccount = nil
					TriggerEvent("esx_addonaccount:getSharedAccount", config.society_name2, function(account)
						societyAccount = account
					end)
					societyAccount.removeMoney(amount)
					TriggerClientEvent("Notify",source,"sucesso","Tunagem aplicada com <b>sucesso</b>!<br>Custo Total: <b>"..tonumber(amount).."€ <b>",7000)
					cb(true)
				else
					TriggerClientEvent("Notify",source,"negado","O teu emprego não te permite tunar um veículo!",7000)
					cb(false)
				end
            else
                if bankey >= amount then
                    xPlayer.removeAccountMoney('bank', amount)
                    TriggerClientEvent("Notify",source,"sucesso","Tunagem aplicada com <b>sucesso</b>!<br>Custo Total: <b>"..tonumber(amount).."€ <b>",7000)
                    cb(true)
                elseif cash >= amount then
                    xPlayer.removeMoney(amount)
                    TriggerClientEvent("Notify",source,"sucesso","Tunagem aplicada com <b>sucesso</b>!<br>Custo Total: <b>"..tonumber(amount).."€ <b>",7000)
                    cb(true)
                end
            end
        else
            TriggerClientEvent("Notify",source,"negado","Não tens dinheiro suficiente!",7000)
            cb(false)
        end
    else
        TriggerClientEvent("Notify",source,"sucesso","Tunagem aplicada com <b>sucesso</b>!",7000)
        cb(true)
    end
end)

RegisterServerEvent("nation:removeVehicle")
AddEventHandler("nation:removeVehicle",function(vehicle)
    using_bennys[vehicle] = nil
    return true
end)

ESX.RegisterServerCallback('nation:checkVehicle',function(source, cb, vehicle)
    if using_bennys[vehicle] then
        cb(false)
    else
        using_bennys[vehicle] = true
        cb(true)
    end
end)

--[[
AddEventHandler('playerDropped', function (reason)
    print('Player ' .. GetPlayerName(source) .. ' dropped (Reason: ' .. reason .. ')')
end)
--]]
  
RegisterServerEvent('saveVehicle')
AddEventHandler('saveVehicle', function(plate,props)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if props.plate == nil then
        props.plate = plate
    end
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = props.plate
	}, function(result)
		if result[1] ~= nil and result[1].vehicle then
            local vehicle = json.decode(result[1].vehicle)
			if props.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = props.plate,
					['@vehicle'] = json.encode(props)
				})
			else
				print(('NOOB: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)


RegisterServerEvent("nation:syncApplyMods")
AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
    TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
end)