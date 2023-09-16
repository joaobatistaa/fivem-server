ESX = nil

ESX = exports['es_extended']:getSharedObject()

--------------------------------------------------------------
-------------------------- BEBIDAS ---------------------------
--------------------------------------------------------------

ESX.RegisterUsableItem('milk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('milk', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', -100000)
	TriggerClientEvent('esx_basicneeds:onDrinkMilk', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_milk'))
end)

ESX.RegisterUsableItem('beer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_beer'))
end)

ESX.RegisterUsableItem('champagne', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('champagne', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 50000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkChampagne', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_champagne'))
end)

ESX.RegisterUsableItem('jager', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jager', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkWine', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_jager'))
end)

ESX.RegisterUsableItem('drpepper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('drpepper', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkWine', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_drpepper'))
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	TriggerClientEvent('esx_basicneeds:onDrinkVodka', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_vodka'))
end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkWine', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_martini'))
end)

ESX.RegisterUsableItem('shot', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('shot', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkGin', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_shot'))
end)

ESX.RegisterUsableItem('wine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('wine', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkWine', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_wine'))
end)

ESX.RegisterUsableItem('mojito', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mojito', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkMojito', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_mojito'))
end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkWine', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_rhum'))
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkWhisky', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_whisky'))
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkTequila', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_tequila'))
end)

ESX.RegisterUsableItem('gintonic', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('gintonic', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkGin', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_gintonic'))
end)

ESX.RegisterUsableItem('absinthe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('absinthe', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	TriggerClientEvent('esx_basicneeds:onDrinkAbsinthe', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_absinthe'))
end)

-- Cigarett
ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter').count
	
	if lighter > 0 then
		xPlayer.removeInventoryItem('cigarett', 1)
		TriggerClientEvent('esx_basicneeds:OnSmokeCigarett', source)
		Citizen.Wait(8000)
		--TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
		--TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = '- Stress'})
	else
		TriggerClientEvent('esx:showNotification', source, ('Não tens 1x isqueiro'))
	end
end)

-- BEBIDAS PIER

