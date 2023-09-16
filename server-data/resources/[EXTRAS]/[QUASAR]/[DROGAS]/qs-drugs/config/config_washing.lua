
--░██╗░░░░░░░██╗░█████╗░░██████╗██╗░░██╗██╗███╗░░██╗░██████╗░
--░██║░░██╗░░██║██╔══██╗██╔════╝██║░░██║██║████╗░██║██╔════╝░
--░╚██╗████╗██╔╝███████║╚█████╗░███████║██║██╔██╗██║██║░░██╗░
--░░████╔═████║░██╔══██║░╚═══██╗██╔══██║██║██║╚████║██║░░╚██╗
--░░╚██╔╝░╚██╔╝░██║░░██║██████╔╝██║░░██║██║██║░╚███║╚██████╔╝
--░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░

Config.CustomPorcentaje = true -- If this is true, the end of the process will give you the porce
Config.FinalWashMoneyPercentage = 100

Config.WashingEntryDistance = 3
Config.WashingExitDistance = 5

Config.QBCoreMarkedBills = false -- Use the metadata of QBCore markedbills?
-- If you use a MarkedBills change the config count = 1 | isItem = true | requiereItem = 'markedbills'

Config.Laundry = {
    entry = {
        coord = vector3(132.1414, -730.646, 42.152),
        intcoord = vector3(1138.0, -3198.96, -39.68),
        intheading = 11.64,
        text = "~b~E~w~ - Entrar",
    },
    exit = {
        intcoord = vector3(1138.0, -3198.96, -39.68),
        coord = vector3(132.1414, -730.646, 42.152),
        heading = 46.85,
        text = "~b~E~w~ - Sair",
    },
    cuttingZone = {
        coords = vector3(1122.24, -3197.88, -40.4), 
        heading = 179.46,
        text = "~b~E~w~ - Cortar Dinheiro",
        progText = "A cortar dinheiro...",
        count = 50000,
        isItem = false, -- requiresItem is an item? Yes = true | No = False for accountmoney 
        requireItem = 'black_money',
        rewardItem = 'sorted_money',
    },
    packageZone = {
        coord = vector3(1120.12, -3197.88, -39.92), 
        heading = 180.93,
        text = "~b~E~w~ - Empacotar Dinheiro", 
        progText = "A empacotar dinheiro...",
        requireItem = 'sorted_money',
        rewardItem = 'package_money',
    },
    washingZone = {
        coord = vector3(1122.32, -3194.6, -40.4), 
        heading = 346.76,
        text = "~b~E~w~ - Lavar Dinheiro", 
        progText = "A lavar dinheiro...",
        requireItem = 'package_money',
        isItem = false, -- give item? Yes = true | No = False for accountmoney 
        rewardItem = "money"
    }
}
