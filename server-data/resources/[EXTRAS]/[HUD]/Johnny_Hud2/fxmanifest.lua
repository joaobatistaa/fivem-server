fx_version 'adamant'
game 'gta5'

shared_script '@es_extended/imports.lua'

ui_page {
	'html/index.html',
}

files {
	'html/css/style.css',
	'html/css/vstyle.css',
	'html/grid.css',

	'html/fonts/pricedown.ttf',
	'html/fonts/gta-ui.ttf',
	'html/js/app.js',
	'html/index.html',

	'html/css/jquery-ui.min.css',
	'html/js/jquery.min.js',
	'html/js/jquery-ui.min.js',

	-- Vehicle Images
	'html/img/vehicle/*.png',

	-- Voice Images

	'html/sounds/*.ogg',

	-- Player Status Images

	'html/img/*.svg',
}

client_scripts {
	'config.lua',
	'client/hud_carro.lua',
	'client/core.lua',
	'client/hud_status.lua'
}

server_scripts {
	'config.lua',
	'server/main.lua',
}
