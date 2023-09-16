fx_version 'cerulean'
game 'gta5'

author 'Redutzu'
version '2.1.3'
description '✨ A good looking police MDT'
github 'https://github.com/redutzu'

lua54 'yes'

ui_page 'nui/build/index.html'

shared_scripts {
    'lib/shared.lua',
    'config.lua'
}

client_scripts {
    'lib/client.lua',
    'client/config.lua',
    'client/functions.lua',
    'client/main.lua',
    'client/modules/alerts.lua',
    'client/modules/chat.lua',
    'client/modules/camera.lua',
    'client/modules/mugshot.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@mysql-async/lib/MySQL.lua',
    'lib/server.lua',
    'server/modules/phone.lua',
    'server/modules/housing.lua',
    'server/config.lua',
    'server/functions.lua',
    'server/main.lua',
    'server/events.lua',
    'server/modules/alerts.lua',
    'server/modules/chat.lua',
    'server/modules/citizens.lua'
}

escrow_ignore {
    'config.lua',
    'server/config.lua',
    'client/config.lua',
    'stream/*'
}

data_file 'DLC_ITYP_REQUEST' 'stream/vpad_prop_1.ytyp'

files {
    'nui/build/static/css/**',
    'nui/build/static/js/**',
    'nui/build/static/media/**',
    'nui/build/**'
}

dependencies {
    '/assetpacks',
    --'screenshot-basic',
    'oxmysql',
    'es_extended'
}

dependency '/assetpacks'