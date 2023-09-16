fx_version 'bodacious'
game 'gta5'

shared_script '@es_extended/imports.lua'

server_scripts {
	'server/main.lua',
}

client_script 'client/main.lua'

ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/style.css',
	'html/listener.js'
}

