fx_version 'cerulean'
game 'gta5'


client_scripts {
    'config.lua',
    'c_functions.lua',
    'client.lua',
}


server_scripts {
    'config.lua',
    'version.lua',
    's_functions.lua',
    'server.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/motels.css',
    'html/script.js',
    'html/style.css',
    'html/public/playground_assets/*'
}

exports {
    "paycheckAll",
    "paycheckUser"
 }

escrow_ignore {
    'config.lua',
    's_functions.lua',
    'c_functions.lua'
}

lua54 'yes'
dependency '/assetpacks'