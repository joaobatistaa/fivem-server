Config = {}
Config.RefreshTime = 200
Config.InCarRefreshTime = 200

Config.RefreshPlayersCountTime = 5 * 1000

-- Changing these keybindings will take effect on the first player to enter the server. 
-- The old keybind will remain saved for players who have already entered the server, 
-- because the player can customize these keybinds by finding them in settings -> keybind -> fivem.

Config.Sealtbelt = "b"
Config.SpeedLimiter = "g"
Config.SettingsMenu = "j"
Config.SpeedLimitCommand = "cruisecontrol"

Config.ClockType = "24" 
-- PM = 12 hour clock 9.30 PM
-- 24 = 24 hour clock 21.30

Config.KeyBindList = {
    {name = "Radial Menu",  key = "F1"},
    {name = "Inventário",  key = "F2"},
	{name = "Telemóvel",  key = "F3"},
	{name = "Menu Emprego",  key = "F6"},
	{name = "Faturas",  key = "F7"},
	{name = "Menu Veículo",  key = "U"},
	{name = "Alterar Distância Voz",  key = "L"},
	{name = "Cinto",  key = "B"},
    {name = "Chat", key = "T"},
}

Config.Langs = {
    ["belt-plug"]   = "Kemer bağlandı.",
    ["belt-out"]    = "Kemer çıkarıldı.",
    ["limiter-on"]  = "Hız Limiti açık",
    ["limiter-off"] = "Hız Limiti kapalı",
    ["dont-set-limit"] = "Hız limitini /"..Config.SpeedLimitCommand.." den ayarla.",
    ["dont-enter-speed"] = "Limit girmedin Örnek: /limit 100",
    ["limiter-error"] = ""
}

Config.CashItem = false
Config.CashItemName = "cash"

Config.SaltyChat = false
Config.SaltychatRange = { --Look and write the distances here in the satychat config file. The default is as follows. 
    ["4.0"] = { "Sussurrar",  30},
    ["8.0"] = { "Normal",   60},
    ["16.0"] = { "Gritar", 90},
}

Config.PmaRange = {
    { "Sussurrar",  35},
    { "Normal",   65}, 
    { "Gritar", 100}
}

Config.BlackListVehicle = {
    "bmx",
    "cruiser",
    "fixter",
    "scorcher",
    "tribike",
    "tribike2",
    "tribike3",
    "polmav",
    "maverick",
    "dodo",
    "seasparrow",
    "shamal",
    "tula",
    "velum",
    "velum2",
    "volatus",
    "annihilator",
    "buzzard",
    "buzzard2",
    "cargobob",
    "cargobob2",
    "cargobob3",
    "cargobob4",
    "frogger",
    "frogger2",
    "maverick",
    "polmav",
    "supervolito",
    "supervolito2",
    "swift",
    "swift2",
    "valkyrie",
    "valkyrie2",
    "volatus",
    "akula",
    "avenger",
    "avenger2",
    "besra",
    "blimp",
    "blimp2",
    "blimp3",
    "bombushka",
    "cargoplane",
    "cuban800",
    "dodo",
    "duster",
    "howard",
    "jet",
    "lazer",
    "luxor",
    "luxor2",
    "mammatus",
    "microlight",
    "miljet",
    "mogul",
    "molotok",
    "nimbus",
    "nokota",
    "pyro",
    "rogue",
    "seabreeze",
    "shamal",
    "starling",
    "strikeforce",
    "stunt",
    "titan",
    "tula",
    "velum",
    "velum2",
    "vestra",
    "volatol",
    "alphaz1",
    "avenger",
    "avenger2",
}