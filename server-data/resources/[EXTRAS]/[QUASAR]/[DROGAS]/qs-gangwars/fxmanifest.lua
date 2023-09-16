fx_version 'bodacious'

game 'gta5'

version '1.2.0'

lua54 'yes'

shared_scripts {
  'config/*.lua',
  'locales/*.lua',
  'utils/*.lua'
}

client_scripts {
  'client/custom/framework/*.lua',
  'client/*.lua',
  'client/modules/*.lua'
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  'server/custom/framework/*.lua',
  'server/custom/*.lua',
  'server/*.lua',
  'server/modules/*.lua'
}

escrow_ignore {
  'config/*.lua',
  'locales/*.lua',
  'client/custom/framework/*.lua',
  'server/custom/framework/*.lua',
  'server/custom/*.lua'
}

dependencies {
	'meta_libs', -- Required.
	'progressbar', -- Required.
	'/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
}
dependency '/assetpacks'