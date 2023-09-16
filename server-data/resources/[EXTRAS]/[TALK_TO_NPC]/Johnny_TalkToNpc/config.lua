Config = {}

Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

Config.AutoCamPosition = true -- If true it'll set the camera position automatically

Config.AutoCamRotation = true -- If true it'll set the camera rotation automatically

Config.HideMinimap = true -- If true it'll hide the minimap when interacting with an NPC

Config.UseOkokTextUI = true -- If true it'll use okokTextUI 

Config.CameraAnimationTime = 1000 -- Camera animation time: 1000 = 1 second

Config.TalkToNPC = {
	{
		npc = 'g_m_y_mexgoon_01', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Dealer de Meta', 								    -- Text over the name
		name = 'Venda de Drogas', 									-- Text under the header
		uiText = "Dealer de Meta",									-- Name shown on the notification when near the NPC
		dialog = 'O que precisas irmão?',							-- Text showm on the message bubble 
		coordinates = vector3(2820.602, -741.830, 1.0171), 			-- coordinates of NPC
		heading = 311.0,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Quero vender 100x Meta Empacotada', 'okokTalk:vendaMeta', 's'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC
			'grove',
			'ballas',
			'vagos'
		},
	},
	{
		npc = 'g_m_y_ballasout_01', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Dealer de Cocaína', 								    -- Text over the name
		name = 'Venda de Drogas', 										-- Text under the header
		uiText = "Dealer de Cocaína",								-- Name shown on the notification when near the NPC
		dialog = 'O que precisas irmão?',							-- Text showm on the message bubble 
		coordinates = vector3(904.4505, 3656.685, 31.573), 			-- coordinates of NPC
		heading = 251.0,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Quero vender 100x Cocaína Empacotada', 'okokTalk:vendaCocaina', 's'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC
			'grove',
			'ballas',
			'vagos'
		},
	},
	{
		npc = 'g_m_y_ballaorig_01', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Dealer de Marijuana', 							-- Text over the name
		name = 'Venda de Drogas', 								 	-- Text under the header
		uiText = "Dealer de Marijuana",								-- Name shown on the notification when near the NPC
		dialog = 'O que precisas irmão?',							-- Text showm on the message bubble 
		coordinates = vector3(2185.370, 5583.348, 52.898), 			-- coordinates of NPC
		heading = 251.0,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Quero vender 100x Marijuana Empacotada', 'okokTalk:vendaMarijuana', 's'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC
			'grove',
			'ballas',
			'vagos'
		},
	},
	{
		npc = 's_m_y_chef_01', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Comprador de Itens de Caça', 							-- Text over the name
		name = 'Venda de Itens de Caça', 								 	-- Text under the header
		uiText = "Comprador de Itens de Caça",								-- Name shown on the notification when near the NPC
		dialog = 'Como posso ajudá-lo?',							-- Text showm on the message bubble 
		coordinates = vector3(-121.93, 6204.93, 31.38), 			-- coordinates of NPC
		heading = 52.61,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Quero vender Carne Fresca', 'fanonx-hunting:legal:sellCarne', 's'},		-- 'c' for client
			{'Quero vender Couros', 'fanonx-hunting:legal:sellCouro', 's'},		-- 'c' for client
			{'Quero vender Chifres de Veado', 'fanonx-hunting:legal:sellChifreVeado', 's'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC
		},
	},
	{
		npc = 'ig_chef', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Comprador de Itens de Caça Ilegal', 							-- Text over the name
		name = 'Venda de Itens de Caça Ilegal', 								 	-- Text under the header
		uiText = "Comprador de Itens de Caça Ilegal",								-- Name shown on the notification when near the NPC
		dialog = 'Posso ajudar-te parceiro?',							-- Text showm on the message bubble 
		coordinates = vector3(582.38, -2723.17, 6.19), 			-- coordinates of NPC
		heading = 183.61,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Quero vender Couros Ilegais', 'fanonx-hunting:legal:sellCouroIlegal', 's'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC
		},
	},
	{
		npc = 'ig_brad', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Comprador de Itens do Lixo', 							-- Text over the name
		name = 'Venda de Itens do Lixo', 								 	-- Text under the header
		uiText = "Comprador de Itens do Lixo",								-- Name shown on the notification when near the NPC
		dialog = 'Como posso ajudá-lo?',							-- Text showm on the message bubble 
		coordinates = vector3(-601.98, -1603.56, 29.40), 			-- coordinates of NPC
		heading = 355.01,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Quero vender 50x Vidro', 'okokTalk:vendaVidro', 's'},		-- 'c' for client
			{'Quero vender 50x Plástico', 'okokTalk:vendaPlastico', 's'},		-- 'c' for client
			{'Quero vender 50x Borracha', 'okokTalk:vendaBorracha', 's'},		-- 'c' for client
			{'Quero vender 50x Metal', 'okokTalk:vendaMetal', 's'},		-- 'c' for client
			{'Quero vender 10x Eletrónicos', 'okokTalk:vendaEletronicos', 's'},		-- 'c' for client
			{'Quero vender 50x Alumínio', 'okokTalk:vendaAluminio', 's'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC
		},
	},
	{
		npc = 'ig_cletus', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Comprador de Itens do Lixo', 							-- Text over the name
		name = 'Venda de Itens do Lixo', 								 	-- Text under the header
		uiText = "Comprador de Itens do Lixo",								-- Name shown on the notification when near the NPC
		dialog = 'Como posso ajudá-lo?',							-- Text showm on the message bubble 
		coordinates = vector3(-601.90, -1598.21, 29.40), 			-- coordinates of NPC
		heading = 174.91,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Quero vender 20x Sucata de Metal', 'okokTalk:vendaSucataMetal', 's'},		-- 'c' for client
			{'Quero vender 20x Telemóveis Estragados', 'okokTalk:vendaTelemoveisAvariados', 's'},		-- 'c' for client
			{'Quero vender 20x Binóculos', 'okokTalk:vendaBinoculos', 's'},		-- 'c' for client
			{'Quero vender 20x Isqueiros', 'okokTalk:vendaIsqueiros', 's'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC
		},
	},
	--[[
	-- This is the template to create new NPCs
	{
		npc = "",
		header = "",
		name = "",
		uiText = "",
		dialog = "",
		coordinates = vector3(0.0, 0.0, 0.0),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 0,
		options = {
			{"", 'client:event', 'c'},
			{"", 'client:event', 'c'},
			{"", 'client:event', 'c'}, 
			{"", 'server:event', 's'}, 
			{"", 'server:event', 's'}, 
			{"", 'server:event', 's'}, 
		},
		jobs = {	-- Example jobs
			'police',
			'ambulance',
		},
	},
	]]--
}