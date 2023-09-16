fx_version 'adamant'

game 'gta5'

version '1.2.5'

lua54 'yes'

this_is_a_map 'yes'

client_scripts {
    'config.lua',
    'client/main.lua'
}

server_scripts {
    'config.lua',
    'server/main.lua'
}

escrow_ignore {
	'config.lua',
}
dependency '/assetpacks'