fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

version '3.0.3'

shared_scripts {
	-- '@ox_lib/init.lua', -- If you use ox_lib in Config.MenuType
	'config/*.lua',
	'locales/*.lua'
}

--ui_page "html/index.html"

--[[ files {
	"html/index.html",
	"html/*.css",
	"html/*.js",
	"html/img/*.png",
} ]]

client_scripts {
	'client/custom/framework/*.lua',
	'client/utils.lua',
	'client/main.lua',
	'client/functions.lua',
	'client/modules/*.lua',
	'client/custom/**/*.lua',
	'client/custom/menus/**/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua', -- RECOMMENDED
	--'@mysql-async/lib/MySQL.lua',
	'server/version.lua',
	'server/utils.lua',
	'server/custom/framework/*.lua',
	'server/custom/**/*.lua',
	'server/*.lua',
	'server/modules/*.lua',
}

escrow_ignore {
	'config/*.lua',
	'locales/*.lua',
	'client/custom/framework/*.lua',
	'server/custom/framework/*.lua',
	'client/custom/**/*.lua',
	'server/custom/**/*.lua',
	'client/custom/menus/**/*.lua',
}

dependencies {
	'/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4752 or higher
	'baseevents',
	--'lockpick', -- Remove if not use
	--'reload-skillbar', -- Remove if not use
}

dependency '/assetpacks'