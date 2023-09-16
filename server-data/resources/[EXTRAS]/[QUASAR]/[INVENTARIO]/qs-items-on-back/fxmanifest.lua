fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

client_scripts {
    'config/config.lua',
    'config/config_framework.lua',
    'client/main.lua',
}

escrow_ignore {
    'config/config.lua',
    'config/config_framework.lua',
}
dependency '/assetpacks'