--░█████╗░██████╗░░█████╗░███████╗████████╗██╗███╗░░██╗░██████╗░
--██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██║████╗░██║██╔════╝░
--██║░░╚═╝██████╔╝███████║█████╗░░░░░██║░░░██║██╔██╗██║██║░░██╗░
--██║░░██╗██╔══██╗██╔══██║██╔══╝░░░░░██║░░░██║██║╚████║██║░░╚██╗
--╚█████╔╝██║░░██║██║░░██║██║░░░░░░░░██║░░░██║██║░╚███║╚██████╔╝
--░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░╚═════╝░

Config.Crafting = {
	[1] = {
        name = 'Craft Armas',
        isjob = 'mafia', --job name or false
        grades = 'all',
        text =  "[E] - Craft Armas",
		maxDistance = 8.0,
        blip = {
            enabled = false,
            title = "Police Crafting",
            scale = 1.0,
            display = 4,
            colour = 0,
            id = 365
        },
        location = vec3(-1106.69, 4947.699, 218.35),
		items = {
			[1] = {
				name = "weapon_combatpistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 1,
					["magazinepistola"] = 1,
					["estruturapistola"] = 1,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 1,
				threshold = 0,
				points = 1,
				time = 5000,
			},
			[2] = {
				name = "weapon_machinepistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 1,
					["magazinepistola"] = 2,
					["estruturapistola"] = 1,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 2,
				threshold = 0,
				points = 2,
				time = 6000,
			},
			[3] = {
				name = "weapon_pistol50",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 2,
					["estruturadeagle"] = 1,
					["magazinepistola"] = 1,
					["punho"] = 2,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 3,
				threshold = 0,
				points = 3,
				time = 7000,
			},
			[4] = {
				name = "weapon_vintagepistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 2,
					["estruturapistola"] = 1,
					["magazinepistola"] = 2,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 4,
				threshold = 0,
				points = 4,
				time = 8000,
			},
			[5] = {
				name = "weapon_gusenberg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 1,
					["coronhasmg"] = 2,
					["50rddrum"] = 1,
					["estruturasmg"] = 1,
					["magazinesmg"] = 2,
					["punho"] = 1,
				},
				type = "weapon",
				slot = 5,
				threshold = 120,
				points = 5,
				time = 9000,
			},
			[6] = {
				name = "weapon_minismg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 1,
					["estruturasmg"] = 2,
					["coronhasmg"] = 1,
					["magazinesmg"] = 2,
					["punho"] = 2,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 6,
				threshold = 160,
				points = 6,
				time = 10000,
			},
			[7] = {
				name = "weapon_revolver",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 2,
					["estruturarevolver"] = 1,
					["magazinepistola"] = 2,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 7,
				threshold = 200,
				points = 7,
				time = 11000,
			},
			[8] = {
				name = "weapon_marksmanpistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 1,
					["magazinepistola"] = 2,
					["estruturarevolver"] = 1,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 8,
				threshold = 250,
				points = 8,
				time = 12000,
			},
			[9] = {
				name = "weapon_microsmg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 2,
					["estruturasmg"] = 1,
					["magazinesmg"] = 2,
					["coronhasmg"] = 1,
					["punho"] = 2,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 9,
				threshold = 300,
				points = 9,
				time = 13000,
			},
			[10] = {
				name = "weapon_combatpdw",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 2,
					["estruturasmg"] = 1,
					["magazinesmg"] = 2,
					["coronhasmg"] = 1,
					["punho"] = 1,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 10,
				threshold = 300,
				points = 10,
				time = 14000,
			},
			[11] = {
				name = "weapon_assaultsmg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 2,
					["estruturasmg"] = 2,
					["magazinesmg"] = 2,
					["coronhasmg"] = 1,
					["punho"] = 2,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 11,
				threshold = 350,
				points = 11,
				time = 15000,
			},
			[12] = {
				name = "weapon_sawnoffshotgun",
				amount = 1,
				info = {},
				costs = {
					["canoshotgun"] = 1,
					["estruturashotgun"] = 1,
					["magazineshotgun"] = 1,
					["punho"] = 2,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 12,
				threshold = 1750,
				points = 12,
				time = 16000,
			},
			[13] = {
				name = "weapon_assaultshotgun",
				amount = 1,
				info = {},
				costs = {
					["canoshotgun"] = 1,
					["estruturashotgun"] = 2,
					["magazineshotgun"] = 1,
					["punho"] = 3,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 13,
				threshold = 1750,
				points = 13,
				time = 17000,
			},
			[14] = {
				name = "weapon_compactrifle",
				amount = 1,
				info = {},
				costs = {
					["estruturarifle"] = 1,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["canorifle"] = 1,
					["punho"] = 3,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 14,
				threshold = 1750,
				points = 14,
				time = 19000,
			},
			[15] = {
				name = "weapon_specialcarbine",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 1,
					["estruturarifle"] = 2,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 1,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 15,
				threshold = 1750,
				points = 15,
				time = 20000,
			},
			[16] = {
				name = "weapon_bullpuprifle",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 1,
					["estruturarifle"] = 1,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 3,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 16,
				threshold = 1750,
				points = 16,
				time = 21000,
			},
			[17] = {
				name = "weapon_assaultrifle",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 2,
					["estruturarifle"] = 1,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 2,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 17,
				threshold = 1750,
				points = 17,
				time = 22000,
			},
			[18] = {
				name = "weapon_assaultrifle_mk2",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 2,
					["estruturarifle"] = 2,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 3,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 18,
				threshold = 1750,
				points = 18,
				time = 23000,
			},
		}
    },
	[2] = {
        name = 'Craft Armas',
        isjob = 'peakyblinders', --job name or false
        grades = 'all',
        text =  "[E] - Craft Armas",
		maxDistance = 8.0,
        blip = {
            enabled = false,
            title = "Police Crafting",
            scale = 1.0,
            display = 4,
            colour = 0,
            id = 365
        },
        location = vec3(-1108.11, 4948.322, 218.35),
		items = {
			[1] = {
				name = "weapon_combatpistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 1,
					["magazinepistola"] = 1,
					["estruturapistola"] = 1,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 1,
				threshold = 0,
				points = 1,
				time = 5000,
			},
			[2] = {
				name = "weapon_machinepistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 1,
					["magazinepistola"] = 2,
					["estruturapistola"] = 1,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 2,
				threshold = 0,
				points = 2,
				time = 6000,
			},
			[3] = {
				name = "weapon_pistol50",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 2,
					["estruturadeagle"] = 1,
					["magazinepistola"] = 1,
					["punho"] = 2,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 3,
				threshold = 0,
				points = 3,
				time = 7000,
			},
			[4] = {
				name = "weapon_vintagepistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 2,
					["estruturapistola"] = 1,
					["magazinepistola"] = 2,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 4,
				threshold = 0,
				points = 4,
				time = 8000,
			},
			[5] = {
				name = "weapon_gusenberg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 1,
					["coronhasmg"] = 2,
					["50rddrum"] = 1,
					["estruturasmg"] = 1,
					["magazinesmg"] = 2,
					["punho"] = 1,
				},
				type = "weapon",
				slot = 5,
				threshold = 120,
				points = 5,
				time = 9000,
			},
			[6] = {
				name = "weapon_minismg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 1,
					["estruturasmg"] = 2,
					["coronhasmg"] = 1,
					["magazinesmg"] = 2,
					["punho"] = 2,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 6,
				threshold = 160,
				points = 6,
				time = 10000,
			},
			[7] = {
				name = "weapon_revolver",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 2,
					["estruturarevolver"] = 1,
					["magazinepistola"] = 2,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 7,
				threshold = 200,
				points = 7,
				time = 11000,
			},
			[8] = {
				name = "weapon_marksmanpistol",
				amount = 1,
				info = {},
				costs = {
					["canopistola"] = 1,
					["magazinepistola"] = 2,
					["estruturarevolver"] = 1,
					["punho"] = 1,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 8,
				threshold = 250,
				points = 8,
				time = 12000,
			},
			[9] = {
				name = "weapon_microsmg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 2,
					["estruturasmg"] = 1,
					["magazinesmg"] = 2,
					["coronhasmg"] = 1,
					["punho"] = 2,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 9,
				threshold = 300,
				points = 9,
				time = 13000,
			},
			[10] = {
				name = "weapon_combatpdw",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 2,
					["estruturasmg"] = 1,
					["magazinesmg"] = 2,
					["coronhasmg"] = 1,
					["punho"] = 1,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 10,
				threshold = 300,
				points = 10,
				time = 14000,
			},
			[11] = {
				name = "weapon_assaultsmg",
				amount = 1,
				info = {},
				costs = {
					["canosmg"] = 2,
					["estruturasmg"] = 2,
					["magazinesmg"] = 2,
					["coronhasmg"] = 1,
					["punho"] = 2,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 11,
				threshold = 350,
				points = 11,
				time = 15000,
			},
			[12] = {
				name = "weapon_sawnoffshotgun",
				amount = 1,
				info = {},
				costs = {
					["canoshotgun"] = 1,
					["estruturashotgun"] = 1,
					["magazineshotgun"] = 1,
					["punho"] = 2,
					["50rddrum"] = 1,
				},
				type = "weapon",
				slot = 12,
				threshold = 1750,
				points = 12,
				time = 16000,
			},
			[13] = {
				name = "weapon_assaultshotgun",
				amount = 1,
				info = {},
				costs = {
					["canoshotgun"] = 1,
					["estruturashotgun"] = 2,
					["magazineshotgun"] = 1,
					["punho"] = 3,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 13,
				threshold = 1750,
				points = 13,
				time = 17000,
			},
			[14] = {
				name = "weapon_compactrifle",
				amount = 1,
				info = {},
				costs = {
					["estruturarifle"] = 1,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["canorifle"] = 1,
					["punho"] = 3,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 14,
				threshold = 1750,
				points = 14,
				time = 19000,
			},
			[15] = {
				name = "weapon_specialcarbine",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 1,
					["estruturarifle"] = 2,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 1,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 15,
				threshold = 1750,
				points = 15,
				time = 20000,
			},
			[16] = {
				name = "weapon_bullpuprifle",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 1,
					["estruturarifle"] = 1,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 3,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 16,
				threshold = 1750,
				points = 16,
				time = 21000,
			},
			[17] = {
				name = "weapon_assaultrifle",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 2,
					["estruturarifle"] = 1,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 2,
					["50rddrum"] = 3,
				},
				type = "weapon",
				slot = 17,
				threshold = 1750,
				points = 17,
				time = 22000,
			},
			[18] = {
				name = "weapon_assaultrifle_mk2",
				amount = 1,
				info = {},
				costs = {
					["canorifle"] = 2,
					["estruturarifle"] = 2,
					["magazinerifle"] = 1,
					["coronharifle"] = 1,
					["punho"] = 3,
					["50rddrum"] = 2,
				},
				type = "weapon",
				slot = 18,
				threshold = 1750,
				points = 18,
				time = 23000,
			},
		}
    },
	[3] = {
        name = 'Craft Peças Armas',
        isjob = 'cartel', --job name or false
        grades = 'all',
        text =  "[E] - Craft Peças Armas",
		maxDistance = 8.0,
        blip = {
            enabled = false,
            title = "Police Crafting",
            scale = 1.0,
            display = 4,
            colour = 0,
            id = 365
        },
        location = vec3(2481.992, 3723.088, 43.930),
		items = {
			[1] = {
				name = "punho",
				amount = 1,
				info = {},
				costs = {
					["glass"] = 20,
					["plastic"] = 30,
					["gold"] = 1,
				},
				type = "item",
				slot = 1,
				threshold = 0,
				points = 1,
				time = 5000,
			},
			[2] = {
				name = "50rddrum",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["gold"] = 5,
					["aluminium"] = 15,
					["metal"] = 30,
				},
				type = "item",
				slot = 2,
				threshold = 0,
				points = 2,
				time = 5000,
			},
			[3] = {
				name = "estruturadeagle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["aluminium"] = 5,
					["glass"] = 20,
					["metal"] = 30,
				},
				type = "item",
				slot = 3,
				threshold = 0,
				points = 3,
				time = 5000,
			},
			[4] = {
				name = "estruturarevolver",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["aluminium"] = 5,
					["steel"] = 10,
					["metal"] = 30,
					["copper"] = 6,
					["gold"] = 2,
				},
				type = "item",
				slot = 4,
				threshold = 0,
				points = 4,
				time = 5000,
			},
			[5] = {
				name = "canopistola",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 2,
					["steel"] = 10,
					["iron"] = 3,
				},
				type = "item",
				slot = 5,
				threshold = 120,
				points = 5,
				time = 5000,
			},
			[6] = {
				name = "estruturapistola",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 5,
					["steel"] = 20,
					["iron"] = 6,
					["rubber"] = 14,
					["glass"] = 4,
					["copper"] = 3,
				},
				type = "item",
				slot = 6,
				threshold = 160,
				points = 6,
				time = 5000,
			},
			[7] = {
				name = "magazinepistola",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 2,
					["steel"] = 10,
					["iron"] = 3,
				},
				type = "item",
				slot = 7,
				threshold = 200,
				points = 7,
				time = 5000,
			},
			[8] = {
				name = "canosmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 2,
					["steel"] = 10,
					["iron"] = 3,
					["gold"] = 1,
					["aluminium"] = 2,
					["glass"] = 4,
				},
				type = "item",
				slot = 8,
				threshold = 250,
				points = 8,
				time = 5000,
			},
			[9] = {
				name = "estruturasmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 12,
					["steel"] = 20,
					["iron"] = 3,
					["gold"] = 2,
					["aluminium"] = 5,
					["glass"] = 20,
					["copper"] = 6,
				},
				type = "item",
				slot = 9,
				threshold = 300,
				points = 9,
				time = 5000,
			},
			[10] = {
				name = "magazinesmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 10,
					["steel"] = 10,
					["iron"] = 3,
					["gold"] = 1,
					["aluminium"] = 2,
				},
				type = "item",
				slot = 10,
				threshold = 300,
				points = 10,
				time = 5000,
			},
			[11] = {
				name = "coronhasmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 5,
					["steel"] = 15,
					["iron"] = 6,
					["copper"] = 3,
					["rubber"] = 14,
					["glass"] = 4,
				},
				type = "item",
				slot = 11,
				threshold = 350,
				points = 11,
				time = 5000,
			},
			[12] = {
				name = "canorifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 25,
					["iron"] = 10,
					["copper"] = 5,
					["aluminium"] = 5,
					["steel"] = 20,
				},
				type = "item",
				slot = 12,
				threshold = 1750,
				points = 12,
				time = 5000,
			},
			[13] = {
				name = "estruturarifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 25,
					["iron"] = 5,
					["copper"] = 5,
					["aluminium"] = 5,
					["steel"] = 20,
					["glass"] = 10,
				},
				type = "item",
				slot = 13,
				threshold = 1750,
				points = 13,
				time = 5000,
			},
			[14] = {
				name = "magazinerifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 20,
					["steel"] = 10,
				},
				type = "item",
				slot = 14,
				threshold = 1750,
				points = 14,
				time = 5000,
			},
			[15] = {
				name = "coronharifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["gold"] = 7,
					["steel"] = 15,
					["copper"] = 5,
					["metal"] = 3,
					["rubber"] = 3,
				},
				type = "item",
				slot = 15,
				threshold = 1750,
				points = 15,
				time = 5000,
			},
			[16] = {
				name = "canoshotgun",
				amount = 1,
				info = {},
				costs = {
					["iron"] = 8,
					["gold"] = 6, 
					["steel"] = 20, 
					["copper"] = 7, 
					["copper"] = 7, 
					["aluminium"] = 5,
				},
				type = "item",
				slot = 16,
				threshold = 1750,
				points = 16,
				time = 5000,
			},
			[17] = {
				name = "estruturashotgun",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 27, 
					["steel"] = 20, 
					["copper"] = 5, 
					["iron"] = 20, 
					["aluminium"] = 5, 
				},
				type = "item",
				slot = 17,
				threshold = 1750,
				points = 17,
				time = 5000,
			},
			[18] = {
				name = "magazineshotgun",
				amount = 1,
				info = {},
				costs = {
					["glass"] = 20,
					["gold"] = 4, 
					["steel"] = 20, 
					["iron"] = 8, 
					["rubber"] = 10, 
					["metal"] = 10, 
				},
				type = "item",
				slot = 18,
				threshold = 1750,
				points = 18,
				time = 5000,
			},
		}
    },
	[4] = {
        name = 'Craft Peças Armas',
        isjob = 'yakuza', --job name or false
        grades = 'all',
        text =  "[E] - Craft Peças Armas",
		maxDistance = 8.0,
        blip = {
            enabled = false,
            title = "Police Crafting",
            scale = 1.0,
            display = 4,
            colour = 0,
            id = 365
        },
        location = vec3(2481.992, 3723.088, 43.930),
		items = {
			[1] = {
				name = "punho",
				amount = 1,
				info = {},
				costs = {
					["glass"] = 10,
					["plastic"] = 20,
					["gold"] = 1,
				},
				type = "item",
				slot = 1,
				threshold = 0,
				points = 1,
				time = 5000,
			},
			[2] = {
				name = "50rddrum",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["gold"] = 5,
					["aluminium"] = 5,
					["metal"] = 30,
				},
				type = "item",
				slot = 2,
				threshold = 0,
				points = 2,
				time = 5000,
			},
			[3] = {
				name = "estruturadeagle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["aluminium"] = 5,
					["glass"] = 20,
				},
				type = "item",
				slot = 3,
				threshold = 0,
				points = 3,
				time = 5000,
			},
			[4] = {
				name = "estruturarevolver",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["aluminium"] = 5,
					["steel"] = 10,
					["copper"] = 6,
					["gold"] = 2,
				},
				type = "item",
				slot = 4,
				threshold = 0,
				points = 4,
				time = 5000,
			},
			[5] = {
				name = "canopistola",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 2,
					["steel"] = 10,
					["iron"] = 3,
				},
				type = "item",
				slot = 5,
				threshold = 120,
				points = 5,
				time = 5000,
			},
			[6] = {
				name = "estruturapistola",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 5,
					["steel"] = 20,
					["iron"] = 6,
					["rubber"] = 14,
					["glass"] = 4,
					["copper"] = 3,
				},
				type = "item",
				slot = 6,
				threshold = 160,
				points = 6,
				time = 5000,
			},
			[7] = {
				name = "magazinepistola",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 2,
					["steel"] = 10,
					["iron"] = 3,
				},
				type = "item",
				slot = 7,
				threshold = 200,
				points = 7,
				time = 5000,
			},
			[8] = {
				name = "canosmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 2,
					["steel"] = 10,
					["iron"] = 3,
					["gold"] = 1,
					["aluminium"] = 2,
					["glass"] = 4,
				},
				type = "item",
				slot = 8,
				threshold = 250,
				points = 8,
				time = 5000,
			},
			[9] = {
				name = "estruturasmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 12,
					["steel"] = 20,
					["iron"] = 3,
					["gold"] = 2,
					["aluminium"] = 5,
					["glass"] = 20,
					["copper"] = 6,
				},
				type = "item",
				slot = 9,
				threshold = 300,
				points = 9,
				time = 5000,
			},
			[10] = {
				name = "magazinesmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 10,
					["steel"] = 10,
					["iron"] = 3,
					["gold"] = 1,
					["aluminium"] = 2,
				},
				type = "item",
				slot = 10,
				threshold = 300,
				points = 10,
				time = 5000,
			},
			[11] = {
				name = "coronhasmg",
				amount = 1,
				info = {},
				costs = {
					["plastic"] = 5,
					["steel"] = 15,
					["iron"] = 6,
					["copper"] = 3,
					["rubber"] = 14,
					["glass"] = 4,
				},
				type = "item",
				slot = 11,
				threshold = 350,
				points = 11,
				time = 5000,
			},
			[12] = {
				name = "canorifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 25,
					["iron"] = 10,
					["copper"] = 5,
					["aluminium"] = 5,
					["steel"] = 20,
				},
				type = "item",
				slot = 12,
				threshold = 1750,
				points = 12,
				time = 5000,
			},
			[13] = {
				name = "estruturarifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 25,
					["iron"] = 5,
					["copper"] = 5,
					["aluminium"] = 5,
					["steel"] = 20,
					["glass"] = 10,
				},
				type = "item",
				slot = 13,
				threshold = 1750,
				points = 13,
				time = 5000,
			},
			[14] = {
				name = "magazinerifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 20,
					["steel"] = 10,
				},
				type = "item",
				slot = 14,
				threshold = 1750,
				points = 14,
				time = 5000,
			},
			[15] = {
				name = "coronharifle",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 2,
					["gold"] = 7,
					["steel"] = 15,
					["copper"] = 5,
					["metal"] = 3,
					["rubber"] = 3,
				},
				type = "item",
				slot = 15,
				threshold = 1750,
				points = 15,
				time = 5000,
			},
			[16] = {
				name = "canoshotgun",
				amount = 1,
				info = {},
				costs = {
					["iron"] = 8,
					["gold"] = 6, 
					["steel"] = 20, 
					["copper"] = 7, 
					["copper"] = 7, 
					["aluminium"] = 5,
				},
				type = "item",
				slot = 16,
				threshold = 1750,
				points = 16,
				time = 5000,
			},
			[17] = {
				name = "estruturashotgun",
				amount = 1,
				info = {},
				costs = {
					["diamond"] = 5,
					["gold"] = 27, 
					["steel"] = 20, 
					["copper"] = 5, 
					["iron"] = 20, 
					["aluminium"] = 5, 
				},
				type = "item",
				slot = 17,
				threshold = 1750,
				points = 17,
				time = 5000,
			},
			[18] = {
				name = "magazineshotgun",
				amount = 1,
				info = {},
				costs = {
					["glass"] = 20,
					["gold"] = 4, 
					["steel"] = 20, 
					["iron"] = 8, 
					["rubber"] = 10, 
					["metal"] = 10, 
				},
				type = "item",
				slot = 18,
				threshold = 1750,
				points = 18,
				time = 5000,
			},
		}
    },
}