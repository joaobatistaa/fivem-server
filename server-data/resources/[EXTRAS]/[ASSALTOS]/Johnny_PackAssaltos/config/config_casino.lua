Config['CasinoHeist'] = {
	['requiredPoliceCount'] = 8, -- Required police count for start heist
    ['nextHeist'] = 7200, -- seconds
    ['requiredItems'] = { -- you need to add them to database
        startKey = 'cardlvl1',
        basementKey = 'cardlvl2',
        drill = 'drill',
    },
    ['rewardItems'] = { -- you need to add them to database
        diamondTrolly = { 
            item = 'diamond', --item code
            count = 1, -- reward count
            sellPrice = 5000, -- for buyer sell price
        },
        goldTrolly = { 
            item = 'gold', 
            count = 1,
            sellPrice = 4000,
        },
        cokeTrolly = { 
            item = 'cocaine_packaged', 
            count = 1,
            sellPrice = 3500,
        },
        cashTrolly = { 
            item = 'black_money', -- cash
            count = 13500
        },
        lockbox = function()
            local items = {Config['CasinoHeist']['rewardItems']['diamondTrolly'], Config['CasinoHeist']['rewardItems']['goldTrolly']}
            local random = math.random(1, 2)
            local lockbaxBag = { -- random diamond or gold for lockbox drill reward
                item = items[random].item,
                count = 5
            }
            return lockbaxBag
        end,
    },
    ['startHeist'] = {
        ['cardSwipe'] = {
            scenePos = vector3(972.299, 50.9161, 120.625), -- swipe card animation position
            sceneRot = vector3(0.0, 0.0, 150.0), -- swipe card animation rotation
            swipeTeleport = vector3(2522.06, -244.12, -24.114), -- teleport after swipe
            startRappel = vector3(2517.70, -258.12, -25.114), -- start rappel action
            finishRappel = vector3(2571.85, -255.37, -145.35), -- finish rappel and play cutscene
            rappelTeleport = vector3(2512.93, -268.74, -59.623) -- teleport after rappel finish
        },
        ['rappel']= { -- rappel coords (enough)
            { coords = vector3(2570.48, -253.72, -64.660), busy = false},
            { coords = vector3(2571.48, -253.72, -64.660), busy = false},
            { coords = vector3(2572.53, -253.72, -64.660), busy = false},
            { coords = vector3(2573.53, -253.72, -64.660), busy = false},
            { coords = vector3(2574.53, -253.72, -64.660), busy = false},
        }
    },
    ['middleHeist'] = {
        ['guardPeds'] = { -- guard ped list (u can add new)
            { coords = vector3(2538.61, -274.93, -58.722), heading = 270.87, model = 'csb_tomcasino'},
            { coords = vector3(2540.50, -265.78, -58.723), heading = 177.93, model = 'csb_vincent'},
            { coords = vector3(2534.91, -284.13, -58.722), heading = 354.93, model = 'cs_fbisuit_01'},
            { coords = vector3(2534.66, -281.70, -58.722), heading = 177.88, model = 'cs_andreas'},
            { coords = vector3(2511.90, -275.53, -58.722), heading = 268.28, model = 'cs_casey'},
            { coords = vector3(2507.68, -278.53, -60.123), heading = 268.3, model = 'cs_stevehains'},
            { coords = vector3(2527.67, -280.25, -70.644), heading = 359.44, model = 's_m_m_armoured_02'},
            { coords = vector3(2488.03, -279.22, -70.694), heading = 265.05, model = 'cs_fbisuit_01'},
            { coords = vector3(2490.69, -263.38, -70.694), heading = 174.77, model = 'csb_vincent'},
            { coords = vector3(2477.92, -270.25, -70.694), heading = 180.79, model = 'cs_andreas'},
        },
        ['nightvision'] = {
            time = 20, -- seconds
            startPos = vector3(2515.47, -283.91, -70.709), -- emp start position
            baseDoors = { -- middle basement doors
                {coords = vector3(2475.37, -277.89, -70.694)},
                {coords = vector3(2475.41, -280.35, -70.694)}
            },
            baseKeypads = { -- middle basement keypads object
                {coords = vector3(2464.64, -276.69, -70.494), heading = 70.15},
                {coords = vector3(2464.64, -281.81, -70.494), heading = 110.15}
            }
        },
        ['vaultAction'] = {
            pos = vector3(2504.06, -239.36, -70.713), -- vault pos
            vaultScenePos = vector3(2504.97, -239.3403, -70.41885),
            vaultSceneRot = vector3(0.0, 0.0, 270.0)
        },
        ['vaultInside'] = {
			['changeObjects'] = {
                --trolly (spawn new trolly) (u can add new)
                {  type = 'trolly', oldModel = 769923921, newModel = 881130828, coords = vector3(2524.77, -233.19, -71.737), heading = 44.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 881130828, coords = vector3(2517.12, -244.09, -71.737), heading = 44.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 269934519, coords = vector3(2518.17, -232.67, -71.737), heading = 204.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 269934519, coords = vector3(2517.17, -233.37, -71.737), heading = 224.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 2007413986, coords = vector3(2526.97, -241.63, -71.737), heading = 44.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 3031213828, coords = vector3(2523.12, -238.04, -71.737), heading = 284.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 3031213828, coords = vector3(2519.02, -238.71, -71.737), heading = 94.43, grab = false},
                --lockbox (they change with previous lockboxs on the map) (u can add but be careful when adding the coordinates because they are next to each other)
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2505.717, -251.9883, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2514.496, -257.8517, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2507.585, -223.1983, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2509.714, -221.5831, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2514.471, -219.1976, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2517.065, -218.5365, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2522.377, -218.1872, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2527.617, -219.2026, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2530.077, -220.2199, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2534.500, -253.8684, -71.73707), heading = nil, grab = false},
            },
            ['keypads'] = { -- inside vault keypads
                { coords = vector3(2519.75, -250.6, -70.437), heading = 182.01, hacked = false},
                { coords = vector3(2533.1, -237.27, -70.437), heading = 269.0, hacked = false},
                { coords = vector3(2519.78, -226.47, -70.437), heading = 2.0, hacked = false},
            }
        }
    },
    ['finishHeist'] = {
        pos = vector3(2549.56, -269.40, -59.722),
        outsidePos = vector3(997.782, 44.1079, 80.9902),
        buyerPos = vector3(206.044, 7033.86, 1.15580),
    }
}

