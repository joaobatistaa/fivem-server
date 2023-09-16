fx_version 'adamant'

game 'gta5'

version '1.0.1'

lua54 'yes'

client_scripts {
    'config/config.lua',
    'config/translations.lua',
    'client/main.lua',
}

server_scripts {
    'config/config.lua',
    'config/translations.lua',
    'server/main.lua',
    'server/check_version.lua',
}

escrow_ignore {
	'config/config.lua',
    'config/translations.lua',
    'server/check_version.lua',
}
dependency '/assetpacks'