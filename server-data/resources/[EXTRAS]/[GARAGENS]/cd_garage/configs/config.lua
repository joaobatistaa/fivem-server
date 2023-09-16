Config = {}
Config.Keys={['ESC']=322,['F1']=288,['F2']=289,['F3']=170,['F5']=166,['F6']=167,['F7']=168,['F8']=169,['F9']=56,['F10']=57,['~']=243,['1']=157,['2']=158,['3']=160,['4']=164,['5']=165,['6']=159,['7']=161,['8']=162,['9']=163,['-']=84,['=']=83,['BACKSPACE']=177,['TAB']=37,['Q']=44,['W']=32,['E']=38,['R']=45,['T']=245,['Y']=246,['U']=303,['P']=199,['[']=39,[']']=40,['ENTER']=18,['CAPS']=137,['A']=34,['S']=8,['D']=9,['F']=23,['G']=47,['H']=74,['K']=311,['L']=182,['LEFTSHIFT']=21,['Z']=20,['X']=73,['C']=26,['V']=0,['B']=29,['N']=249,['M']=244,[',']=82,['.']=81,['LEFTCTRL']=36,['LEFTALT']=19,['SPACE']=22,['RIGHTCTRL']=70,['HOME']=213,['PAGEUP']=10,['PAGEDOWN']=11,['DELETE']=178,['LEFTARROW']=174,['RIGHTARROW']=175,['TOP']=27,['DOWNARROW']=173,['NENTER']=201,['N4']=108,['N5']=60,['N6']=107,['N+']=96,['N-']=97,['N7']=117,['N8']=61,['N9']=118,['UPARROW']=172,['INSERT']=121}
function L(cd) if Locales[Config.Language][cd] then return Locales[Config.Language][cd] else print('Locale is nil ('..cd..')') end end


--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


--WHAT DOES 'auto_detect' DO?
--The 'auto_detect' feature automatically identifies your framework and SQL database resource, and applies the appropriate default settings.

Config.Framework = 'auto_detect' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only ESX and QBCore frameworks will be detected. Use 'other' for custom frameworks.
Config.Database = 'auto_detect' --[ 'auto_detect' ]   If you select 'auto_detect', only MySQL, GHMattimysql, and Oxmysql SQL database resources will be detected.
Config.AutoInsertSQL = false --Would you like the script to insert the necessary SQL tables into your database automatically? If you have already done this, please set it to false.
Config.Notification = 'okokNotify' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only ESX, QBCore, okokNotify, ps-ui and ox_lib notifications will be detected. Use 'other' for custom notification resources.
Config.Language = 'PT' --[ 'EN' / 'CZ' / 'DE' / 'DK' / 'ES' / 'FI' / 'FR' / 'NL' / 'PT' / 'SE' / 'SK' ]   You can add your own locales to locales.lua, but be sure to update the Config.Language to match it.

Config.FrameworkTriggers = {
    esx = { --If you have modified the default event names in the es_extended resource, change them here.
        resource_name = 'es_extended',
        main = 'esx:getSharedObject',
        load = 'esx:playerLoaded',
        job = 'esx:setJob'
    },
    qbcore = { --If you have modified the default event names in the qb-core resource, change them here.
        resource_name = 'qb-core',
        main = 'QBCore:GetObject',
        load = 'QBCore:Client:OnPlayerLoaded',
        job = 'QBCore:Client:OnJobUpdate',
        gang = 'QBCore:Client:OnGangUpdate',
        duty = 'QBCore:Client:SetDuty'
    }
}


--██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝
--██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   
--██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝


