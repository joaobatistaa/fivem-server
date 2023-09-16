fx_version 'adamant'

game 'gta5'

version '1.0'

lua54 'yes'

ui_page 'html/ui.html'

files {
	'html/background.png',
	'html/debounce.min.js',
	'html/pricedown.ttf',
	'html/scripts.js',
	'html/styles.css',
	'html/ui.html',
}

client_scripts {
	"client/main.lua",
}

server_scripts {
	'server/main.lua',
	'server/check_version.lua',
}

escrow_ignore {
	'server/check_version.lua',
}
dependency '/assetpacks'