Config.TimeoutLenhador = 20 * (60 * 1000)                                   -- 20 minutes

Config.LenhadorUniforms = {
	cloakroom = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 72,   ['torso_2'] = 8,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 73,   ['pants_2'] = 8,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 154,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 25,
			['pants_1'] = 66,   ['pants_2'] = 0,
			['shoes_1'] = 50,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	}
}

-- Blips
LumberDepo = {
    targetZone = vector3(1167.73, -1347.27, 33.92),                 -- qb-target vector
    targetHeading = 273.47,                                         -- qb-target box zone
    coords = vector4(1167.73, -1347.27, 33.92, 273.47),             -- Move Location (Ped and blip)
    SetBlipSprite = 85,                                             -- Blip Icon (https://docs.fivem.net/docs/game-references/blips/)
    SetBlipDisplay = 6,                                             -- Blip Behavior (https://docs.fivem.net/natives/?_0x9029B2F3DA924928)
    SetBlipScale = 0.85,                                            -- Blip Size
    SetBlipColour = 5,                                              -- Blip Color
    BlipLabel = "Serração",                                      -- Blip Label
    minZ = 31.92,                                                   -- Max Z
    maxZ = 35.92,                                                   -- Max Z
    Vehicle = 'tiptruck',                                           -- Job Vehicle
    VehicleCoords = vector4(1162.27, -1318.55, 34.74, 173.91),      -- Job Vehcile Coords
}
LumberProcessor = {
    targetZone = vector3(-517.13, 5331.54, 79.26),
    targetHeading = 336.38,
    coords = vector4(-517.13, 5331.54, 79.26, 336.38),
    SetBlipSprite = 365,
    SetBlipDisplay = 6,
    SetBlipScale = 1.15,
    SetBlipColour = 64,
    BlipLabel = "Processo de Madeira",
    minZ = 77.26,
    maxZ = 81.26,
}
LumberSeller = {
    targetZone = vector3(259.44, -3059.57, 4.86),
    targetHeading = 131.34,
    coords = vector4(259.44, -3059.57, 4.86, 131.34),
    SetBlipSprite = 605,
    SetBlipDisplay = 6,
    SetBlipScale = 0.85,
    SetBlipColour = 45,
    BlipLabel = "Venda de Madeira",
    minZ = 2.86,
    maxZ = 6.86,
}

LumberJob = {
    LumberModel = "s_m_y_construct_01",                             -- Ped model  https://wiki.rage.mp/index.php?title=Peds
    LumberHash = 0xD7DA9E99,                                        -- Hash numbers for ped model
    
    ChoppingTreeTimer = 20 * 1000,                                  -- 12 second timer
    ProcessingTime = 10 * 1000,                                     -- 10 second timer

    LumberAmount_Min = 2,
    LumberAmount_Max = 6,

    TreeBarkAmount_Min = 1,
    TreeBarkAmount_Max = 10,

    TradeAmount_Min = 3,
    TradeAmount_Max = 6,

    TradeRecevied_Min = 1,
    TradeRecevied_Max = 3,

    AxePrice = 100,                                                 -- Axe Price ($100)
}

Config.SellLenhador = {
    ["tree_lumber"] = {
        ["price"] = math.random(45, 60)                             -- Seller Price
    },
    ["tree_bark"] = {
        ["price"] = math.random(20, 30)
    },
    ["wood_plank"] = {
        ["price"] = math.random(65, 100)
    },
}

Config.Axe = {
    [`weapon_battleaxe`] = {}
}

Config.TreeLocations = {
    [1] = {
        ["coords"] = vector3(-504.47, 5392.09, 75.82),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [2] = {
        ["coords"] = vector3(-510.08, 5389.15, 73.71),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [3] = {
        ["coords"] = vector3(-558.32, 5418.98, 62.78),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [4] = {
        ["coords"] = vector3(-561.47, 5420.32, 62.39),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [5] = {
        ["coords"] = vector3(-578.9, 5427.22, 58.54),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [6] = {
        ["coords"] = vector3(-600.28, 5397.03, 52.48),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [7] = {
        ["coords"] = vector3(-614.04, 5399.73, 50.86),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [8] = {
        ["coords"] = vector3(-616.38, 5403.72, 50.59),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [9] = {
        ["coords"] = vector3(-553.08, 5445.65, 64.16),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [10] = {
        ["coords"] = vector3(-500.53, 5401.34, 75.05),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [11] = {
        ["coords"] = vector3(-491.78, 5395.47, 77.57),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [12] = {
        ["coords"] = vector3(-457.24, 5398.19, 79.35),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [13] = {
        ["coords"] = vector3(-456.87, 5408.32, 79.26),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [14] = {
        ["coords"] = vector3(-627.6, 5322.19, 59.86),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [15] = {
        ["coords"] = vector3(-626.05, 5315.49, 60.87),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [16] = {
        ["coords"] = vector3(-628.47, 5286.07, 63.75),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [17] = {
        ["coords"] = vector3(-604.23, 5243.57, 71.53),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [18] = {
        ["coords"] = vector3(-599.94, 5239.87, 71.87),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [19] = {
        ["coords"] = vector3(-556.65, 5233.61, 72.53),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [20] = {
        ["coords"] = vector3(-557.92, 5224.02, 77.24),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [21] = {
        ["coords"] = vector3(-546.26, 5219.38, 77.94),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [22] = {
        ["coords"] = vector3(-537.93, 5226.47, 78.52),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [23] = {
        ["coords"] = vector3(-628.32, 5286.04, 63.76),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [24] = {
        ["coords"] = vector3(-633.1, 5275.56, 69.11),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [25] = {
        ["coords"] = vector3(-604.37, 5243.69, 71.89),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [26] = {
        ["coords"] = vector3(-646.03, 5269.73, 74.01),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [27] = {
        ["coords"] = vector3(-644.29, 5241.2, 76.3),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [28] = {
        ["coords"] = vector3(-657.02, 5296.15, 69.35),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [29] = {
        ["coords"] = vector3(-659.05, 5293.48, 70.02),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [30] = {
        ["coords"] = vector3(-664.32, 5277.7, 74.4),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [31] = {
        ["coords"] = vector3(-615.24, 5433.06, 54.3),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [32] = {
        ["coords"] = vector3(-616.14, 5424.5, 51.71),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [33] = {
        ["coords"] = vector3(-690.07, 5304.85, 70.51),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
}

Config.Alerts = {
	['cancel'] = 'Cancelado',
	['error_lumber'] = 'Não tens madeira suficiente para fazer isso!',
	['error_axe'] = 'Não tens um machado na mão para cortar a árvore!',
	['lumber_progressbar'] = 'A processar madeira...',
	['itemamount'] = 'Estás a tentar processar uma quantidade inválida, tenta novamente!',
	['lumber_processed_trade'] = 'Trocaste com sucesso ',
	['lumber_processed_lumberamount'] = 'x Madeiras por ',
	['lumber_processed_received'] = 'x Tábuas Embaladas',
	['error_sold'] = 'Não tens itens para vender aqui!',
	['successfully_sold'] = 'Vendeste os teus itens.',

    ["axe_check"] = 'Já tens um machado!',
    ["axe_bought"] = 'Compraste um machado por ' ..LumberJob.AxePrice..'€',

    ['phone_sender'] = 'Lumber Mill Supervisor',
    ['phone_subject'] = 'Job task',
    ['phone_message'] = 'Estás encarregado de apanhar madeira perto da serraria Paleto Bay lá no Norte (Campo de Árvores no mapa). Depois de terminares de apanhar a madeira, fala com o chefe da fábrica para processar a madeira.',

    ['chopping_tree'] = 'A Cortar Árvore...',

    ['Tree_label'] = '~b~[E]~s~ Começar a cortar',
    ['depo_label'] = '~b~[E]~s~ Falar com o Chefe',
    ['mill_label'] = '~b~[E]~s~ Processar Madeira',

    ['depo_blocked'] = 'Spawn de veículos bloqueado por outro veículo.',
    ['depo_stored'] = 'Veículo do trabalho guardado.',

    ['vehicle_header'] = 'Menu Lenhador',
    ['vehicle_get'] = 'Veículo do Trabalho',
    ['vehicle_text'] = 'Job Vehicle',

    ['battleaxe_label'] = 'Machado',
    ['battleaxe_text'] = 'Axe used for chopping down trees',
    
    ['vehicle_remove'] = 'Guardar Veículo',
    ['remove_text'] = 'Remove Job Vehicle',

    ['lumber_mill'] = 'Serração',
    ['lumber_header'] = 'Processar Madeira',
    ['lumber_text'] = 'Troco por Tábuas de Madeira',

    ['Lumber_Seller'] = 'Vender a Madeira',

    ['goback'] = '< Go Back',

}