local comidas = {
	['bacalhau_bras'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['bacalhau_natas'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['pizza_pepperoni'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'v_res_tt_pizzaplate'},
	['pizza_margarita'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'v_res_tt_pizzaplate'},
	['pizza_carbonara'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'v_res_tt_pizzaplate'},
	['pizza_vegetariana'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'v_res_tt_pizzaplate'},
	['pizza_havaiana'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'v_res_tt_pizzaplate'},
	['hamburguer'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_burger_01'},
	['strogonoff'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['lasanha'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['massa_bolonhesa'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['salada_mar'] = {fome = 700000, sede = 100000, tempo = 20000, prop = 'ng_proc_food_ornge1a'},
	['pudim'] = {fome = 100000, sede = 50000, tempo = 10000, prop = 'ng_proc_food_ornge1a'},
	['salada_fruta'] = {fome = 100000, sede = 50000, tempo = 10000, prop = 'prop_plate_03'},
	['mousse'] = {fome = 100000, sede = 50000, tempo = 10000, prop = 'ng_proc_food_ornge1a'},
	['prato_casa'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['feijoada'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['picapau'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['moelas'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['caracois'] = {fome = 500000, sede = 50000, tempo = 15000, prop = 'prop_cs_plate_01'},
	['kebab'] = {fome = 1000000, sede = 100000, tempo = 15000, prop = 'prop_ff_noodle_01'},
	['maca'] = {fome = 100000, sede = 100000, tempo = 5000, prop = 'ng_proc_food_ornge1a'},
	['banana'] = {fome = 100000, sede = 100000, tempo = 5000, prop = 'ng_proc_food_ornge1a'},
	['melancia'] = {fome = 100000, sede = 100000, tempo = 5000, prop = 'ng_proc_food_ornge1a'},
	['pessego'] = {fome = 100000, sede = 100000, tempo = 5000, prop = 'ng_proc_food_ornge1a'},
	['batatas_fritas'] = {fome = 300000, sede = 50000, tempo = 10000, prop = 'prop_food_bs_chips'},
	['arroz_valenciana'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['francesinha'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['entrecosto'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['nuggets'] = {fome = 500000, sede = 100000, tempo = 15000, prop = 'ng_proc_food_ornge1a'},
	['brownie_chocolate'] = {fome = 200000, sede = 50000, tempo = 5000, prop = 'ng_proc_food_ornge1a'},
	['noodles'] = {fome = 1000000, sede = 100000, tempo = 15000, prop = 'v_ret_247_noodle1'},
	['taco'] = {fome = 500000, sede = 100000, tempo = 10000, prop = 'prop_taco_01'},
	['polvo_lagareiro'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['arroz_pato'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['salmao_batatas'] = {fome = 1000000, sede = 100000, tempo = 20000, prop = 'prop_cs_plate_01'},
	['sardinhas_assadas'] = {fome = 1000000, sede = 100000, tempo = 15000, prop = 'prop_cs_plate_01'},
	['caldo_verde'] = {fome = 700000, sede = 500000, tempo = 15000, prop = 'v_res_mcofcup'},
	['sopa_legumes'] = {fome = 700000, sede = 500000, tempo = 15000, prop = 'v_res_mcofcup'},
	['pastel_nata'] = {fome = 100000, sede = 50000, tempo = 10000, prop = 'ng_proc_food_ornge1a'},
	['alface'] = {fome = 100000, sede = 50000, tempo = 5000, prop = 'prop_food_bag1'},
	['tomate'] = {fome = 100000, sede = 50000, tempo = 5000, prop = 'prop_food_bag1'},
	-- loja normal
	['bread'] = {fome = 50000, sede = 0, tempo = 5000, prop = 'ng_proc_food_ornge1a'},
	['sandwich'] = {fome = 100000, sede = 70000, tempo = 5000, prop = 'prop_sandwich_01'},
	['chocolate'] = {fome = 30000, sede = 10000, tempo = 5000, prop = 'prop_choc_ego'},
}

local bebidas = {
	['cocacola'] = {fome = 10000, sede = 800000, tempo = 5000, prop = 'prop_ecola_can'},
	['cafe'] = {fome = 10000, sede = 50000, tempo = 5000, prop = 'prop_fib_coffee'},
	['icetea'] = {fome = 10000, sede = 800000, tempo = 5000, prop = 'prop_orang_can_01'},
	['sevenup'] = {fome = 10000, sede = 800000, tempo = 5000, prop = 'prop_ld_can_01'},
	['sumol'] = {fome = 10000, sede = 800000, tempo = 5000, prop = 'v_res_tt_can03'},
	['fanta'] = {fome = 10000, sede = 800000, tempo = 5000, prop = 'prop_orang_can_01'},
	['sangria'] = {fome = 10000, sede = 1000000, tempo = 5000, prop = 'vw_prop_casino_wine_glass_01a'},
	-- loja normal
	['water'] = {fome = 10000, sede = 200000, tempo = 5000, prop = 'prop_ld_flow_bottle'},
	['energy'] = {fome = 10000, sede = 100000, tempo = 5000, prop = 'prop_energy_drink'},
}

local isBusy = {}

Citizen.CreateThread(function()
	-- Comida
	for item, data in pairs(comidas) do
		ESX.RegisterUsableItem(item, function(source)
			local playerId = source

			if not isBusy[playerId] or not isBusy[playerId].busy then
				isBusy[playerId] = { busy = true }
				local xPlayer = ESX.GetPlayerFromId(playerId)
				xPlayer.removeInventoryItem(item, 1)
				TriggerClientEvent('esx_basicneeds:onEat', playerId, data.prop, data.tempo)
				Citizen.Wait(data.tempo+1000)
				TriggerClientEvent('esx_status:add', playerId, 'hunger', data.fome)
				TriggerClientEvent('esx_status:add', playerId, 'thirst', data.sede)
				isBusy[playerId].busy = false
			end
		end)
	end

	-- Bebidas
	for item, data in pairs(bebidas) do
		ESX.RegisterUsableItem(item, function(source)
			local playerId = source

			if not isBusy[playerId] or not isBusy[playerId].busy then
				isBusy[playerId] = { busy = true }
				local xPlayer = ESX.GetPlayerFromId(playerId)
				xPlayer.removeInventoryItem(item, 1)
				TriggerClientEvent('esx_basicneeds:onDrink', playerId, data.prop, data.tempo)
				Citizen.Wait(data.tempo+1000)
				TriggerClientEvent('esx_status:add', playerId, 'hunger', data.fome)
				TriggerClientEvent('esx_status:add', playerId, 'thirst', data.sede)
				isBusy[playerId].busy = false
			end
		end)
	end
end)


