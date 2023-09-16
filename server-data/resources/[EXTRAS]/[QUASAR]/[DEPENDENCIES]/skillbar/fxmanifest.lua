fx_version 'cerulean'
game 'gta5'

ui_page "html/index.html"

client_scripts {
    'client/main.lua',
    'config.lua',
}

server_scripts {
    'config.lua',
}

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
}

exports {
    'GetSkillbarObject'
}
