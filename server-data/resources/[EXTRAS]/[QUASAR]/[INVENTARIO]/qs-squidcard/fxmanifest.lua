fx_version 'bodacious'

game 'gta5'

version '1.0'

lua54 'yes'

client_script {
    'client/main.lua',
}

server_script {
    'server/main.lua',
    'server/check_version.lua',
}

ui_page {
    'html/index.html',
}

files {
	'html/index.html',
	'html/app.js', 
	'html/style.css',
    'html/cardboard.png',
    'html/house.png',
}

escrow_ignore {
	'server/check_version.lua',
}