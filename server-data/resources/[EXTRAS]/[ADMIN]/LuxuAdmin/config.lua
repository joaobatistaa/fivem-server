if type(Config) ~= 'table' then
      Config = {}
end

Config.Locale = 'pt'               -- Language of the bot | Locales folder

Config.BanCheckerDelay = 60 * 1000 -- ms |  Delay for the ban checker

--[[  Date format ]]
Config.DateLocale = {
      locale = 'pt-PT', --[[ Locale| Find yours: https://gist.github.com/jacobbubu/1836273 ]]
      options = {
            weekday = "long",
            year = "numeric",
            month = "long",
            day = "2-digit",
            hour = "2-digit",
            minute = "2-digit",
      } --[[ Delete options you dont want, https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat#options ]]
}

Config.PersistentProps = true    -- Set to false to disable persistent props

Config.OneReportPerPlayer = true -- If set to true, players can only have one report active at a time

Config.LuxuDiscordBot = {
      enabled = false,
      resourceName = 'luxudiscord'
} -- Luxu Discord Bot

Config.Commands = {
      ["AdminMenu"] = {
            name = 'luxuadmin',
            key = 'RSHIFT',
      },
      ["Report"] = {
            name = false,
            key = false,
      },
      ["Noclip"] = {
            name = 'noclip',
            key = false,
      },
      ["TPM"] = {
            name = 'luxutpm',
            key = 'DELETE',
      },
      ["Vector3"] = {
            name = 'vector3',
            key = false,
      },
      ["Vector4"] = {
            name = 'vector4',
            key = false,
      }
}


Config.Menus = {
      ['Reports'] = {
            enabled = false,
      },
      ['Banned'] = {
            enabled = true,
      }
}

Config.DiscordLogs = {
      enabled = true,
      bypass = { 'license:232432424', "discord:424242424", } -- users that will not be logged
}


Config.DisableNotifyLogs = true              -- If set to true will no longer print notifications in console.

Config.WarningStrikes = 3                     -- How many warnings until ban
Config.WarningBanTimeout = 24                 -- How many hours the warning ban should be
Config.WarnBanReason = "Alcançaste os 3 avisos e levaste um BAN de 1 dia" -- Reason for the warning ban

--[[ Notification Position - Interface only ]]
Config.NotifyX = 'start' -- start | center | end
Config.NotifyY = 'top' -- top | middle | bottom


--[[ PERMISSIONS ]]
Config.IdentifiersAlwaysAllowed = {'license:208387e21f51f6a316ec6170385894d348cb5496', 'license:8b9db3619ba93332f84c30bde1075514383086e8', 'license:7f09cec9b4b5c2200bb72e7eaf77d3fcd0a1f979', 'license:01c52d90d8022b907a1583ce2bd9f65c5787c693', 'license:e5b01bb57b054f2373d377050013aecb3e499156', 'license:6ba52cda982222da3b8f75ad93017348a9f4898c' } -- Identifiers that can always use the panel with ALL permissions (license,fivem,discord)

-- All the ace groups in your server

Config.TeleportEffect = {
      enable = true, -- Set to false to disable teleport effect
      effectLibrary = "scr_rcbarry1",
      effectName = "scr_alien_teleport",
      delay = 5000
}
