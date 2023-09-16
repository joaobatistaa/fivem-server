local beds = {
	{ x = 324.15, y = -583.02, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 322.73, y = -586.7, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 317.72, y = -585.14, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 314.5, y = -584.16, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 311.18, y = -582.71, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 307.78, y = -581.63, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 309.3, y = -577.6, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
	{ x = 313.83, y = -579.35, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
}

local bedsTaken = {}
local injuryBasePrice = 1000

ESX = nil

ESX = exports['es_extended']:getSharedObject()

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não há camas disponíveis' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Essa cama está ocupada' })
            end
        end
    end

    if not foundbed then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Não estás perto de uma cama de hospital' })
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

    -- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	
	--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'Radar (90KM/H) - A tua velocidade era: ' .. math.floor(SpeedKM) .. ' KM/H - ', finalBillingPrice) -- Sends a bill from the police
	--TriggerServerEvent('zapps_billing:sendNewInvoice', data) -- Sends a bill from the police
	--TriggerEvent("okokBilling:createInvoicePlayer", data)
	TriggerEvent("okokBilling:CreateCustomInvoice", src, totalBill, 'Tratamento médico no Hospital', 'Tratamento', 'society_ambulance', 'INEM')
	
	--local xPlayer = ESX.GetPlayerFromId(src)
	--xPlayer.removeAccountMoney('bank', totalBill)
   -- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Pagaste uma fatura no valor de ' .. totalBill ..'€' })
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)
