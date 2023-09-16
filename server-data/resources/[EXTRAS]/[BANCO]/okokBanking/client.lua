ESX = exports.es_extended:getSharedObject()
local PlayerData = {}
local trans = {}
local societyTrans = {}
local societyIdent, societyDays
local didAction = false
local isBankOpened = false
local canAccessSociety = false
local society = ''
local societyInfo
local closestATM, atmPos
local isDead = false
local playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney
local targetOptionsNames = { atm = 'okokBanking:ATM', bank = 'okokBanking:Bank'}
local BankZonesId, AtmModels = {}, {}

CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

-- Add support for the /relog from esx_multicharacter
RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

-- Support Wasabi Ambulance job.
AddEventHandler('esx:onPlayerSpawn', function()
    isDead = false
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

CreateThread(function()
	if Config.ShowBankBlips then
		Wait(2000)
		for k,v in ipairs(Config.BankLocations)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.blipScale)
			SetBlipColour(blip, v.blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipText)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

if Config.UseTargetOnBank then
	RegisterNetEvent("okokBanking:OpenBank")
	AddEventHandler("okokBanking:OpenBank", function()
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data'
		})
		Wait(500)
		openBank()
	end)

	-- Creation of all box zones for banking.
	for k, v in ipairs(Config.BankLocations) do
		local boxName = targetOptionsNames.bank .. k

		if v.boxZone then
			local zoneId = exports.qtarget:AddBoxZone(boxName, v.boxZone.pos, v.boxZone.size.x, v.boxZone.size.y, {
				name = boxName,
            	heading =  v.boxZone.rotation,
            	debugPoly = Config.DebugTargetZones,
            	minZ =  v.boxZone.pos.z ,
            	maxZ = v.boxZone.maxZ,
            	useZ = false,
			}, {
				options = {{
					icon = 'fas fa-piggy-bank',
					label = _L('open_banking_target').text,
					-- With CanInteract if the player is dead or in a vehicle, it will return false and he will not be able to open the bank.
					canInteract = function(entity)
						return not isDead and not IsPedInAnyVehicle(PlayerPedId())
					end,
					action = function(entity)
						TriggerEvent('okokBanking:OpenBank')
					end
				}},
				distance = Config.TargetBankDistance,
			})
			table.insert(BankZonesId, zoneId)
		end
	end
else
	local function NearBank()
		local pos = GetEntityCoords(PlayerPedId())

		for k, v in pairs(Config.BankLocations) do
			local dist = #(vector3(v.x, v.y, v.z) - pos)

			if dist <= v.BankDistance then
				return true
			elseif dist <= v.BankDistance + 5 then
				return "update"
			end
		end
	end

	CreateThread(function()
		local inRange = false
		local shown = false
		local notified = false

		while true do
			local playerped = PlayerPedId()
			inRange = false
			Wait(0)
			if NearBank() and not isBankOpened and NearBank() ~= "update" then
				if not Config.okokTextUI then
					ESX.ShowHelpNotification(_L('open_banking').text)
				else
					inRange = true
				end

				if IsControlJustReleased(0, 38) then

					if not isDead and not IsPedInAnyVehicle(playerped) then
						SetNuiFocus(true, true)
						SendNUIMessage({
							action = 'loading_data'
						})
						Wait(500)
						openBank()
					else
						if not notified then
							exports['Johnny_Notificacoes']:Alert(_L('not_use_bank').title, _L('not_use_bank').text, _L('not_use_bank').time, _L('not_use_bank').type)
							notified = true
						end
					end
				end
			elseif NearBank() == "update" then
				Wait(300)
			else
				Wait(1000)
			end

			if inRange and not shown then
				shown = true
				exports['okokTextUI']:Open(_L('open_banking').text, _L('open_banking').color, _L('open_banking').side)
			elseif not inRange and shown then
				shown = false
				exports['okokTextUI']:Close()
			end
			notified = false
		end
	end)
end

