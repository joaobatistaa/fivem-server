Config = {}

--██╗████████╗███████╗███╗░░░███╗░██████╗  ░█████╗░███╗░░██╗  ██████╗░░█████╗░░█████╗░██╗░░██╗
--██║╚══██╔══╝██╔════╝████╗░████║██╔════╝  ██╔══██╗████╗░██║  ██╔══██╗██╔══██╗██╔══██╗██║░██╔╝
--██║░░░██║░░░█████╗░░██╔████╔██║╚█████╗░  ██║░░██║██╔██╗██║  ██████╦╝███████║██║░░╚═╝█████═╝░
--██║░░░██║░░░██╔══╝░░██║╚██╔╝██║░╚═══██╗  ██║░░██║██║╚████║  ██╔══██╗██╔══██║██║░░██╗██╔═██╗░
--██║░░░██║░░░███████╗██║░╚═╝░██║██████╔╝  ╚█████╔╝██║░╚███║  ██████╦╝██║░░██║╚█████╔╝██║░╚██╗
--╚═╝░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝╚═════╝░  ░╚════╝░╚═╝░░╚══╝  ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝

-- It is recommended to add items little by little, investigating the position you want to give it.
-- The best reference to get props is: https://gta-objects.xyz/.
Config.Items = {
    --[[
    ["markedbills"] = {
        model="prop_money_bag_01",
        back_bone = 24818,
        x = -0.4,
        y = -0.17,
        z = -0.12,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },

    ["meth"] = {
        model="hei_prop_pill_bag_01", 
        back_bone = 24818,
        x = -0.1,
        y = -0.17,
        z = 0.12,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    --]]
    
    ["weapon_smg"] = {
        model="w_sb_smg", 
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = -0.12,
        x_rotation = 0.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },

    ["weapon_assaultrifle"] = {
        model="w_ar_assaultrifle",
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = -0.05,
        x_rotation = 0.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },

    ["weapon_carbinerifle_mk2"] = {
        model="w_ar_carbinerifle", 
        back_bone = 24818,
        x = 0.0,
        y = -0.17,
        z = 0.08,
        x_rotation = 0.0,
        y_rotation = -180.0,
        z_rotation = 180.0,
    },

    ["weapon_rpg"] = {
        model="w_lr_rpg", 
        back_bone = 24818,
        x = 0.2,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 180.0,
        z_rotation = 180.0,
    },
	
	["weapon_bat"] = {
        model="w_me_bat", 
        back_bone = 24816,
        x = 0.075,
        y = -0.15,
        z = -0.02,
        x_rotation = 0.0,
        y_rotation = 165.0,
        z_rotation = 0.0,
    },
}
