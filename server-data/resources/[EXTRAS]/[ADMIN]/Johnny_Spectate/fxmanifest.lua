fx_version 'adamant'
game 'gta5'

shared_script '@es_extended/imports.lua'

server_scripts {
 '@oxmysql/lib/MySQL.lua',
 'server/main.lua'
 }
 
client_script 'client/main.lua'

ui_page {
  'ui/index.html'
}

files {
  'ui/index.html',
  'ui/style.css',
  'ui/main.js',
}

