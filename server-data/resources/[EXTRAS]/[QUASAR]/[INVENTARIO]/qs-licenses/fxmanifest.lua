fx_version "adamant"

game "gta5"

lua54 'yes'

shared_scripts {
    'config/*.lua'
}

client_scripts {
    'client/custom/*.lua',
    'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/custom/*.lua',
    'server/main.lua',
    'server/version.lua'
}

escrow_ignore {
    'client/custom/*.lua',
    'server/custom/*.lua',
	'config/*.lua'
}
dependency '/assetpacks'