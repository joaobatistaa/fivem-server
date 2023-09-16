function CreateAddonAccount(name, owner, money, black_money)
	local self = {}

	self.name  = name
	self.owner = owner
	self.money = money
	self.black_money = black_money

	self.addMoney = function(m)
		self.money = self.money + m
		self.save()

		TriggerClientEvent('esx_addonaccount:setMoney', -1, self.name, self.money)
	end

	self.removeMoney = function(m)
		self.money = self.money - m
		self.save()

		TriggerClientEvent('esx_addonaccount:setMoney', -1, self.name, self.money)
	end

	self.setMoney = function(m)
		self.money = m
		self.save()

		TriggerClientEvent('esx_addonaccount:setMoney', -1, self.name, self.money)
	end
	
	self.addBlackMoney = function(m)
		self.black_money = self.black_money + m
		
		self.save()
	end

	self.removeBlackMoney = function(m)
		self.black_money = self.black_money - m
		
		self.save()
	end

	self.setBlackMoney = function(m)
		self.black_money = m
		
		self.save()
	end

	self.save = function()
		if self.owner == nil then
			MySQL.Async.execute('UPDATE addon_account_data SET money = @money, black_money = @black_money WHERE account_name = @account_name', {
				['@account_name'] = self.name,
				['@money']        = self.money,
				['@black_money']  = self.black_money
			})
		else
			MySQL.Async.execute('UPDATE addon_account_data SET money = @money, black_money = @black_money WHERE account_name = @account_name AND owner = @owner', {
				['@account_name'] = self.name,
				['@money']        = self.money,
				['@black_money']  = self.black_money,
				['@owner']        = self.owner
			})
		end
	end

	return self
end