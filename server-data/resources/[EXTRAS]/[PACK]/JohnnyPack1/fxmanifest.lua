fx_version 'adamant'

game 'gta5'

shared_scripts {
    'config/*.lua',
}

server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}


files {
	'html/audio/sfx/weapons_player/lmg_combat.awc',
	'html/audio/sfx/weapons_player/lmg_mg_player.awc',
	'html/audio/sfx/weapons_player/mgn_sml_am83_vera.awc',
	'html/audio/sfx/weapons_player/mgn_sml_am83_verb.awc',
	'html/audio/sfx/weapons_player/mgn_sml_sc__l.awc',
	'html/audio/sfx/weapons_player/ptl_50cal.awc',
	'html/audio/sfx/weapons_player/ptl_combat.awc',
	'html/audio/sfx/weapons_player/ptl_pistol.awc',
	'html/audio/sfx/weapons_player/ptl_px4.awc',
	'html/audio/sfx/weapons_player/ptl_rubber.awc',
	'html/audio/sfx/weapons_player/sht_bullpup.awc',
	'html/audio/sfx/weapons_player/sht_pump.awc',
	'html/audio/sfx/weapons_player/smg_micro.awc',
	'html/audio/sfx/weapons_player/smg_smg.awc',
	'html/audio/sfx/weapons_player/snp_heavy.awc',
	'html/audio/sfx/weapons_player/snp_rifle.awc',
	'html/audio/sfx/weapons_player/spl_grenade_player.awc',
	'html/audio/sfx/weapons_player/spl_minigun_player.awc',
	'html/audio/sfx/weapons_player/spl_prog_ar_player.awc',
	'html/audio/sfx/weapons_player/spl_railgun.awc',
	'html/audio/sfx/weapons_player/spl_rpg_player.awc',
	'html/audio/sfx/weapons_player/spl_tank_player.awc',
}