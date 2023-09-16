fx_version 'adamant'

game "gta5"

version '1.3.4'

lua54 'yes'

client_scripts {
	'config/config.lua',
  'config/config_framework.lua',
  'config/config_farm.lua',
  'config/config_processes.lua',
  'config/config_washing.lua',
  'config/config_seller.lua',
  'config/translations.lua',
  'config/config_webhook.lua',
  'client/main.lua',
  'client/collection/cocaine.lua',
  'client/collection/meth.lua',
  'client/collection/weed.lua',
  'client/processes.lua',
  'client/sell.lua',
  'client/washing.lua',
  'config/config_notifyCops.lua'
}

server_scripts {
	'config/config.lua',
  'config/config_framework.lua',
  'config/config_farm.lua',
  'config/config_processes.lua',
  'config/config_washing.lua',
  'config/config_seller.lua',
  'config/config_webhook.lua',
  'config/translations.lua',
  'server/main.lua', -- Remove if use ox
  'server/washing.lua', -- Remove if use ox
  --'server/ox_main.lua', -- Uncomment if use ox
  --'server/ox_washing.lua', -- Uncomment if use ox
  'server/version_check.lua'
}

escrow_ignore {
	'config/config.lua',
  'config/config_framework.lua',
  'config/config_farm.lua',
  'config/config_processes.lua',
  'config/config_seller.lua',
  'config/config_webhook.lua',
  'config/config_washing.lua',
  'config/translations.lua',
  'config/config_notifyCops.lua',
  'server/version_check.lua'
}

dependencies {
  --[[ 'meta_libs', ]] -- Required.
	'progressbar', -- Required.
	'/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
}

dependency '/assetpacks'