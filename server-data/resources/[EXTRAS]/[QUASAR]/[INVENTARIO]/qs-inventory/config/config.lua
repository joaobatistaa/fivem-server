Config = Config or {}
Locales = Locales or {}

--[[ 
    The first thing will be to choose our main language, here you can choose 
    between the default languages that you will find within locales/*, 
    if yours is not there, feel free to create it!
]]

Config.Language = 'pt'
Config.Framework = 'esx' -- Set 'qb' or 'esx'

--[[  
    General configuration of the resource!
    Configure each part as you wish.

    Target systems pre-configured by default:
        'qb-target'
		'ox_target'
]]

Config.UseTarget = false -- Set the target system or false (For example 'qb-target' or 'ox_target')

Config.InventoryWeight = { -- Configuration of maximum weight and maximum slots of the player
    ['weight'] = 200000,
    ['slots'] = 55, -- If you want to remove the 6 slot, use 40 here!
}

Config.LabelChange = true -- Enable or disable this function here
Config.LabelChangePrice = false -- Set prince or false
Config.BlockedLabelChangeItems = {
    ['money'] = true,
    ['phone'] = true,
}

Config.Handsup = true -- Enable or disable Handsup and Robbery button
Config.Clothing = true -- Enable or disable clothing system, this will disable the button too
Config.WeaponsOnVehicle = true -- By enabling this, you disable any weapons inside the vehicle (false consume performance)

Config.DisableHudComponent = false -- Disable components and map in inventory (This could raise the resmon a bit)

Config.ItemDropObject = `prop_money_bag_01`
Config.DropRefreshTime = 15 * 60
Config.MaxDropViewDistance = 15

Config.Genders = { -- You can ignore this
    ['m'] = 'Masculino',
    ['f'] = 'Feminino',
    [1] = 'Masculino',
    [2] = 'Feminino'
}

Config.notStolenItems = {
    ['water'] = true,
    ['bread'] = true,
    ['sandwich'] = true
}

Config.notStoredStashItems = {
    ['backpack'] = true,
}

--[[  
    Visual configuration of the resource!
    Here you can configure the animation to open the inventory, 
    the logo or even the icons within the item information.

    InventoryOptions are the boxes that you see on the sides of the 
    inventory, enable or disable them as you want.

    Regarding the genres of Default config, it is for clothes, 
    configure it as you wish, if you have custom clothes, you should 
    touch that configuration a lot.
]]

Config.OpenInventoryAnim = true
Config.Logo = 'https://cdn.discordapp.com/attachments/582219191587962891/1093945141112348833/worldtugarp-bg.png' -- or 'https://i.imgur.com/xfcHKW6.png'

Config.InventoryOptions = {
    -- Generic menu
    ["clothes"] = Config.Clothing,
    ["configuration"] = true,
    -- Left menu
    ["health"] = true,
    ["armor"] = true,
    ["hunger"] = true,
    ["thirst"] = true,
    -- Right menu
    ["id"] = true,
    ["money"] = true,
    ["bank"] = true,
    ["blackmoney"] = true,
}

-- https://fontawesome.com/
-- In this section we can give custom icons to the info of the items
Config.getItemicons = {
    ["sandwich"] = {
      icon = "fa-solid fa-utensils",
    },
    ["water"] = {
      icon = "fa-solid fa-utensils",
    },
}

-- In case of using custom clothing, modify here
Config.Defaults = {
    ['female'] = {
        torso = 129,
        jeans = 73,
        shoes = 61,
        arms = 15,
        helmet = -1,
        glasses = -1,
        mask = 0,
        tshirt = 15,
        ears = -1,
        bag = 0,
    },
    ['male'] = {
        torso = 203,
        jeans = 75,
        shoes = 73,
        arms = 15,
        helmet = -1,
        glasses = -1,
        mask = 0,
        tshirt = 15,
        ears = -1,
        bag = 0,
    }
}

Config.KeyBinds = { -- They are keymaps, check the docs to know how they work!
    ["inventory"] = 'F2',
    ["hotbar"] = 'TAB',
    ["reload"] = 'R', 
    ["handsup"] = 'X',
}

--[[ 
    Debug mode, you can see all kinds of prints/logs using debug, 
    but it's only for development.
]]

Config.Debug = false -- Do not touch here if you are not a developer