-- Added support atm on target for ox_target
if Config.UseTargetOnAtm then
    -- Convert ATM list from config for compatibility with ox_target | qtarget.
    for k, v in ipairs(Config.ATM) do AtmModels[#AtmModels + 1] = v.model end

	-- New Event to open atm from targetting.
	RegisterNetEvent('okokBanking:TargetATM')
	AddEventHandler('okokBanking:TargetATM', function()
		local ped = PlayerPedId()
		local dict = 'anim@amb@prop_human_atm@interior@male@enter'
		local anim = 'enter'

		ESX.TriggerServerCallback("okokBanking:GetPIN", function(pin)
			if pin then
				if not isBankOpened then
					isBankOpened = true
					RequestAnimDict(dict)

					while not HasAnimDictLoaded(dict) do
						Wait(7)
					end

					TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
					Wait(Config.AnimTime * 1000)
					ClearPedTasks(ped)

					TriggerEvent("okokBanking:OpenATM", pin)
					Wait(3000)
					RemoveAnimDict(dict)
				end
			else
				exports['Johnny_Notificacoes']:Alert(_L('no_pin').title, _L('no_pin').text, _L('no_pin').time, _L('no_pin').type)
			end
		end)
	end)

	-- Create target options for atm.
	local options= {{
		name = targetOptionsNames.atm,
		event = 'okokBanking:TargetATM',
		icon = 'fas fa-piggy-bank',
		label = _L('open_atm_target').text,
		-- With CanInteract if the player is dead or in a vehicle, it will return false and he will not be able to open the atm even if he has the item
		canInteract = function(entity) 
			return not isDead and not IsPedInAnyVehicle(PlayerPedId())
		end
	}}

	-- Add check item to interact with the atm (like this don't need call server to check if player as the right items).
	if Config.RequireCreditCardForATM then options[1].item = Config.CreditCardItem end

	-- Create target model.
	-- You can call this exports when you used ox_target because it's supported by him.
	exports.qtarget:AddTargetModel(AtmModels, {
		options = options,
		distance = Config.ATMDistance
	})
else
	-- Native Way to check if you are close of an atm.
	function NearATM()
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)

		for i = 1, #Config.ATM do
			local atm = GetClosestObjectOfType(pos.x, pos.y, pos.z, Config.ATMDistance + 5, Config.ATM[i].model, false, false, false)
			if DoesEntityExist(atm) then
				if atm ~= closestATM then
					closestATM = atm
					atmPos = GetEntityCoords(atm)
				end
				local dist = #(pos - atmPos)

				if dist <= Config.ATMDistance then
					return true
				elseif dist <= Config.ATMDistance + 5 then
					return "update"
				end
			end
		end
	end

	CreateThread(function()
		local inRange = false
		local shown = false
		local notified = false

		local dict = 'anim@amb@prop_human_atm@interior@male@enter'
		local anim = 'enter'

		while true do
			local ped = PlayerPedId()
			inRange = false
			Wait(0)
			if NearATM() and not isBankOpened and NearATM() ~= "update" then
				if not Config.okokTextUI then
					ESX.ShowHelpNotification(_L('open_atm').text)
				else
					inRange = true
				end

				if IsControlJustReleased(0, 38) then
					if not isDead and not IsPedInAnyVehicle(ped) then
						if Config.RequireCreditCardForATM then
							ESX.TriggerServerCallback("okokBanking:HasCreditCard", function(hasItem)
								if not hasItem then
									exports['Johnny_Notificacoes']:Alert(_L('no_creditcard').title, _L('no_creditcard').text, _L('no_creditcard').time, _L('no_creditcard').type)
									return
								else
									ESX.TriggerServerCallback("okokBanking:GetPIN", function(pin)
										if pin then
											if not isBankOpened then
												isBankOpened = true
												RequestAnimDict(dict)

												while not HasAnimDictLoaded(dict) do
													Wait(7)
												end

												TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
												Wait(Config.AnimTime * 1000)
												ClearPedTasks(ped)

												TriggerEvent("okokBanking:OpenATM", pin)
												Wait(3000)
												RemoveAnimDict(dict)
											end
										else
											exports['Johnny_Notificacoes']:Alert(_L('no_pin').title, _L('no_pin').text, _L('no_pin').time, _L('no_pin').type)
										end
									end)
								end
							end)
						else
							ESX.TriggerServerCallback("okokBanking:GetPIN", function(pin)
								if pin then
									if not isBankOpened then
										isBankOpened = true
										RequestAnimDict(dict)

										while not HasAnimDictLoaded(dict) do
											Wait(7)
										end

										TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
										Wait(Config.AnimTime * 1000)
										ClearPedTasks(ped)

										TriggerEvent("okokBanking:OpenATM", pin)
										Wait(3000)
										RemoveAnimDict(dict)
									end
								else
									exports['Johnny_Notificacoes']:Alert(_L('no_pin').title, _L('no_pin').text, _L('no_pin').time, _L('no_pin').type)
								end
							end)
						end
					else
						if not notified then
							exports['Johnny_Notificacoes']:Alert(_L('not_use_bank').title, _L('not_use_bank').text, _L('not_use_bank').time, _L('not_use_bank').type)
							notified = true
						end
					end
				end
			elseif NearATM() == "update" then
				Wait(100)
			else
				Wait(1000)
			end

			if inRange and not shown then
				shown = true
				exports['okokTextUI']:Open(_L('open_atm').text, _L('open_atm').color, _L('open_atm').side)
			elseif not inRange and shown then
				shown = false
				exports['okokTextUI']:Close()
			end
			notified = false
		end
	end)
end

RegisterNetEvent("okokBanking:OpenATM")
AddEventHandler("okokBanking:OpenATM", function(pin)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'atm',
		pin = pin,
		UseSound = Config.UseOkOkBankingSounds,
	})
