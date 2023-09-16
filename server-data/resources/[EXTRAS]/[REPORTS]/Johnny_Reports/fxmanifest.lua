fx_version 'adamant'

game 'gta5'

shared_script '@es_extended/imports.lua'

ui_page 'web/ui.html'

files {
	'web/*.*',
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
}

server_scripts {
	'server.lua',
}

