Config.TaxistaUniforms = {
	wear_work = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 405,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 74,   ['pants_2'] = 0,
			['shoes_1'] = 59,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 10,    ['chain_2'] = 2,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 128,  ['tshirt_2'] = 0,
			['torso_1'] = 135,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	}
}

Config.TaxiInfo = {
	
	Veiculos = {
		{
			model = 'trans_teslams',
			label = 'Mercedes - Carro'
		},
		{
			model = 'trans_mbv250',
			label = 'Mercedes - Carrinha'
		}
	},
	
	Zones = {
		VehicleSpawner = {
			Pos   = {x = 903.94, y = -173.39, z = 74.1},
			Size  = {x = 1.5, y = 1.5, z = 1.5},
			Color = {r = 0, g = 255, b = 0},
			Type  = 36, Rotate = false
		},

		VehicleSpawnPoint = {
			Pos     = {x = 911.108, y = -177.867, z = 74.283},
			Size    = {x = 1.5, y = 1.5, z = 1.0},
			Type    = -1, Rotate = false,
			Heading = 225.0
		},

		VehicleDeleter = {
			Pos   = {x = 908.317, y = -183.070, z = 74.201},
			Size  = {x = 3.0, y = 3.0, z = 0.25},
			Color = {r = 255, g = 0, b = 0},
			Type  = 1, Rotate = true
		},

		Cloakroom = {
			Pos     = {x = 895.7, y = -179.34, z = 74.7},
			Size    = {x = 1.2, y = 1.2, z = 1.0},
			Color   = {r = 0, g = 0, b = 255},
			Type    = 27, Rotate = true
		}
	}
}