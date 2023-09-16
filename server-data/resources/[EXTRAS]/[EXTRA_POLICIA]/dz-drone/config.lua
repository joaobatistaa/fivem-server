Config = {}

-- QBCore Framework
Config.Framework = "esx" -- Set you framework "qbcore" or "esx" or "" if you use standalone framework and use /drone 1 or 2 command to use the Drone
Config.QBCoreName = "qb-core" -- You QBCore script name must be correct to work (only if you use QBCore Framework)

-- ESX Framework
Config.IsESXLegacy = true -- Set it true is you're using esx legacy (only if you use ESX Framework)
Config.ESXLegacyName = "es_extended" -- You ESX Legacy script name must be correct to work (only if you use ESX Legacy Framework)
Config.SQL = "oxmysql" -- Set the SQL to "oxmysql" or "mysql-async" depends on what you use on you ESX framework

-- Drone Controls
Config.Controls = { -- FiveM Controls: https://docs.fivem.net/docs/game-references/controls/
	Forward		= 32,	-- W for Qwerty / Z for Azerty
	Backward	= 33,	-- S
	Left		= 34,	-- A for Qwerty / Q for Azerty
	Right		= 35,	-- D
	Up			= 51,	-- E
	Down		= 52,	-- Q for Qwerty / A for Azerty
	Stop		= 22,	-- Space
	ZoomOut		= 16,	-- Mouse Scroll Whell Down
	ZoomIn		= 17,	-- Mouse Scroll Whell Up
	Nightvision	= 140,	-- R
	Heatvision	= 75,	-- F
	Spotlight	= 47,	-- G
	Scanner		= 24,	-- Left Mouse Button
	Cancel		= 200,	-- ESC
}

-- Drone Scanner
Config.ScannerRange = 50.0
Config.ScannerIgnoreMask = false

-- Drone Text Font
Config.TextFont = 4 -- Text font type
Config.TextCustomFont = { -- This option for servers that use custom fonts or other languages - Used Natives: RegisterFontFile(FontName) / RegisterFontId(FontName)
	UseCustomFont = false, -- Set to "true" to enable using custom font
	FontName = '', -- Custom font file name
}

-- Drone Transition
Config.Transition = {
	['direction']       	= 'Direção',
	['height']          	= 'Altura',
	['camera']          	= 'Câmera',
	['zoom']            	= 'Zoom',
	['nightvision']     	= 'Visão Noturna',
	['heatvision']      	= 'Visão Térmica',
	['spotlight']       	= 'Luz',
	['scan_player']     	= 'Scan Jogador',
	['cancel']          	= 'Cancelar',
	['cant_use_drone']  	= 'Não consegues usar o drone',
	
	['scan_searching']  	= 'A procurar...',
	['scan_searching_db']	= 'A procurar na base de dados...',
	['scan_unknown']		= 'Desconhecido',
	['scan_not_recognized']	= 'Não foi possível reconhecer o alvo',
}

-- This two commands are made for servers that want to toggle ON/OFF the Instructional Buttons or Cam Scaleforms - Default is ON
Config.DroneCamScaleforms = "cameradrone"
Config.DroneInstructionalButtons = "instrucoesdrone"
