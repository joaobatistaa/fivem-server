
--██████╗░██████╗░██╗░░░██╗░██████╗░  ░██████╗███████╗██╗░░░░░██╗░░░░░███████╗██████╗░
--██╔══██╗██╔══██╗██║░░░██║██╔════╝░  ██╔════╝██╔════╝██║░░░░░██║░░░░░██╔════╝██╔══██╗
--██║░░██║██████╔╝██║░░░██║██║░░██╗░  ╚█████╗░█████╗░░██║░░░░░██║░░░░░█████╗░░██████╔╝
--██║░░██║██╔══██╗██║░░░██║██║░░╚██╗  ░╚═══██╗██╔══╝░░██║░░░░░██║░░░░░██╔══╝░░██╔══██╗
--██████╔╝██║░░██║╚██████╔╝╚██████╔╝  ██████╔╝███████╗███████╗███████╗███████╗██║░░██║
--╚═════╝░╚═╝░░╚═╝░╚═════╝░░╚═════╝░  ╚═════╝░╚══════╝╚══════╝╚══════╝╚══════╝╚═╝░░╚═╝

Config.DrugSeller = false --If you put false, there will be no drug sales.
Config.OnlyRetailer = false --Only retail?

Config.RequiredCops = 2 --Minimum police to sell drugs.
Config.VehiclePrice = 0 --Price of the vehicle to distribute the drugs.
Config.CustomersFindPrice = 25 --Price for requesting data from buyers..
Config.MinWholesaleCount = 50 --Minimum drug to start the sale.
Config.WholesaleVehicle = 'buffalo' --Delivery vehicle https://wiki.rage.mp/index.php?title=Vehicles.
Config.CopsRefreshTime = 30000 --Min 30000ms. If you put less it lowers the performance, if you put more, it is better

Config.SellGiveitem = false -- Give item or account money
Config.SellItemName = 'markedbills' -- If SellGiveitem = true 
Config.MoneyAccount = 'black_money' --Change account type, example: money, black_money or bank

--You can put larger numbers for example 100, but this means that it will have less probability of happening

--Example:
--Config.NormalSellChance = 100 is 1%
--Config.DruggedSellChance = 1 is 100%

--(Min 1) If 1 = 99%, 2=50%, 3=33%, 4=25%, 5=20%

Config.NormalSellChance = 0 -- 20% Normal Sale.
Config.DruggedSellChance = 0 -- 20% NPC is drugged and paid 2x.
Config.AttackSellChance = 0 -- 20% NPC robbing us.
Config.PoliceSellChance = 0 -- 20% NPC notifies the LSPD.

Config.SellOnlyJob = true --If you enable this, only the Jobs mentioned below will be able to access the seller.

Config.SellJobs = { --Jobs allowed for sale.
    ['grove'] = true,
    ['ballas'] = true,
	['vagos'] = true,
}


function VehicleKeys(vehicle)
    --TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
end

Config.Drugs = {
    Weed = {
        ItemName = "weed_packaged",
        ItemWholesalePrice = 940, --Wholesaler's price.
        ItemSinglyPrice = 940, --Retail.
    },
    Meth = {
        ItemName = "meth_packaged",
        ItemWholesalePrice = 1250, --Wholesaler's price.
        ItemSinglyPrice = 1250, --Retail.
    },
    Coke = {
        ItemName = "cocaine_packaged",
        ItemWholesalePrice = 1070, --Wholesaler's price.
        ItemSinglyPrice = 1070, --Retail.
    },
}

