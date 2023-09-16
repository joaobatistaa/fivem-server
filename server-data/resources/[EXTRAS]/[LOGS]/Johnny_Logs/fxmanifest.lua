fx_version 'adamant'

game 'gta5'

shared_script '@es_extended/imports.lua'

server_script {		
    '@es_extended/locale.lua', 
	'config.lua',
	'locales/en.lua',
	'server/server.lua'
}

client_script {	
	'@es_extended/locale.lua',				
	'config.lua',
	'locales/en.lua',
	'client/client.lua'
}