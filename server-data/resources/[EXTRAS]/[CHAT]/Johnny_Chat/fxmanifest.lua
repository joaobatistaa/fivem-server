fx_version 'adamant'

game 'gta5'

ui_page 'web/ui.html'

files {
	'web/*.*',
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
	'ooc.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua',
	'commands.lua',
}