fx_version 'adamant'

game 'gta5'

shared_script '@es_extended/imports.lua'

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js",
    "ui/badge.png",
	"ui/footer.png",
	"ui/mugshot.png",
	"ui/ipad.png"
}

server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	"sv_mdt.lua",
	"sv_vehcolors.lua"
}

client_script "cl_mdt.lua"

