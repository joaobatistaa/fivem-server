fx_version 'bodacious'

game 'gta5'

version '2.5.4'

lua54 'yes'

ui_page 'html/index.html'

shared_scripts {
    -- '@ox_lib/init.lua', -- If you use ox_lib in Config.MenuType
	'config/*.lua',
	'utils/*.lua',
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'locales/*.lua',
	'client/custom/framework/*.lua',
	'client/custom/interiors/*.lua',
	'client/custom/inventory/*.lua',
	'client/custom/wardrobe/*.lua',
	'client/custom/weather/*.lua',
	'client/custom/garage/*.lua',
	'client/custom/furniture/*.lua',
	'client/custom/*.lua',
	'client/modules/*.lua',
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'locales/*.lua',
	'server/custom/framework/*.lua',
	'server/custom/garages/*.lua',
	'server/custom/society/*.lua',
	'server/custom/logout/*.lua',
	'server/custom/*.lua',
	'server/modules/*.lua',
	'server/*.lua',
}

files {
	'html/index.html',
	'html/reset.css',
	'html/style.css',
	'html/script.js',
	'html/img/*.png',
	'html/img/build-menu/*.png',
	'html/img/build-menu/Interior/*.png',
	'html/img/build-menu/Interior/bathroom/*.png',
	'html/img/build-menu/Interior/bedroom/*.png',
	'html/img/build-menu/Interior/kitchen/*.png',
	'html/img/build-menu/Interior/living-room/*.png',
	'html/img/build-menu/Interior/garden/*.png',
	'html/img/build-menu/Interior/killstore/*.png'
}

escrow_ignore {
	'config/*.lua',
	'locales/*.lua',
	'client/custom/*.lua',
	'client/custom/interiors/*.lua',
	'client/custom/furniture/*.lua',
	'client/custom/framework/*.lua',
	'client/custom/inventory/*.lua',
	'client/custom/wardrobe/*.lua',
	'client/custom/weather/*.lua',
	'client/custom/garage/*.lua',
	'server/custom/*.lua',
	'server/custom/framework/*.lua',
	'server/custom/garages/*.lua',
	'server/custom/society/*.lua',
	'server/custom/logout/*.lua'
}

server_export {
	'hasKey',
	'CallRemoteMethod',
    'RegisterMethod'
}

exports {
    'CallRemoteMethod',
    'RegisterMethod'
}

dependencies {
	'/server:5848', -- ⚠️PLEASE READ⚠️ This requires at least server build 5848 or higher
	--'k4mb1shellstarter', -- ⚠️PLEASE READ⚠️ You need https://github.com/quasar-scripts/k4mb1shellstarter 
	--'interact-sound', -- Optional if you want to use the sounds from the housing
	'PolyZone',
	'meta_libs',
	--'bob74_ipl',
	--'lockpick',
	--'skillbar'
}

dependency '/assetpacks'