Config.PlateFormats = 'with_spaces' --[ 'trimmed' /  'with_spaces' / 'mixed' ] CHOOSE CAREFULLY! Read our documentation website for more info on this if you are unsure! [https://docs.codesign.pro/paid-scripts/garage#step-6-vehicle-plate-format].
Config.UsingOnesync = true --Do you use OneSync legacy/infinity?
Config.IdentifierType = 'steamid' --[ 'steamid' / 'license' ] Choose the identifier type that your server uses.
Config.UseFrameworkDutySystem = false --Do you want to use your frameworks (esx/qbcore) built-in duty system?
Config.Debug = false --To enable debug prints.


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.Keys = {
    QuickChoose_Key = Config.Keys['E'], --The key to open the quick garage (default E).
    EnterGarage_Key = Config.Keys['H'], --The key to open the inside garage (default H).
    StoreVehicle_Key = Config.Keys['K'], --The key to store your vehicle (default G).
    StartHotwire_Key = Config.Keys['E'] --The key to start hotwiring a vehicle (default E).
}

Config.UniqueGarages = false --Do you want to only be able to get your car from the garage you last put it in?
Config.SaveAdvancedVehicleDamage = true --Do you want to save poped tyres, broken doors and broken windows and re-apply them all when spawning a vehicle?
Config.UseExploitProtection = true --Do you want to enable the cheat engine protection to check the vehicle hashes when a vehicle is stored?
Config.ResetGarageState = false --Do you want the in_garage state of all vehicles to be reset when the script starts/restarts?


--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗███████╗    ██████╗  █████╗ ████████╗ █████╗ 
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝██╔════╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗  ███████╗    ██║  ██║███████║   ██║   ███████║
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  ╚════██║    ██║  ██║██╔══██║   ██║   ██╔══██║
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗███████║    ██████╔╝██║  ██║   ██║   ██║  ██║
--  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝


Config.VehiclesData = {
    ENABLE = true, --Do you want to allow the script to grab vehicles data ( ESX: from the 'vehicles' table in the database / QBCORE: from the shared.lua ).
    -- Read our documentation website for more info - https://docs.codesign.pro/paid-scripts/garage#vehicles-data.
    --This will be force enabled (at the bottom of this file) if you use QBCore.

    Vehicledatabase_Tablenames = { --FOR ESX ONLY. The 'vehicles' database table is common in esx servers, but we will repurpose this to store information for us to use on the garage UI's.
        [1] = 'vehicles', --As some people use multiple vehicles tables for donator vehicles, emergency vehicles etc, extra tables are optional for those people.
        --[2] = 'vehicles2',
        --[3] = 'add_more_here',
    },
}

Config.GarageTax = {
    ENABLE = false, --Do you want to enable the vehicle tax system? (each vehicle will be taxed 1 time per server restart).
    method = 'default', --[ 'default' / 'vehicles_data' ] Read below for more info on each on these 2 options.
    default_price = 1000, --If 'default' method is chosen, then it will be a set price to return any vehicle. (eg., $500 fee).
    vehiclesdata_price_multiplier = 1 --If 'vehicles_data' method is chosen, the return vehicle price will be a % of the vehcles value. (eg., 1% of a $50,000 car would be a $500 fee).
}

Config.Return_Vehicle = { --This is the price players pay for their vehicle to be returned to their garage if it has despawned or been blown up.
    ENABLE = true, --Do you want to allow players to return their vehicle if they are destroyed or despawned?
    method = 'default', --[ 'default' / 'vehicles_data' ] Read below for more info on each on these 2 options.
    default_price = 2000, --If 'default' method is chosen, then it will be a set price to return any vehicle. (eg., $500 fee).
    vehiclesdata_price_multiplier = 1 --If 'vehicles_data' method is chosen, the return vehicle price will be a % of the vehcles value. (eg., 1% of a $50,000 car would be a $500 fee).
}


--██╗███╗   ███╗██████╗  ██████╗ ██╗   ██╗███╗   ██╗██████╗ 
--██║████╗ ████║██╔══██╗██╔═══██╗██║   ██║████╗  ██║██╔══██╗
--██║██╔████╔██║██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ██║
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██║   ██║██║╚██╗██║██║  ██║
--██║██║ ╚═╝ ██║██║     ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ 


Config.Impound = {
    ENABLE = true, --Do you want to use the built in impound system?
    chat_command = 'apreender', --Customise the chat command to impound vehicles.

    Authorized_Jobs = { --Only jobs inside this table can impound vehicles or unimpound vehicles.
        ['police'] = true,
        ['mechanic'] = true,
        --['add_more_here'] = true,
    },

    Impound_Fee = { --This is the price players pay for their vehicle to be unimpounded.
        method = 'default', --[ 'default' / 'vehicles_data' ] Read below for more info on each of these 2 options. (Config.VehiclesData.ENABLE must be enabled if you want to use 'vehicles_data').
        default_price = 2000, --If 'default' method is chosen, then it will be a set price to unimpounded any vehicle. (eg., $1000 fee).
        vehiclesdata_price_multiplier = 1 --If 'vehicles_data' method is chosen, the unimpounded vehicle price will be a % of the vehcles value. (eg., 1% of a $50,000 car would be a $500 fee).
    }
}


--████████╗██████╗  █████╗ ███╗   ██╗███████╗███████╗███████╗██████╗     ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗
--╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██╔════╝██╔════╝██╔══██╗    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝
--   ██║   ██████╔╝███████║██╔██╗ ██║███████╗█████╗  █████╗  ██████╔╝    ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  
--   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██╔══╝  ██╔══╝  ██╔══██╗    ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  
--   ██║   ██║  ██║██║  ██║██║ ╚████║███████║██║     ███████╗██║  ██║     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗
--   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝      ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝


Config.TransferVehicle = {
    ENABLE = true, --Do you want to use the built features to transfer vehicles to another player?
    chat_command = 'transferirveiculo', --Customise the chat command to transfer vehicles.

    Transfer_Blacklist = { --Vehicles inside this table will not be able to be transfered to another player. Use the vehicles spawn name. eg., `adder`.
        [`dump`] = true,
        --[`add_more_here`] = true,
    }
}


--████████╗██████╗  █████╗ ███╗   ██╗███████╗███████╗███████╗██████╗      ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗
--╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██╔════╝██╔════╝██╔══██╗    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--   ██║   ██████╔╝███████║██╔██╗ ██║███████╗█████╗  █████╗  ██████╔╝    ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  
--   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██╔══╝  ██╔══╝  ██╔══██╗    ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  
--   ██║   ██║  ██║██║  ██║██║ ╚████║███████║██║     ███████╗██║  ██║    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗
--   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝


Config.TransferGarage = {
    ENABLE = false, --Do you want to allow players to pay for their vehicles to be transferred to another garage?
    transfer_fee = 500 --The cost per vehicle garage transfer ^.
}


--██████╗ ██████╗ ██╗██╗   ██╗ █████╗ ████████╗███████╗     ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗███████╗
--██╔══██╗██╔══██╗██║██║   ██║██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝██╔════╝
--██████╔╝██████╔╝██║██║   ██║███████║   ██║   █████╗      ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  ███████╗
--██╔═══╝ ██╔══██╗██║╚██╗ ██╔╝██╔══██║   ██║   ██╔══╝      ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  ╚════██║
--██║     ██║  ██║██║ ╚████╔╝ ██║  ██║   ██║   ███████╗    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗███████║
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝  ╚═╝   ╚═╝   ╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝


Config.PrivateGarages = {
    ENABLE = true, --Do you want to use the built private garages?
    create_chat_command = 'criargaragemprivada', --Customise the chat command to create a private garage to sell to a player.
    delete_chat_command = 'apagargaragemprivada', --Customise the chat command to delete a players private garage.

    Authorized_Jobs = { --Only jobs inside this table can use the command above.
        ['remax'] = true,
        --['add_more_here'] = true,
    }
}


--██████╗ ██████╗  ██████╗ ██████╗ ███████╗██████╗ ████████╗██╗   ██╗     ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗███████╗
--██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔════╝██╔══██╗╚══██╔══╝╚██╗ ██╔╝    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝██╔════╝
--██████╔╝██████╔╝██║   ██║██████╔╝█████╗  ██████╔╝   ██║    ╚████╔╝     ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  ███████╗
--██╔═══╝ ██╔══██╗██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗   ██║     ╚██╔╝      ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  ╚════██║
--██║     ██║  ██║╚██████╔╝██║     ███████╗██║  ██║   ██║      ██║       ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗███████║
--╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝      ╚═╝        ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝


Config.PropertyGarages = {
    ENABLE = true, --Do you want to use built in property garages?
    only_showcars_inpropertygarage = false --Do you want the inside garage to only show the vehicles which are currently stored in a property garage. (this works for inside garage only, even with this enabled all the cars will show in the outside UI).
}


--███████╗ █████╗ ██╗  ██╗███████╗    ██████╗ ██╗      █████╗ ████████╗███████╗███████╗
--██╔════╝██╔══██╗██║ ██╔╝██╔════╝    ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔════╝
--█████╗  ███████║█████╔╝ █████╗      ██████╔╝██║     ███████║   ██║   █████╗  ███████╗
--██╔══╝  ██╔══██║██╔═██╗ ██╔══╝      ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ╚════██║
--██║     ██║  ██║██║  ██╗███████╗    ██║     ███████╗██║  ██║   ██║   ███████╗███████║
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝


Config.FakePlates = {
    ENABLE = false, --Do you want to use the built in fake plate system?
    item_name = 'fakeplate', --The name of the usable item to add a fake plate.

    RemovePlate = {
        chat_command = 'removefakeplate', --Customise the chat command to remove a fake plate from a vehicle.
        allowed_jobs = {
            ENABLE = false, --Do you want to allow certain jobs to remove a fake plate? (the vehicles owner will always be able to remove plates).
            table = { --The list of jobs who can remove a fake plate.
                ['police'] = true,
                --['add_more_here'] = true,
            }
        }
    }
}


--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗    ██╗  ██╗███████╗██╗   ██╗███████╗
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗      █████╔╝ █████╗   ╚████╔╝ ███████╗
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗    ██║  ██╗███████╗   ██║   ███████║
--  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝


Config.VehicleKeys = {
    ENABLE = false, --Do you want to use the built in vehicle keys system?
    allow_shared_vehicles = false, --If this is enabled, when you give another player a "saved" key to one of your vehicles, it will allow them to spawn your vehicles from their garage.

    Commands = {
        temporary_key = 'givekey', --These keys will be deleted on script/server restart (but keys will save if you relog).
        database_key = 'givekeysave', --These keys will be saved in the database meaning even after script/server restart the player will still have these keys.
        remove_key = 'removekey' --Remove temporary and database keys from a player.
    },

    Hotwire = {
        ENABLE = false, --Do you want players to only be able to drive vehicles they have the keys for?

        --seconds: (1-10) How many seconds it takes for the bar to reach from 1 side to the other. (less is faster).
        --size: (10-100) How wide the target bar is. (100 is widest and easiest to hit).
        --chances: How many chances you have on each action bar. (1 means if you fail the first time it cancels, 2 means if you fail the first and second time it cancels).
        ActionBar = {
            [1] = {seconds = 6, size = 30, chances = 3}, --Choose how many seperate action bars you will need to complete to hotwire a vehicle you do not have keys for.
            [2] = {seconds = 3, size = 20, chances = 2},
            [3] = {seconds = 2, size = 10, chances = 1}, --This is the 3rd action bar.
            --[4] = {seconds = 1, size = 10, chances = 1},
        }
    },

    Lock = {
        ENABLE = false, --Do you want to use the vehicle locking system?
        lock_from_inside = true, --Do you want to also lock the vehicle from the inside when the vehicle is locked? (meaning when the vehicle is locked players can not exit).
        command = 'vehlock', --Customise the chat command.
        key = 'm' --Customise the key.
    },

    Lockpick = {
        ENABLE = false, --Do you want to use the vehicle lockpick system?
        command = { --Do you want players to use a chat command to start lockpicking a vehicle?
            ENABLE = false,
            chat_command = 'lockpick' --Customise the chat command.
        },
        usable_item = { --Do you want players to use a usable item to lockpick a vehicle?
            ENABLE = false,
            item_name = 'lockpick' --The name of the usable item to start lockpicking a vehicle.
        }
    },
}


--███╗   ███╗██╗██╗     ███████╗ █████╗  ██████╗ ███████╗
--████╗ ████║██║██║     ██╔════╝██╔══██╗██╔════╝ ██╔════╝
--██╔████╔██║██║██║     █████╗  ███████║██║  ███╗█████╗  
--██║╚██╔╝██║██║██║     ██╔══╝  ██╔══██║██║   ██║██╔══╝  
--██║ ╚═╝ ██║██║███████╗███████╗██║  ██║╚██████╔╝███████╗
--╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝


Config.Mileage = {
    ENABLE = false, --Do you want to use the built in vehicle mileage system? The higher the miles the lower the vehicles max health will be. (or you can repurpose this for any other use).
    chat_command = 'km', --Customise the chat command to check your vehicles miles and max health.
    mileage_multiplier = 1.0, --If you increase this number it will increase how fast vehicles gain miles. (decrease to lower).
    speed_metrics = 'kilometers', --(miles/kilometers) Choose what you want the mileage to display as.
    show_maxhealth = true --Do you want to show the max health of the vehicle you are in when you use the /checkmiles command?
}


-- ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗    ███████╗██████╗  █████╗  ██████╗███████╗
--██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝    ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
--██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗      ███████╗██████╔╝███████║██║     █████╗  
--██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝      ╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝  
--╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗    ███████║██║     ██║  ██║╚██████╗███████╗
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝


Config.GarageSpace = {
    ENABLE = false, --Do you want to limit the amount of cars each player can hold?
    chat_command_main = 'garagespace', --Customise the chat command to purchase extra garage space.
    chat_command_check = 'checkgaragespace', --Customise the chat command to check how many garage slots you have.

    Garagespace_Table = { --If Config.TransferGarage.ENABLE is enabled, this is the max amount of cars each player can own. To allow people to own more vehicles, add them to the table.
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0,
        [7] = 0,
        [8] = 25000,
        [9] = 50000,
        [10] = 75000,
        --[11] = 100000, --The number 11 would be the 11th garage slot, and the 100000 number would be the price for the 11th garage slot.
    },

    Authorized_Jobs = { --Only jobs inside this table can sell extra garage slots to players.
        ['cardealer'] = true,
        --['add_more_here'] = true,
    }
}


--██████╗ ███████╗██████╗ ███████╗██╗███████╗████████╗███████╗███╗   ██╗████████╗    ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗███████╗
--██╔══██╗██╔════╝██╔══██╗██╔════╝██║██╔════╝╚══██╔══╝██╔════╝████╗  ██║╚══██╔══╝    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝██╔════╝
--██████╔╝█████╗  ██████╔╝███████╗██║███████╗   ██║   █████╗  ██╔██╗ ██║   ██║       ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  ███████╗
--██╔═══╝ ██╔══╝  ██╔══██╗╚════██║██║╚════██║   ██║   ██╔══╝  ██║╚██╗██║   ██║       ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  ╚════██║
--██║     ███████╗██║  ██║███████║██║███████║   ██║   ███████╗██║ ╚████║   ██║        ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗███████║
--╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝   ╚═╝         ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝


Config.PersistentVehicles = { --Requires OneSync to use.
    ENABLE = false --Do you want to use the built-in persistent vehicle feature?
}


--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗███╗   ███╗███████╗███╗   ██╗████████╗
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗      ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║   
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝      ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   


Config.StaffPerms = {
    ['add'] = {
        ENABLE = true, --Do you want to allow staff to add vehicles to a players garage?
        chat_command = 'adicionarveiculo', --Customise the chat commands.
        perms = {
            ['esx'] = {'superadmin', 'admin'}, --You decide which permission groups can use the staff commands.
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    },

    ['delete'] = {
        ENABLE = true, --Do you want to allow staff to delete vehicles from the database?
        chat_command = 'apagarveiculo',
        perms = {
            ['esx'] = {'superadmin', 'admin'},
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    },

    ['plate'] = {
        ENABLE = true, --Do you want to allow staff to change a vehicles plate?
        chat_command = 'trocarmatricula',
        perms = {
            ['esx'] = {'superadmin', 'admin'},
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    },

    ['keys'] = {
        ENABLE = false, --Do you want to allow staff to give theirself keys to a vehicle?
        chat_command = 'chavesveiculo',
        perms = {
            ['esx'] = {'superadmin', 'admin'},
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    }
}


--██╗███╗   ██╗███████╗██╗██████╗ ███████╗     ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗
--██║████╗  ██║██╔════╝██║██╔══██╗██╔════╝    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--██║██╔██╗ ██║███████╗██║██║  ██║█████╗      ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  
--██║██║╚██╗██║╚════██║██║██║  ██║██╔══╝      ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  
--██║██║ ╚████║███████║██║██████╔╝███████╗    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗
--╚═╝╚═╝  ╚═══╝╚══════╝╚═╝╚═════╝ ╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝


Config.InsideGarage = {
    ENABLE = true, --Do you want to allow players to use the inside garage?
    only_showcars_inthisgarage = false, --Do you want the inside garage to only show the vehicles which are currently stored at that garage (eg., garage A).  (this works for inside garage only, even with this enabled all the cars will show in the outside UI).
    shell_z_axis = math.random(10,50), --This is how low under the ground the garage shell will spawn, you could use math.random(10,50) to make it random each time so players dont see each other in their garage.
    shell_time_script = 'easytime', --Choose which time script you are using so we can set the time when you enter the shell. [ 'easytime' / 'vsync' / 'qbcore' / 'other' ].
    engines_on = false, --Do you want the vehicles engine will be turned on when you enter the inside garage?
    lights_on = false, --Do you want the vehicles headlights will be turned on when you enter the inside garage?
    use_spotlight = false, --Do you want the spotlight to shine on the closest vehicle?
    
    Insidegarage_Blacklist = { --Vehicles inside this table will not be spawned inside the garage, this is used for large vehicles that will not fit.
        [`flatbed`] = true,
        --[`add_more_here`] = true,
    },

    Car_Offsets = { --This is the offsets of the vehicles inside the garage.
        ['10cargarage_shell'] = {
            [1] = {x = -4, y = 6.5, z = -99.43, h = 135.00},--1
            [2] = {x = -4, y = 10.8, z = -99.43, h = 135.00},--2
            [3] = {x = -4, y = 15.1, z = -99.43, h = 135.00},--3
            [4] = {x = -4, y = 19.4, z = -99.43, h = 135.00},--4
            [5] = {x = -4, y = 23.7, z = -99.42, h = 135.00},--5

            [6] = {x = -12, y = 23.7, z = -99.43, h = 225.00},--6
            [7] = {x = -12, y = 19.4, z = -99.42, h = 225.00},--7
            [8] = {x = -12, y = 15.1, z = -99.42, h = 225.00},--8
            [9] = {x = -12, y = 10.8, z = -99.43, h = 225.00},--9
            [10] = {x = -12, y = 6.5, z = -99.42, h = 225.00}--10
        },

        ['40cargarage_shell'] = {
            [1] = {x = 7.0, y = -7.0, z = 0, h = 352.0},--1
            [2] = {x = 11.0, y = -8.0, z = 0, h = 352.0},--2
            [3] = {x = 15.0, y = -9.0, z = 0, h = 352.0},--3
            [4] = {x = 19.0, y = -10.0, z = 0, h = 352.0},--4
            [5] = {x = 23.0, y = -11.0, z = 0, h = 352.0},--5
            [6] = {x = 27.0, y = -12.0, z = 0, h = 352.0},--6
            [7] = {x = 31.0, y = -13.0, z = 0, h = 352.0},--7
            [8] = {x = 35.0, y = -14.0, z = 0, h = 352.0},--8
            [9] = {x = 39.0, y = -15.0, z = 0, h = 352.0},--9
            [10] = {x = 43.0, y = -16.0, z = 0, h = 352.0},--10

            [11] = {x = 7.0, y = 5.0, z = 0, h = 162.0},--11
            [12] = {x = 11.0, y = 4.0, z = 0, h = 162.0},--12
            [13] = {x = 15.0, y = 3.0, z = 0, h = 162.0},--13
            [14] = {x = 19.0, y = 2.0, z = 0, h = 162.0},--14
            [15] = {x = 23.0, y = 1.0, z = 0, h = 162.0},--15
            [16] = {x = 27.0, y = 0.0, z = 0, h = 162.0},--16
            [17] = {x = 31.0, y = -1.0, z = 0, h = 162.0},--17
            [18] = {x = 35.0, y = -2.0, z = 0, h = 162.0},--18
            [19] = {x = 39.0, y = -3.0, z = 0, h = 162.0},--19
            [20] = {x = 43.0, y = -4.0, z = 0, h = 162.0},--20

            [21] = {x = -7.0, y = 5.0, z = 0, h = 192.0},--21
            [22] = {x = -11.0, y = 4.0, z = 0, h = 192.0},--22
            [23] = {x = -15.0, y = 3.0, z = 0, h = 192.0},--23
            [24] = {x = -19.0, y = 2.0, z = 0, h = 192.0},--24
            [25] = {x = -23.0, y = 1.0, z = 0, h = 192.0},--25
            [26] = {x = -27.0, y = 0.0, z = 0, h = 192.0},--26
            [27] = {x = -31.0, y = -1.0, z = 0, h = 192.0},--27
            [28] = {x = -35.0, y = -2.0, z = 0, h = 192.0},--28
            [29] = {x = -39.0, y = -3.0, z = 0, h = 192.0},--29
            [30] = {x = -43.0, y = -4.0, z = 0, h = 192.0},--30

            [31] = {x = -7.0, y = -7.0, z = 0, h = 13.0},--31
            [32] = {x = -11.0, y = -8.0, z = 0, h = 13.0},--32
            [33] = {x = -15.0, y = -9.0, z = 0, h = 13.0},--33
            [34] = {x = -19.0, y = -10.0, z = 0, h = 13.0},--34
            [35] = {x = -23.0, y = -11.0, z = 0, h = 13.0},--35
            [36] = {x = -27.0, y = -12.0, z = 0, h = 13.0},--36
            [37] = {x = -31.0, y = -13.0, z = 0, h = 13.0},--37
            [38] = {x = -35.0, y = -14.0, z = 0, h = 13.0},--38
            [39] = {x = -39.0, y = -15.0, z = 0, h = 13.0},--39
            [40] = {x = -43.0, y = -16.0, z = 0, h = 13.0},--40
        }
    }
}


--     ██╗ ██████╗ ██████╗     ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗███████╗
--     ██║██╔═══██╗██╔══██╗    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝██╔════╝
--     ██║██║   ██║██████╔╝    ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  ███████╗
--██   ██║██║   ██║██╔══██╗    ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  ╚════██║
--╚█████╔╝╚██████╔╝██████╔╝     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗███████║
-- ╚════╝  ╚═════╝ ╚═════╝       ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝


Config.JobVehicles = {
    ENABLE = true, --Do you want players with defined jobs (below) to be able to use the garage ui to spawn job vehicles? (if disabled none of the options below will be used).
    choose_liverys = false, --Do you want players to be able to change liverys when they spawn a vehicle at a job garage?
    share_job_keys = false, --Do you want job vehicle keys to be automatically shared with other players with the same job? (requires you to be using the built in cd_garage keys feature).

    Locations = {
        --coords: Where the job garage can be accessed from.
        --spawn_coords: Where the chosen vehicle will spawn.
        --distance: If the player is within the 'distance' of these coords ^, they can open the job garage UI.
        --garage_type: The type of vehicles that can be accessed from this location.
        --method: There are 3 different methods you can use (all 3 are explained below).
        
            --'regular' = This will use the vehicles from the Config.JobVehicles.RegularMethod table below. These are spawned in vehicles and are not owned by anyone.
            --'personalowned' = This will use your personal job vehicles that you have purchased from the cardealer and only you can only access from your job spawn location. Vehicles in your owned_vehicles database table which have job_personalowned set to a players "job name" (not "job label") will be classed as personal owned job vehicles.
            --'societyowned' = This will use society owned vehicles. This will search for your job instead of your steam/license identifier in the owned_vehicles database table and allow you to use all of the vehicles your job owns.
        
        ['police'] = { --If you choose to add more tables here for more jobs, they must be the jobs name, not the label.
            --Cidade
            [1] = {coords = vector3(446.98, -1013.04, 28.54), spawn_coords = vector4(446.97, -1021.19, 28.47, 90.00), distance = 10, garage_type = 'car', method = 'regular'}, --Mission Row PD (cars)
            [2] = {coords = vector3(460.46, -991.17, 43.69), spawn_coords = vector4(450.24, -981.14, 42.691, 90.00), distance = 5, garage_type = 'air', method = 'regular'}, --Mission Row PD (helipad)
            --ilha
            [5] = {coords = vector3(5151.28, -4938.52, 14.20), spawn_coords = vector4(5156.57, -4963.41, 13.81, 229.9), distance = 10, garage_type = 'car', method = 'regular'}, --Paleto PD (cars)
            [6] = {coords = vector3(4361.276, -4562.27, 4.2076), spawn_coords = vector4(4354.340, -4549.88, 4.1844, 100.56425476074), distance = 5, garage_type = 'air', method = 'regular'}, --Paleto PD (helipad)
            --norte
            [7] = {coords = vector3(-461.08, 6014.47, 31.49), spawn_coords = vector4(-463.61, 6019.4, 31.35, 310.6), distance = 10, garage_type = 'car', method = 'regular'}, --Paleto PD (cars)
            [8] = {coords = vector3(1866.04, 3660.41, 33.85), spawn_coords = vector4(1868.62, 3648.09, 35.86, 328.4), distance = 5, garage_type = 'air', method = 'regular'}, --Paleto PD (helipad)
       
			--BOATS
            [9] = {coords = vector3(-775.02, -1500.53, 2.23), spawn_coords = vector4(-792.13, -1500.95, 1.1, 110.5), distance = 20, garage_type = 'boat', method = 'regular'}, --Vespucci Beach (boats)
            [10] = {coords = vector3(-3421.1, 954.17, 8.35), spawn_coords = vector4(-3426.51, 936.88, 1.1, 86.33), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
			[11] = {coords = vector3(-1850.72, -1244.19, 8.62), spawn_coords = vector4(-1870.08, -1256.12, 1.1, 135.41), distance = 20, garage_type = 'boat', method = 'regular'},
			[12] = {coords = vector3(-1611.42, 5255.63, 3.97), spawn_coords = vector4(-1589.01, 5259.24, 1.1, 25.9), distance = 20, garage_type = 'boat', method = 'regular'},
			[13] = {coords = vector3(3857.38, 4459.59, 1.84), spawn_coords = vector4(3874.88, 4461.65, 1.1, 289.9), distance = 20, garage_type = 'boat', method = 'regular'},
			[14] = {coords = vector3(5108.26, -5120.97, 2.03), spawn_coords = vector4(5096.51, -5097.92, 2.0, 0.0), distance = 20, garage_type = 'boat', method = 'regular'},
			[15] = {coords = vector3(23.95, -2799.14, 5.7), spawn_coords = vector4(12.1, -2818.03, 1.1, 174.52), distance = 20, garage_type = 'boat', method = 'regular'},
			
		},
        ['ambulance'] = {
            --PILLBOX HOSPITAL
            [1] = {coords = vector3(299.13, -572.59, 43.26), spawn_coords = vector4(293.4, -575.21, 43.2, 43.2), distance = 10, garage_type = 'car', method = 'regular'}, --Pillbox Hospital (cars)
            [2] = {coords = vector3(342.17, -581.28, 74.17), spawn_coords = vector4(352.3, -588.28, 74.17, 311.55), distance = 10, garage_type = 'air', method = 'regular'}, --Pillbox Hospital (helipad)
		},
    },

    --This will only be used if any of the 'method'(s) in the table above are set to use 'regular' job vehicles.
    RegularMethod = {
        --job: The job name, not job label.
        --spawn_max: Do you want the vehicles to spawn fully upgraded (performance wise)?.
        --plate: The script fills in the rest of the plate characters with random numbers (up to 8 characters max), so for example 'PD' would be 'PD425424'.
        --job_grade: The minimum a players job grade must be to have access to this vehicle.
        --garage_type: What type of vehicle this is ('car' / 'boat', 'air').
        --model: The spawn name of this vehicle. (this is not supposed to be a string, these symbols get the hash key of this vehicle).

        ['police'] = {
            [1] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `psp_ftipo2`},
            [2] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 2, garage_type = 'car', model = `policesu`},
            [3] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `dgrsp_vwcrafter`},
			[4] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 5, garage_type = 'car', model = `pd_dirtbike`},
            [5] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 2, garage_type = 'car', model = `sheriff`},
            [6] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `benson`},
			[7] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 5, garage_type = 'car', model = `wrangler_psp`},
            [8] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 5, garage_type = 'car', model = `MercedesA45Psp`},
            [9] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `mustang19`},
			[10] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 5, garage_type = 'car', model = `psp_bmwgs`},
            [11] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 5, garage_type = 'car', model = `pspt_530d`},
            [12] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 2, garage_type = 'car', model = `police2`},
			[13] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `psp_mbsprinter`},
            [14] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `gnr_ssti`},
            [15] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `ExplorerGOE`},
			[16] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `MercedesGOE`},
            [17] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `BlindadoGOE`},
            [18] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `riot`},
			[19] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 11, garage_type = 'car', model = `nonelsm5`},
            [20] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 12, garage_type = 'car', model = `policer8`},
            [21] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 11, garage_type = 'car', model = `NissanGtrPsp`},
			[22] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 5, garage_type = 'car', model = `FordRaptorPsp`},
			[23] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 9, garage_type = 'car', model = `ghispo2`},
			[24] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 6, garage_type = 'car', model = `18awd`},
			[25] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 15, garage_type = 'car', model = `AmgGtrPsp`},
			[26] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `ngt199`},
			[27] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `pd_gwagon12`},
			[28] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `pd_bmw111`},
			[29] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 8, garage_type = 'car', model = `mustang199`},
			[30] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 2, garage_type = 'car', model = `sheriffx6`},
			

            [31] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 0, garage_type = 'air', model = `heli1psp`},

            [32] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 0, garage_type = 'boat', model = `seashark`},
			[33] = {job = 'police', spawn_max = true, plate = 'PSP'..math.random(100,999), job_grade = 0, garage_type = 'boat', model = `largeboat`},
        },
        ['ambulance'] = {
            [1] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `ambulancec`},
			[2] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `ambulancei`},
			[3] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `anpc_l200`},
			[4] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `emir_vwgolf6`},
			[5] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `fordinem`},
			[6] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `inem_vwcrafter`},
			[7] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `pt_inem4`},
			[8] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `srpcba_kiaceed`},
			[9] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'car', model = `ems_gs1200`},
            [10] = {job = 'ambulance', spawn_max = true, plate = 'INEM'..math.random(100,999), job_grade = 0, garage_type = 'air', model = `heli1inem`},
        },
    }
}


