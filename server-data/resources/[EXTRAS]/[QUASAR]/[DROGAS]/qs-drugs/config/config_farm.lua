--██╗░░██╗░█████╗░██████╗░██╗░░░██╗███████╗░██████╗████████╗
--██║░░██║██╔══██╗██╔══██╗██║░░░██║██╔════╝██╔════╝╚══██╔══╝
--███████║███████║██████╔╝╚██╗░██╔╝█████╗░░╚█████╗░░░░██║░░░
--██╔══██║██╔══██║██╔══██╗░╚████╔╝░██╔══╝░░░╚═══██╗░░░██║░░░
--██║░░██║██║░░██║██║░░██║░░╚██╔╝░░███████╗██████╔╝░░░██║░░░
--╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░

Config.CollectItems = { --Modify the collectibles.
  ["weed"] = {
    prop = 'prop_weed_01', --Prop.
    name = 'Marijuana', --Visual name.
    item = 'weed', --Item Name.
    time = 4000, --Progressbar timer.
    quantityMin = 2, -- Minium Amount you will get when collecting.
    quantityMax = 4, -- Max Amount you will get when collecting.
    requiredCops = false, -- 
    requiredCopsQuantity = 0 -- Minimum of police on duty to collect drugs
  },
  ["meth"] = {
    prop = 'prop_barrel_exp_01a', --Prop.
    name = 'Químicos', --Visual name.
    item = 'chemicals', --Item Name.
    time = 4000, --Progressbar timer.
    quantityMin = 1, -- Minium Amount you will get when collecting.
    quantityMax = 2, -- Max Amount you will get when collecting.
    requiredCops = false, -- Require police online?
    requiredCopsQuantity = 0 -- Minimum of police on duty to collect drugs
  },
  ["cocaine"] = {
    prop = 'prop_plant_cane_02b', --Prop.
    name = 'Cocaína', --Visual name.
    item = 'cocaine', --Item Name.
    time = 4000, --Progressbar timer.
    quantityMin = 1, -- Minium Amount you will get when collecting.
    quantityMax = 3, -- Max Amount you will get when collecting.
    requiredCops = false, --  Require police online?
    requiredCopsQuantity = 0 -- Minimum of police on duty to collect drugs
  },
}

Config.CircleZones = { --Modify the coordinates, or add more.
--Weed.
	WeedField = {coords = vector3(1320.04, 1870.26, 90.83), SpawnCoords = {
    vector3(1320.215, 1870.333, 90.85452),
    vector3(1327.837, 1868.747, 92.27645),
    vector3(1324.869, 1861.578, 92.30363),
    vector3(1315.104, 1860.166, 90.54333),
    vector3(1308.948, 1866.706, 88.88728),
    vector3(1310.077, 1876.98, 88.63334),
    vector3(1319.797, 1881.809, 90.20747),
    vector3(1333.231, 1879.296, 92.46505),
    vector3(1343.808, 1869.762, 94.27966),
    vector3(1337.932, 1861.433, 93.82767),
    vector3(1332.817, 1850.088, 93.33994),
    vector3(1340.589, 1849.246, 94.33746),
    vector3(1350.098, 1859.028, 95.41202),
    vector3(1343.933, 1866.611, 94.42379),
    vector3(1328.526, 1885.29, 91.4468),
    vector3(1320.057, 1891.196, 89.80909),
    vector3(1299.274, 1869.89, 86.87721),
    vector3(1301.823, 1859.475, 87.80598),
  }},
--Chemicals.
	ChemicalsField = {coords = vector3(817.46, -3192.84, 5.9), SpawnCoords = {
    vector3(814.7153, -3195.444, 5.900818),
    vector3(817.7902, -3200.771, 5.900818),
    vector3(820.09, -3194.618, 5.900818),
    vector3(817.5483, -3189.987, 5.900818),
    vector3(811.2111, -3189.486, 5.900818),
    vector3(810.2635, -3192.79, 5.900818),
    vector3(812.1355, -3199.094, 5.900818),
    vector3(808.2501, -3201.11, 5.900818),
    vector3(812.5481, -3200.223, 5.900815),
  }},
--Cocaine.
	CocainaField = {coords = vector3(16.34, 6875.94, 12.64), SpawnCoords = {
    vector3(16.33991, 6875.94, 12.63982),
    vector3(20.36974, 6871.238, 13.07422),
    vector3(15.21229, 6865.497, 12.72771),
    vector3(6.707561, 6867.579, 12.6143),
    vector3(8.672844, 6873.903, 12.46061),
    vector3(16.59974, 6882.196, 12.51987),
    vector3(22.7651, 6876.811, 13.19112),
    vector3(27.99341, 6872.438, 13.75746),
    vector3(14.50345, 6869.238, 12.67547),
    vector3(6.396118, 6860.454, 12.84791),
    vector3(-0.7274725, 6865.107, 12.78476),
  }},
}