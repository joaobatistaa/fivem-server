Config.LixeiroValorCaucao = 500 -- valor caucao do veiculo
Config.LixeiroMin = 1300 -- valor minimo a receber por cada zona de lixo recolhida
Config.LixeiroMax = 1500 -- valor maximo a receber por cada zona de lixo recolhida

Config.LixeiroUniforms = {
	cloakroom = {
		male = {
			['tshirt_1'] = 112,  ['tshirt_2'] = 0,
			['torso_1'] = 5,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 127,
			['pants_1'] = 82,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 370,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 2,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 66,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	}
}

Config.LixeiroLocations = {
    ["main"] = {
        label = "Aterro Sanitário",
        coords = {x = -350.08, y = -1569.95, z = 25.22, h = 292.42},
    },
    ["vehicle"] = {
        label = "Aterro Sanitário",
        coords = {x = -340.74, y = -1561.82, z = 25.23, h = 58.0},
    },
    ["paycheck"] = {
        label = "Contabilista",
        coords = {x = -348.9, y = -1569.4, z = 25.22, h = 163.5, r = 1.0}, 
    },
	["vestiario"] = {
        label = "Vestiário",
        coords = {x = -351.06, y = -1564.98, z = 25.22, h = 163.5, r = 1.0}, 
    },
    ["vuilnisbakken"] ={
        [1] = {
            name = "forumdrive",
            coords = {x = -168.07, y = -1662.8, z = 33.31, h = 137.5},
        },
        [2] = {
            name = "grovestreet",
            coords = {x = 118.06, y = -1943.96, z = 20.43, h = 179.5},
        },
        [3] = {
            name = "jamestownstreet",
            coords = {x = 336.47, y = -1968.31, z = 24.39, h = 240.63},
        },
        [4] = {
            name = "roylowensteinblvd",
            coords = {x = 509.99, y = -1620.98, z = 29.09, h = 0.5},
        },
        [5] = {
            name = "littlebighornavenue",
            coords = {x = 488.49, y = -1284.1, z = 29.24, h = 138.5},
        },
        [6] = {
            name = "vespucciblvd",
            coords = {x = 307.47, y = -1033.6, z = 29.03, h = 46.5},
        },
        [7] = {
            name = "elginavenue",
            coords = {x = 239.19, y = -681.5, z = 37.15, h = 178.5},
        },
        [8] = {
            name = "elginavenue2",
            coords = {x = 543.51, y = -204.41, z = 54.16, h = 199.5},
        },
        [9] = {
            name = "powerstreet",
            coords = {x = 268.72, y = -25.92, z = 73.36, h = 90.5},
        },
        [10] = {
            name = "altastreet",
            coords = {x = 267.03, y = 276.01, z = 105.54, h = 332.5},
        },
        [11] = {
            name = "didiondrive",
            coords = {x = 21.65, y = 375.44, z = 112.67, h = 323.5},
        },
        [12] = {
            name = "miltonroad",
            coords = {x = -546.9, y = 286.57, z = 82.85, h = 127.5},
        },
        [13] = {
            name = "eastbourneway",
            coords = {x = -683.23, y = -169.62, z = 37.74, h = 267.5},
        },
        [14] = {
            name = "eastbourneway2",
            coords = {x = -771.02, y = -218.06, z = 37.05, h = 277.5},
        },
        [15] = {
            name = "industrypassage",
            coords = {x = -1057.06, y = -515.45, z = 35.83, h = 61.5},
        },
        [16] = {
            name = "boulevarddelperro",
            coords = {x = -1558.64, y = -478.22, z = 35.18, h = 179.5, r = 1.0},
        },
        [17] = {
            name = "sandcastleway",
            coords = {x = -1350.0, y = -895.64, z = 13.36, h = 17.5},
        },
        [18] = {
            name = "magellanavenue",
            coords = {x = -1243.73, y = -1359.72, z = 3.93, h = 287.5},
        },
        [19] = {
            name = "palominoavenue",
            coords = {x = -845.87, y = -1113.07, z = 6.91, h = 253.5},
        },
        [20] = {
            name = "southrockforddrive",
            coords = {x = -635.21, y = -1226.45, z = 11.8, h = 143.5},
        },
        [21] = {
            name = "southarsenalstreet",
            coords = {x = -587.74, y = -1739.13, z = 22.47, h = 339.5},
        },
    },
}