Config['VangelicoHeist'] = {
    ['requiredPoliceCount'] = 0, -- required police count for start heist
    ['nextRob'] = 3600, -- seconds for next heist
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-846.42, -1307.5, 5.00017),
        peds = {
            {pos = vector3(-846.73, -1306.4, 5.00018), heading = 174.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-845.40, -1306.7, 5.00018), heading = 131.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(-845.61, -1308.2, 5.00018), heading = 79.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['gasMask'] = {
        itemName = 'gasmask', -- item name for gasmask
        clothNumber = 75 -- you can change, this is my choise
    },
    ['requiredItems'] = { -- add item to database
        'cutter',
        'bag'
    },
    ['smashRewards'] = { -- you can add new smash reward items
        {item = 'rolex', price = 20000},
        {item = 'ring', price = 20000},
        {item = 'necklace', price = 20000},
    },
    ['smashWeapons'] = { -- you can add new smash required weapons
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_CARBINERIFLE',
        'WEAPON_ADVANCEDRIFLE',
        'WEAPON_BULLPUPRIFLE',
    },
    ['finishHeist'] = {
        buyerPos = vector3(832.607, -2954.4, 4.90086)
    }
}

Config['VangelicoInside'] = {
    ['glassCutting'] = {
        displayPos = vector3(-617.4622, -227.4347, 37.057),
        displayHeading = -53.06,
        rewardPos = vector3(-617.4622, -227.4347, 38.0861),
        rewardRot = vector3(360.0, 0.0, 70.0),
        rewards = {
            {
                object = {model = 'h4_prop_h4_diamond_01a', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
                item = 'vanDiamond',
                price = 200000,
            },
            {
                object = {model = 'h4_prop_h4_art_pant_01a', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
                item = 'vanPanther',
                price = 200000,
            },
            {
                object = {model = 'h4_prop_h4_necklace_01a', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_neck_disp_01a', rot = vector3(360.0, 0.0, -60.0)},
                item = 'vanNecklace',
                price = 200000,
            },
            {
                object = {model = 'h4_prop_h4_t_bottle_02b', rot = -53.06},
                displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
                item = 'vanBottle',
                price = 200000,
            },
        }
    },
    ['smashScenes'] = {
        {
            objPos = vector3(-627.735, -234.439, 37.875),
            scenePos = vector3(-628.187, -233.538, 37.0946),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-626.716, -233.685, 37.8583),
            scenePos = vector3(-627.136, -232.775, 37.0946),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-627.35, -234.947, 37.8531),
            scenePos = vector3(-626.62, -235.725, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-626.298, -234.193, 37.8492),
            scenePos = vector3(-625.57, -234.962, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-626.399, -239.132, 37.8616),
            scenePos = vector3(-626.894, -238.2, 37.0856),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
        {
            objPos = vector3(-625.376, -238.358, 37.8687),
            scenePos = vector3(-625.867, -237.458, 37.0946),
            sceneRot = vector3(0.0, 0.0, -144.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-625.517, -227.421, 37.86),
            scenePos = vector3(-624.738, -228.2, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-624.467, -226.653, 37.861),
            scenePos = vector3(-623.688, -227.437, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.0),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-623.8118, -228.6336, 37.8522),
            scenePos = vector3(-624.293, -227.831, 37.0946),
            sceneRot = vector3(0.0, 0.0, -143.511),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
        {
            objPos = vector3(-624.1267, -230.7476, 37.8618),
            scenePos = vector3(-624.939, -231.247, 37.0946),
            sceneRot = vector3(0.0, 0.0, -54.13),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-621.7181, -228.9636, 37.8425),
            scenePos = vector3(-620.864, -228.481, 37.0946),
            sceneRot = vector3(0.0, 0.0, 126.925),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-622.7541, -232.614, 37.8638),
            scenePos = vector3(-623.3596, -233.2296, 37.0946),
            sceneRot = vector3(0.0, 0.0, -52.984),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-620.3262, -230.829, 37.8578),
            scenePos = vector3(-619.408, -230.1969, 37.0946),
            sceneRot = vector3(0.0, 0.0, 126.352),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-620.6465, -232.9308, 37.8407),
            scenePos = vector3(-620.184, -233.729, 37.0946),
            sceneRot = vector3(0.0, 0.0, 36.398),
            oldModel = 'des_jewel_cab4_start',
            newModel = 'des_jewel_cab4_end'
        },
        {
            objPos = vector3(-619.978, -234.93, 37.8537),
            scenePos = vector3(-620.44, -234.084, 37.0946),
            sceneRot = vector3(0, 0, -144.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-618.937, -234.16, 37.8425),
            scenePos = vector3(-619.39, -233.32, 37.0946),
            sceneRot = vector3(0, 0, -144.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-620.163, -226.212, 37.8266),
            scenePos = vector3(-620.797, -226.79, 37.0946),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab_start',
            newModel = 'des_jewel_cab_end'
        },
        {
            objPos = vector3(-619.384, -227.259, 37.8342),
            scenePos = vector3(-620.055, -227.817, 37.0856),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
        {
            objPos = vector3(-618.019, -229.115, 37.8302),
            scenePos = vector3(-618.679, -229.704, 37.0946),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab3_start',
            newModel = 'des_jewel_cab3_end'
        },
        {
            objPos = vector3(-617.249, -230.156, 37.8201),
            scenePos = vector3(-617.937, -230.731, 37.0856),
            sceneRot = vector3(0, 0, -54.0),
            oldModel = 'des_jewel_cab2_start',
            newModel = 'des_jewel_cab2_end'
        },
    },
    ['painting'] = {
        {
            rewardItem = 'paintingg', -- u need add item to database
            paintingPrice = '120000', -- price of the reward item for sell
            scenePos = vector3(-626.70, -228.3, 38.06), -- animation coords
            sceneRot = vector3(0.0, 0.0, 90.0), -- animation rotation
            object = 'ch_prop_vault_painting_01g', -- object (https://mwojtasik.dev/tools/gtav/objects/search?name=ch_prop_vault_painting_01)
            objectPos = vector3(-627.20, -228.31, 38.06), -- object spawn coords
            objHeading = 94.75 -- object spawn heading
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '120000', 
            scenePos = vector3(-622.97, -225.54, 38.06), 
            sceneRot = vector3(0.0, 0.0, -20.0),
            object = 'ch_prop_vault_painting_01f', 
            objectPos = vector3(-622.80, -225.14, 38.06), 
            objHeading = 345.85
        },
        {
            rewardItem = 'paintingh',
            paintingPrice = '120000', 
            scenePos = vector3(-617.48, -233.22, 38.06), 
            sceneRot = vector3(0.0, 0.0, -90.0),
            object = 'ch_prop_vault_painting_01h', 
            objectPos = vector3(-617.00, -233.22, 38.06), 
            objHeading = 269.53
        },
        {
            rewardItem = 'paintingj',
            paintingPrice = '120000', 
            scenePos = vector3(-621.25, -235.78, 38.06), 
            sceneRot = vector3(0.0, 0.0, 160.0),
            object = 'ch_prop_vault_painting_01j', 
            objectPos = vector3(-621.25, -236.38, 38.06), 
            objHeading = 161.22
        },
    }
}

