fx_version "bodacious"
games {"gta5"}

shared_script '@es_extended/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    "config.lua",
    "server/server.lua"
}
client_scripts {
    "config.lua",
    "client/client.lua",
}

ui_page('html/ui.html')

files {
  'html/ui.html',
  'html/js/script.js',
  'html/css/style.css',
  'html/img/digital.ttf',
  'html/img/*.svg',
  'html/img/*.png'
}