-- ██████╗  █████╗ ███╗   ██╗ ██████╗      ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗███████╗
--██╔════╝ ██╔══██╗████╗  ██║██╔════╝     ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝██╔════╝
--██║  ███╗███████║██╔██╗ ██║██║  ███╗    ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  ███████╗
--██║   ██║██╔══██║██║╚██╗██║██║   ██║    ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  ╚════██║
--╚██████╔╝██║  ██║██║ ╚████║╚██████╔╝    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗███████║


Config.GangGarages = {
    ENABLE = true, --Do you want players in defined gangs to be able to use this specific gang garage?
    not_in_gang_name = 'unemployed', --What's the "gang" name if a player isn't part of a gang? (eg., when a player dosnt have a job, their job name is usually "unemployed"). ("none" is the default on qbcore).

    Blip = { --You can find more info on blips here - https://docs.fivem.net/docs/game-references/blips.
        sprite = 84, --Icon of the blip.
        scale = 0.6, --Size of the blip.
        colour = 22, --Colour of the blip.
        name = L('gang_garage')..': ' --You dont need to change this.
    },

    Locations = {
        --gang: The gang name, not gang label.
        --garage_id: The unique id of the garage (this can not be named same as other normal garages).
        --coords: Where the gang garage can be accessed from.
        --spawn_coords: Where the chosen vehicle will spawn.
        --distance: If the player is within the 'distance' of these coords ^, they can open the gang garage UI.
        --garage_type: The type of vehicles that can be accessed from this location ('car' / 'boat', 'air').

        [1] = {gang = 'ballas', garage_id = 'Ballas', coords = vector3(115.9450, -1949.14, 20.689), spawn_coords = vector4(107.1848, -1940.81, 20.803, 52.16), distance = 5, garage_type = 'car'}, --GROVE STREET
        [2] = {gang = 'grove', garage_id = 'ForumDrive', coords = vector3(-147.197, -1637.24, 33.072), spawn_coords = vector4(-147.139, -1645.73, 32.562, 48.71), distance = 5, garage_type = 'car'},
		[3] = {gang = 'vagos', garage_id = 'Vagos', coords = vector3(318.9968, -2016.08, 20.804), spawn_coords = vector4(312.4554, -2020.57, 20.412, 45.68), distance = 5, garage_type = 'car'},
		[4] = {gang = 'bahamas', garage_id = 'Bahamas', coords = vector3(-1376.91, -588.113, 29.856), spawn_coords = vector4(-1371.20, -581.846, 29.894, 125.9), distance = 5, garage_type = 'car'},
		[5] = {gang = 'vanilla', garage_id = 'Vanilla', coords = vector3(144.37, -1288.3, 29.35), spawn_coords = vector4(146.65, -1279.0, 28.99, 27.38), distance = 5, garage_type = 'car'},
		[6] = {gang = 'mafia', garage_id = 'Máfia', coords = vector3(-1528.58, 81.12, 56.65), spawn_coords = vector4(-1521.94, 90.42, 56.44, 230.77), distance = 5, garage_type = 'car'},
		[7] = {gang = 'peakyblinders', garage_id = 'PeakyBlinders', coords = vector3(-1917.47, 2055.907, 140.73), spawn_coords = vector4(-1914.34, 2044.255, 140.73, 211.23), distance = 5, garage_type = 'car'},
		[8] = {gang = 'cartel', garage_id = 'Cartel', coords = vector3(-3193.77, 819.3123, 8.9308), spawn_coords = vector4(-3197.44, 808.2335, 8.9308, 199.23), distance = 5, garage_type = 'car'},
		[9] = {gang = 'yakuza', garage_id = 'Yakuza', coords = vector3(833.2944, -2341.35, 30.334), spawn_coords = vector4(842.3571, -2335.77, 30.334, 265.25), distance = 5, garage_type = 'car'},
		[10] = {gang = 'redline', garage_id = 'Redline', coords = vector3(-375.043, -119.726, 38.698), spawn_coords = vector4(-375.043, -119.726, 38.698, 127.0765914917), distance = 5, garage_type = 'car'},
		[11] = {gang = 'remax', garage_id = 'Remax', coords = vector3(-111.955, -599.416, 36.280), spawn_coords = vector4(-106.742, -614.774, 36.070, 159.90), distance = 5, garage_type = 'car'},
    },
}


