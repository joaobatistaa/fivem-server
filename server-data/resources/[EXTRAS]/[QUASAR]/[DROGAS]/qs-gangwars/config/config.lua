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


--░██████╗░░█████╗░███╗░░██╗░██████╗░░██╗░░░░░░░██╗░█████╗░██████╗░░██████╗
--██╔════╝░██╔══██╗████╗░██║██╔════╝░░██║░░██╗░░██║██╔══██╗██╔══██╗██╔════╝
--██║░░██╗░███████║██╔██╗██║██║░░██╗░░╚██╗████╗██╔╝███████║██████╔╝╚█████╗░
--██║░░╚██╗██╔══██║██║╚████║██║░░╚██╗░░████╔═████║░██╔══██║██╔══██╗░╚═══██╗
--╚██████╔╝██║░░██║██║░╚███║╚██████╔╝░░╚██╔╝░╚██╔╝░██║░░██║██║░░██║██████╔╝
--░╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░

--[[ 
    The first thing will be to choose our main language, here you can choose 
    between the default languages that you will find within locales/*, 
    if yours is not there, feel free to create it!
]]

Config.Language = 'en' 


--[[  
    Framework configuration and scripts of your server!
    Remember that most of these settings are freely modifiable.
    inside client/custom/* and server/custom/*, but I'll give you the options that
    you have by default:

    Framework:
        'esx'
        'qb'
]]

Config.Framework = 'esx'


--[[  
    Here you have the general configuration!
    The general configuration deals with the timer, 
    available police or things like that, keep in mind that 
    modifying this could affect the role within your server.
]]

Config.ReqPolice = true
Config.ReqPoliceCount = 4 --Minimum police to conquer the zones.
Config.ReqJobPolice = 'police'
Config.RefreshPolice = 30000 -- Ammount of time to check por police count again, higher for more performance, don't use below 1000ms
Config.ProgressBarTimer = true --If you use true, when dominating a zone you can use the progressbar as a counter, if you use false, the classic numbers will appear.


--[[  
    Zone configuration!
    Here you can select the zones available for conquest, remember that 
    you must add the name of the job/gang and then add the color of the zone.

    Each zone will consist of three zones of collectable drugs, if you are 
    the leader of a zone, you will farm twice as much, you will have to 
    configure everything in CircleZones, but please, keep in mind that you 
    cannot add more, so there are only 3 zones.
]]

Config.DropBlipColors = { --Colors: https://docs.fivem.net/docs/game-references/blips/
	['vanilla'] = 8,
	['bahamas'] = 3,
	['grove'] = 2,
	['ballas'] = 27,
	['peakyblinders'] = 76,
	['mafia'] = 40,
	['yakuza'] = 1,
	['cartel'] = 56,
	['vagos'] = 46,
}

Config.CapturedText = { --If you use Config.ProgressBarTimer = false, you can modify here where the letters of the counter will appear.
    horizontal = 0.815,
    vertical = 0.96,
    font = 4,
}

Config.MaxPlayerHeightAboveGround = 30.0
Config.CircleZones = { --Set up the controllable areas and the collectibles within them here.
    WeedField = { --Weed
        coords = vector3(4927.665, -4500.325, 10.60461),
        BlipHeight = 630.0,
        BlipDisplay = 3,
        influence = 100.0,
        BlipHeading = 1100,
        BlipWidth = 630.0,
        maxDistance = 200.0,
        remainingTime = 15,
        radius = 700.0,
        maxSpawn = 150,
        SpawnCoords = {
            vector3(4887.948, -4560.569, 19.98401),
            vector3(4891.364, -4567.212, 19.64062),
            vector3(4899.347, -4562.409, 20.53419),
            vector3(4880.411, -4562.521, 19.46269),
            vector3(4875.552, -4572.836, 18.08289),
            vector3(4876.952, -4584.013, 16.78087),
            vector3(4888.704, -4587.93, 17.32463),
            vector3(4898.375, -4585.765, 18.5451),
            vector3(4882.94, -4592.749, 16.41122),
            vector3(4878.147, -4601.592, 15.31286),
            vector3(4867.233, -4598.437, 15.67893),
            vector3(4859.443, -4590.124, 16.48662),
            vector3(4859.718, -4576.716, 17.50716),
            vector3(4868.551, -4567.171, 18.41126),
            vector3(4865.325, -4576.056, 17.3943),
        },
    },

    CocainaField = { --Cocaine
        coords = vector3(5068.939, -5101.451, 14.58305),
        BlipHeight = 980.0,
        BlipDisplay = 3,
        BlipHeading = 1100,
        influence = 100.0,
        BlipWidth = 595.0,
        maxDistance = 200.0,
        radius = 100.0,
        remainingTime = 15,
        maxSpawn = 50,
        SpawnCoords = {
            vector3(5063.3, -5096.01, 2.21),
            vector3(5051.02, -5090.66, 3.02),
            vector3(5058.97, -5087.57, 2.19),
            vector3(5055.71, -5100.03, 3.11),
            vector3(5060.96, -5101.49, 2.39),
            vector3(5050.07, -5098.41, 4.17),
            vector3(5057.1, -5093.34, 2.33),
            vector3(5069.73, -5094.9, 2.21),
        },
    },

    ChemicalsField = { --Chemicals
        coords = vector3(5234.809, -5708.026, 28.72433),
        BlipHeight = 1150.0,
        BlipDisplay = 3,
        influence = 100.0,
        BlipHeading = 1100,
        BlipWidth = 660.0,
        maxDistance = 200.0,
        radius = 100.0,
        remainingTime = 16,
        maxSpawn = 50,
        SpawnCoords = {
            vector3(5291.577, -5593.988, 61.52751),
            vector3(5296.476, -5599.799, 62.24624),
            vector3(5291.155, -5605.955, 59.78961),
            vector3(5300.022, -5611.059, 62.28185),
            vector3(5307.843, -5620.442, 62.52276),
            vector3(5327.192, -5615.917, 64.68799),
            vector3(5333.126, -5602.287, 64.52621),
            vector3(5324.453, -5600.988, 65.2867),
            vector3(5318.838, -5590.713, 65.1526),
            vector3(5313.901, -5607.046, 64.86407),
            vector3(5308.767, -5587.024, 63.89774),
        },
    }
}


--[[  
    Configure here the drug, the item, the prop or even the amount that it gives 
    you if you own the area or not, do not add more since it will not work and you could break the resource.
]]

Config.Items = { --These are the items, prop and quantity that you can farm.
    weed = {
        itemname = 'weed',
        prop = 'prop_weed_01',
        amount = 1,
        masteramount = 2, --If your gang dominates the area, you will get more.
    },

    cocaine = {
        itemname = 'cocaine',
        prop = 'prop_plant_cane_02b',
        amount = 1,
        masteramount = 2, --If your gang dominates the area, you will get more.
    },

    meth = {
        itemname = 'meth',
        prop = 'prop_barrel_exp_01a',
        amount = 1,
        masteramount = 2, --If your gang dominates the area, you will get more.
    },
}


--[[  
    Airdrop configuration!
    Here you will find all the configuration of the drop, remember 
    that if you use Items instead of Weapons, you must set the 
    Config.Weapons to false. In case of using an inventory without Items 
    as weapons, you should use true.
]]

Config.CooldownMinutes = 180 --After requesting an Airdrop, this will be the cooldown minutes to request another for any player.
Config.PlaneArrivalTimeSecons = 10 --Time it will take for the plane to arrive in seconds.
Config.FlareItem = 'flare_airdrop' --With this object you will call the plane.

Config.ItemCount = 1 -- Quantity of objects that the airdrop box will bring.
Config.ItemsDrop = { --Items that will fall in the airdrop.
	{Item = 'diamond', count = 100},
	{Item = 'armor', count = 10},
	{Item = 'black_money', count = 200000},
	{Item = 'weapon_minismg', count = 1},
	{Item = 'weapon_pistol', count = 1},
	{Item = 'weapon_revolver', count = 1},
	{Item = 'weapon_microsmg', count = 1},
	{Item = 'weapon_assaultsmg', count = 1},
	{Item = 'weapon_advancedrifle', count = 1},
	{Item = 'weapon_snspistol', count = 1},
	{Item = 'weapon_dagger', count = 1},
	{Item = 'weapon_combatpdw', count = 1},
    -- {Item = 'example', count = 1},
}


--[[  
    Leave this false in case of using ox, qb, qs, or inventory that use weapons as an Item.
]]

Config.Weapons = false --If you activate this, you will be able to choose weapons for the drops. If you use Quasar Inventory, leave this false, since weapons are objects.
Config.WeaponChance  =  100 --Chance of a weapon being airdropped.
Config.WeaponsDrop = { --Weapons that will airdrop.
    {weapon = 'weapon_pistol', ammo_count = 10},
    {weapon = 'weapon_revolver', ammo_count = 20},
    {weapon = 'weapon_microsmg', ammo_count = 50},
    -- {weapon = 'example', ammo_count = 120},
}


--[[ 
    Debug mode, you can see all kinds of prints/logs using debug, 
    but it's only for development.
]]

Config.Debug = false