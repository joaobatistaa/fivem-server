local infoEdenAnimal = {}

infoEdenAnimal.PetShop = {
	{
		pet = 'chien',
		label = 'Cão',
		price = 500000
	},

	{
		pet = 'chat',
		label = 'Gato',
		price = 150000
	},

	{
		pet = 'lapin',
		label = 'Coelho',
		price = 250000
	},

	{
		pet = 'husky',
		label = 'Husky',
		price = 350000
	},

	{
		pet = 'cochon',
		label = 'Porco',
		price = 100000
	},

	{
		pet = 'caniche',
		label = 'Caniche',
		price = 500000
	},

	{
		pet = 'carlin',
		label = 'Pug',
		price = 60000
	},

	{
		pet = 'retriever',
		label = 'Labrador',
		price = 100000
	},

	--{
--		pet = 'berger',
--		label = _U('asatian'),
--		price = 55000
--	},

	{
		pet = 'westie',
		label = 'Westie',
		price = 500000
	}
	
	--{
	--	pet = 'leoa',
	--	label = 'Leôa',
	--	price = 100000000000
	--}

	--{
--		pet = 'chop',
	--	label = _U('chop'),
	--	price = 12000
--	}
}

infoEdenAnimal.Zones = {
	PetShop = {
		Pos = {x = 562.19, y = 2741.30, z = 41.86 },
		Sprite = 463,
		Display = 4,
		Scale = 1.0,
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1
	}
}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('eden_animal:getPet', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT pet FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].pet ~= nil then
			cb(result[1].pet)
		else
			cb('')
		end
	end)
end)

RegisterServerEvent('eden_animal:petDied')
AddEventHandler('eden_animal:petDied', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE users SET pet = "(NULL)" WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('eden_animal:consumePetFood')
AddEventHandler('eden_animal:consumePetFood', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('croquettes', 1)
end)

ESX.RegisterServerCallback('eden_animal:buyPet', function(source, cb, pet)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPriceFromPet(pet)

	if price == 0 then
		print(('eden_animal: %s attempted to buy an invalid pet!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('UPDATE users SET pet = @pet WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@pet'] = pet
		}, function(rowsChanged)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Compraste um '..pet..' por '..ESX.Math.GroupDigits(price)..'€')
			cb(true)
		end)
	else
		TriggerClientEvent('esx:showNotification', source, 'Não tens dinheiro suficiente!')
		cb(false)
	end
end)

function GetPriceFromPet(pet)
	for i=1, #infoEdenAnimal.PetShop, 1 do
		if infoEdenAnimal.PetShop[i].pet == pet then
			return infoEdenAnimal.PetShop[i].price
		end
	end

	return 0
end