--██████╗ ██╗     ██╗██████╗ ███████╗
--██╔══██╗██║     ██║██╔══██╗██╔════╝
--██████╔╝██║     ██║██████╔╝███████╗
--██╔══██╗██║     ██║██╔═══╝ ╚════██║
--██████╔╝███████╗██║██║     ███████║
--╚═════╝ ╚══════╝╚═╝╚═╝     ╚══════╝


Config.Unique_Blips = true --Do you want each garage to be named by its unique id, for example: 'Garage A'? (If disabled all garages will be called 'Garage').
Config.Blip = { --You can find more info on blips here - https://docs.fivem.net/docs/game-references/blips.
    ['car'] = {
        sprite = 357, --Icon of the blip.
        scale = 0.6, --Size of the blip.
        colour = 3, --Colour of the blip.
        name = L('garage')..' ' --You dont need to change this.
    },

    ['boat'] = {
        sprite = 357,
        scale = 0.6,
        colour = 9,
        name = L('harbor')..' '
    },

    ['air'] = {
        sprite = 357,
        scale = 0.6,
        colour = 50,
        name = L('hangar')..' '
    }
}


-- ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗      ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝      ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

local UIText
if Config.InsideGarage.ENABLE then
    UIText = '<b>'..L('garage')..'</b></p>'..L('open_garage_1')..'</p>'..L('open_garage_2').. '</p>'..L('notif_storevehicle')
