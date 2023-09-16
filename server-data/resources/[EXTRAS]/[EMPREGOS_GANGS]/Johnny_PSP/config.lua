Config                            = {}

Config.DrawDistance               = 40.0
Config.DrawDistance2              = 3
Config.DrawDistance3              = 2
Config.MarkerType                 = 1
Config.MarkerType2                = 36
Config.MarkerType3                = 34
Config.MarkerSize                 = { x = 1.3, y = 1.3, z = 1.0 }
Config.MarkerSize2                = { x = 1.5, y = 1.5, z = 1.5 }
Config.MarkerSize3                = { x = 9.5, y = 9.5, z = 1.2 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.MarkerColor2               = { r = 0, g = 255, b = 0 }
Config.MarkerColor3               = { r = 255, g = 0, b = 0 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'br'

Config.ArmasPermitidas ={
	Nivel1 = {
		{ name = 'WEAPON_FLASHLIGHT'},
		{ name = 'WEAPON_NIGHTSTICK'},
		{ name = 'WEAPON_COMBATPISTOL' },
		{ name = 'WEAPON_FLAREGUN'},
		{ name = 'WEAPON_STUNGUN'},
		{ name = 'WEAPON_SMG'},
		{ name = 'WEAPON_PUMPSHOTGUN'},
		{ name = 'WEAPON_CARBINERIFLE'},
		--{ name = 'WEAPON_BZGAS'},
		{ name = 'WEAPON_FLARE'},
		{ name = 'WEAPON_FIREEXTINGUISHER'},
		{ name = 'WEAPON_SNIPERRIFLE'},
                   
	},
	Nivel2 = {
		{ name = 'WEAPON_FLASHLIGHT'},
		{ name = 'WEAPON_NIGHTSTICK'},
		{ name = 'WEAPON_COMBATPISTOL' },
		{ name = 'WEAPON_FLAREGUN'},
		{ name = 'WEAPON_STUNGUN'},
		{ name = 'WEAPON_SMG'},
		{ name = 'WEAPON_PUMPSHOTGUN'},
		{ name = 'WEAPON_CARBINERIFLE'},
		--{ name = 'WEAPON_BZGAS'},
		{ name = 'WEAPON_FLARE'},
		{ name = 'WEAPON_FIREEXTINGUISHER'},
		{ name = 'WEAPON_SNIPERRIFLE'},

	},
	Nivel3 = {
		{ name = 'WEAPON_FLASHLIGHT'},
		{ name = 'WEAPON_NIGHTSTICK'},
		{ name = 'WEAPON_COMBATPISTOL' },
		{ name = 'WEAPON_FLAREGUN'},
		{ name = 'WEAPON_STUNGUN'},
		{ name = 'WEAPON_SMG'},
		{ name = 'WEAPON_PUMPSHOTGUN'},
		{ name = 'WEAPON_CARBINERIFLE'},
		--{ name = 'WEAPON_BZGAS'},
		{ name = 'WEAPON_FLARE'},
		{ name = 'WEAPON_FIREEXTINGUISHER'},
		{ name = 'WEAPON_SNIPERRIFLE'},
	},
}

Config.PoliceStations = {

	LSPD = {
		--[[
		Blip = { --Vespucci
			Pos     = { x = -1095.85, y = -846.38, z = 37.7 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 29,
		},
		
		Blip2 = { -- Principal
			Pos     = { x = 433.61, y = -981.82, z = 30.71 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29,
		},

		Blip3 = { -- Principal
			Pos     = { x = 433.61, y = -981.82, z = 30.71 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29,
		},
		--]]

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_FLASHLIGHT',       price = 0 },
			{ name = 'WEAPON_NIGHTSTICK',       price = 0 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 0 },
			{ name = 'WEAPON_FLAREGUN',         price = 0 },
			{ name = 'WEAPON_STUNGUN',      	price = 0 },
			{ name = 'WEAPON_SMG',         		price = 0 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 0 },
			{ name = 'WEAPON_CARBINERIFLE',     price = 0 },
			{ name = 'WEAPON_SNIPERRIFLE',      price = 0 },
			{ name = 'WEAPON_BZGAS',      		price = 0 },
			{ name = 'WEAPON_FLARE',      		price = 0 },
			{ name = 'WEAPON_FIREEXTINGUISHER', price = 0 },
		},

		Cloakrooms = {
			{ x = 462.06, y = -999.11, z = 30.69 },  	-- PSP CENTRO
			{ x = 1841.794, y = 3679.824, z = 34.189 }, 	-- GNR Centro
			--{ x = -1098.03, y = -831.68, z = 14.28 },   -- VESPUCCI
			{ x = -437.98, y = 6010.58, z = 31.72 }, 	-- GNR Norte
			--{ x = 384.78, y = 794.31, z = 188.68 }, 	-- Posto Florestal
			{ x = 5144.0, y = -4954.71, z = 15.01 },     -- Ilha - CayoPerico   
		},

		Armories = {
			--{ x = 484.63, y = -1006.09, z = 21.73 },  -- Mission Row
			--{ x = 1842.64, y = 3691.45, z = 33.3 }, 	-- PSP Centro
			--{ x = -1104.93, y = -821.45, z = 13.28 }, -- VESPUCCI
			--{ x = -438.14, y = 5988.67, z = 30.72 },  -- GNR Norte
			--{ x = 387.53, y = 799.45, z = 186.68 }, 	-- Posto Florestal
		},
		
		Armario_Evidencias = {
			{ x = 474.83, y = -996.59, z = 26.27 }, 	-- PSP LOS SANTOS
			--{ x = 1842.64, y = 3691.45, z = 34.3 }, 	-- PSP CENTRO
			--{ x = -1089.35,  y = -811.75, z = 11.04 },  -- PSP VESPUCCI
			{ x = -433.32, y = 5994.6,  z = 31.72 }, 	-- PSP NORTE
		},
		
		Armario_Pessoal = {
			--{ x = -1098.7, y = -826.08,  z = 14.28 }, 	 -- PSP VESPUCCI
			--{ x = 1845.81, y = 3692.53,  z = 34.26 }, 	 -- PSP CENTRO
			{ x = 479.16,  y = -996.69, z = 30.69 }, 	 -- PSP LOS SANTOS
			{ x = -440.21, y = 5996.72,  z = 31.72 }, 	 -- PSP NORTE
		},
		
		Armario_ItensIlegais = {
		--	{ x = 472.23, y = -1005.22, z = 34.22 },	 -- PSP LOS SANTOS
			--{ x = 1842.64, y = 3691.45, z = 34.3 }, 	 -- PSP Centro
			--{ x = -1087.92,  y = -821.77, z = 11.04 },	 -- PSP VESPUCCI
		--	{ x = -442.29, y = 5987.27, z = 31.72 }, 	 -- PSP NORTE
		},
		
		Armario_ItensAssalto = {
		--	{ x = 475.21, y = -1006.41, z = 34.22 },	 -- PSP LOS SANTOS
			--{ x = 1842.64, y = 3691.45,  z = 34.3 },	 -- PSP CENTRO
			--{ x = -1078.08,  y = -815.63, z = 11.04 }, 	 -- PSP VESPUCCI
		--	{ x = -442.45, y = 5988.86,  z = 31.72 }, 	 -- PSP NORTE
		},
		
		Armario_Lixo = {
			{ x = 474.75, y = -993.71, z = 26.27 },	 -- PSP LOS SANTOS
			--{ x = 1842.64, y = 3691.45,  z = 34.3 },	 -- PSP CENTRO
			--{ x = -1092.67,  y = -816.54, z = 11.04 },	 -- PSP VESPUCCI
			{ x = -440.06, y = 5991.85,  z = 31.72 },	 -- PSP NORTE
		},
		
		Armario_Outros = {
		--	{ x = 473.44, y = -1006.67, z = 34.22 }, 	-- PSP LOS SANTOS
			--{ x = 1842.64, y = 3691.45, z = 34.3 },  	-- PSP CENTRO
			--{ x = -1084.75, y = -808.66, z = 11.04 }, 	-- PSP VESPUCCI
		--	{ x = -439.73, y = 5987.8,  z = 31.72 }, 	-- PSP NORTE
		},
		
		-- Armario_Privado = {
			-- { x = 1842.64, y = 3691.45, z = 33.3 }, -- PSP Centro
			-- { x = -1089.29, y = -811.65, z = 10.04 }, -- Vespucci
			-- { x = -438.14, y = 5988.67, z = 30.72 }, -- PSP Norte
		-- }

		Vehicles = {
			 
			--{
			--	Spawner    = { x = -1062.3, y = -846.83, z = 5.04 }, -- Vespucci
			--	SpawnPoints = {
			--		{ x = -1066.85, y = -861.81, z = 4.87, heading = 200.92, radius = 6.0 },
			--		{ x = -1049.44, y = -853.95, z = 4.87, heading = 118.07, radius = 6.0 }
			--	},
			--	SpawnPoints2 = {
			--		{ x = -1049.44, y = -853.95, z = 4.87, heading = 118.07, radius = 6.0 }
			--	}
			--},
			
			--{
			--	Spawner    = { x = -1116.88, y = -846.52, z = 13.39 }, -- Vespucci
			--	SpawnPoints = {
			--		{ x = -1123.77, y = -851.25, z = 13.48, heading = 111.69, radius = 6.0 },
			--		{ x = -1130.8, y = -840.66, z = 13.71, heading = 126.74, radius = 6.0 }
			--	},
			--	SpawnPoints2 = {
			--		{ x = -1143.42, y = -851.98, z = 13.92, heading = 39.89, radius = 6.0 }
			--	}
			--},
			
			{
				Spawner    = { x = 446.98, y = -1013.04, z = 28.54 }, -- Cidade
				SpawnPoints = {
					{ x = 446.97, y = -1021.19, z = 28.47, heading = 90.0, radius = 6.0 },
					{ x = 441.08, y = -1024.23, z = 28.30, heading = 90.0, radius = 6.0 },
					{ x = 453.53, y = -1022.20, z = 28.02, heading = 90.0, radius = 6.0 },
					{ x = 450.97, y = -1016.55, z = 28.10, heading = 90.0, radius = 6.0 }
				},
				SpawnPoints2 = {
					{ x = 438.42, y = -1018.30, z = 27.75, heading = 90.0, radius = 6.0 },
				}
			},

			{
				Spawner    = { x = 460.61, y = -984.36, z = 25.7 }, -- Cidade
				SpawnPoints = {
					{ x = 431.97, y = -992.89, z = 25.7, heading = 174.06, radius = 6.0 }
				},
				SpawnPoints2 = {
					{ x = 431.06, y = -983.02, z = 25.73, heading = 174.92, radius = 6.0 }
				}
			},
			
			--{
			--	Spawner    = { x = 1866.57, y = 3700.99, z = 33.51 }, -- PSP Centro
			--	SpawnPoints = {
			--		{ x = 1869.61, y = 3694.92, z = 33.58, heading = 214.22, radius = 6.0 }
			--	},
			--	SpawnPoints2 = {
			--		{ x = 1874.59, y = 3674.44, z = 33.68, heading = 117.07, radius = 6.0 }
			--	}
			--},
			
			{
				Spawner    = { x = 5151.28, y = -4938.52, z = 14.20 }, -- Ilha CayoPerico
				SpawnPoints = {
					{ x = 5156.57, y = -4963.41, z = 13.81, heading = 229.9, radius = 6.0 }
				},
				SpawnPoints2 = {
					{ x = 5160.77, y = -4957.61, z = 13.81, heading = 224.7, radius = 6.0 }
				}
			},
			
			{
				Spawner    = { x = -461.08, y = 6014.47, z = 31.49 }, -- PSP Norte
				SpawnPoints = {
					{ x = -463.61, y = 6019.4, z = 31.35, heading = 310.6, radius = 6.0 },
					{ x = -473.96, y = 6023.51, z = 31.35, heading = 286.04, radius = 6.0 },
				},
				SpawnPoints2 = {
					{ x = -463.61, y = 6019.4, z = 31.35, heading = 310.6, radius = 6.0 }
				}
			},
		},
		
		Boats = {
			{
				Spawner    = { x = -775.02, y = -1500.53, z = 2.23 },
				SpawnPoints = {
					{ x = -792.13, y = -1500.95, z = 1.1, heading = 110.5, radius = 6.0 },
				},
				Teleport    = { x = -800.92, y = -1513.39, z = 1.6, heading = 295.56, radius = 6.0 }
			},
			
			{
				Spawner    = { x = -3421.1, y = 954.17, z = 8.35 },
				SpawnPoints = {
					{ x = -3426.51, y = 936.88, z = 1.1, heading = 86.33, radius = 6.0 },
				},
				Teleport    = { x = -3424.78, y = 954.48, z = 8.35, heading = 230.8, radius = 6.0 }
			},
			
			{
				Spawner    = { x = -1850.72, y = -1244.19, z = 8.62 },
				SpawnPoints = {
					{ x = -1870.08, y = -1256.12, z = 1.1, heading = 135.41, radius = 6.0 },
				},
				Teleport    = { x = -1849.95, y = -1248.18, z = 8.65, heading = 323.11, radius = 6.0 }
			},
			
			{
				Spawner    = { x = -1611.42, y = 5255.63, z = 3.97 },
				SpawnPoints = {
					{ x = -1589.01, y = 5259.24, z = 1.1, heading = 25.9, radius = 6.0 },
				},
				Teleport    = { x = -1605.43, y = 5258.58, z = 2.09, heading = 32.51, radius = 6.0 }
			},
			
			{
				Spawner    = { x = 3857.38, y = 4459.59, z = 1.84 },
				SpawnPoints = {
					{ x = 3874.88, y = 4461.65, z = 1.1, heading = 289.9, radius = 6.0 },
				},
				Teleport    = { x = 3853.13, y = 4459.01, z = 1.85, heading = 3.11, radius = 6.0 }
			},
			
			{
				Spawner    = { x = 5108.26, y = -5120.97, z = 2.03 }, -- Ilha CayoPerico
				SpawnPoints = {
					{ x = 5096.51, y = -5097.92, z = 2.0, heading = 0.0, radius = 6.0 },
				},
				Teleport    = { x = 5096.51, y = -5097.92, z = 2.0, heading = 0.0, radius = 6.0 }
			},			
			
			{
				Spawner    = { x = 23.95, y = -2799.14, z = 5.7 },
				SpawnPoints = {
					{ x = 12.1, y = -2818.03, z = 1.1, heading = 174.52, radius = 6.0 },
				},
				Teleport    = { x = 13.91, y = -2795.95, z = 2.53, heading = 1.61, radius = 6.0 }
			}
		},

		Helicopters = {
			--{
			--	Spawner    = { x = -1108.26, y = -834.89, z = 37.7 }, -- Vespucci
			--	SpawnPoints = {
			--		{x = -1096.37, y = -832.45, z = 37.7, heading = 311.55, radius = 6.0 }
			--	}
			--},
			
			{
				Spawner    = { x = 460.46, y = -991.17, z = 43.69 }, -- Mission Row
				SpawnPoints = {
					{x = 450.24, y = -981.14, z = 42.691, heading = 90.0, radius = 6.0 }
				}
			},
			
			{
				Spawner    = { x = 1866.04, y = 3660.41, z = 33.85 },  -- GNR Centro
				SpawnPoints = {
					{x = 1868.62, y = 3648.09, z = 35.86, heading = 328.4, radius = 6.0 }
				}
			},
			
			{
				Spawner    = { x = -461.04, y = 5991.78, z = 31.27 },  -- GNR Norte
				SpawnPoints = {
					{x = -475.18, y = 5988.83, z = 31.34, heading = 145.31, radius = 6.0 }
				}
			}
		},

		VehicleDeleters = {
		--	{ x = -1048.86, y = -853.31, z = 4.87 }, -- Vespucci
		--	{ x = -1115.87, y = -832.55, z = 13.34}	, -- Vespucci
		--	{ x = -1113.4, y = -837.15, z = 13.34 }, -- Vespucci
			{ x = 1865.76, y = 3681.79, z = 33.7 }, -- PSP Centro
			{ x = 462.74, y = -1014.4, z = 28.53 }, -- Mission Row
			{ x = 462.40, y = -1019.7, z = 28.53 }, -- Mission Row
			{ x = 469.12, y = -1024.52, z = 28.63 }, -- Mission Row	
			{ x = 459.34, y = -977.89, z = 25.7 }, -- Mission Row			
			{ x = -471.56, y = 6031.9, z = 31.34 }, -- PSP Norte			
			{ x = 5164.16, y = -4947.27, z = 13.50} -- Ilha CayoPerico	
		},

		VehicleDeleters2 = {
			{ x = 1868.62, y = 3648.09, z = 35.86 }, -- PSP Centro
			{ x = 449.27, y = -981.22, z = 43.69 }, -- Mission Row
		--	{ x = -1096.45, y = -832.48, z = 37.7 },  -- Vespucci
			{ x = -475.34, y = 5988.5, z = 31.34 }  -- PSP Norte

		},
		
		VehicleDeleters3 = {
			{ x = -810.36, y = -1507.93, z = 0.3 },
			{ x = -3427.45, y = 947.34, z = 0.4 },
			{ x = -1860.78, y = -1255.66, z = 0.7 },
			{ x = -1595.88, y = 5252.13, z = 0.1 },
			{ x = 3867.54, y = 4451.42, z = 0.1 },
			{ x = -0.43, y = -2811.35, z = 0.4 }
			--{ x = 5099.96, y = -5136.46, z = 0.42} -- Ilha CayoPerico
		},

		BossActions = {
			--{ x = -1114.55, y = -833.09, z = 30.76 }, -- Vespucci
			{ x = 1834.561, y = 3677.658, z = 38.869 }, -- PSP Centro
			{ x = 461.76,   y = -985.8, z = 30.69 }, -- Mission Row
			--{ x = -435.87,   y = 6000.33,  z = 31.72 }, -- GNR Norte
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
				
		
	},

	recruit = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		
	},

	aspirante = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
	},

	officer = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},

	},

	sergeant = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
      
	},

	lieutenant = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
	},

	chefe = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},

	chefeprincipal = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},

    chefecoordenador = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},
	
    subcomissario = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	
	},

    comissario = {  
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},

    subintendente = {   
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},

    intendente = {  
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},

    superintendente = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},
	
	superintendentechefe = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'nonelsm5',
			label = 'PSP | BMW M5'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},
	
	goe = {
	},

    diretornacionaladjunto = {
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'nonelsm5',
			label = 'PSP | BMW M5'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'AmgGtrPsp',
			label = 'PSP | Mercedes AMG'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	},

    boss = {   
		{
			model = 'psp_ftipo2',
			label = 'PSP | FIAT Tipo'
		},
		{
			model = 'policesu',
			label = 'PSP | Subaru'
		},
		{
			model = 'dgrsp_vwcrafter',
			label = 'PSP | VW CRAFTER'
		},
		{
			model = 'pd_dirtbike',
			label = 'PSP | Mota de Cross'
		},
		{
			model = 'sheriff',
			label = 'PSP | Mercedes'
		},
		{
			model = 'benson',
			label = 'PSP | Centro de Operações Móvel'
		},
		{
			model = 'wrangler_psp',
			label = 'PSP | Jeep'
		},
		{
			model = 'MercedesA45Psp',
			label = 'PSP | Mercedes A45'
		},
		{
			model = 'mustang19',
			label = 'PSP | Ford Mustang GT'
		},
		{
			model = 'psp_bmwgs',
			label = 'PSP | Mota BMW GS'
		},
		{
			model = 'pspt_530d',
			label = 'PSP | BMW 530D'
		},
		{
			model = 'police2',
			label = 'PSP | Ford Carrinha'
		},
		{
			model = 'psp_mbsprinter',
			label = 'PSP | Mercedes Sprinter UEP'
		},
		{
			model = 'gnr_ssti',
			label = 'PSP Descaracterizado | Subaru'
		},
		{
			model = 'nonelsm5',
			label = 'PSP | BMW M5'
		},
		{
			model = 'policer8',
			label = 'PSP | Audi R8'
		},
		{
			model = 'NissanGtrPsp',
			label = 'PSP | Nissan GTR'
		},
		{
			model = 'FordRaptorPsp',
			label = 'PSP | Ford Raptor PSP'
		},
		{
			model = 'ghispo2',
			label = 'PSP | Maserati'
		},
		{
			model = '18awd',
			label = 'PSP | Dodge Charger AWD'
		},
		{
			model = 'AmgGtrPsp',
			label = 'PSP | Mercedes AMG'
		},
		{
			model = 'ExplorerGOE',
			label = 'PSP | Ford Explorer'
		},	
		{
			model = 'MercedesGOE',
			label = 'PSP Descaracterizado | Mercedes GOE '
		},
		{
			model = 'BlindadoGOE',
			label = 'PSP | Blindade GOE'
		},
		{
			model = 'riot',
			label = 'PSP | Blindado UEP'
		},
	}

}

