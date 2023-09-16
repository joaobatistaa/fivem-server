--[[ 
    Welcome to the qs-housing configuration!
    To start configuring your new asset, please read carefully
    each step in the documentation that we will attach at the end of this message.

    Each important part of the configuration will be highlighted with a box.
    like this one you are reading now, where I will explain step by step each
    configuration available within this file.

    This is not all, most of the settings, you are free to modify it
    as you wish and adapt it to your framework in the most comfortable way possible.
    The configurable files you will find all inside client/custom/*
    or inside server/custom/*.

    Direct link to the resource documentation, read it before you start:
    https://docs.quasar-store.com/information/welcome
]]

Config = Config or {}
Locales = Locales or {}


--██╗░░██╗░█████╗░██╗░░░██╗░██████╗██╗███╗░░██╗░██████╗░
--██║░░██║██╔══██╗██║░░░██║██╔════╝██║████╗░██║██╔════╝░
--███████║██║░░██║██║░░░██║╚█████╗░██║██╔██╗██║██║░░██╗░
--██╔══██║██║░░██║██║░░░██║░╚═══██╗██║██║╚████║██║░░╚██╗
--██║░░██║╚█████╔╝╚██████╔╝██████╔╝██║██║░╚███║╚██████╔╝
--╚═╝░░╚═╝░╚════╝░░╚═════╝░╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░

--[[ 
    The first thing will be to choose our main language, here you can choose 
    between the default languages that you will find within locales/*, 
    if yours is not there, feel free to create it!
]]

Config.Language = 'pt'

--[[ 
    Framework configuration and scripts of your server!
    In the following configurations you will see the mandatory scripts that
    you should configure in your new housing system, as inventory for the
    stashes, clothing for your wardrobes, synchronization system of
    weather and climate, menu systems, and much more.

    Remember that most of these settings are freely modifiable.
    inside client/custom/* and server/custom/*, but I'll give you the options that
    you have by default:

    Framework:
        'esx'
        'qb'

    MenuType: 
        'esx_menu_default'
        'nh-context'
        'ox_lib' -- NEED UNCOMMENT IN FXMANIFEST THE EXPORT
        'qb-menu'
        'esx_context'
    
    Inventory:
        'esx_inventory'
        'qs-inventory'
        'qb-inventory'
        'ox_inventory'
		'mf-inventory'
        'cheeza_inventory'
        'core_inventory'
    
    Wardrobe:
        'esx_skin',
        'qb-clothing'
        'raid_clothes'
        'rcore_clothes'
        'ak47_clothing'
        'illenium-appearance'
		'fivem-appearance'

    Garage:
        'cd_garage'
        'okokGarage'
        'jg-advancedgarages'
        'qb-garages'
        'qs-garages'
        'rcore_garage'
		'zerio-garage'

    Logout:
        'qb-multicharacter'
        'esx_multicharacter'
        'drop'

    Weather:
        'cd_easytime'
        'vSync'
        'qb-weathersync'

    HelpNotification:
        'ShowHelpNotification'
        'DrawText3D'

    The qs-garages and qb-garages options are not editable, so they are selectable but not editable.
    Remember that you can modify them and even create more yourself.
	
	In case of using 'ox_lib', you must enable it in the first lines of fxmanifest.lua, it is marked there!
]]

Config.Framework = 'esx'

Config.MenuType = 'esx_menu_default'
Config.Inventory = 'qs-inventory'
Config.Wardrobe = 'esx_skin'
Config.Garage = 'cd_garage'
Config.Logout = 'drop'
Config.Weather = 'qb-weathersync'
Config.HelpNotification = 'DrawText3D'


--[[ 
    Basic configuration of your new housing!
    Next you will see the basic configurations that will allow you
    control most of the basic functionalities of the resource.

    The configurables that do not have a comment, you can read the name of
    their title to see what they do, some are pretty obvious and not
    you need to give it a description.
]]

Config.Plants = true -- Enable weed plants?
Config.PlantsLimit = 15 -- Limit plants
Config.HarvestTime = 3 -- Setting it by hours (1 = 60 minutes)
Config.HarvestItem = 'empty_weed_bag' -- Require item for harvestItem
Config.HarvestAmountWeed = math.random(12, 16) -- Amount of weed that will give you
Config.HarversAmountSeeds = { -- Quantity of seeds that dates you depending on the gender
    male = math.random(1, 5),
    female = math.random(3, 8),
}
Config.WeedArea = {}

Config.RemoveRain = true
Config.HideMapDecorateMode = true
Config.SetEntityVisible = true -- Be invisible inside decorate mode?
Config.DecorateDistance = 100 -- Distance you can fly decorating.

Config.LimitOfKeys = 5 -- Limit of keys that can be owned by house.
Config.LimitOfHouses = 15 -- Limit of houses for each player.

Config.ShowAvailableHouses = true --If you desactivate this function, the available houses will not appear.
Config.ShowNameOfAllHouses = true -- Show the name of all the houses as blips
Config.Blips = {
    ["SetBlipSprite"] = 40,
    ["SetBlipDisplay"] = 4,
    ["SetBlipScale"] = 0.45,
    ["SetBlipAsShortRange"] = true,
    ["SetBlipColour"] = 0,
    ["SetBlipColourNotOwner"] = 55,
    ["SetBlipColourOwner"] = 3,
}


--[[ 
    Now let's set up our real estate job system!
    As you well know, qs-housing is a system of real estate agents that 
    will create houses for sale within your server.
    Here you will have the complete working configuration, where you can
    configure whether to access the work menu, or even keys to open
    this menu, if you want to remove options from the menu or more.
	
	Please read each setting carefully.
]]

Config.RealEstateMenu = true -- Enable keybind of Config.KeyHouseMenuRealEstate, if need changes go to client/modules/commands.lua
Config.EnableBossMenu = true
Config.EnableDeleteHousesRealEstate = true
Config.KeyHouseMenuRealEstate = "F6"
Config.HousingTypes = { mlo = true, shell = true, ipl = true }
Config.Realestatejob = {
    ['remax'] = true,
    --['job'] = true,
   --['job'] = true,
}

--[[ 
    On the societies, you can choose between the following options or false:

    Society:
        'esx_society'
        'qb-management'
        'ap-government' 
]]
Config.Society = 'esx_society'  -- or "Society" options.
Config.SocietyPorcentage = 100
Config.PercentageForSell = 25
Config.Taxes = { AgencyFee = 5, BankFee = 10, TaxesFee = 6 }


--[[ 
    Advanced configurations of your housing!
    You are doing very well, let's continue with the more advanced configuration
    that will allow you to control the most internal part of your housing.

    Here you will have the mortgage configuration, which has some
    points to clarify before continuing...
    First of all, you can't make it charge for long, just
    charging is allowed within the session, if you restart your server, this count
    of time will start from the beginning, make sure you don't use tenses
    long if you know you will restart your server frequently.

    The rest is about permits for players to sell their houses or
    about the menu inside the house.
]]

Config.Decimals = false
Config.EnableCredit = false -- Enable or disable mortgages
Config.CreditEq = 0.3 -- Percentage to pay
Config.CreditTime = 1 -- Time between payments, put only the hours

Config.SellFurniture = 25 -- % This is the % to sell Furniture
Config.SellHouse = true -- House sell option?
Config.PercentageSell = 50
Config.WordToSell = 'vender'

Config.KeyHouseMenuMlo = "F5" -- Key to open the housing menu in MLO
Config.MenuOptions = {
    camera = true,
    invite = true,
    givehousekey = true,
    removehousekey = true,
    toggledoorlock = true,
    decorate = true,
    setwardrobe = true,
    setstash = true,
    setcharger = false, -- only for Smartphone
    setlogout = true,
    sellhouse = true,
}


--[[ 
    Configuration of robberies and police!
    This section will allow you to configure everything related
    robberies, raids, or even the police housing system.
    
    For these systems, we will need the scripts:
        'lockpick'
        'skillbar'

    And if you want to modify the dispatch, you can do it from client/custom/dispatch.lua!
]]

Config.PoliceRaidItemAllow = true --Enable or disable the object for the police to raid.
Config.MinimumPoliceGrade = 2 -- Set the minimum grade of the police officer to be able to raid a house
Config.ItemRequired = 'police_stormram' --This is the item needed to initiate the raids.
Config.RamsNeeded = 2 --This will be the number of times you must do the minigame before opening a door.
Config.TimeAutoCloseDoor = 5 -- In minutes

Config.HouseRobbery = false --If you activate this, the players will be able to rob the houses.
Config.RequiredCops = 5 --Minimum number of police officers available to initiate house robberies.
Config.RobberyItem = 'lockpick' --This is the item needed to rob the houses.
Config.LockpickBrokenChance = 80 --You can modify the chance that the item will break, if you place 0, it will never break, if you place 100, it will always break.

Config.PoliceJob = {
    ['police'] = true,
    --['job'] = true,
}

--[[ 
    Command configuration!
    This part is not needed anymore, you could ignore it if you want, 
    but I will attach it here so you can know what are all the commands and their executable events :)
]]

Config.Commands = {
    ['createhouse'] = 'criarcasa', --Event: housing:client:createHouses
    ['addgarage'] = 'adicionargaragem', --Event: housing:client:addGarage
    ['setpolyzone'] = 'definirpolyzone', --Event: housing:client:setPolyZone
    ['givehousekey'] = 'darchavecasa', --Event: housing:client:giveHouseKey
    ['removehousekey'] = 'removerchavecasa', --Event: housing:client:removeHouseKey
    ['toggledoorlock'] = 'fecharportacasa', --Event: housing:client:toggleDoorlock
    ['decorate'] = 'decorar', --Event: housing:client:decorate
    ['setwardrobe'] = 'definirguardaroupa', --Event: housing:client:setLocation
    ['setstash'] = 'definircofre', --Event: housing:client:setLocation
    ['setchargespot'] = 'definircarregador', --Event: housing:client:setLocation
    ['setlogout'] = 'definirlogout', --Event: housing:client:setLocation
    ['ring'] = 'campainha', --Event: housing:client:requestRing
    ['deletehouse'] = 'apagarcasa', --Event: housing:client:deleteHouse
    ['changetype'] = 'alterartipocasa', -- ChangeTypeMenu()
    ['checkhouse'] = 'vercasa', -- Server Callback housing:server:getCreditState
    ['housemenu'] = 'menucasa', -- OpenHouseMenu()
	['housingfix'] = 'housingfix', -- Interan command
}

Config.HelpText = {
    ['addgarage'] = 'Criar uma garagem para a casa mais próxima.',
    ['setpolyzone'] = 'Adicionar uma PolyZone se esta casa não tiver uma.',
    ['givehousekey'] = 'Dar chaves de casa.',
    ['removehousekey'] = 'Remover as chaves de casa.',
    ['toggledoorlock'] = 'Fechar a porta de casa.',
    ['decorate'] = 'Decorar a tua casa.',
    ['setwardrobe'] = 'Criar um guarda-roupa neste local.',
    ['setstash'] = 'Criar um cofre neste local.',
    ['setchargespot'] = 'Criar uma tomada para carregar o teu smartphone.',
    ['setlogout'] = 'Criar um ponto de logout neste local.',
    ['deletehouse'] = 'Comando para excluir a casa mais próxima.',
}


--[[ 
    Help notification system!
    Your new housing system has a series of notifications that will provide help during the 
    creation of the house and during its decoration, to make all this more friendly, you will 
    have multiple tips that you can configure.
]]

Config.HomeDecorationTips = {
    title = "Dicas gerais de decoração.",
    content = {
        [1] = {text = "Bem-vindo ao modo de decoração, aqui pode comprar e colocar móveis na sua casa!"},
        [2] = {text = "Lembre-se que todos os seus móveis serão armazenados na caixa."},
        [3] = {text = "Pode selecionar o tipo de móvel na imagem com forma de quarto, logo abaixo."},
        [4] = {text = "Lembre-se que pode armazenar, remover ou mesmo vender os seus móveis na caixa, logo abaixo."},
        [5] = {text = "Lembre-se sempre de verificar o preço dos móveis, pode não conseguir pagar esse luxo hoje!"},
        [6] = {text = "Se precisar de um guia de controles, abra o menu INFORMAÇÃO à direita."},
        [7] = {text = "Agora com o Modo Livre, tudo é mais rápido, pode mover qualquer móvel na sua casa super rápido."},
    }
}
  
Config.SpawnObjectDecorationTips = {
    title = "Dicas de posicionamento de móveis.",
    content = {
        [1] = {text = "Para mover o móvel, tem de manter o clique sobre ele e arrastá-lo pela casa até ao ponto desejado."},
        [2] = {text = "Selecione o móvel com a linha vermelha, mantendo o clique pode mover o móvel por toda a casa!"},
        [3] = {text = "Clique num móvel e arraste-o pela casa, pode também controlar a altura com as teclas de seta do teclado."},
        [4] = {text = "Agora mover móveis é muito mais fácil, basta manter o clique sobre o móvel e arrastá-lo, não se esqueça de gerir a altura com as teclas do teclado!"},
    }
}
  
Config.StashObjectDecorationTips = {
    title = "Dicas para guardar móveis.",
    content = {
        [1] = {text = "O Modo Livre permite mover qualquer móvel em sua casa rapidamente e facilmente. Clique no móvel e arraste-o!"},
        [2] = {text = "Este modo permite mover o móvel rapidamente, basta manter o clique pressionado no móvel e arrastá-lo pela casa."},
        [3] = {text = "Não se esqueça que, para mover o móvel, deve clicar nele e arrastá-lo. Pode também rodar o seu eixo com a roda do rato."},
        [4] = {text = "Bem-vindo ao modo de decoração rápida, conhecido como Modo Livre. Aqui pode personalizar completamente a sua casa de forma fácil e rápida!"},
    }
}
  
Config.FreeModeDecorationTips = {
    title = "Dicas gerais para o modo de decoração livre.",
    content = {
        [1] = {text = "O Modo Livre permite mover qualquer móvel em sua casa rapidamente e facilmente. Clique no móvel e arraste-o!"},
        [2] = {text = "Este modo permite mover o móvel rapidamente, basta manter o clique pressionado no móvel e arrastá-lo pela casa."},
        [3] = {text = "Não se esqueça que, para mover o móvel, deve clicar nele e arrastá-lo. Pode também rodar o seu eixo com a roda do rato."},
        [4] = {text = "Bem-vindo ao modo de decoração rápida, conhecido como Modo Livre. Aqui pode personalizar completamente a sua casa de forma fácil e rápida!"},
    }
}

Config.CreateHousePolyZone = {
    title = "Criação do exterior.",
    content = "Nesta secção devemos criar a zona decorável e exterior, caso contrário, toda a área verde será a casa.",
    error = "Falta adicionar uma zona de visita para que os jogadores possam visitar a casa, no caso de ser um MLO."
}

Config.CreateHouseDoors = {
    title = "Seleção de portas.",
    content = "Escolha a porta principal da casa. Caso tenha duas portas, deverá selecionar ambas. Não pode criar mais do que uma porta neste momento, crie-as com o seu menu de trabalho.",
}

Config.CreateHouseShell = {
    title = "Seleção de interior.",
    content = "Escolha o mapa que deseja para a casa e a sua altura. Recomendamos que fique sempre abaixo do mapa para uma melhor jogabilidade.",
}

Config.CreateHouseIPL = {
    title = "Seleção de interior.",
    content = "Tenha em mente que alguns IPL permitem alterar a cor das paredes e do chão, mas nem todos.",
}


--[[ 
    Debug mode, you can see all kinds of prints/logs using debug, 
    but it's only for development.
]]

Config.Debug = false
Config.Houses = {}