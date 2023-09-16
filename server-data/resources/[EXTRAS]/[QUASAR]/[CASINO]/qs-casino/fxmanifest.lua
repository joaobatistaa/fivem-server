fx_version 'adamant'

game "gta5"

version '1.3.5'

lua54 'yes'

--this_is_a_map 'yes'

client_scripts {
    'config/config_car.lua',
    'client/main.lua',
}

server_scripts {
    'config/config_server.lua',
    'server/main.lua',
	'server/version_check.lua',
}

shared_script {
	'config/config.lua',
	'config/translations.lua',
}

escrow_ignore {
	'config/config.lua',
	'config/config_car.lua',
	'config/config_server.lua',
	'config/translations.lua',
    'server/version_check.lua',
}


ui_page('html/UI.html')

files {
    'html/UI.html',
    'html/style.css',
	'html/img/user.png',
	'html/img/phone.png',
	'html/img/clock.png',
	'html/img/receipt.png',
	'html/img/knife.png'
}
dependency '/assetpacks'