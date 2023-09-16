Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 0, g = 0, b = 255 }
Config.MarkerColor2               = { r = 0, g = 255, b = 0 }
Config.MarkerColor3               = { r = 255, g = 0, b = 0 }
Config.MarkerSize                 = { x = 1.2, y = 1.2, z = 1.0 }
Config.MarkerSize2                = { x = 1.5, y = 1.5, z = 1.5 }
Config.MarkerSize3                = { x = 1.5, y = 1.5, z = 1.5 }
Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale                     = 'br'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 5 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.objects = {
	object = nil, ObjectVertX = nil, ObjectVertY = nil, ObjectVertZ = nil, OjbectDir = nil, isBed = nil,
	SitAnimation = 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER',
	LayBackAnimation = 'WORLD_HUMAN_SUNBATHE_BACK',
	LayStomachAnimation = 'WORLD_HUMAN_SUNBATHE',
	locations = {
		[1] = {object="v_med_bed2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		[2] = {object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		[3] = {object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[4] = {object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[5] = {object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[6] = {object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[7] = {object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[8] = {object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		[9] = {object="v_med_emptybed", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		[10] = {object="Prop_Off_Chair_01", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		[11] = {object="gabz_pillbox_MRI_bed", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=0.0, bed=true},
		[12] = {object="gabz_pillbox_diagnostics_bed_01", verticalOffsetX=0.0, verticalOffsetY=0.2, verticalOffsetZ=-1.8, direction=0.0, bed=true},
		[13] = {object="gabz_pillbox_diagnostics_bed_02", verticalOffsetX=0.0, verticalOffsetY=0.2, verticalOffsetZ=-1.8, direction=0.0, bed=true},	
		[14] = {object="gabz_pillbox_diagnostics_bed_03", verticalOffsetX=0.0, verticalOffsetY=0.2, verticalOffsetZ=-1.8, direction=0.0, bed=true},
		[15] = {object="v_med_bed1", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		[16] = {object="v_med_cor_medstool", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.7, direction=0.0, bed=false}
	}
}

Config.ambulanceStations = {

	ambulance = {

		Blip = {
			Pos     = { x = 298.9, y = -584.37, z = 43.26 },
			Sprite  = 61,
			Display = 4,
			Scale   = 0.7,
			Colour  = 2
		},

		Vestiario = {
			{ x = 301.3093, y = -599.271, z = 43.284 },  
		},

		Cofre = {
			{ x = 306.6353, y = -601.600, z = 43.284 }, 
		},
		
		Cofre_Pessoal = {
			{ x = 304.1463, y = -599.924, z = 43.284 }, 
		},

		Veiculos = {
			 
			{
				Spawner    = { x = 299.13, y = -572.59, z = 43.26 },
				SpawnPoints = {
					{ x = 293.4, y = -575.21, z = 43.2, heading = 51.32, radius = 6.0 },
					{ x = 290.94, y = -590.56, z = 43.2, heading = 341.93, radius = 6.0 }
				},
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
			{
				Spawner    = { x = 342.17, y = -581.28, z = 74.17 },
				SpawnPoints = {
					{x = 352.3, y = -588.28, z = 74.17, heading = 311.55, radius = 6.0 }
				}
			},
		},

		GuardarVeiculo = {
			{ x = 291.35, y = -588.15, z = 43.19 }, -- Vespucci
		},

		GuardarHeli = {
			{ x = 350.75, y = -587.97, z = 74.07 }, -- PSP Centro

		},
		
		GuardarBarco = {
			{ x = -810.36, y = -1507.93, z = 0.3 },
			{ x = -3427.45, y = 947.34, z = 0.4 },
			{ x = -1860.78, y = -1255.66, z = 0.7 },
			{ x = -1595.88, y = 5252.13, z = 0.1 },
			{ x = 3867.54, y = 4451.42, z = 0.1 },
			{ x = -0.43, y = -2811.35, z = 0.4 }
			--{ x = 5099.96, y = -5136.46, z = 0.42} -- Ilha CayoPerico
		},

		BossActions = {
			{ x = 334.8357, y = -594.046, z = 43.283 }, -- Vespucci
		},

	},

}

Config.VeiculosInem = {
	{
		model = 'ambulancec',
		label = 'Mercedes AMG '
	},
	{
		model = 'ambulancei',
		label = 'VW Passat'
	},
	{	model = 'anpc_l200',
		label = 'Mitsubishi'
	},
	{	model = 'emir_vwgolf6',
		label = 'VW Golf 6'
	},
	{	model = 'fordinem',
		label = 'Ford'
	},
	{	model = 'inem_vwcrafter',
		label = 'Ambulância VW'
	},
	{	model = 'pt_inem4',
		label = 'Ambulância Mercedes Sprinter'
	},
	{	model = 'srpcba_kiaceed',
		label = 'Kia'
	},
	{	model = 'ems_gs1200',
		label = 'Mota BMW '
	}
}


Config.HelicopteroInem = {

	{
		model = 'heli1inem',
		label = 'Helicóptero INEM'
	}

}

Config.BarcosInem = {

	{
		model = 'seashark3',
		label = 'Barco Bombeiros'
	}

}


Config.UniformsInem = {
	[1] = {
		minimum_grade = 0,
		label = "Farda Branca",
		variations = {
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 2,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 82,
				['pants_1'] = 77,   ['pants_2'] = 3,
				['shoes_1'] = 64,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 174,    ['chain_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0
			},
			female = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 14,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 102,
				['pants_1'] = 86,   ['pants_2'] = 0,
				['shoes_1'] = 51,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 141,    ['chain_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0
			}
		}
	},
	[2] = {
		minimum_grade = 0,
		label = "Farda Amarela",
		variations = {
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 2,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 82,
				['pants_1'] = 77,   ['pants_2'] = 3,
				['shoes_1'] = 64,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 174,    ['chain_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0
			},
			female = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 14,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 102,
				['pants_1'] = 86,   ['pants_2'] = 0,
				['shoes_1'] = 51,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 141,    ['chain_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0
			}
		}
	},
	[3] = {
		minimum_grade = 0,
		label = "Farda de Mota",
		variations = {
			male = {
				['tshirt_1'] = 92,  ['tshirt_2'] = 0,
				['torso_1'] = 293,   ['torso_2'] = 2,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 25,
				['pants_1'] = 206,   ['pants_2'] = 0,
				['shoes_1'] = 64,   ['shoes_2'] = 0,
				['helmet_1'] = 83,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0
			},
			female = {
				['tshirt_1'] = 75,  ['tshirt_2'] = 3,
				['torso_1'] = 73,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 109,
				['pants_1'] = 23,   ['pants_2'] = 0,
				['shoes_1'] = 3,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0
			}
		}
	},
	
	[4] = {
		minimum_grade = 0,
		label = "Farda de Resgate",
		variations = {
			male = {
				['tshirt_1'] = 15,   ['tshirt_2'] = 0,
				['torso_1'] = 293,   ['torso_2'] = 2,
				['decals_1'] = 0,    ['decals_2'] = 0,
				['arms'] = 25,
				['pants_1'] = 206,   ['pants_2'] = 0,
				['shoes_1'] = 64,    ['shoes_2'] = 0,
				['helmet_1'] = 105,  ['helmet_2'] = 2,
				['chain_1'] = 68,    ['chain_2'] = 2,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['glasses_1'] = 29,  ['glasses_2'] = 1,
				['bag_1'] = 20,  	 ['bag_2'] = 0,
				['mask_1'] = 65,  	 ['mask_2'] = 0,
				['bproof_1'] = 0,  	 ['bproof_2'] = 0
			},
			female = {
				['tshirt_1'] = 75,  ['tshirt_2'] = 3,
				['torso_1'] = 73,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 109,
				['pants_1'] = 23,   ['pants_2'] = 0,
				['shoes_1'] = 3,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['ears_1'] = -1,     ['ears_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0
			}
		}
	},
}

Config.OnlyAllowHelpWhenThereIsNoMedicsAvailable = false
Config.HelpTime = 20000

Config.Medics = {
    {
        Location = vector3(312.22305297852, -592.88073730469, 43.284034729004),
        Heading = 340.0,

        Hash = 0xB353629E,

        Price = 10000, -- This is the price the character will be deducted from the bank balance.

        Sequence = { -- This is the order the medic will walk.
            { Location = vector3(313.84375, -589.72747802734, 43.284324645996), Heading = 252.7112121582 },
            { Location = vector3(324.3180847168, -592.94116210938, 43.284034729004), Heading = 334.94021606445 },
            { Location = vector3(328.86163330078, -580.14562988281, 43.284034729004), Heading = 69.457992553711 },
            { Location = vector3(318.07431030273, -576.63079833984, 43.284034729004), Heading = 157.86259460449 },
            { Location = vector3(315.49456787109, -581.93743896484, 43.284038543701), Heading = 159.31224060059 }
        },

        Beds = {
            {
                Location = vector3(319.31500244141, -580.98791503906, 44.203979492188),
                Heading = 158.91000366211,

                Hash = 1631638868
            },
            {
                Location = vector3(324.21200561523, -582.76086425781, 44.20397567749),
                Heading = 158.52694702148,

                Hash = 1631638868
            },
            {
                Location = vector3(322.65103149414, -587.31011962891, 44.203971862793),
                Heading = 339.25442504883,

                Hash = 1631638868
            },
            {
                Location = vector3(317.64022827148, -585.60888671875, 44.20397567749),
                Heading = 335.54779052734,

                Hash = 1631638868
            },
            {
                Location = vector3(314.53564453125, -584.39331054688, 44.20397567749),
                Heading = 340.25094604492,

                Hash = 1631638868
            },
            {
                Location = vector3(313.98001098633, -578.90460205078, 44.203971862793),
                Heading = 155.94953918457,

                Hash = 1631638868
            },
            {
                Location = vector3(311.05587768555, -583.04479980469, 44.20397567749),
                Heading = 344.00546264648,

                Hash = 1631638868
            },
            {
                Location = vector3(307.826171875, -581.53228759766, 44.20397567749),
                Heading = 334.53707885742,

                Hash = 1631638868
            },
            {
                Location = vector3(309.28030395508, -577.43334960938, 44.203926086426),
                Heading = 159.16683959961,

                Hash = 1631638868
            }
        },
	},	 
    { --Easy to add more medics.
		Location = vector3(307.08, -595.13, 43.284034729004),
		Heading = 80.52,

        Hash = 0xB353629E,

        Price = 10000, -- This is the price the character will be deducted from the bank balance.

        Sequence = { -- This is the order the medic will walk.
            { Location = vector3(313.84375, -589.72747802734, 43.284324645996), Heading = 252.7112121582 },
            { Location = vector3(324.3180847168, -592.94116210938, 43.284034729004), Heading = 334.94021606445 },
            { Location = vector3(328.86163330078, -580.14562988281, 43.284034729004), Heading = 69.457992553711 },
            { Location = vector3(318.07431030273, -576.63079833984, 43.284034729004), Heading = 157.86259460449 },
            { Location = vector3(315.49456787109, -581.93743896484, 43.284038543701), Heading = 159.31224060059 }
        },

        Beds = {
            {
                Location = vector3(319.31500244141, -580.98791503906, 44.203979492188),
                Heading = 158.91000366211,

                Hash = 1631638868
            },
            {
                Location = vector3(324.21200561523, -582.76086425781, 44.20397567749),
                Heading = 158.52694702148,

                Hash = 1631638868
            },
            {
                Location = vector3(322.65103149414, -587.31011962891, 44.203971862793),
                Heading = 339.25442504883,

                Hash = 1631638868
            },
            {
                Location = vector3(317.64022827148, -585.60888671875, 44.20397567749),
                Heading = 335.54779052734,

                Hash = 1631638868
            },
            {
                Location = vector3(314.53564453125, -584.39331054688, 44.20397567749),
                Heading = 340.25094604492,

                Hash = 1631638868
            },
            {
                Location = vector3(313.98001098633, -578.90460205078, 44.203971862793),
                Heading = 155.94953918457,

                Hash = 1631638868
            },
            {
                Location = vector3(311.05587768555, -583.04479980469, 44.20397567749),
                Heading = 344.00546264648,

                Hash = 1631638868
            },
            {
                Location = vector3(307.826171875, -581.53228759766, 44.20397567749),
                Heading = 334.53707885742,

                Hash = 1631638868
            },
            {
                Location = vector3(309.28030395508, -577.43334960938, 44.203926086426),
                Heading = 159.16683959961,

                Hash = 1631638868
            }
        },
    
    },
	 
	
 
	
}