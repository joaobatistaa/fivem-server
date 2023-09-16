--[[  
    Welcome to the Garbages setting!
    In this configuration you will find everything related 
    to garbage cans and their items, since a random one will 
    appear from the list that you will see below.

    Config.GarbageObjects is simply for target use, so if 
    you don't use it, you can ignore it.
]]

Config.GarbageItems = {}


Config.FreezeGarbages = false


Config.GarbageRefreshTime = 3600000


Config.GarbageObjects = {
    'prop_dumpster_02a',
    'prop_dumpster_4b',
    'prop_dumpster_4a',
    'prop_dumpster_3a',
    'prop_dumpster_02b',
    'prop_dumpster_01a',
	[218085040],
    [666561306], 
	[-58485588],
	[-206690185],
	[1511880420],
    [682791951], 
	[1437508529], 
    [1614656839], 
    [-1096777189],
    [-228596739], 
    [-1187286639], 
    [-130812911], 
	[-468629664]
}

Config.GarbageItemsForProp = {
    [joaat('prop_dumpster_02a')] = {
        label = 'Caixote do Lixo',
        slots = 30,
        items = {
            [1] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[2] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[3] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[4] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[5] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[6] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[7] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[8] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[9] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[10] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[11] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[12] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[13] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[14] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[15] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[16] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[17] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[18] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[19] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[20] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[21] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[22] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[23] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[24] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[25] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[26] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[27] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[28] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[29] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[30] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[31] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[32] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[33] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[34] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[35] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[36] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[37] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[38] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[39] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[40] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[41] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[42] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 30
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[43] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[44] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[45] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[46] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[47] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[48] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[49] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_pink_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[50] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[51] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[52] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_blue_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[53] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "fixtool",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[54] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "water",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[55] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 5                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[56] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[57] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[58] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[59] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[60] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[61] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[62] = {
				[1] = {
					name = "wet_purple_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[63] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[64] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[65] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[66] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[67] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[68] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[69] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[70] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 2,
                        max = 9                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[71] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[72] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[73] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[74] = {
				[1] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[75] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[76] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[77] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[78] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[79] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[80] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
        }
    },
	[joaat('prop_dumpster_4b')] = {
        label = 'Caixote do Lixo',
        slots = 30,
        items = {
            [1] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[2] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[3] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[4] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[5] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[6] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[7] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[8] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[9] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[10] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[11] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[12] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[13] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[14] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[15] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[16] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[17] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[18] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[19] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[20] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[21] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[22] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[23] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[24] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[25] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[26] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[27] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[28] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[29] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[30] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[31] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[32] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[33] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[34] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[35] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[36] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[37] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[38] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[39] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[40] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[41] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[42] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 30
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[43] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[44] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[45] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[46] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[47] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[48] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[49] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_pink_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[50] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[51] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[52] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_blue_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[53] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "fixtool",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[54] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "water",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[55] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 5                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[56] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[57] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[58] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[59] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[60] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[61] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[62] = {
				[1] = {
					name = "wet_purple_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[63] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[64] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[65] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[66] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[67] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[68] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[69] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[70] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 2,
                        max = 9                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[71] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[72] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[73] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[74] = {
				[1] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[75] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[76] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[77] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[78] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[79] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[80] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
        }
    },
	[joaat('prop_dumpster_4a')] = {
        label = 'Caixote do Lixo',
        slots = 30,
        items = {
            [1] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[2] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[3] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[4] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[5] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[6] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[7] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[8] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[9] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[10] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[11] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[12] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[13] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[14] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[15] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[16] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[17] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[18] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[19] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[20] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[21] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[22] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[23] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[24] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[25] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[26] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[27] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[28] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[29] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[30] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[31] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[32] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[33] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[34] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[35] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[36] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[37] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[38] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[39] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[40] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[41] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[42] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 30
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[43] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[44] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[45] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[46] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[47] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[48] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[49] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_pink_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[50] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[51] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[52] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_blue_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[53] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "fixtool",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[54] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "water",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[55] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 5                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[56] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[57] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[58] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[59] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[60] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[61] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[62] = {
				[1] = {
					name = "wet_purple_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[63] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[64] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[65] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[66] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[67] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[68] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[69] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[70] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 2,
                        max = 9                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[71] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[72] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[73] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[74] = {
				[1] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[75] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[76] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[77] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[78] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[79] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[80] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
        }
    },
	[joaat('prop_dumpster_3a')] = {
        label = 'Caixote do Lixo',
        slots = 30,
        items = {
            [1] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[2] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[3] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[4] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[5] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[6] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[7] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[8] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[9] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[10] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[11] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[12] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[13] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[14] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[15] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[16] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[17] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[18] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[19] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[20] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[21] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[22] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[23] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[24] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[25] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[26] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[27] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[28] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[29] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[30] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[31] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[32] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[33] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[34] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[35] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[36] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[37] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[38] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[39] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[40] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[41] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[42] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 30
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[43] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[44] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[45] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[46] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[47] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[48] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[49] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_pink_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[50] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[51] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[52] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_blue_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[53] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "fixtool",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[54] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "water",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[55] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 5                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[56] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[57] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[58] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[59] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[60] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[61] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[62] = {
				[1] = {
					name = "wet_purple_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[63] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[64] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[65] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[66] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[67] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[68] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[69] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[70] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 2,
                        max = 9                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[71] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[72] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[73] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[74] = {
				[1] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[75] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[76] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[77] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[78] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[79] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[80] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
        }
    },
	[joaat('prop_dumpster_02b')] = {
        label = 'Caixote do Lixo',
        slots = 30,
        items = {
            [1] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[2] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[3] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[4] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[5] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[6] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[7] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[8] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[9] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[10] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[11] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[12] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[13] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[14] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[15] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[16] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[17] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[18] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[19] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[20] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[21] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[22] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[23] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[24] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[25] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[26] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[27] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[28] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[29] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[30] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[31] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[32] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[33] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[34] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[35] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[36] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[37] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[38] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[39] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[40] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[41] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[42] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 30
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[43] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[44] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[45] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[46] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[47] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[48] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[49] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_pink_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[50] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[51] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[52] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_blue_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[53] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "fixtool",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[54] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "water",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[55] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 5                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[56] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[57] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[58] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[59] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[60] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[61] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[62] = {
				[1] = {
					name = "wet_purple_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[63] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[64] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[65] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[66] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[67] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[68] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[69] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[70] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 2,
                        max = 9                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[71] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[72] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[73] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[74] = {
				[1] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[75] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[76] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[77] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[78] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[79] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[80] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
        }
    },
	[joaat('prop_dumpster_01a')] = {
        label = 'Caixote do Lixo',
        slots = 30,
        items = {
            [1] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[2] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[3] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[4] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[5] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[6] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[7] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[8] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[9] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[10] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[11] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[12] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[13] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[14] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[15] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[16] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[17] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[18] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[19] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[20] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[21] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[22] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[23] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[24] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[25] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[26] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[27] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[28] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[29] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[30] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[31] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[32] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[33] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[34] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[35] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[36] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[37] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[38] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[39] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[40] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[41] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[42] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 30
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[43] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[44] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[45] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[46] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
			},
			[47] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[48] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[49] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_pink_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[50] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_red_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[51] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "green_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[52] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "wet_blue_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[53] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "fixtool",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[54] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "water",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[55] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 5                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[56] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[57] = {
				[1] = {
					name = "rubber",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[58] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[59] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "binoculars",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[60] = {
				[1] = {
					name = "plastic",
					amount = {
                        min = 4,
                        max = 15
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[61] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[62] = {
				[1] = {
					name = "wet_purple_phone",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[63] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[64] = {
				[1] = {
					name = "radio",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "cigarett",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[65] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[66] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[67] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[68] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "plastic",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[69] = {
				[1] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[70] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 2,
                        max = 9                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[71] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "electronics",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[72] = {
				[1] = {
					name = "aluminium",
					amount = {
                        min = 1,
                        max = 3
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "rubber",
					amount = {
                        min = 1,
                        max = 2                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[73] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[74] = {
				[1] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[75] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[76] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[77] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[78] = {
				[1] = {
					name = "metalscrap",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[79] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
			[80] = {
				[1] = {
					name = "glass",
					amount = {
                        min = 1,
                        max = 7                    
					},
					price = 4,
					info = {},
					type = "item",
					slot = 1,
				},
				[2] = {
					name = "metal",
					amount = {
                        min = 4,
                        max = 10
                    },
					price = 4,
					info = {},
					type = "item",
					slot = 2,
				},
			},
        }
    }
}