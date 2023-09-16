fx_version 'adamant'

game 'gta5'

version '2.0.0'

lua54 'yes'

ui_page 'html/index.html'

server_scripts {
    'config/config.lua',
    'config/config_framework.lua',
    'config/translations.lua',
	'server/main.lua',
}

client_scripts {
    'config/config.lua',
    'config/config_framework.lua',
    'config/config_dispatch.lua',
    'config/translations.lua',
	'client/main.lua',
}

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css'
}

escrow_ignore {
    'config/config.lua',
    'config/config_framework.lua',
    'config/config_dispatch.lua',
    'config/translations.lua',
}

dependency '/assetpacks'