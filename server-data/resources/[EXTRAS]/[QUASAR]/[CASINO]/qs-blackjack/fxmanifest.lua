fx_version 'adamant'

game "gta5"

version '1.3.5'

lua54 'yes'

client_scripts {
    'client/functions.lua',
	'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

shared_script {
	'config/config.lua',
	'config/translations.lua',
}

escrow_ignore {
	'config/config.lua',
	'config/translations.lua',
}
dependency '/assetpacks'