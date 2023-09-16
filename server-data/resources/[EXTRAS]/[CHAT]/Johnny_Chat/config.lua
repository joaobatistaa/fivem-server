Config = {}
--------------------------------
-- [Date Format]

Config.DateFormat = '%H:%M' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- [Staff Groups]

Config.StaffGroups = {
	'superadmin',
	'admin',
	'mod'
}

--------------------------------
-- [Clear Player Chat]

Config.AllowPlayersToClearTheirChat = true

Config.ClearChatCommand = 'clear'

--------------------------------
-- [Staff]

Config.EnableStaffCommand = true

Config.StaffCommand = 'staff'

Config.AllowStaffsToClearEveryonesChat = true

Config.ClearEveryonesChatCommand = 'clearchat'

-- [Staff Only Chat]

Config.EnableStaffOnlyCommand = true

Config.StaffOnlyCommand = 'sc'

--------------------------------
-- [Advertisements]

Config.EnableAdvertisementCommand = false

Config.AdvertisementCommand = 'publicidade'

Config.AdvertisementPrice = 5000

Config.AdvertisementCooldown = 5 -- in minutes

--------------------------------
-- [Twitch]

Config.EnableTwitchCommand = true

Config.TwitchCommand = 'streamer'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.TwitchList = {
	--'steam:110000115708986' -- Johnny
	'steam:110000118a12j8a' -- Jesus
}

--------------------------------
-- [Youtube]

Config.EnableYoutubeCommand = false

Config.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.YoutubeList = {
	--'steam:110000115708986' -- Johnny
	'steam:110000118a12j8a' -- Jesus
}

--------------------------------
-- [Twitter]

Config.EnableTwitterCommand = false

Config.TwitterCommand = 'twitter'

--------------------------------
-- [Police]

Config.EnablePoliceCommand = true

Config.PoliceCommand = 'policia'

Config.PoliceJobName = 'police'

--------------------------------
-- [Ambulance]

Config.EnableAmbulanceCommand = true

Config.AmbulanceCommand = 'inem'

Config.AmbulanceJobName = 'ambulance'

--------------------------------
-- [Mechanic]

Config.EnableMechanicCommand = true

Config.MechanicCommand = 'mecanicos'

Config.MechanicJobName = 'mechanic'

--------------------------------
-- [Redline]

Config.EnableRedlineCommand = true

Config.RedlineCommand = 'redline'

Config.RedlineJobName = 'redline'

--------------------------------
-- [Pearl]

Config.EnablePearCommand = true

Config.PearCommand = 'pearls'

Config.PearJobName = 'pear'

--------------------------------
-- [tribunal]

Config.EnableTribunalCommand = true

Config.TribunalCommand = 'tribunal'

Config.TribunalJobName = 'juiz'


--------------------------------
-- [OOC]

Config.EnableOOCCommand = true

Config.OOCCommand = 'ooc'

Config.OOCDistance = 15.0

--------------------------------