StringsVangelico = {
	['start_heist'] = 'Pressiona ~INPUT_CONTEXT~ para iniciar o assalto à Joalharia',
	['goto_vangelico'] = 'Vá para a localização indicada no GPS. Lance um Gás BZ no duto de ventilação. Aguarda que os funcionários desmaiem para iniciar o roubo.',
	['wait_nextrob'] = 'Tens de aguardar',
	['minute'] = 'minutos para iniciares um novo assalto!',
	['start_stealing'] = 'Pressiona ~INPUT_CONTEXT~ para roubar',
	['cute_right'] = 'Pressiona ~INPUT_CONTEXT~ para cortar à direita',
	['cute_left'] = 'Pressiona ~INPUT_CONTEXT~ para cortar à esquerda',
	['cute_down'] = 'Pressiona ~INPUT_CONTEXT~ para cortar para baixo',
	['glass_cut'] = 'Pressiona ~INPUT_CONTEXT~ para cortar o vidro',
	['smash'] = 'Pressiona ~INPUT_CONTEXT~ para quebrar o vidro',
	['throw_gas_blip'] = 'Lança o gás para a ventilação',
	['good_shot'] = 'Bom lançamento! Aguarda que os funcionários desmaiem. Não te esqueças de colocar a máscara antes de entrar na Joalharia!',
	['need_switchblade'] = 'Precisas de um canivete!',
	['need_rifle'] = 'Precisas de uma Rifle!',
	['need_this'] = 'Precisas de: ',
	['deliver_to_buyer'] = 'Entrega o que roubaste ao comprador. Verifica o teu GPS.',
	['buyer_blip'] = 'Comprador',
	['need_police'] = 'Não há polícia suficiente na cidade.',
	['total_money'] = 'Ganhaste: ',
	['police_alert'] = 'Alerta de roubo à Joalharia! Verifica o teu GPS.'
}

