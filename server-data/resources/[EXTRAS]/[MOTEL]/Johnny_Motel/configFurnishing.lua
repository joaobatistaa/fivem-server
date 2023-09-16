Config.MegaMall = {
    ["entrance"] = {
        ["pos"] = vector3(313.09, -225.75, 54.22),
        ["label"] = "Entrar no armazém."
    },
    ["exit"] = {
        ["pos"] = vector3(1087.4390869141, -3099.419921875, -38.99995803833),
        ["label"] = "Sair do Armazém."
    },
    ["computer"] = {
        ["pos"] = vector3(1088.4245605469, -3101.2800292969, -38.99995803833),
        ["label"] = "Usar Computador."
    },
    ["object"] = {
        ["pos"] = vector3(1095.916015625, -3100.3781738281, -38.99995803833),
        ["rotation"] = vector3(0.0, 0.0, 270.0)
    }
}

Config.FurnishingPurchasables = {
    ["Camas"] = {
        ["big_double_bed"] = {
            ["label"] = "Cama de Casal",
            ["description"] = "",
            ["price"] = 4250,
            ["model"] = `apa_mp_h_bed_double_09`
        },
        ["big_black_bed"] = {
            ["label"] = "Cama Grande",
            ["description"] = "",
            ["price"] = 5750,
            ["model"] = `apa_mp_h_yacht_bed_02`
        },
        ["big_black_doublebed"] = {
            ["label"] = "Cama Preta",
            ["description"] ="",
            ["price"] = 3750,
            ["model"] = `apa_mp_h_bed_double_08`
        },
        ["big_beige_double_bed"] = {
            ["label"] = "Cama Castanha",
            ["description"] = "",
            ["price"] = 6250,
            ["model"] = `apa_mp_h_yacht_bed_01`
        },
    },

    ["Plantas"] = {
        ["high_brown_pot"] = {
            ["label"] = "Planta longa em vaso castanho",
            ["description"] = "",
            ["price"] = 1650,
            ["model"] = `apa_mp_h_acc_plant_tall_01`
        },
        ["short_blue_pot"] = {
            ["label"] = "Planta Pequena",
            ["description"] = "",
            ["price"] = 900,
            ["model"] = `apa_mp_h_acc_vase_flowers_04`
        },
        ["palm_white_pot"] = {
            ["label"] = "Palmeira",
            ["description"] = "",
            ["price"] = 1300,
            ["model"] = `apa_mp_h_acc_plant_palm_01`
        },
        ["hole_wase"] = {
            ["label"] = "Planta em vaso oco",
            ["description"] = "",
            ["price"] = 1075,
            ["model"] = `apa_mp_h_acc_vase_flowers_02`
        },
        ["white_flower_vase"] = {
            ["label"] = "Planta em vaso branco",
            ["description"] = "",
            ["price"] = 800,
            ["model"] = `hei_heist_acc_flowers_01`
        },
        ["long_vase"] = {
            ["label"] = "Planta Grande",
            ["description"] = "",
            ["price"] = 1125,
            ["model"] = `prop_plant_int_03b`
        }
    },

    ["Armários"] = {
        ["large_drawer"] = {
            ["label"] = "Armário Grande",
            ["description"] = "",
            ["price"] = 2500,
            ["model"] = `hei_heist_bed_chestdrawer_04`,
            ["func"] = function(furnishId)
                OpenStorage("motel-" .. furnishId)
            end
        },
        ["chest_drawer"] = {
            ["label"] = "Armário Pequeno",
            ["description"] = "",
            ["price"] = 3750,
            ["model"] = `apa_mp_h_bed_chestdrawer_02`,
            ["func"] = function(furnishId)
                OpenStorage("motel-" .. furnishId)
            end
        },
        ["mini_fridge"] = {
            ["label"] = "Minibar",
            ["description"] = "",
            ["price"] = 2250,
            ["model"] = `prop_bar_fridge_03`,
            ["func"] = function(furnishId)
                OpenStorage("motel-" .. furnishId)
            end
        },
    },
    
    ["Carpetes"] = {
        ["big_rug"] = {
            ["label"] = "Carpete Azul",
            ["description"] = "",
            ["price"] = 1050,
            ["model"] = `apa_mp_h_acc_rugwoolm_03`
        },
        ["beige_rug"] = {
            ["label"] = "Carpete Branca",
            ["description"] = "",
            ["price"] = 1250,
            ["model"] = `apa_mp_h_acc_rugwoolm_04`
        },
        ["beige_brown_circle_rug"] = {
            ["label"] = "Carpete Castanha",
            ["description"] = "",
            ["price"] = 1525,
            ["model"] = `apa_mp_h_acc_rugwoolm_01`
        },
        ["blue_white_turqoise_rug"] = {
            ["label"] = "Carpete Azul",
            ["description"] = "",
            ["price"] = 1750,
            ["model"] = `apa_mp_h_acc_rugwoolm_02`
        },
    },
    
    ["Candeeiros"] = {
        ["floorlamp_mp_apa"] = {
            ["label"] = "Candeeiro A",
            ["description"] = "",
            ["price"] = 1600,
            ["model"] = `apa_mp_h_floorlamp_b`
        },
        ["floorlamp_basic_mp_apa"] = {
            ["label"] = "Candeeiro B",
            ["description"] = "",
            ["price"] = 1400,
            ["model"] = `apa_mp_h_floorlamp_c`
        },
        ["hanging_brown_yellow_lamp"] = {
            ["label"] = "Candeeiro C",
            ["description"] = "",
            ["price"] = 1575,
            ["model"] = `apa_mp_h_lit_floorlamp_05`
        },
        ["red_modern_lamp"] = {
            ["label"] = "Candeeiro D",
            ["description"] = "",
            ["price"] = 2100,
            ["model"] = `apa_mp_h_lit_floorlamp_13`
        },
        ["table_lamp_small"] = {
            ["label"] = "Candeeiro E",
            ["description"] = "",
            ["price"] = 1250,
            ["model"] = `apa_mp_h_lit_lamptable_09`
        },
        ["table_lamp_modern_small"] = {
            ["label"] = "Candeeiro F",
            ["description"] = "",
            ["price"] = 1400,
            ["model"] = `apa_mp_h_yacht_table_lamp_01`
        },
        ["ek_colored_fan_lamp"] = {
            ["label"] = "Candeeiro G",
            ["description"] = "",
            ["price"] = 1200,
            ["model"] = `bkr_prop_biker_ceiling_fan_base`
        },
        ["table_lamp_white"] = {
            ["label"] = "Candeeiro H",
            ["description"] = "",
            ["price"] = 900,
            ["model"] = `v_ilev_fh_lampa_on`
        },
    },

    ["Bancos"] = {
        ["gray_white_tv_table"] = {
            ["label"] = "Banco A",
            ["description"] = "",
            ["price"] = 2750,
            ["model"] = `apa_mp_h_str_sideboardl_13`
        },
        ["gray_white_tv_smaller_table"] = {
            ["label"] = "Banco B",
            ["description"] = "",
            ["price"] = 1800,
            ["model"] = `apa_mp_h_str_sideboards_01`
        },
        ["ek_colored_tv_table"] = {
            ["label"] = "Banco C",
            ["description"] = "",
            ["price"] = 2150,
            ["model"] = `apa_mp_h_str_sideboardm_02`
        },
    },

    ["Mesas"] = {
        ["modern_triangle_table"] = {
            ["label"] = "Mesa Moderna",
            ["description"] = "",
            ["price"] = 1700,
            ["model"] = `apa_mp_h_tab_coffee_07`
        },
        ["square_glass_table"] = {
            ["label"] = "Mesa de Quadrante",
            ["description"] = "",
            ["price"] = 1250,
            ["model"] = `apa_mp_h_tab_sidelrg_07`
        },
        ["tree_ram_glass_table"] = {
            ["label"] = "Mesa da Arvore",
            ["description"] = "",
            ["price"] = 2000,
            ["model"] = `apa_mp_h_yacht_coffee_table_02`
        },
        ["metal_table"] = {
            ["label"] = "Mesa de Metal",
            ["description"] = "",
            ["price"] = 2125,
            ["model"] = `apa_mp_h_yacht_coffee_table_01`
        },
    },

    ["Quadros"] = {
        ["orange_painting"] = {
            ["label"] = "Pintura Laranja",
            ["description"] = "",
            ["price"] = 750,
            ["model"] = `apa_p_h_acc_artwalll_02`
        },
        ["blue_painting"] = {
            ["label"] = "Pintura Azul",
            ["description"] = "",
            ["price"] = 925,
            ["model"] = `apa_p_h_acc_artwalll_01`
        },
        ["turqoise_painting"] = {
            ["label"] = "Pintura Turquesa",
            ["description"] = "",
            ["price"] = 1025,
            ["model"] = `apa_p_h_acc_artwallm_04`
        },
    },

    ["Eletrónica"] = {
        ["big_tv"] = {
            ["label"] = "TV",
            ["description"] = "",
            ["price"] = 6500,
            ["model"] = `ex_prop_ex_tv_flat_01`
        },
        ["i_mac_keyboard"] = {
            ["label"] = "iMac",
            ["description"] = "",
            ["price"] = 5500,
            ["model"] = `ex_prop_trailer_monitor_01`
        },
        ["black_laptop"] = {
            ["label"] = "Portátil",
            ["description"] = "",
            ["price"] = 3250,
            ["model"] = `p_amb_lap_top_02`
        },
        ["i_max_keyboard"] = {
            ["label"] = "iMax",
            ["description"] = "",
            ["price"] = 5500,
            ["model"] = `xm_prop_x17_computer_01`
        },
    },
}