Config.SellDrugs = { --Customers configuration.
    Dealer = {
		Pos   = {x = 997.5124, y = -1480.71, z = 31.433, h = 238.49},
		WholesaleVehicleSpawnPoint = {x = -49.22, y = -1222.01, z = 28.93, h = 88.14},
		DealerPed = "g_m_y_famca_01",

        CustomerWholesaleText = {
            [1] = {text = "Você tem algo bom para mim?"},
            [2] = {text = "Você sabe sobre o que era?"},
            [3] = {text = "Ação rápida, as pessoas dirigem aqui ..."},
            [4] = {text = "Mova-se mais rápido, não temos tempo!"},
            [5] = {text = "Espero que as drogas sejam as melhores"},
            [6] = {text = "Espero que tudo seja convertido em miligramas"},
        },
        CustomerSinglyText = {
            [1] = {text = "Ei, você tem alguma coisa boa para mim?"},
            [2] = {text = "Oi amigo, você tem alguma droga?"},
            [3] = {text = "Quanto tempo posso esperar por você ... Você tem drogas?"},
            [4] = {text = "E aí, anda logo, não tenho tempo!"},
            [5] = {text = "Oba, espero que os medicamentos sejam os melhores"},
            [6] = {text = "Ei, espero que tudo seja convertido em miligramas ..."},
        },
        CustomerSinglyNormalText = {
            [1] = {text = "Obrigado, vou me divertir um pouco"},
            [2] = {text = "Tudo bem mano, até o próximo ..."},
            [3] = {text = "Estamos em contato, companheiro!"},
            [4] = {text = "Hoje vou ficar louco"},
            [5] = {text = "Entrarei em contato para saber mais em breve!"},
            [6] = {text = "Vou para o clube, cuide-se"},
        },
        CustomerSinglyDruggedText = {
            [1] = {text = "Vou ficar mais alto, cruze os dedos"},
            [2] = {text = "Foda-se, mas essas drogas estão batendo forte"},
            [3] = {text = "Obrigado, minha querida, se cuide ..."},
            [4] = {text = "Foda-se! Eu tinha um compromisso com alguém, mas não me lembro com quem ..."},
            [5] = {text = "Vou para casa descansar até o próximo"},
            [6] = {text = "H ... H ... Ei amigo!"},
        },
        CustomerSinglyAttackText = {
            [1] = {text = "Levante as mãos, vadia!"},
            [2] = {text = "Desiste de seu filho da puta!"},
            [3] = {text = "E agora, vadia ?! Me dê as drogas!"},
            [4] = {text = "Haha! Escolha bem, bastardo!"},
            [5] = {text = "Sem movimentos bruscos ou vou estourar sua cabeça!"},
            [6] = {text = "O que você diria sobre isso?"},
        },
        CustomerSinglyPoliceText = {
            [1] = {text = "Não quero suas merdas!"},
            [2] = {text = "Foda-se com isso"},
            [3] = {text = "Não estou interessado, obrigado"},
            [4] = {text = "Estou chamando a polícia"},
            [5] = {text = "Afaste-se de mim com isso!"},
            [6] = {text = "Talvez outra hora"},
        },
	},
    SinglyPeds = {
        [1] = {ped = "a_m_y_beach_03"},
        [2] = {ped = "a_m_y_breakdance_01"},
        [3] = {ped = "g_m_m_chicold_01"},
        [4] = {ped = "s_m_y_dealer_01"},
        [5] = {ped = "a_m_y_downtown_01"},
        [6] = {ped = "g_m_y_famfor_01"},
        [7] = {ped = "csb_g"},
        [8] = {ped = "ig_jimmydisanto"},
        [9] = {ped = "u_m_y_militarybum"},
        [10] = {ped = "ig_ortega"},
	},
    DocksCustomer = {
        DocksPed = "s_m_m_gardener_01",
	},
    EastVinewoodCustomer = {
        EastVinewoodPed = "s_m_m_bouncer_01",
	},
    SandyShoresCustomer = {
        SandyShoresPed = "a_m_m_eastsa_01",
	},
    PaletoBayCustomer = {
        PaletoBayPed = "a_m_m_hillbilly_02",
	},
}

Config.SinglyLocations = {
    {Location = "Loc1"},
    {Location = "Loc2"},
    {Location = "Loc3"},
    {Location = "Loc4"},
    {Location = "Loc5"},
    {Location = "Loc6"},
    {Location = "Loc7"},
    {Location = "Loc8"},
    {Location = "Loc9"},
    {Location = "Loc10"},
    {Location = "Loc11"},
    {Location = "Loc12"},
    {Location = "Loc13"},
    {Location = "Loc14"},
    {Location = "Loc15"},
    {Location = "Loc16"},
    {Location = "Loc17"},
    {Location = "Loc18"},
    {Location = "Loc19"},
    {Location = "Loc20"},
}

Config.Loc1 = {
    {x = 581.66, 
    y = -2728.68, 
    z = 6.06 - 0.1, 
    h = 189.28,
    gx = 582.23,
    gy = -2723.09,
    gz = 7.19,
    blip,
    ped},
}

Config.Loc2 = {
    {x = 859.23,
    y = -2273.51, 
    z = 30.35 - 0.1, 
    h = 86.60,
    gx = 856.22,
    gy = -2284.15,
    gz = 30.35,
    blip,
    ped},
}

Config.Loc3 = {
    {x = 974.69,
    y = -2366.70, 
    z = 30.52 - 0.1, 
    h = 177.90,
    gx = 975.64,
    gy = -2358.18,
    gz = 31.82,
    blip,
    ped},
}

Config.Loc4 = {
    {x = 1078.17,
    y = -1967.82, 
    z = 31.01 - 0.1, 
    h = 63.56,
    gx = 1083.57,
    gy = -1974.09,
    gz = 31.01,
    blip,
    ped},
}

Config.Loc5 = {
    {x = 1411.30,
    y = -2048.84, 
    z = 52.00 - 0.1, 
    h = 173.76,
    gx = 1414.01,
    gy = -2042.01,
    gz = 52.00,
    blip,
    ped},
}

Config.Loc6 = {
    {x = 138.77,
    y = -1333.59, 
    z = 29.20 - 0.1, 
    h = 310.05,
    gx = 138.62,
    gy = -1348.53,
    gz = 29.20,
    blip,
    ped},
}

Config.Loc7 = {
    {x = 43.51,
    y = -1447.94, 
    z = 29.31 - 0.1, 
    h = 47.66,
    gx = 49.98,
    gy = -1453.60,
    gz = 29.31,
    blip,
    ped},
}

Config.Loc8 = {
    {x = -31.08,
    y = -1497.87, 
    z = 30.55 - 0.1, 
    h = 141.21,
    gx = -25.38,
    gy = -1491.27,
    gz = 30.36,
    blip,
    ped},
}

