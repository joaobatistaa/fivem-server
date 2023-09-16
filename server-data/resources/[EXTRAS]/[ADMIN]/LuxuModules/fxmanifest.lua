fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.0.4'
author 'Luxu.gg'
description 'LuxuModules - A script that serves luxu.gg'

shared_scripts { '@ox_lib/init.lua', 'config.lua', 'shared/utils.lua' }

ui_page 'nui/index.html'

files { 'nui/index.html', 'nui/**/*', 'nui/*', }


client_scripts {
      'client/_framework.lua', 'client/cl_utils.lua', 'client/client.lua'
}

server_scripts { '@mysql-async/lib/MySQL.lua', 'server/_framework.lua', 'server/sv_utils.lua', 'server/server.lua' }

escrow_ignore {
      'config.lua',
      'server/sv_utils.lua',
      'client/cl_utils.lua',
      'server/_framework.lua',
      'client/_framework.lua',
}

dependencies {
      'ox_lib',

}

dependency '/assetpacks'