ESX = nil

ESX = exports['es_extended']:getSharedObject()

local marijuanaPrice = 1050
local cocainePrice = 1200
local methPrice = 1500

local vidroPrice = math.random(100,150)
local plasticoPrice = math.random(100,150)
local borrachaPrice = math.random(100,150)
local metalPrice = math.random(100,175)
local eletronicosPrice = math.random(150,250)
local aluminioPrice = math.random(100,150)
local sucataMetalPrice = math.random(100,150)
local telemoveisPrice = math.random(80,150)
local binoculosPrice = math.random(80,150)
local isqueirosPrice = math.random(20,40)


local minPolicia = 1

RegisterServerEvent('okokTalk:vendaDrogas')
AddEventHandler('okokTalk:vendaDrogas', function(evento)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if evento == 'meta' then
		local metaQuantity = xPlayer.getInventoryItem('meth_packaged').count
		
		if metaQuantity >= 100 then
			local totalMoney = methPrice * 100
			xPlayer.removeInventoryItem('meth_packaged', 100)
			xPlayer.addAccountMoney('black_money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 100x de Meta Empacotada por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 100x Meta Empacotada no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'cocaina' then
		local cocaineQuantity = xPlayer.getInventoryItem('cocaine_packaged').count
		
		if cocaineQuantity >= 100 then
			local totalMoney = cocainePrice * 100
			xPlayer.removeInventoryItem('cocaine_packaged', 100)
			xPlayer.addAccountMoney('black_money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 100x de Cocaína Empacotada por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 100x Cocaína Empacotada no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'marijuana' then
		local marijuanaQuantity = xPlayer.getInventoryItem('weed_packaged').count
		
		if marijuanaQuantity >= 100 then
			local totalMoney = marijuanaPrice * 100
			xPlayer.removeInventoryItem('weed_packaged', 100)
			xPlayer.addAccountMoney('black_money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 100x de Marijuana Empacotada por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 100x Marijuana Empacotada no inventário!</span>", 5000, 'error')
		end
	end
end)

function getPoliceCount() 
	local players = ESX.GetPlayers()
    local policeCount = 0
	print(#players)
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
		if player == nil then
			print(players[i])
		end
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end
	
	return policeCount
end

RegisterServerEvent('okokTalk:vendaMeta')
AddEventHandler('okokTalk:vendaMeta', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local metaQuantity = xPlayer.getInventoryItem('meth_packaged').count
	
	local policeCount = getPoliceCount()
	
    if policeCount >= minPolicia then
		if metaQuantity >= 100 then
			TriggerClientEvent("okokTalk:progressbarDrogas", source, 15000, "A vender Meta...", "meta")
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 100x Meta Empacotada no inventário!</span>", 5000, 'error')
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Tem que haver pelo menos 2 polícias na cidade!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaCocaina')
AddEventHandler('okokTalk:vendaCocaina', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local cocaineQuantity = xPlayer.getInventoryItem('cocaine_packaged').count
	
	local policeCount = getPoliceCount()
	
	if policeCount >= minPolicia then
		if cocaineQuantity >= 100 then
			TriggerClientEvent("okokTalk:progressbarDrogas", source, 15000, "A vender Cocaína...", "cocaina")
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 100x Cocaína Empacotada no inventário!</span>", 5000, 'error')
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Tem que haver pelo menos 2 polícias na cidade!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaMarijuana')
AddEventHandler('okokTalk:vendaMarijuana', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local marijuanaQuantity = xPlayer.getInventoryItem('weed_packaged').count
	
	local policeCount = getPoliceCount()
	
	if policeCount >= minPolicia then
		if marijuanaQuantity >= 100 then
			TriggerClientEvent("okokTalk:progressbarDrogas", source, 15000, "A vender Marijuana...", "marijuana")
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 100x Marijuana Empacotada no inventário!</span>", 5000, 'error')
		end
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Tem que haver pelo menos 2 polícias na cidade!</span>", 5000, 'error')
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------ VENDA LIXO --------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('okokTalk:vendaItensLixo')
AddEventHandler('okokTalk:vendaItensLixo', function(evento)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if evento == 'vidro' then
		local itemQuantity = xPlayer.getInventoryItem('glass').count
		
		if itemQuantity >= 50 then
			local totalMoney = vidroPrice * 50
			xPlayer.removeInventoryItem('glass', 50)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 50x Vidro por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Vidro no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'plastico' then
		local itemQuantity = xPlayer.getInventoryItem('plastic').count
		
		if itemQuantity >= 50 then
			local totalMoney = plasticoPrice * 50
			xPlayer.removeInventoryItem('plastic', 50)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 50x Plástico por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Plástico no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'borracha' then
		local itemQuantity = xPlayer.getInventoryItem('rubber').count
		
		if itemQuantity >= 50 then
			local totalMoney = borrachaPrice * 50
			xPlayer.removeInventoryItem('rubber', 50)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 50x Borracha por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Borracha no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'metal' then
		local itemQuantity = xPlayer.getInventoryItem('metal').count
		
		if itemQuantity >= 50 then
			local totalMoney = metalPrice * 50
			xPlayer.removeInventoryItem('metal', 50)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 50x Metal por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Metal no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'eletronicos' then
		local itemQuantity = xPlayer.getInventoryItem('electronics').count
		
		if itemQuantity >= 10 then
			local totalMoney = eletronicosPrice * 10
			xPlayer.removeInventoryItem('electronics', 10)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 10x Eletrónicos por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 10x Eletrónicos no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'aluminio' then
		local itemQuantity = xPlayer.getInventoryItem('aluminium').count
		
		if itemQuantity >= 50 then
			local totalMoney = aluminioPrice * 50
			xPlayer.removeInventoryItem('aluminium', 50)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 50x Alumínio por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Alumínio no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'sucatametal' then
		local itemQuantity = xPlayer.getInventoryItem('metalscrap').count
		
		if itemQuantity >= 20 then
			local totalMoney = sucataMetalPrice * 20
			xPlayer.removeInventoryItem('metalscrap', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Sucata de Metal por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Sucata de Metal no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'telemovelavariado' then
		local telemovelA_Quantity = xPlayer.getInventoryItem('wet_classic_phone').count
		local telemovelB_Quantity = xPlayer.getInventoryItem('wet_black_phone').count
		local telemovelC_Quantity = xPlayer.getInventoryItem('wet_blue_phone').count
		local telemovelD_Quantity = xPlayer.getInventoryItem('wet_gold_phone').count
		local telemovelE_Quantity = xPlayer.getInventoryItem('wet_red_phone').count
		local telemovelF_Quantity = xPlayer.getInventoryItem('wet_green_phone').count
		local telemovelG_Quantity = xPlayer.getInventoryItem('wet_greenlight_phone').count
		local telemovelH_Quantity = xPlayer.getInventoryItem('wet_pink_phone').count
		local telemovelI_Quantity = xPlayer.getInventoryItem('wet_white_phone').count
		
		if telemovelA_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_classic_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelB_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_black_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Preto Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelC_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_blue_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Azul Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelD_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_gold_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Dourado Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelE_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_red_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Vermelho Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelF_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_green_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Verde Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelG_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_greenlight_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Lima Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelH_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_pink_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Rosa Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		elseif telemovelI_Quantity >= 20 then
			local totalMoney = telemoveisPrice * 20
			xPlayer.removeInventoryItem('wet_white_phone', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Telemóvel Branco Avariado por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Telemóvel Avariado de um tipo no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'binoculos' then
		local itemQuantity = xPlayer.getInventoryItem('binoculars').count
		
		if itemQuantity >= 20 then
			local totalMoney = binoculosPrice * 20
			xPlayer.removeInventoryItem('binoculars', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Binóculos por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Binóculos no inventário!</span>", 5000, 'error')
		end
	end
	
	if evento == 'isqueiro' then
		local itemQuantity = xPlayer.getInventoryItem('lighter').count
		
		if itemQuantity >= 20 then
			local totalMoney = isqueirosPrice * 20
			xPlayer.removeInventoryItem('lighter', 20)
			xPlayer.addAccountMoney('money', totalMoney)
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "SUCESSO", "<span style='color:#c7c7c7'>Vendeste 20x Isqueiros por <b>"..totalMoney.."</b></span>€!", 5000, 'success')
		else
			TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Isqueiros no inventário!</span>", 5000, 'error')
		end
	end
end)

RegisterServerEvent('okokTalk:vendaVidro')
AddEventHandler('okokTalk:vendaVidro', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local vidroQuantity = xPlayer.getInventoryItem('glass').count
	
	if vidroQuantity >= 50 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Vidro...", "vidro")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Vidro no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaPlastico')
AddEventHandler('okokTalk:vendaPlastico', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local plasticoQuantity = xPlayer.getInventoryItem('plastic').count
	
	if plasticoQuantity >= 50 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Plástico...", "plastico")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Plástico no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaBorracha')
AddEventHandler('okokTalk:vendaBorracha', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local borrachaQuantity = xPlayer.getInventoryItem('rubber').count
	
	if borrachaQuantity >= 50 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Borracha...", "borracha")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Borracha no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaMetal')
AddEventHandler('okokTalk:vendaMetal', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local metalQuantity = xPlayer.getInventoryItem('metal').count
	
	if metalQuantity >= 50 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Metal...", "metal")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Metal no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaEletronicos')
AddEventHandler('okokTalk:vendaEletronicos', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local eletronicosQuantity = xPlayer.getInventoryItem('electronics').count
	
	if eletronicosQuantity >= 10 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Eletrónicos...", "eletronicos")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 10x Eletrónicos no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaAluminio')
AddEventHandler('okokTalk:vendaAluminio', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local aluminioQuantity = xPlayer.getInventoryItem('aluminium').count
	
	if aluminioQuantity >= 50 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Alumínio...", "aluminio")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 50x Alumínio no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaSucataMetal')
AddEventHandler('okokTalk:vendaSucataMetal', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local sucataQuantity = xPlayer.getInventoryItem('metalscrap').count
	
	if sucataQuantity >= 20 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Sucata de Metal...", "sucatametal")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Sucata de Metal no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaTelemoveisAvariados')
AddEventHandler('okokTalk:vendaTelemoveisAvariados', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local telemovelA_Quantity = xPlayer.getInventoryItem('wet_classic_phone').count
    local telemovelB_Quantity = xPlayer.getInventoryItem('wet_black_phone').count
    local telemovelC_Quantity = xPlayer.getInventoryItem('wet_blue_phone').count
    local telemovelD_Quantity = xPlayer.getInventoryItem('wet_gold_phone').count
    local telemovelE_Quantity = xPlayer.getInventoryItem('wet_red_phone').count
    local telemovelF_Quantity = xPlayer.getInventoryItem('wet_green_phone').count
    local telemovelG_Quantity = xPlayer.getInventoryItem('wet_greenlight_phone').count
    local telemovelH_Quantity = xPlayer.getInventoryItem('wet_pink_phone').count
    local telemovelI_Quantity = xPlayer.getInventoryItem('wet_white_phone').count
	
	if telemovelA_Quantity >= 20 or telemovelB_Quantity >= 20 or telemovelC_Quantity >= 20 or telemovelD_Quantity >= 20 or telemovelE_Quantity >= 20 or telemovelF_Quantity >= 20 or telemovelG_Quantity >= 20 or telemovelH_Quantity >= 20 or telemovelI_Quantity >= 20 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Telemóveis Avariados...", "telemovelavariado")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Telemóveis Avariados de um tipo no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaBinoculos')
AddEventHandler('okokTalk:vendaBinoculos', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local binoculosQuantity = xPlayer.getInventoryItem('binoculars').count
	
	if binoculosQuantity >= 20 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Binóculos...", "binoculos")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Binóculos no inventário!</span>", 5000, 'error')
	end
end)

RegisterServerEvent('okokTalk:vendaIsqueiros')
AddEventHandler('okokTalk:vendaIsqueiros', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local isqueiroQuantity = xPlayer.getInventoryItem('lighter').count
	
	if isqueiroQuantity >= 20 then
		TriggerClientEvent("okokTalk:progressbarLixo", source, 15000, "A Vender Isqueiros...", "isqueiro")
	else
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "ERRO", "<span style='color:#c7c7c7'>Não tens no mínimo 20x Isqueiros no inventário!</span>", 5000, 'error')
	end
end)