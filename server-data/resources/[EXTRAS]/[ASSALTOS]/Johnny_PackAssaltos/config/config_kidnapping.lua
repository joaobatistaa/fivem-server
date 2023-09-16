Config['Kidnapping'] = {
	['requiredPoliceCount'] = 2,
    ['nextNapping'] = 500, -- seconds
    ['start'] = { -- start boss ped
        ped = {model = 'a_m_m_soucent_02', pos = vector3(-2201.45, -403.341, 9.3344), heading = 74.63}
    },
    ['randomSpawnCoords'] = { -- kidnapped ped spawn
        {pos = vector3(1666.559, 0.537445, 166.11), heading = 80.11},
        {pos = vector3(1666.046, 1.814250, 166.11), heading = 160.30},
        {pos = vector3(1665.684, -0.37126, 166.11), heading = 350.30}
    },
    ['query'] = {
        scenePos = vector3(568.450, -3123.8, 18.7686),
        sceneRot = vector3(0.0, 0.0, -90.0),
        laptopScenePos = vector3(565.9, -3123.0, 18.7686),
        laptopSceneRot = vector3(0.0, 0.0, 0.0),
        tripodPos = vector3(570.572, -3123.8, 17.7086),
        cameraPos = vector3(570.572, -3123.755, 19.2986),
        cameraHeading = -90.0
    },
    videoRecordItem = 'video_record', -- add database item
    pedToKidnapped = 'a_m_m_prolhost_01',
    rewardCash = 50000, -- reward cash to video record
    randomRewardItems = { -- reward random item for sell video record
        'diamond',
        'gold'
    },
    ['objects_1'] = {
        'prop_cs_wrench'
    },
    ['animations_1'] = {
        {'wrench_idle_player', 'wrench_idle_victim', 'wrench_idle_chair', 'wrench_idle_wrench'},
        {'wrench_attack_left_player', 'wrench_attack_left_victim', 'wrench_attack_left_chair', 'wrench_attack_left_wrench'},
        {'wrench_attack_mid_player', 'wrench_attack_mid_victim', 'wrench_attack_mid_chair', 'wrench_attack_mid_wrench'},
        {'wrench_attack_right_player', 'wrench_attack_right_victim', 'wrench_attack_right_chair', 'wrench_attack_right_wrench'},
    },
    ['objects_2'] = {
        'w_am_jerrycan',
        'p_loose_rag_01_s'
    },
    ['animations_2'] = {
        {'waterboard_idle_player', 'waterboard_idle_victim', 'waterboard_idle_chair', 'waterboard_idle_jerrycan', 'waterboard_idle_rag'},
        {'waterboard_kick_player', 'waterboard_kick_victim', 'waterboard_kick_chair', 'waterboard_kick_jerrycan', 'waterboard_kick_rag'},
        {'waterboard_loop_player', 'waterboard_loop_victim', 'waterboard_loop_chair', 'waterboard_loop_jerrycan', 'waterboard_loop_rag'},
        {'waterboard_outro_player', 'waterboard_outro_victim', 'waterboard_outro_chair', 'waterboard_outro_jerrycan', 'waterboard_outro_rag'}
    },
    ['objects_3'] = {
        'prop_pliers_01'
    },
    ['animations_3'] = {
        {'pull_tooth_intro_player', 'pull_tooth_intro_victim', 'pull_tooth_intro_pliers'},
        {'pull_tooth_idle_player', 'pull_tooth_idle_victim', 'pull_tooth_idle_pliers'},
        {'pull_tooth_loop_player', 'pull_tooth_loop_victim', 'pull_tooth_loop_pliers'},
        {'pull_tooth_outro_b_player', 'pull_tooth_outro_b_victim', 'pull_tooth_outro_b_pliers'},
    }
}

StringsKidnapping = {
	['attack_left'] = 'Pressiona ~INPUT_CONTEXT~ para atacares à esquerda',
	['attack_mid'] = 'Pressiona ~INPUT_CONTEXT~ para atacares no meio',
	['attack_right'] = 'Pressiona ~INPUT_CONTEXT~ para atacares à direita',
	['switch_jerrycan'] = 'Pressiona ~INPUT_CONTEXT~ para trocar para o galão',
	['switch_pliers'] = 'Pressiona ~INPUT_CONTEXT~ para trocar para os alicates',
	['tooth_pull'] = 'Pressiona ~INPUT_CONTEXT~ para puxar o dente',
	['tooth_rip'] = 'Pressiona ~INPUT_CONTEXT~ para arrancar o dente',
	['blindfold'] = 'Pressiona ~INPUT_CONTEXT~ para colocar a venda nos olhos',
	['cant_blindfold'] = 'Estás muito longe para colocar a venda!',
	['police_alert'] = 'Alerta de sequestro! Verifica o teu GPS.',
	['query_room_busy'] = 'Sala de interrogatório ocupada, aguarda um pouco.',
	['wait_nextnapping'] = 'Tens de aguardar',
	['minute'] = 'minutos para iniciares um novo trabalho!',
	['get_job'] = 'Pressiona ~INPUT_CONTEXT~ para obteres um trabalho',
	['finish_job'] = 'Pressiona ~INPUT_CONTEXT~ para terminar o trabalho',
	['get_videorecord'] = 'Pressiona ~INPUT_CONTEXT~ para obter o registro em vídeo',
	['check_videorecord'] = 'Pressiona ~INPUT_CONTEXT~ para verificar o registro em vídeo',
	['go_laptop'] = 'Vá ao laptop para verificar o registro em vídeo.',
	['mission_failed'] = 'Missão falhada. A pessoa sequestrada está morta.',
	['mission_failed2'] = 'Missão falhada. Afastaste-te muito da pessoa sequestrada.',
	['kidnap_blip'] = 'Sequestro a decorrer',
	['boss_blip'] = 'Vender Registro em Vídeo',
	['info_1'] = 'Eu quero que você encontre uma pessoa para mim. Verifica o GPS. Há algumas coisas que tens de perguntar para aquele homem.',
	['info_2'] = 'Podes libertá-lo depois de obteres as respostas que eu preciso. Tens que obter as respostas.',
	['info_3'] = 'Não te esqueças de gravar o vídeo!',
	['go_query'] = 'Vá para a sala de interrogatório.',
	['start_query'] = 'Pressiona ~INPUT_CONTEXT~ para começar o interrogatório',
	['leave_vehicle'] = 'Pressiona ~INPUT_CONTEXT~ para retirar a vítima do carro',
	['drop_chair'] = 'Pressiona ~INPUT_CONTEXT~ para empurrar a cadeira',
	['pour_gasoline'] = 'Pressiona ~INPUT_CONTEXT~ para derramar gasolina',
	['up_chair'] = 'Pressiona ~INPUT_CONTEXT~ para levantar a cadeira'
}