else
    UIText = '<b>'..L('garage')..'</b></p>'..L('open_garage_1')
end

Config.Locations = {
    {
        Garage_ID = 'A', --The very first car garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage. You can change the garage id's to what ever you like but make sure to also change the default garage_id in the database.
        Type = 'car', --The type of vehicles which use this garage. ('car'/'boat'/'air').
        Dist = 10, --The distance that you can use this garage.
        x_1 = 215.09, y_1 = -805.17, z_1 = 30.81, --This is the location of the garage, where you press e to open for example.
        EventName1 = 'cd_garage:QuickChoose', --DONT CHANGE THIS.
        EventName2 = 'cd_garage:EnterGarage', --DONT CHANGE THIS.
        Name = UIText, --You dont need to change this.
        x_2 = 212.42, y_2 = -798.77, z_2 = 30.88, h_2 = 336.61, --This is the location where the vehicle spawns.
        EnableBlip = true, --If disabled, this garage blip will not show on the map.
        JobRestricted = nil, --This will allow only players with certain jobs to use this. This is not a job garage, its still a normal garage. (SINGLE JOB EXAMPLE:  JobRestricted = {'police'},  MULTIPLE JOBS EXAMPLE:  JobRestricted = {'police', 'ambulance'}, )
        ShellType = '40cargarage_shell', --[ '10cargarage_shell' / '40cargarage_shell' / nil ] --You can choose the shell which is loaded when you enter the inside garage from this location. If you set it to nil the script will load a shell based on the amount of cars you own.
    },

    
    {
        Garage_ID = 'B', --PINK MOTEL
        Type = 'car',
        Dist = 10,
        x_1 = 273.0, y_1 = -343.85, z_1 = 44.91,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 270.75, y_2 = -340.51, z_2 = 44.92, h_2 = 342.03,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'C', --GROVE
        Type = 'car',
        Dist = 10,
        x_1 = 29.45031, y_1 = -1721.08, z_1 = 29.302,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 29.45031, y_2 = -1721.08, z_2 = 29.302, h_2 = 235.64,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'D', --MIRROR
        Type = 'car',
        Dist = 10,
        x_1 = 1032.84, y_1 = -765.1, z_1 = 58.18,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1023.2, y_2 = -764.27, z_2 = 57.96, h_2 = 319.66,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'E', --BEACH
        Type = 'car',
        Dist = 10,
        x_1 = -1248.69, y_1 = -1425.71, z_1 = 4.32,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1244.27, y_2 = -1422.08, z_2 = 4.32, h_2 = 37.12,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'F', --G O HIGHWAY
        Type = 'car',
        Dist = 10,
        x_1 = -2961.58, y_1 = 375.93, z_1 = 15.02,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -2964.96, y_2 = 372.07, z_2 = 14.78, h_2 = 86.07,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'G', --SANDY WEST
        Type = 'car',
        Dist = 10,
        x_1 = 217.33, y_1 = 2605.65, z_1 = 46.04,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 216.94, y_2 = 2608.44, z_2 = 46.33, h_2 = 14.07,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'H', --SANDY MAIN
        Type = 'car',
        Dist = 10,
        x_1 = 1878.44, y_1 = 3760.1, z_1 = 32.94,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1880.14, y_2 = 3757.73, z_2 = 32.93, h_2 = 215.54,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'I', --VINEWOOD
        Type = 'car',
        Dist = 10,
        x_1 = 365.21, y_1 = 295.65, z_1 = 103.46,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 364.84, y_2 = 289.73, z_2 = 103.42, h_2 = 164.23,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'J', --GRAPESEED
        Type = 'car',
        Dist = 10,
        x_1 = 1713.06, y_1 = 4745.32, z_1 = 41.96,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1710.64, y_2 = 4746.94, z_2 = 41.95, h_2 = 90.11,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

    {
        Garage_ID = 'K', --Redline
        Type = 'car',
        Dist = 10,
        x_1 = 161.48, y_1 = -3237.08, z_1 = 5.9682,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 163.5839, y_2 = -3228.55, z_2 = 5.9301, h_2 = 258.74,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'L', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = 107.32, y_1 = 6611.77, z_1 = 31.98,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 110.84, y_2 = 6607.82, z_2 = 31.86, h_2 = 265.28,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'M', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = 821.04, y_1 = -2120.99, z_1 = 29.327,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 811.6564, y_2 = -2126.17, z_2 = 29.318, h_2 = 81.37,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'N', --PALETO
        Type = 'car',
        Dist = 5,
        x_1 = -1905.38, y_1 = 2004.184, z_1 = 141.84,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1894.79, y_2 = 2002.970, z_2 = 141.78, h_2 = 303.96,
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'O', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = 4515.29, y_1 = -4525.16, z_1 = 4.2072,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 4508.421, y_2 = -4512.32, z_2 = 4.0359, h_2 = 26.277,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'P', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = 4994.585, y_1 = -5187.60, z_1 = 2.5234,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 5004.777, y_2 = -5183.70, z_2 = 2.5169, h_2 = 256.05,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'Q', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = -687.107, y_1 = -1410.74, z_1 = 5.0005,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -697.077, y_2 = -1416.02, z_2 = 5.0005, h_2 = 131.51,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'R', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = -1532.79, y_1 = -438.326, z_1 = 35.442,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1522.41, y_2 = -439.308, z_2 = 35.442, h_2 = 203.66,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'S', --PALETO
        Type = 'car',
        Dist = 20,
        x_1 = -1303.62, y_1 = 260.5162, z_1 = 63.079,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1282.42, y_2 = 262.1699, z_2 = 64.074, h_2 = 283.00,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'T', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = -328.393, y_1 = 281.4529, z_1 = 86.313,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -335.948, y_2 = 274.5233, z_2 = 85.895, h_2 = 181.81,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{
        Garage_ID = 'U', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = 932.4119, y_1 = -95.6134, z_1 = 78.764,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 916.6237, y_2 = -95.5802, z_2 = 78.764, h_2 = 56.24,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

	
	{
        Garage_ID = 'V', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = -2214.55, y_1 = 4245.777, z_1 = 47.398,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -2214.55, y_2 = 4245.777, z_2 = 47.398, h_2 = 56.24,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },

	{	
        Garage_ID = 'W', --Cidade
        Type = 'car',
        Dist = 10,
        x_1 = -141.515, y_1 = -1351.33, z_1 = 29.575,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -141.515, y_2 = -1351.33, z_2 = 29.575, h_2 = 56.24,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{	
        Garage_ID = 'X', --Cidade
        Type = 'car',
        Dist = 10,
        x_1 = 106.99, y_1 = -1073.85, z_1 =  29.192,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 114.32, y_2 = -1071.92, z_2 = 29.192, h_2 = 76.64,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },
	
	{	
        Garage_ID = 'Y', --Cidade
        Type = 'car',
        Dist = 10,
		x_1 = -528.945, y_1 = 48.38592, z_1 = 52.579,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -529.184, y_2 = 49.47007, z_2 = 52.579, h_2 = 316.92,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '40cargarage_shell',
    },


    {   --THIS IS A BOAT GARAGE, YOU CAN REMOVE OR ADD NEW BOAT GARAGES IF YOU WISH.
        Garage_ID = 'A', --The very first boat garage's `garage_id` must be the same as the default value of the garage_id in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'boat',
        Dist = 15,
        x_1 = -806.22, y_1 = -1496.7, z_1 = 1.6,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('harbor')..'</b></p>'..L('open_garage_3'),
        x_2 = -811.54, y_2 = -1509.42, z_2 = -0.47, h_2 = 130.14,
        EnableBlip = true,
        JobRestricted = nil,
    },
	
	{  
        Garage_ID = 'B', --The very first boat garage's `garage_id` must be the same as the default value of the garage_id in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'boat',
        Dist = 15,
        x_1 = 4950.918, y_1 = -5162.23, z_1 = 0,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('harbor')..'</b></p>'..L('open_garage_3'),
        x_2 = 4941.752, y_2 = -5159.06, z_2 = 0, h_2 = 73.35,
        EnableBlip = true,
        JobRestricted = nil,
    },
	
	{  
        Garage_ID = 'C', --The very first boat garage's `garage_id` must be the same as the default value of the garage_id in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'boat',
        Dist = 15,
        x_1 = -1604.62, y_1 = 5257.250, z_1 = 2.0772,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('harbor')..'</b></p>'..L('open_garage_3'),
        x_2 = -1601.04, y_2 = 5259.849, z_2 = 0, h_2 = 9.9,
        EnableBlip = true,
        JobRestricted = nil,
    },
	
	{  
        Garage_ID = 'D', --The very first boat garage's `garage_id` must be the same as the default value of the garage_id in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'boat',
        Dist = 15,
        x_1 = 3853.343, y_1 = 4459.844, z_1 = 1.8497,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('harbor')..'</b></p>'..L('open_garage_3'),
        x_2 = 3864.349, y_2 = 4454.479, z_2 = 0, h_2 = 260.03,
        EnableBlip = true,
        JobRestricted = nil,
    },

    {   --THIS IS AN AIR GARAGE, YOU CAN REMOVE OR ADD NEW AIR GARAGES IF YOU WISH.
        Garage_ID = 'A', --The very first air garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'air',
        Dist = 20,
        x_1 = -982.55, y_1 = -2993.94, z_1 = 13.95,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = -989.59, y_2 = -3004.93, z_2 = 13.94, h_2 = 58.15,
        EnableBlip = true,
        JobRestricted = nil,
    },
	
	
    {  
        Garage_ID = 'B', --The very first air garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'air',
        Dist = 20,
        x_1 = 4447.30, y_1 = -4486.46, z_1 = 4.2246,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = 4454.009, y_2 = -4503.08, z_2 = 4.1869, h_2 = 105.53,
        EnableBlip = true,
        JobRestricted = nil,
    },
	
	{  
        Garage_ID = 'C', --The very first air garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'air',
        Dist = 20,
        x_1 = -721.518, y_1 = -1472.97, z_1 = 5.0005,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = -724.296, y_2 = -1443.75, z_2 = 5.0005, h_2 = 137.44,
        EnableBlip = true,
        JobRestricted = nil,
    },
	
	{  
        Garage_ID = 'D', --The very first air garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'air',
        Dist = 20,
        x_1 = 1738.754, y_1 = 3285.816, z_1 = 41.124,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = 1731.970, y_2 = 3261.122, z_2 = 41.226, h_2 = 115.38,
        EnableBlip = true,
        JobRestricted = nil,
    },
}


--██╗███╗   ███╗██████╗  ██████╗ ██╗   ██╗███╗   ██╗██████╗     ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██║   ██║████╗  ██║██╔══██╗    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║██╔████╔██║██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██║   ██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║██║ ╚═╝ ██║██║     ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝     ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


Config.ImpoundLocations = { --DO NOT CHANGE THE TABLE IDENTIFIERSs, for example - ['car_2'], if you wish to add more, then name the next one ['car_3']. It must have either 'car'/'boat'/'air' in the name and also be unique.
    ['car_1'] = {
        ImpoundID = 1, --The unique id of the impound.
        coords = {x = 401.28, y = -1631.44, z = 29.29}, --This is the location of the garage, where you press e to open for example.
        spawnpoint = {x = 404.66, y = -1642.03, z = 29.29, h = 225.5}, --This is the location where the vehicle spawns.
        blip = {
            sprite = 357, --Icon of the blip.
            scale = 0.5, --Size of the blip.
            colour = 3, --Colour of the blip.
            name = L('car_city_impound'), --This can be changed in the Locales.
        }
    },

    ['car_2'] = { 
        ImpoundID = 2,
        coords = {x = 1893.48, y = 3713.50, z = 32.77},
        spawnpoint = {x = 1887.123, y = 3710.348, z = 31.92, h = 212.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = L('car_sandy_impound'),
        }
    },

    ['boat_1'] = {
        ImpoundID = 3,
        coords = {x = -848.8, y = -1368.42, z = 1.6},
        spawnpoint = {x = -848.4, y = -1362.8, z = -0.47, h = 113.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = L('boat_impound'),
        }
    },

    ['air_1'] = {
        ImpoundID = 4,
        coords = {x = -956.49, y = -2919.74, z = 13.96},
        spawnpoint = {x = -960.22, y = -2934.4, z = 13.95, h = 153.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = L('air_impound'),
        }
    },
}


-- ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
--██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
--██║   ██║   ██║   ███████║█████╗  ██████╔╝
--██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
--╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
-- ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


function Round(cd) return math.floor(cd+0.5) end
function Trim(cd) return cd:gsub('%s+', '') end

function GetConfig()
    return Config
end

function GetCorrectPlateFormat(plate)
    if Config.PlateFormats == 'trimmed' then
        return Trim(plate)

    elseif Config.PlateFormats == 'with_spaces' then
        return plate

    elseif Config.PlateFormats == 'mixed' then
        return string.gsub(plate, "^%s*(.-)%s*$", "%1")
    end
end


-- █████╗ ██╗   ██╗████████╗ ██████╗     ██████╗ ███████╗████████╗███████╗ ██████╗████████╗
--██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗    ██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝
--███████║██║   ██║   ██║   ██║   ██║    ██║  ██║█████╗     ██║   █████╗  ██║        ██║   
--██╔══██║██║   ██║   ██║   ██║   ██║    ██║  ██║██╔══╝     ██║   ██╔══╝  ██║        ██║   
--██║  ██║╚██████╔╝   ██║   ╚██████╔╝    ██████╔╝███████╗   ██║   ███████╗╚██████╗   ██║   
--╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝     ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝ ╚═════╝   ╚═╝   
        

-----DO NOT TOUCH ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----
if Config.Framework == 'auto_detect' then
    if GetResourceState(Config.FrameworkTriggers.esx.resource_name) == 'started' then
        Config.Framework = 'esx'
    elseif GetResourceState(Config.FrameworkTriggers.qbcore.resource_name) == 'started' then
        Config.Framework = 'qbcore'
    end
    if Config.Framework == 'esx' or Config.Framework == 'qbcore' then
        for c, d in pairs(Config.FrameworkTriggers[Config.Framework]) do
            Config.FrameworkTriggers[c] = d
        end
        Config.FrameworkTriggers.esx, Config.FrameworkTriggers.qbcore = nil, nil
    end
end

if Config.Database == 'auto_detect' then
    if GetResourceState('oxmysql') == 'started' then
        Config.Database = 'oxmysql'
	elseif GetResourceState('mysql-async') == 'started' then
        Config.Database = 'mysql'
    elseif GetResourceState('ghmattimysql') == 'started' then
        Config.Database = 'ghmattimysql'
    end
end

if Config.Notification == 'auto_detect' then
    if GetResourceState('Johnny_Notificacoes') == 'started' then
        Config.Notification = 'okokNotify'
    elseif GetResourceState('ps-ui') == 'started' then
        Config.Notification = 'ps-ui'
    elseif GetResourceState('ox_lib') == 'started' then
        Config.Notification = 'ox_lib'
    else
        Config.Notification = Config.Framework
        if Config.Notification == 'standalone' or Config.Notification == 'vrp' then Config.Notification = 'chat' end
    end
end

if Config.Framework == 'esx' then
    Config.FrameworkSQLtables = {
        vehicle_table = 'owned_vehicles',
        vehicle_identifier = 'owner',
        vehicle_props = 'vehicle',
        users_table = 'users',
        users_identifier = 'identifier',
    }
	Config.VehiclesData.ENABLE = true
elseif Config.Framework == 'qbcore' then
    Config.FrameworkSQLtables = { 
        vehicle_table = 'player_vehicles',
        vehicle_identifier = 'citizenid',
        vehicle_props = 'mods',
        users_table = 'players',
        users_identifier = 'citizenid',
    }
    Config.VehiclesData.ENABLE = true
end

if not Config.VehiclesData.ENABLE then
    Config.Impound.Impound_Fee.method = 'default'
    Config.GarageTax.method = 'default'
    Config.Return_Vehicle.method = 'default'
end
-----DO NOT TOUCH ANYTHING ABOVE THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----