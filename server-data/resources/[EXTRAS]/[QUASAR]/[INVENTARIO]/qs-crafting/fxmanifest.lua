fx_version 'cerulean'

game 'gta5'

lua54 'yes'

shared_scripts {
    'config/*.lua'
}

client_scripts {
    'client/custom/*.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

escrow_ignore {
    'config/*.lua',
    'client/custom/*.lua'
}

dependencies {
    '/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
    'progressbar' -- Required.
}
dependency '/assetpacks'