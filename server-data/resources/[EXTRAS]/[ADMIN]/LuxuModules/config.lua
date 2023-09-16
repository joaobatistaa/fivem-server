Config = {}

--[[ Framework ]]
Config.Framework = "esx"                                 -- QBCore = 'qb' | ESX = 'esx'
Config.ESX_Version = 'new'                              -- ESX Legacy = 'new' | Old ESX = 'old'
Config.ESX_GetSharedObjectEvent = 'esx:getSharedObject' -- Event name of ESX GetSharedObject


Config.ShowPlayerIPinStats = true -- Show Player IP in Stats /playerinfo id

--[[ All the money accounts in your server || MYSQL: QB: players/money | ESX: users/accounts ]]
Config.Accounts = { 'money', 'bank', 'black_money' }

--[[ Ace Groups ]]
Config.Permissions = { 'group.user', 'group.admin', 'group.superadmin' }

--[[ WEAPONS AND AMMO ]]
Config.WeaponItem = true -- set to true if weapon is a item in your server, set to false if not. | Usualy, ESX = false, QBCore = true
Config.AmmoItem = true   -- set to true if weapon ammunition is a item in your server, set to false if not. | Usualy, ESX = false, QBCore = true

--✅ Change to true if you have the follwing scripts 👇

--[[ Luxu.gg ]]
Config.LuxuAdmin = true
Config.LuxuCEX = false
Config.LuxuCM = false
Config.LuxuDiscordBot = false


--[[ OX | Overextended ]]
Config.OxInventory = false

--[[ Wasabi ]]
Config.Wasabi_Ambulance = false
Config.Wasabi_CarLock = false

--[[ illenium ]]
Config.illeniumAppearance = false

--[[ Quasar ]]
Config.QuasarInventory = true

--[[ okok ]]
Config.okokNotify = true
