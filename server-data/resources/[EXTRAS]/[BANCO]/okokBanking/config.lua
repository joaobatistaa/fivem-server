Config, Locales = {}, {}

Config.Locale = 'pt' -- en / pt / gr / fr / de

Config.ESX11 = false -- set it to true if you are using ESX 1.1

Config.okokTextUI = true -- true = okokTextUI (I recommend you using this since it is way more optimized than the default ShowHelpNotification) | false = ShowHelpNotification

Config.UseOkOkBankingSounds = true -- true = Uses Sounds | false = No sounds

Config.UseTargetOnAtm = false -- Using ox_target or q-target and not TextUI to access to the atms

Config.UseTargetOnBank = false -- Using ox_target or q-target and not TextUI to access to the bank

Config.TargetBankDistance = 1.5 -- Distance to target a bank from ox_target or q-target ( To change the distance to ATM check line 66)

Config.DebugTargetZones = false -- Set to true only if you need to check the position of a zone

Config.IBANPrefix = "PT50" -- IBAN prefix

Config.IBANNumbers = 6 -- How many characters the IBAN has by default

Config.CustomIBANMaxChars = 10 -- How many characters the IBAN can have when changing it to a custom one (on Settings tab)

Config.CustomIBANAllowLetters = false -- If the custom IBAN can have letters or only numbers (on Settings tab)

Config.IBANChangeCost = 7000 -- How much it costs to change the IBAN to a custom one (on Settings tab)

Config.PINChangeCost = 5000 -- How much it costs to change the PIN (on Settings tab)

Config.AnimTime = 2 -- Seconds (ATM animation)

Config.UseAddonAccount = true -- If true it will use the addon_account_data table | If false the okokbanking_societies table

Config.RequireCreditCardForATM = true -- Set to true if you would like players to access the ATM with a card item | If false there is no item requirement

Config.CreditCardItem = "cartao_credito" -- Required item to access the ATM

Config.CreditCardPrice = 10000 -- How much it costs to purchase a credit card

Config.UseSteamNames = true -- If true it will use steam name | If false, the character name

Config.Societies = { -- Which societies have bank accounts
	"police",
	"ambulance",
	"redline",
	"bahamas",
	"ballas",
	"bombeiros",
	"burgershot",
	"cartel",
	"medusa",
	"grove",
	"juiz",
	"pear",
	"mafia",
	"mechanic",
	"peakyblinders",
	"remax",
	"sheriff",
	"vagos",
	"vanilla",
	"yakuza",	
}

Config.SocietyAccessRanks = { -- Which ranks of the society have access to it
	"boss",
}

Config.ShowBankBlips = true -- True = show bank blips on the map | false = don't show blips

Config.BankLocations = { -- To get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
	{blip = 108, blipColor = 2, blipScale = 0.7, x = 150.266, y = -1040.203, z = 29.374, blipText = "Banco", BankDistance = 3},
	{blip = 108, blipColor = 2, blipScale = 0.7, x = -1212.980, y = -330.841, z = 37.787, blipText = "Banco", BankDistance = 3},
	{blip = 108, blipColor = 2, blipScale = 0.7, x = -2962.582, y = 482.627, z = 15.703, blipText = "Banco", BankDistance = 3},
	{blip = 108, blipColor = 2, blipScale = 0.7, x = -112.202, y = 6469.295, z = 31.626, blipText = "Banco", BankDistance = 3},
	{blip = 108, blipColor = 2, blipScale = 0.7, x = 314.187, y = -278.621, z = 54.170, blipText = "Banco", BankDistance = 3},
	{blip = 108, blipColor = 2, blipScale = 0.7, x = -351.534, y = -49.529, z = 49.042, blipText = "Banco", BankDistance = 3},
	{blip = 108, blipColor = 3, blipScale = 0.7, x = 247.1222, y = 222.4996, z = 106.29, blipText = "Banco Principal", BankDistance = 3},
	{blip = 108, blipColor = 2, blipScale = 0.7, x = 1175.064, y = 2706.643, z = 38.094, blipText = "Banco", BankDistance = 3},
}

Config.ATMDistance = 1.5 -- How close you need to be in order to access the ATM

Config.ATM = { -- ATM models, do not remove any
	{model = -870868698}, 
	{model = -1126237515}, 
	{model = -1364697528}, 
	{model = 506770882}
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 2

Config.BotName = 'Johnny Logs' -- Write the desired bot name

Config.ServerName = 'WorldTugaRP' -- Write your server's name

Config.IconURL = 'https://i.ibb.co/ck8hQ7g/worldtuga.png' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.TransferWebhookColor = '16127'

Config.WithdrawWebhookColor = '16127'

Config.DepositWebhookColor = '16127'

-------------------------- LOCALES (DON'T TOUCH)

function _L(id)
    if Locales[Config.Locale][id] then
        return Locales[Config.Locale][id]
    else
        print("Locale '"..id.."' doesn't exist")
    end
end