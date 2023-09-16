fx_version "bodacious"

game "gta5"

shared_script '@es_extended/imports.lua'

files { 
	"html/radar.css",
    "html/radar.js",   
    "html/jquery.js", 
    "html/radar.png",  
    "html/power_on.png",
    "html/power_off.png",
	"html/radar.html"
}

ui_page "html/radar.html"

server_scripts {    
    '@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_script{
    "client.lua"
}

