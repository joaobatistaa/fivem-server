fx_version 'cerulean'
game 'gta5'
author 'Aiakos#8317'
description 'Codem-Deathscreen'
ui_page {
	'html/index.html',
}

files {
	'html/css/*.css',
	'html/app/*.js',
	
	'html/lib/*.js',
	'html/lib/*.css',
	'html/*.html',
	'html/images/*.png',
	'html/fonts/*.otf',

}

shared_script{
	'config.lua',
	'GetFrameworkObject.lua',

}

escrow_ignore {
	'config.lua',
	'GetFrameworkObject.lua',
	'client/weapons.lua',

}

client_scripts {
	'GetFrameworkObject.lua',
	'client/*.lua',
}
server_scripts {
	'server/main.lua',
	'server/discord.lua',
	'GetFrameworkObject.lua',

}



lua54 'yes'

dependency '/assetpacks'