Config.AuthorizedVehicles2 = {

	{
		model = 'heli1psp',
		label = 'Helicóptero PSP'
	}

}

Config.AuthorizedVehicles3 = {

	{
		model = 'seashark',
		label = 'Mota de Água PSP'
	},
	{
		model = 'largeboat',
		label = 'Barco PSP'
	}

}

Config.AuthorizedVehicles4 = {

	{
		model = 'seashark3',
		label = 'Barco Bombeiros'
	}

}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {

-- 						#FARDA RECRUTA# ( recruit )#

	fardarecruta_wear = { 
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 463,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
-- 					#FARDA AGENTE EM FORMAÇÃO# ( aspirante )#	
	
	fardaagentef_wear = { 
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS AGENTES# ( officer ) #	
	
	fardaagente_wear = { 
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
	fardaagentecolete_wear = { -- FARDA AGENTE COM COLETE DE TRANSITO
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 47,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 48,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS AGENTES# ( sergeant ) #	
	
	fardaagente2_wear = { -- FARDA AGENTE2
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
	fardaagente2colete_wear = { -- FARDA AGENTE2 COM COLETE DE TRANSITO
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 47,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 48,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS AGENTES# ( lieutenant ) #	

	fardaagente3_wear = { -- FARDA AGENTE3
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
	fardaagente3colete_wear = { -- FARDA AGENTE3 COM COLETE DE TRANSITO
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 47,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 48,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
	fardaagente3colete2_wear = { -- FARDA AGENTE3 COM COLETE BALISTICO
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 28,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS CHEFE# ( chefe ) #
	
	fardachefe_wear = { -- FARDA CHEFE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 26,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
	fardachefecolete_wear = { -- FARDA CHEFE COM COLETE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 26,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 92,  ['bproof_2'] = 0
		}
	},	
	
-- 						#FARDAS CHEFE PRINCIPAL# ( chefeprincipal ) #
	
	fardachefeprincipal_wear = { -- FARDA CHEFE PRINCIPAL
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 26,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
	fardachefeprincipalcolete_wear = { -- FARDA CHEFE PRINCIPAL COM COLETE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 26,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 92,  ['bproof_2'] = 0
		}
	},	
	
-- 						#FARDAS CHEFE COORDENADOR# ( chefecoordenador ) #
	
	fardachefecoordenador_wear = { -- FARDA CHEFE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 26,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	
	fardachefecoordenadorcolete_wear = { -- FARDA CHEFE COORDENADOR COM COLETE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 576,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 26,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 92,  ['bproof_2'] = 0
		}
	},		
	
-- 						#FARDAS SUB COMISSÁRIO ( subcomissario ) #	

	fardasubcomissario_wear = { -- FARDA SUB COMISSÁRIO 
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		}
	},
	fardasubcomissariocolete_wear = { -- FARDA SUB COMISSÁRIO COM COLETE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 83,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 3434,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 18,     ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS COMISSÁRIO ( comissario ) #	
	
		fardacomissario_wear = { --psp comissario sem colete
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 8,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 7,     ['bproof_2'] = 0
		}
	},
	fardacomissariocolete_wear = { --psp comissario com colete
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 8,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 83,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS SUBINTENDENTE ( Subintendente ) #	
	
		fardasubintendente_wear = {-- FARDA SUB INTENDENTE 
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 9,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {--psp Subintendente com colete
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 18,     ['bproof_2'] = 0
		}
	},
	
		fardasubintendentecolete_wear = {-- FARDA SUB INTENDENTE COM COLETE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 9,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 83,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 7,     ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS INTENDENTE ( intendente ) #
	
	fardaintendente_wear = {-- FARDA INTENDENTE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 10,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {--psp Subintendente com colete
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 18,     ['bproof_2'] = 0
		}
	},

	fardaintendentecolete_wear = { -- FARDA INTENDENTE COM COLETE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 10,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 83,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS SUPERINTENDENTE ( superintendente ) #	
	
	fardasuperintendente_wear = { -- FARDA SUPERINTENDENTE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 14,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 18,     ['bproof_2'] = 0
		}
	},
	
	fardasuperintendentecolete_wear = { -- FARDAS SUPERINTENDENTE COM COLETE
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 14,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 83,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 7,     ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS SUPERINTENDENTECHEFE ( superintendentechefe ) #	
	
	fardasuperintendentechefe_wear = {-- FARDAS SUPERINTENDENTECHEFE 
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 13,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 10,     ['bproof_2'] = 0
		}
	},
	
	fardasuperintendentechefecolete_wear = {-- FARDAS SUPERINTENDENTECHEFE COM COLETE
		male = {
			['tshirt_1'] = 92,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 13,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 86,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 98,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 28,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 25,     ['bproof_2'] = 0
		}
	},
	
-- 						#FARDAS DIRETOR NACIONAL ADJUNTO ( diretornacionaladjunto ) #	

		fardadnajunto_wear = { -- FARDA DIRETOR NACIONAL ADJUNTO
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 12,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		}
	},
	fardadnajuntocolete_wear = { -- FARDAS DIRETOR NACIONAL ADJUNTO COM COLETE
		male = {
			['tshirt_1'] = 92,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 12,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 86,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		}
	},




-- 						#FARDAS DIRETOR NACIONAL ( boss ) #	
	
		fardadn_wear = { -- FARDA DIRETOR NACIONAL
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 11,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		}
	},
	
		fardadncolete_wear = { -- FARDA DIRETOR NACIONAL COM COLETE
		male = {
			['tshirt_1'] = 92,  ['tshirt_2'] = 0,
			['torso_1'] = 564,   ['torso_2'] = 11,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 206,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 86,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		}
	},
	
		fardadncerimonica_wear = { -- FARDA DIRETOR NACIONAL CERIMONIA
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 561,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 74,   ['pants_2'] = 0,
			['shoes_1'] = 60,   ['shoes_2'] = 0,
			['helmet_1'] = 1,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 8,     ['bproof_2'] = 0
		}
	},
	
	fardaepri_wear = {-- Farda EPRI
		male = {
			['tshirt_1'] = 91,  ['tshirt_2'] = 0,
			['torso_1'] = 575,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 180,
			['pants_1'] = 77,   ['pants_2'] = 3,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = 64,  ['helmet_2'] = 0,
			['mask_1'] = 81,  ['mask_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 19,     ['ears_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 8,     ['bproof_2'] = 0
		}
	},
	
	
	fardagoe_wear = { -- FARDA GOE
		male = {
			['tshirt_1'] = 148,  ['tshirt_2'] = 1,
			['torso_1'] = 571,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 25,
			['pants_1'] = 92,   ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = 88,  ['helmet_2'] = 1,
			['mask_1'] = 81,  ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 90,     ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 8,     ['bproof_2'] = 0
		}
	},

	fardaaguia_wear = {-- FARDA AGUIA
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 557,  ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 25,
			['pants_1'] = 138,  ['pants_2'] = 0,
			['shoes_1'] = 64,   ['shoes_2'] = 0,
			['helmet_1'] = 94,  ['helmet_2'] = 0,
			['mask_1'] = 64,  	['mask_2'] = 0,
			['chain_1'] = 26,   ['chain_2'] = 0,
			['ears_1'] = 28,    ['ears_2'] = 2,
			['bproof_1'] = 0,   ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['mask_1'] = 0,  	['mask_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['bproof_1'] = 8,   ['bproof_2'] = 0
		}
	},

}