fx_version "adamant"

game "gta5"

shared_script '@es_extended/imports.lua'

client_script {
	--'@es_extended/locale.lua',
	--'locales/br.lua',
	--'locales/en.lua',
	'client/client.lua',
	'config.lua'
}

server_script {
	--'@es_extended/locale.lua',
	--'locales/br.lua',
	--'locales/en.lua',
	'config.lua',
	'server/server.lua',
	--'server/commands.lua',
	
}

ui_page('html/ui.html')

files {
    'html/ui.html',
    'html/js/script.js',
    'html/css/style.css',
    'html/img/cursor.png',
    'html/img/radio.png'
}

