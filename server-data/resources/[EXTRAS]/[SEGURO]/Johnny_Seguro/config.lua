Config = {

	UsingCoreCredits = false, -- You will be able to pay with credits for the vehicle claim (https://core.tebex.io/package/4523886)
	CanClaimExisting = false, -- If set to true you can claim a vehicle if it already exists in the world (EXPERMENTAL) (WONT APPLY IS VEHICLE IS BROKEN) (WORKS FOR ALL VANILLA AND FOR SOME IMPORTS)
	CanInsureNotStored = true, -- This will only work if you have 'stored' in your owned_vehicle structure. If disabled this will not allow insuring of non stored vehicles meaning if you lose your vehicle you wont get it back
	SpawnLocked = false, -- Spawns vehicle with locked doors

	BlipCenterSprite = 649,
	BlipCenterColor = 3,
	BlipCenterText = 'Seguradora de Veículos',

	NotifyOfInsurancePayment = true, -- Give you notification when you pay for car insurance
	InsurancePaymentInterval = 3600, -- Interval in seconds when you pay insurance during gameplay

	--Plans you can choose for your vehicle
	-- oneTimePrice = Price that will be paid as a signup fee
	-- intervalPrice = Price that will be paid every inverval cycle
	-- franchise = Price that has be paid to submit a claim
	-- cooldown = How long before you can submit a claim again on the same vehicle
	-- claimTime = Amount of time to get your vehicle
	-- claimCreditsPrice = If paid with credits this will eliminate claimTime and will give you vehicle instantly
	InsurancePlans = {

	['basic'] = { label = 'BÁSICO', intervalPrice = 0, oneTimePrice = 50, franchise = 200, cooldown = 1800, claimTime = 60, claimCreditsPrice = 100},
	['premium'] = { label = 'INTERMÉDIO', intervalPrice = 100, oneTimePrice = 500, franchise = 100, cooldown = 900, claimTime = 30, claimCreditsPrice = 150},
	['advanced'] = {label = 'AVANÇADO', intervalPrice = 500, oneTimePrice = 1000, franchise = 0, cooldown = 300, claimTime = 15, claimCreditsPrice = 250}

	},

	InsuranceDesk = vector3(-291.1,-429.71,30.24),
	--InsuranceDesk2 = vector3(1777.13,3799.67,34.52),
	--InsuranceDesk3 = vector3(-87.67, 6494.31, 32.1),

	Lots = {

	[1] = {coords = vector3(394.95,-1625.92,29.29), heading = 51.81, occupied = false},
	[2] = {coords = vector3(398.6,-1621.16,29.29), heading = 51.81, occupied = false}

	},

	--[[
	Lots2 = {

	[1] = {coords = vector3(1765.81, 3792.47,33.94), heading = 207.97, occupied = false},
	[2] = {coords = vector3(1762.58,3790.4,33.95), heading = 210.64, occupied = false}

	},

	Lots3 = {

	[1] = {coords = vector3(-80.98,6493.73,31.49), heading = 227.01, occupied = false},
	[2] = {coords = vector3(-77.04, 6497.92, 31.49), heading = 228.8, occupied = false}

	},
	--]]

	 

	Text = {

		['desk_hologram'] = '[~b~E~w~] Seguradora',
		['occupied'] = 'Todos os estacionamentos estão ocupados, aguarda!',
		['claimed'] = 'Veículo recuperado! Waypoint definido para o estacionamento',
		['plan_changed'] = 'Alteraste o plano do teu seguro!',
		['not_enough_money'] = 'Não tens dinheiro suficiente no banco!',
		['credits_updated'] = 'Credits updated! Claim was executed instantly!',
		['not_enough_credits'] = 'You dont have enough credits!',
		['inverval_payment'] = 'Pagaste pelo seguro do teu carro!',
		['inverval_payment_error'] = 'Não tens dinheiro para pagar o seguro! O mesmo foi removido!'
	}

}



function SendTextMessage(msg, type)

        --SetNotificationTextEntry('STRING')
        --AddTextComponentString(msg)
        --DrawNotification(0,1)

        --EXAMPLE USED IN VIDEO
		if type == 'success' then
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'success')
		elseif type == 'error' then
			exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'error')
		elseif type == 'info' then
			exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..msg.."", 10000, 'info')
		else
			exports['Johnny_Notificacoes']:Alert("AVISO", "<span style='color:#c7c7c7'>"..msg.."", 5000, 'warning')
		end

		
        --exports['mythic_notify']:DoHudText('inform', msg)

end
