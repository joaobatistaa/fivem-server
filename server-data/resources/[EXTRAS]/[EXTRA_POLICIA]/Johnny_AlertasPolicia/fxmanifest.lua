fx_version 'adamant'

game 'gta5'

shared_script '@es_extended/imports.lua'

files {
    'client/dist/index.html',
    'client/dist/js/app.js',
    'client/dist/css/app.css',
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',

}

ui_page 'client/dist/index.html'



