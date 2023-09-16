fx_version "bodacious"

game "gta5"

shared_script '@es_extended/imports.lua'

server_scripts {
  'server/main.lua'
}

client_scripts {
  'client/main.lua'
}

ui_page('html/index.html')

files {
    'html/index.html'
}