StringsCasino = {
    ['start_heist'] = 'Pressiona ~INPUT_CONTEXT~ para iniciar o Assalto ao Casino',
    ['wait_nextheist'] = 'Tens de aguardar',
    ['minute'] = 'minutos para iniciares um novo assalto!',
    ['need_item'] = 'Precisas de: ',
    ['police_alert'] = 'Assalto a decorrer no Casino! Verifica o teu GPS.',
    ['go_rappel'] = 'Vá para o rapel',
    ['rappels_busy'] = 'Todos os rapéis estão ocupados, tenta novamente em segundos.',
    ['rappel_start'] = 'Pressiona ~INPUT_CONTEXT~ para fazer rapel',
    ['rappel_action'] = '~INPUT_MOVE_DOWN_ONLY~ Baixo / ~INPUT_PICKUP~ Escorregar',
    ['go_base'] = 'Vá para o porão',
    ['emp_activated'] = 'Visão Noturna ativa!',
    ['emp_deactivated'] = 'Visão Noturna desativada! Vá para as portas do meio.',
    ['swipe_card_base'] = 'Pressiona ~INPUT_CONTEXT~ para passar o cartão',
    ['door_opened'] = 'As portas foram abertas. Vá para o cofre.',
    ['laser_drill'] = 'Pressiona ~INPUT_CONTEXT~ para usar o laser de perfuração',
    ['vault_open'] = 'Rápido! Verifica no GPS para sair do casino. Irás precisar de usar a porta reservada aos funcionários novamente.',
    ['grab'] = 'Pressiona ~INPUT_CONTEXT~ para pegar o carrinho',
    ['lockbox_drill'] = 'Pressiona ~INPUT_CONTEXT~ para usar a broca na caixa de segurança',
    ['hack_keypad'] = 'Pressiona ~INPUT_CONTEXT~ para hackear o teclado',
    ['exit_casino'] = 'Pressiona ~INPUT_CONTEXT~ para sair do casino',
    ['deliver_to_buyer'] = 'Entrega o que roubaste ao comprador',
    ['base_blip'] = 'Porão',
    ['middle_doors_blip'] = 'Portas do meio',
    ['vault_blip'] = 'Cofre',
    ['exit_blip'] = 'Saída do casino',
    ['buyer_blip'] = 'Comprador'
}

--Dont change cuzz those main and required things.
LaserDrillCasino = {
    ['animations'] = {
        {'intro', 'bag_intro', 'intro_drill_bit'},
        {'drill_straight_start', 'bag_drill_straight_start', 'drill_straight_start_drill_bit'},
        {'drill_straight_end_idle', 'bag_drill_straight_idle', 'drill_straight_idle_drill_bit'},
        {'drill_straight_fail', 'bag_drill_straight_fail', 'drill_straight_fail_drill_bit'},
        {'drill_straight_end', 'bag_drill_straight_end', 'drill_straight_end_drill_bit'},
        {'exit', 'bag_exit', 'exit_drill_bit'},
    },
    ['scenes'] = {}
}

LockboxCasino = {
    ['objects'] = {
        'ch_prop_vault_drill_01a',
        'hei_p_m_bag_var22_arm_s',
        'ch_prop_ch_moneybag_01a'
    },
    ['animations'] = {
        {'enter', 'enter_ch_prop_ch_sec_cabinet_01abc', 'enter_ch_prop_vault_drill_01a', 'enter_p_m_bag_var22_arm_s'},
        {'action', 'action_ch_prop_ch_sec_cabinet_01abc', 'action_ch_prop_vault_drill_01a', 'action_p_m_bag_var22_arm_s'},
        {'reward', 'reward_ch_prop_ch_sec_cabinet_01abc', 'reward_ch_prop_vault_drill_01a', 'reward_p_m_bag_var22_arm_s', 'reward_ch_prop_ch_moneybag_01a'},
        {'no_reward', 'no_reward_ch_prop_ch_sec_cabinet_01abc', 'no_reward_ch_prop_vault_drill_01a', 'no_reward_p_m_bag_var22_arm_s'},
    }
}

TrollyCasino = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'intro', 'bag_intro'},
        {'grab', 'bag_grab', 'cart_cash_dissapear'},
        {'exit', 'bag_exit'}
    }
}

HackKeypadCasino = {
    ['animations'] = {
        {'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing'},
        {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
        {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
        {'fail_react', 'fail_react_ch_prop_ch_usb_drive01x', 'fail_react_prop_phone_ing'},
        {'reattempt', 'reattempt_ch_prop_ch_usb_drive01x', 'reattempt_prop_phone_ing'},
    },
    ['scenes'] = {}
}