fx_version 'cerulean'

game 'gta5'

lua54 'yes'

version '2.1.0'

shared_scripts {
    'shared/*.lua',
    'config/*.lua',
    'locales/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/custom/framework/*.lua',
    'server/custom/webhook/*.lua',
    'server/*.lua',
    'server/custom/misc/*.lua',
    'server/modules/*.lua'
}

client_script {
    'client/custom/framework/*.lua',
    'client/*.lua',
    'client/custom/misc/*.lua',
    'client/custom/target/*.lua',
    'client/modules/*.lua'
}

ui_page {
    'html/ui.html'
}

files {
    'config/*.js',
    'html/ui.html',
    'html/css/main.css',
    'html/js/*.js',
    'html/js/modules/*.js',
    'html/images/*.png',
    'html/images/*.jpg',
    'html/cloth/*.png',
    'html/*.ttf'
}

escrow_ignore {
    'shared/*.lua',
    'config/*.lua',
    'locales/*.lua',
    'client/custom/framework/*.lua',
    'client/custom/misc/*.lua',
    'client/custom/target/*.lua',
    'server/custom/framework/*.lua',
    'server/custom/webhook/*.lua',
    'server/custom/misc/*.lua'
}

dependencies {
	'/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
	'progressbar' -- Required
}

dependency '/assetpacks'