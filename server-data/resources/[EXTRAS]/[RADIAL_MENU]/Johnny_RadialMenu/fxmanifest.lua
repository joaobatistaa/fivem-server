fx_version "bodacious"
games {"gta5"}

shared_script '@es_extended/imports.lua'

client_script {
    "config.lua",
	"client_menu.lua",
	"keycontrol.lua",
	"emotes_triggers.lua"
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"server.lua"
}

ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/css/RadialMenu.css",
	"html/js/RadialMenu.js",
	'html/css/all.min.css',
	'html/js/all.min.js',
}
