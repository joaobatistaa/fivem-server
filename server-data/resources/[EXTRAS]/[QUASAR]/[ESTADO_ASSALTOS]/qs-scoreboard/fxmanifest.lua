fx_version 'cerulean'

game 'gta5'

version '1.0.3'

lua54 'yes'

ui_page "html/ui.html"

lua54 'yes'

client_scripts {
	'config.lua',
    'client/main.lua',
}

server_scripts {
	'config.lua',
	'server/check_version.lua',
	'server/main.lua',
}

files {
    "html/*"
}

escrow_ignore {
	'config.lua',
	'server/check_version.lua',
}
dependency '/assetpacks'