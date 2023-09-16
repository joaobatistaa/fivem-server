fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Luxu#0001 <luxu@luxu.gg>'
description 'Admin Menu by Luxu.gg'
version '2.0.4'

ui_page 'nui/index.html'
files { 'nui/index.html', 'nui/**/*', 'nui/*', 'nui/addon_vehicles_imgs/*', 'database/*' }

shared_scripts { '@ox_lib/init.lua', '@LuxuModules/config.lua', 'config.lua', 'locales/*', 'shared/*' }

client_scripts {
      'client/*',
      'notify/client.lua',
      'custom_functions/client.lua',
}

server_scripts { '@mysql-async/lib/MySQL.lua', 'discord.lua', 'server/server-reports.lua',
      'server/open-server.lua', "server/webhook.lua", 'server/server.lua',
      'notify/server.lua',
      'server/bancheck.lua',
      'server/getplayers.lua', 'server/permissionChecker.lua', 'custom_functions/server.lua', }

escrow_ignore { 'config.lua', 'discord.lua', 'locales/*', 'notify/*', 'client/open-client.lua', 'server/open-server.lua',
      'server/permissionChecker.lua',
      'shared/*', 'server/webhook.lua', 'custom_functions/*' }

dependencies {
      'ox_lib',
      'LuxuModules'
}

dependency '/assetpacks'