Config.Loc9 = {
    {x = -356.80,
    y = -1460.36, 
    z = 29.57 - 0.1, 
    h = 4.09,
    gx = -356.27,
    gy = -1466.82,
    gz = 30.87,
    blip,
    ped},
}

Config.Loc10 = {
    {x = -646.38,
    y = -1222.01, 
    z = 11.20 - 0.1, 
    h = 304.78,
    gx = -643.12,
    gy = -1227.65,
    gz = 11.55,
    blip,
    ped},
}

Config.Loc11 = {
    {x = -1407.18,
    y = -456.70, 
    z = 34.48 - 0.1, 
    h = 210.40,
    gx = -1402.51,
    gy = -452.20,
    gz = 34.48,
    blip,
    ped},
}

Config.Loc12 = {
    {x = -1470.42,
    y = -391.72, 
    z = 38.68 - 0.1, 
    h = 137.57,
    gx = -1467.74,
    gy = -387.50,
    gz = 38.77,
    blip,
    ped},
}

Config.Loc13 = {
    {x = -1560.84,
    y = -412.85, 
    z = 42.38 - 0.1, 
    h = 227.57,
    gx = -1567.30,
    gy = -403.89,
    gz = 42.39,
    blip,
    ped},
}

Config.Loc14 = {
    {x = -1696.27,
    y = -468.86, 
    z = 41.65 - 0.1, 
    h = 239.87,
    gx = -1700.22,
    gy = -474.50,
    gz = 41.65,
    blip,
    ped},
}

Config.Loc15 = {
    {x = -1776.32,
    y = -434.20, 
    z = 42.11 - 0.1, 
    h = 195.12,
    gx = -1778.11,
    gy = -427.52,
    gz = 41.45,
    blip,
    ped},
}

Config.Loc16 = {
    {x = 1923.26,
    y = 3733.66, 
    z = 32.77 - 0.1, 
    h = 25.40,
    gx = 1920.92,
    gy = 3728.55,
    gz = 32.79,
    blip,
    ped},
}

Config.Loc17 = {
    {x = 1781.21,
    y = 3644.36, 
    z = 34.44 - 0.1, 
    h = 296.70,
    gx = 1776.50,
    gy = 3640.95,
    gz = 34.52,
    blip,
    ped},
}

Config.Loc18 = {
    {x = 1442.02,
    y = 3650.48, 
    z = 34.34 - 0.1, 
    h = 221.48,
    gx = 1426.07,
    gy = 3644.88,
    gz = 37.89,
    blip,
    ped},
}

Config.Loc19 = {
    {x = 913.06,
    y = 3588.33, 
    z = 33.34 - 0.1, 
    h = 272.65,
    gx = 905.82,
    gy = 3586.49,
    gz = 33.42,
    blip,
    ped},
}

Config.Loc20 = {
    {x = 1769.44,
    y = 3337.62, 
    z = 41.43 - 0.1, 
    h = 299.44,
    gx = 1776.61,
    gy = 3327.63,
    gz = 41.43,
    blip,
    ped},
}

Config.WholesaleLocations = {
	{Location = "Docks"},
    {Location = "East Vinewood"},
    {Location = "Sandy Shores"},
    {Location = "Paleto Bay"},
}

Config.Docks = {
    {x = 1216.20, 
    y = -2990.94, 
    z = 5.68, 
    h = 89.91, 
    ped, 
    blip, 
    PedPosX = 1230.93, 
    PedPosY = -3002.17, 
    PedPosZ = 9.32, 
    PedPosH = 89.06,
    PedGoX = 1222.13,
    PedGoY = -2990.95,
    PedGoZ = 5.87,
    PedGoH = 85.69},
}

Config.EastVinewood = {
    {x = 601.46, 
    y = -454.80, 
    z = 24.56, 
    h = 355.60, 
    ped, 
    blip, 
    PedPosX = 608.72, 
    PedPosY = -459.64, 
    PedPosZ = 24.74, 
    PedPosH = 168.34,
    PedGoX = 604.93,
    PedGoY = -459.78,
    PedGoZ = 24.74,
    PedGoH = 39.70},
}

Config.SandyShores = {
    {x = 1354.00, 
    y = 3619.38, 
    z = 34.61, 
    h = 109.01, 
    ped, 
    blip, 
    PedPosX = 1363.69, 
    PedPosY = 3616.45, 
    PedPosZ = 34.89, 
    PedPosH = 22.83,
    PedGoX = 1359.42,
    PedGoY = 3621.19,
    PedGoZ = 34.81,
    PedGoH = 101.93},
}

Config.PaletoBay = {
    {x = -22.33, 
    y = 6457.40, 
    z = 31.20, 
    h = 223.36, 
    ped, 
    blip, 
    PedPosX = -29.62, 
    PedPosY = 6457.64, 
    PedPosZ = 31.46, 
    PedPosH = 221.25,
    PedGoX = -26.41,
    PedGoY = 6461.58,
    PedGoZ = 31.45,
    PedGoH = 220.46},
}