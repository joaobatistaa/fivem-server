Config = {}
Locales = {}

--[[ 
    The first thing will be to choose our main language, here you can choose 
    between the default languages that you will find within locales/*, 
    if yours is not there, feel free to create it!
]]

Config.Language = 'pt'
Config.Framework = 'esx' -- 'esx' or 'qb'

--[[  
    General configuration of the resource!
    Configure each part as you wish.
]]

Config.Progressbar = { -- Progressbar Timer.
    UseArmor = 5000,
    UseHeavyArmor = 5000,
    ResetArmor = 2500
}

Config.SetPedArmour = { -- SetPedArmour Quantity.
    UseArmor = 100,
    UseHeavyArmor = 100,
    ResetArmor = 0
}

Config.ResetArmor = 'colete' -- Command to remove your vest.

--[[  
    Check vest?
]]

Config.VestTexture = false -- Use Vest texture?
Config.CheckVest = { -- Check if the person has a vest, if they have a vest but do not have it equipped, they put it on automatically
    check = false, -- True = Yes || False = No
    time = 30000 -- If check = true How often do you check? in milliseconds, If check = false ignore this
}

Config.Vest = {
    male = {
        ['bproof_1'] = 7,  ['bproof_2'] = 1,
    },
    female = {
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
    },

    maleHeavy = {
        ['bproof_1'] = 27,  ['bproof_2'] = 2,
    },

    femaleHeavy = {
        ['bproof_1'] = 0,  ['bproof_2'] = 0,
    }
}


--[[  
    Editable functions!
]]

function SetVest() -- If VestTexture = true
    SetPedComponentVariation(PlayerPedId(), 9, 7, 1, 0)
end

function SetHeavyVest() -- If VestTexture = true
    SetPedComponentVariation(PlayerPedId(), 9, 2, 1, 0)
end
 
function RemoveVest()
    SetPedComponentVariation(PlayerPedId(), 9, 34, 1, 0)
end


--[[ 
    Debug mode, you can see all kinds of prints/logs using debug, 
    but it's only for development.
]]

Config.Debug = false