fx_version "adamant"

game "gta5"

lua54 'yes'

version "1.0.0"

client_scripts {
	"config.lua",
	"client/main.lua"
}

server_script {
	"config.lua",
	"server/main.lua"
}

ui_page "html/ui.html"

files {
	"html/BebasNeueBold.ttf",
    "html/ui.html",
    "html/style.css",
    "html/script.js",
}

escrow_ignore {
	"config.lua",
}