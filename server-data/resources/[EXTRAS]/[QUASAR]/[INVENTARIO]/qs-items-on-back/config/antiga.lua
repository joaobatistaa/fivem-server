Config = {}

Config.Framework = 'ESX' -- 'ESX' or 'QBCore'.

Config.Weapons = {
	compatable_weapon_hashes = { -- Here you can set for each weapon the back Bone Index and the position & rotation that will fit while equiped
		-- melee:
		["w_me_bat"] = { hash = -1786099057, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		--["prop_ld_jerrycan_01"] = { hash = 883325847, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		-- assault rifles:
		["w_ar_carbinerifle"] = { hash = -2084633992, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 75.0, z_rotation = 0.0 },
		["w_ar_carbineriflemk2"] = { hash = GetHashKey("WEAPON_CARBINERIFLE_MK2"), back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_ar_assaultrifle"] = { hash =  -1074790547, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_ar_specialcarbine"] = { hash = -1063057011, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_ar_bullpuprifle"] = { hash = 2132975508, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_ar_advancedrifle"] = { hash = -1357824103, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		-- sub machine guns:
		["w_sb_microsmg"] = { hash = 324215364, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_sb_assaultsmg"] = { hash = -270015777, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_sb_smg"] = { hash = 736523883, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_sb_smgmk2"] = { hash = GetHashKey("WEAPON_SMG_MK2"), back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_sb_gusenberg"] = { hash = 1627465347, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		-- sniper rifles:
		["w_sr_sniperrifle"] = { hash = 100416529, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		-- shotguns:
		["w_sg_assaultshotgun"] = { hash = -494615257, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_sg_bullpupshotgun"] = { hash = -1654528753, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_sg_pumpshotgun"] = { hash = 487013001, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_ar_musket"] = { hash = -1466123874, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		["w_sg_heavyshotgun"] = { hash = GetHashKey("WEAPON_HEAVYSHOTGUN"), back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
		-- launchers:
		["w_lr_firework"] = { hash = 2138347493, back_bone = 24816, x = 0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 165.0, z_rotation = 0.0 },
	}
}
