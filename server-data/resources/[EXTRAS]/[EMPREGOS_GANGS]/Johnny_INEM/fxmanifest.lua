fx_version 'adamant'
game 'gta5'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'server/main.lua',
	'server/items.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'client/main.lua',
	'client/npc_medico.lua',
	'client/drogas_medicamentos.lua',
	'client/cryptos_stretcher.lua',
	'client/items.lua',
}