end)

function openBank()
	local hasJob = false
	local playeJob = ESX.GetPlayerData().job
	local playerJobName = ''
	local playerJobGrade = ''
	local jobLabel = ''
	isBankOpened = true

	canAccessSociety = false

	if playeJob ~= nil then
		hasJob = true
		playerJobName = playeJob.name
		playerJobGrade = playeJob.grade_name
		jobLabel = playeJob.name
		society = 'society_'..playerJobName
	end

	ESX.TriggerServerCallback("okokBanking:GetPlayerInfo", function(data)
		ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cb, identifier, allDays)
			for k,v in pairs(Config.Societies) do
				if playerJobName == v then
					if json.encode(Config.SocietyAccessRanks) ~= '[]' then
						for k2,v2 in pairs(Config.SocietyAccessRanks) do
							if playerJobGrade == v2 then
								canAccessSociety = true
							end
						end
					else
						canAccessSociety = true
					end
				end
			end

			if canAccessSociety then
				ESX.TriggerServerCallback("okokBanking:SocietyInfo", function(cb)
					if cb ~= nil then
						societyInfo = cb
					else
						local societyIban = Config.IBANPrefix..jobLabel
						TriggerServerEvent("okokBanking:CreateSocietyAccount", society, jobLabel, 0, societyIban)
						Wait(200)
						ESX.TriggerServerCallback("okokBanking:SocietyInfo", function(cb)
							societyInfo = cb
						end, society)
					end
				end, society)
			end

			isBankOpened = true
			trans = cb
			playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney = data.playerName, data.playerBankMoney, data.playerIBAN, identifier, allDays, data.walletMoney
			ESX.TriggerServerCallback("okokBanking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
				societyIdent = societyID
				societyDays = societyAllDays
				societyTrans = societyTranscb
				if data.playerIBAN ~= nil then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'bankmenu',
						playerName = data.playerName,
						playerSex = data.sex,
						playerBankMoney = data.playerBankMoney,
						walletMoney = walletMoney,
						playerIBAN = data.playerIBAN,
						db = trans,
						identifier = trsIdentifier,
						graphDays = allDaysValues,
						isInSociety = canAccessSociety,
						RequireCC = Config.RequireCreditCardForATM,
						UseSound = Config.UseOkOkBankingSounds,
					})
				else
					GenerateIBAN()
					Wait(1000)
					ESX.TriggerServerCallback("okokBanking:GetPlayerInfo", function(data)
						SetNuiFocus(true, true)
						SendNUIMessage({
							action = 'bankmenu',
							playerName = data.playerName,
							playerSex = data.sex,
							playerBankMoney = data.playerBankMoney,
							walletMoney = walletMoney,
							playerIBAN = data.playerIBAN,
							db = trans,
							identifier = trsIdentifier,
							graphDays = allDaysValues,
							isInSociety = canAccessSociety,
							RequireCC = Config.RequireCreditCardForATM,
							UseSound = Config.UseOkOkBankingSounds,
						})
					end)
				end
			end, society)
		end)
	end)
