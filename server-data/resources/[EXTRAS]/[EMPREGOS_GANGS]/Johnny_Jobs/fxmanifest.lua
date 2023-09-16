fx_version 'adamant'

game 'gta5'

description 'ESX Jobs'

version '1.1.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',

	--'jobs/fisherman.lua',
	'jobs/abastecedor.lua',
	--'jobs/lenhador.lua',
	--'jobs/mineiro.lua',
	--'jobs/reporter.lua',
	'jobs/abatedor.lua',
	'jobs/alfaiate.lua',

	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',

	--'jobs/fisherman.lua',
	'jobs/abastecedor.lua',
	--'jobs/lenhador.lua',
	--'jobs/mineiro.lua',
	--'jobs/reporter.lua',
	'jobs/abatedor.lua',
	'jobs/alfaiate.lua',

	'client/main.lua'
}
