fx_version 'bodacious'
game 'gta5'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

ui_page "html/index.html"

files {
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/img/*.png',
    'html/img/speedm-images/*.png',
    'html/img/weapons/*.png',
    'html/fonts/*.ttf',
    'html/fonts/*.TTF',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/*.mp3',
}

lua54 'yes'

escrow_ignore {
    'config.lua',
}