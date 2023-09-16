local AccountsIndex, Accounts, SharedAccounts = {}, {}, {}

ESX = nil

ESX = exports['es_extended']:getSharedObject()

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM addon_account')

	for i=1, #result, 1 do
		local name   = result[i].name
		local label  = result[i].label
		local shared = result[i].shared

		local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name', {
			['@account_name'] = name
		})

		if shared == 0 then
			table.insert(AccountsIndex, name)
			Accounts[name] = {}

			for j=1, #result2, 1 do
				local addonAccount = CreateAddonAccount(name, result2[j].owner, result2[j].money, result2[j].black_money)
				table.insert(Accounts[name], addonAccount)
			end
		else
			local money = nil
			local black_money = nil

			if #result2 == 0 then
				MySQL.Sync.execute('INSERT INTO addon_account_data (account_name, money, black_money, owner) VALUES (@account_name, @money, @black_money, NULL)', {
					['@account_name'] = name,
					['@money']        = 0,
					['@black_money']  = 0
				})

				money = 0
				black_money = 0
			else
				money = result2[1].money
				black_money = result2[1].black_money
			end

			local addonAccount   = CreateAddonAccount(name, nil, money, black_money)
			SharedAccounts[name] = addonAccount
		end
	end
end)

function GetAccount(name, owner)
	for i=1, #Accounts[name], 1 do
		if Accounts[name][i].owner == owner then
			return Accounts[name][i]
		end
	end
end

function GetSharedAccount(name)
	return SharedAccounts[name]
end

AddEventHandler('esx_addonaccount:getAccount', function(name, owner, cb)
	cb(GetAccount(name, owner))
end)

AddEventHandler('esx_addonaccount:getSharedAccount', function(name, cb)
	cb(GetSharedAccount(name))
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local addonAccounts = {}
	local xPlayer2 = ESX.GetPlayerFromId(playerId)

	for i=1, #AccountsIndex, 1 do
		local name    = AccountsIndex[i]
		local account = GetAccount(name, xPlayer2.identifier)

		if account == nil then
			MySQL.Async.execute('INSERT INTO addon_account_data (account_name, money, black_money, owner) VALUES (@account_name, @money, @black_money, @owner)', {
				['@account_name'] = name,
				['@money']        = 0,
				['@black_money']  = 0,
				['@owner']        = xPlayer2.identifier
			})

			account = CreateAddonAccount(name, xPlayer2.identifier, 0)
			table.insert(Accounts[name], account)
		end

		table.insert(addonAccounts, account)
	end

	xPlayer2.set('addonAccounts', addonAccounts)
end)