OverheatVangelico = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'h4_prop_h4_cutter_01a',
    },
    ['animations'] = {
        {'enter', 'enter_bag', 'enter_cutter', 'enter_glass_display'},
        {'idle', 'idle_bag', 'idle_cutter', 'idle_glass_display'},
        {'cutting_loop', 'cutting_loop_bag', 'cutting_loop_cutter', 'cutting_loop_glass_display'},
        {'overheat_react_01', 'overheat_react_01_bag', 'overheat_react_01_cutter', 'overheat_react_01_glass_display'},
        {'success', 'success_bag', 'success_cutter', 'success_glass_display_cut'},
    },
    ['scenes'] = {},
    ['sceneObjects'] = {},
}

ArtHeistVangelico = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { 
        {"top_left_enter", "top_left_enter_ch_prop_ch_sec_cabinet_02a", "top_left_enter_ch_prop_vault_painting_01a", "top_left_enter_hei_p_m_bag_var22_arm_s", "top_left_enter_w_me_switchblade"},
        {"cutting_top_left_idle", "cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_idle_ch_prop_vault_painting_01a", "cutting_top_left_idle_hei_p_m_bag_var22_arm_s", "cutting_top_left_idle_w_me_switchblade"},
        {"cutting_top_left_to_right", "cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_to_right_ch_prop_vault_painting_01a", "cutting_top_left_to_right_hei_p_m_bag_var22_arm_s", "cutting_top_left_to_right_w_me_switchblade"},
        {"cutting_top_right_idle", "_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_right_idle_ch_prop_vault_painting_01a", "cutting_top_right_idle_hei_p_m_bag_var22_arm_s", "cutting_top_right_idle_w_me_switchblade"},
        {"cutting_right_top_to_bottom", "cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_right_top_to_bottom_ch_prop_vault_painting_01a", "cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_right_top_to_bottom_w_me_switchblade"},
        {"cutting_bottom_right_idle", "cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_idle_ch_prop_vault_painting_01a", "cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_idle_w_me_switchblade"},
        {"cutting_bottom_right_to_left", "cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_to_left_ch_prop_vault_painting_01a", "cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_to_left_w_me_switchblade"},
        {"cutting_bottom_left_idle", "cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_left_idle_ch_prop_vault_painting_01a", "cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_left_idle_w_me_switchblade"},
        {"cutting_left_top_to_bottom", "cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_left_top_to_bottom_ch_prop_vault_painting_01a", "cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_left_top_to_bottom_w_me_switchblade"},
        {"with_painting_exit", "with_painting_exit_ch_prop_ch_sec_cabinet_02a", "with_painting_exit_ch_prop_vault_painting_01a", "with_painting_exit_hei_p_m_bag_var22_arm_s", "with_painting_exit_w_me_switchblade"},
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}