fx_version 'adamant'

game 'gta5'

version '2.0'

lua54 'yes'

shared_scripts {
	"config/config.lua",
}

client_script {
    "client/*.lua",
}

server_script {
    "server/custom/*.lua",
    "server/main.lua",
    "server/version_check.lua",
}

escrow_ignore {
	"config/config.lua",
    "server/custom/*.lua",
}

dependencies {
	'progressbar', -- Required.
    'qs-inventory', -- Required.
	'/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
}
dependency '/assetpacks'