end

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isBankOpened = false
		SetNuiFocus(false, false)
	elseif data.action == "deposit" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				if data.window == 'bankmenu' then
					TriggerServerEvent('okokBanking:DepositMoney', tonumber(data.value))
				elseif data.window == 'societies' then
					TriggerServerEvent('okokBanking:DepositMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name)
				end
			else
				exports['Johnny_Notificacoes']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
			end
		else
			exports['Johnny_Notificacoes']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
		end
	elseif data.action == "withdraw" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				if data.window == 'bankmenu' then
					TriggerServerEvent('okokBanking:WithdrawMoney', tonumber(data.value))
				elseif data.window == 'societies' then
					TriggerServerEvent('okokBanking:WithdrawMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name, societyInfo.value)
				end
			else
				exports['Johnny_Notificacoes']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
			end
		else
			exports['Johnny_Notificacoes']:Alert(_L('invalid_input').title, _L('invalid_input').text, _L('invalid_input').time, _L('invalid_input').type)
		end
	elseif data.action == "transfer" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)
					if isUsed ~= nil then
						if data.window == 'bankmenu' then
							if isPlayer then
								TriggerServerEvent('okokBanking:TransferMoney', tonumber(data.value), data.iban:upper(), isUsed.identifier, isUsed.accounts, isUsed.name)
							elseif not isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society)
							end
						elseif data.window == 'societies' then
							local toMyself = false
							if data.iban:upper() == playerIBAN then
								toMyself = true
							end

							if isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToPlayerFromSociety', tonumber(data.value), data.iban:upper(), isUsed.identifier, isUsed.accounts, isUsed.name, societyInfo.society, societyInfo.society_name, societyInfo.value, toMyself)
							elseif not isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToSocietyFromSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society, societyInfo.society, societyInfo.society_name, societyInfo.value)
							end
						end
					elseif isUsed == nil then
						exports['Johnny_Notificacoes']:Alert(_L('iban_not_exist').title, _L('iban_not_exist').text, _L('iban_not_exist').time, _L('iban_not_exist').type)
					end
				end, data.iban:upper())
			else
				exports['Johnny_Notificacoes']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
			end
		else
			exports['Johnny_Notificacoes']:Alert(_L('invalid_input').title, _L('invalid_input').text, _L('invalid_input').time, _L('invalid_input').type)
		end
	elseif data.action == "overview_page" then
		SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'overview_page',
				playerBankMoney = playerBankMoney,
				walletMoney = walletMoney,
				playerIBAN = playerIBAN,
				db = trans,
				identifier = trsIdentifier,
				graphDays = allDaysValues,
				isInSociety = canAccessSociety,
				RequireCC = Config.RequireCreditCardForATM,
			})
	elseif data.action == "transactions_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'transactions_page',
			db = trans,
			identifier = trsIdentifier,
			graph_values = allDaysValues,
			isInSociety = canAccessSociety,
		})
	elseif data.action == "society_transactions" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_transactions',
			db = societyTrans,
			identifier = societyIdent,
			graph_values = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "society_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			playerIBAN = playerIBAN,
			db = societyTrans,
			identifier = societyIdent,
			graphDays = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "settings_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'settings_page',
			isInSociety = canAccessSociety,
			ibanCost = Config.IBANChangeCost,
			ibanPrefix = Config.IBANPrefix,
			ibanCharNum = Config.CustomIBANMaxChars,
			pinCost = Config.PINChangeCost,
			pinCharNum = 4,
		})
	elseif data.action == "atm" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Wait(500)
		openBank()
	elseif data.action == "change_iban" then
		if Config.CustomIBANAllowLetters then
			local iban = Config.IBANPrefix..data.iban:upper()
			
			ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)

				if isUsed == nil then
					TriggerServerEvent('okokBanking:UpdateIbanDB', iban, Config.IBANChangeCost)
				elseif isUsed ~= nil then
					exports['Johnny_Notificacoes']:Alert(_L('iban_in_use').title, _L('iban_in_use').text, _L('iban_in_use').time, _L('iban_in_use').type)
				end
			end, iban)
		elseif not Config.CustomIBANAllowLetters then
			if tonumber(data.iban) ~= nil then
				local iban = Config.IBANPrefix..data.iban:upper()
				
				ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)

					if isUsed == nil then
						TriggerServerEvent('okokBanking:UpdateIbanDB', iban, Config.IBANChangeCost)
					elseif isUsed ~= nil then
						exports['Johnny_Notificacoes']:Alert(_L('iban_in_use').title, _L('iban_in_use').text, _L('iban_in_use').time, _L('iban_in_use').type)
					end
				end, iban)
			else
				exports['Johnny_Notificacoes']:Alert(_L('iban_only_numbers').title, _L('iban_only_numbers').text, _L('iban_only_numbers').time, _L('iban_only_numbers').type)
			end
		end
	elseif data.action == "change_pin" then
		if tonumber(data.pin) ~= nil then
			if string.len(data.pin) == 4 then
				ESX.TriggerServerCallback("okokBanking:GetPIN", function(pin)
					if pin then
						TriggerServerEvent('okokBanking:UpdatePINDB', data.pin, Config.PINChangeCost)
					else
						TriggerServerEvent('okokBanking:UpdatePINDB', data.pin, 0)
					end
				end)
			else
				exports['Johnny_Notificacoes']:Alert(_L('pin_digits').title, _L('pin_digits').text, _L('pin_digits').time, _L('pin_digits').type)
			end
		else
			exports['Johnny_Notificacoes']:Alert(_L('pin_only_numbers').title, _L('pin_only_numbers').text, _L('pin_only_numbers').time, _L('pin_only_numbers').type)
		end
	elseif data.action == "buy_new_cc" then
		TriggerServerEvent('okokBanking:GiveCC')
	end
	cb('ok')
