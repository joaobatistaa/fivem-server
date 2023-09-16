fx_version 'adamant'

game 'gta5'

shared_script '@es_extended/imports.lua'

ui_page 'html/index.html'

server_script {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}

client_script {
	'config.lua',
	'client.lua'
}

files {
	'html/assets/images/dna.png',
	'html/assets/images/logo.png',
	'html/index.html',
	'html/assets/fonts/roboto/Roboto-Bold.woff',
	'html/assets/fonts/roboto/Roboto-Bold.woff2',
	'html/assets/fonts/roboto/Roboto-Light.woff',
	'html/assets/fonts/roboto/Roboto-Light.woff2',
	'html/assets/fonts/roboto/Roboto-Medium.woff',
	'html/assets/fonts/roboto/Roboto-Medium.woff2',
	'html/assets/fonts/roboto/Roboto-Regular.woff',
	'html/assets/fonts/roboto/Roboto-Regular.woff2',
	'html/assets/fonts/roboto/Roboto-Thin.woff',
	'html/assets/fonts/roboto/Roboto-Thin.woff2',
	'html/assets/css/materialize.min.css',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/materialize.js',
	'html/assets/js/init.js',
}