end)

RegisterNetEvent("okokBanking:updateTransactions")
AddEventHandler("okokBanking:updateTransactions", function(money, wallet)
	Wait(100)
	if isBankOpened then
		ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cb, id, allDays)
			trans = cb
			allDaysValues = allDays
			SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'overview_page',
					playerBankMoney = playerBankMoney,
					walletMoney = walletMoney,
					playerIBAN = playerIBAN,
					db = trans,
					identifier = trsIdentifier,
					graphDays = allDaysValues,
					isInSociety = canAccessSociety,
					isUpdate = true,
					RequireCC = Config.RequireCreditCardForATM,
				})
			TriggerEvent('okokBanking:updateMoney', money, wallet)
		end)
	end
end)

RegisterNetEvent("okokBanking:updateMoney")
AddEventHandler("okokBanking:updateMoney", function(money, wallet)
	if isBankOpened then
		playerBankMoney = money
		walletMoney = wallet
		SendNUIMessage({
			action = 'updatevalue',
			playerBankMoney = money,
			walletMoney = wallet,
		})
	end
end)

RegisterNetEvent("okokBanking:updateIban")
AddEventHandler("okokBanking:updateIban", function(iban)
	playerIBAN = iban
	SendNUIMessage({
		action = 'updateiban',
		iban = playerIBAN,
	})
end)

RegisterNetEvent("okokBanking:updateIbanPinChange")
AddEventHandler("okokBanking:updateIbanPinChange", function()
	Wait(100)
	ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cbs, ids, allDays)
		trans = cbs
	end)
end)

RegisterNetEvent("okokBanking:updateTransactionsSociety")
AddEventHandler("okokBanking:updateTransactionsSociety", function(wallet)
	Wait(100)
	ESX.TriggerServerCallback("okokBanking:SocietyInfo", function(cb)
		ESX.TriggerServerCallback("okokBanking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
			ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cbs, ids, allDays)
				trans = cbs
				walletMoney = wallet
				societyDays = societyAllDays
				societyIdent = societyID
				societyTrans = societyTranscb
				societyInfo = cb
				if cb ~= nil then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'society_page',
						walletMoney = wallet,
						db = societyTrans,
						graphDays = societyDays,
						isInSociety = canAccessSociety,
						societyInfo = societyInfo,
						identifier = societyIdent,
						isUpdate = true,
					})
				end
			end)
		end, society)
	end, society)
end)

function GenerateIBAN()
	math.randomseed(GetGameTimer())
	local stringFormat = "%0"..Config.IBANNumbers.."d"
	local number = math.random(0, 10^Config.IBANNumbers-1)
	number = string.format(stringFormat, number)
	local iban = Config.IBANPrefix..number:upper()
	local isIBanUsed = true
	local hasChecked = false

	while true do
		Wait(10)
		if isIBanUsed and not hasChecked then
			isIBanUsed = false
			ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed)
				if isUsed ~= nil then
					isIBanUsed = true
					number = math.random(0, 10^Config.IBANNumbers-1)
					number = string.format("%03d", number)
					iban = Config.IBANPrefix..number:upper()
				elseif isUsed == nil then
					hasChecked = true
					isIBanUsed = false
				end
				canLoop = true
			end, iban)
		elseif not isIBanUsed and hasChecked then
			break
		end
	end
	TriggerServerEvent('okokBanking:SetIBAN', iban)
end