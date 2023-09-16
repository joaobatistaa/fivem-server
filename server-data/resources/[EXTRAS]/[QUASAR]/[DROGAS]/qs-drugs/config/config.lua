Config = Config or {}

--░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
--██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
--██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
--██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
--╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
--░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝


Config.loadImportExportDlc = true --If your use externals ipl, use false.

Config.hasCar = false -- Take out vehicle without finishing the mission?

Config.Progbar = 'progressbar' -- Only support mythic_progbar or progressbar.

Config.policeJob = {
  ['police'] = true,
  --['sheriff'] = true,
  --['change_me'] = true, -- You can add the jobs so that the plantations are activated
}

--Remove them if you don't want blips, or add your own.
Config.Blips = {
  --{title="Weed", colour= 0, id= 469, x = 1320.04, y = 1870.26, z = 90.83},
  --{title="Chemicals", colour= 0, id= 469, x = 817.46, y = -3192.84, z = 5.9},
  --{title="Cocaine", colour= 0, id= 469, x = 16.34, y = 6875.94, z = 12.64},
  --{title="Weed Lab", colour= 0, id= 615, x = 183.03, y = -1836.59, z = 28.10},
  --{title="Meth Lab", colour= 0, id= 615, x = 1561.46, y = -1693.57, z = 89.21},
  --{title="Cocaine Lab", colour= 0, id= 615, x = 465.00, y = -1894.07, z = 25.90},
  --{title="Wash Money", colour= 0, id= 615, x = 887.38409, y = -953.7551, z = 39.21},
  --{title="Dealer", colour= 0, id= 310, x = -60.8, y = -1213.1, z = 28.1},
}

Config.okokTextUI = {
  enable = false, -- If you use false, by default there will be DrawText3D.
  colour = 'darkred', -- Change the color of your TextUI here.
  position = 'left', -- Change the position of the TextUI here.
}

Config.Marker = { --Modify the Marker as you like.
  type = 2, 
  scale = {x = 0.2, y = 0.2, z = 0.1}, 
  colour = {r = 71, g = 181, b = 255, a = 120},
  movement = 1 --Use 0 to disable movement.
}

Config.CustomerBlip = { --Modify the Blip as you like.
  sprite = 205, 
  color = 2, 
  scale = 0.5,
  name = '[Dealer] Ponto de Encontro',
}

Config.PoliceBlip = { --Modify the Blip as you like.
  sprite = 403, 
  color = 1, 
  scale = 1.2,
  alpha = 250,
  name = '[Drugs] Venda de Drogas',
}

function SendTextMessage(msg, type) --You can add your notification system here for simple messages.
  if type == 'inform' then 
    --SetNotificationTextEntry('STRING')
    --AddTextComponentString(msg)
    --DrawNotification(0,1)

    --MORE EXAMPLES OF NOTIFICATIONS.
    exports['qs-core']:Notify(msg, "primary")
    --exports['mythic_notify']:DoHudText('inform', msg)
  end
  if type == 'error' then 
    --SetNotificationTextEntry('STRING')
    --AddTextComponentString(msg)
    --DrawNotification(0,1)

    --MORE EXAMPLES OF NOTIFICATIONS.
    exports['qs-core']:Notify(msg, "error")
    --exports['mythic_notify']:DoHudText('error', msg)
  end
  if type == 'success' then 
    --SetNotificationTextEntry('STRING')
    --AddTextComponentString(msg)
    --DrawNotification(0,1)

    --MORE EXAMPLES OF NOTIFICATIONS.
    exports['qs-core']:Notify(msg, "success")
    --exports['mythic_notify']:DoHudText('success', msg)
  end
end

function DrawText3D(x, y, z, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(x,y,z, 0)
  DrawText(0.0, 0.0)
  local factor = (string.len(text)) / 370
  DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 55)
  ClearDrawOrigin()
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3D2(x, y, z, text)
	  SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 22)
    ClearDrawOrigin()
end


--░█████╗░███╗░░██╗██╗███╗░░░███╗░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
--██╔══██╗████╗░██║██║████╗░████║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
--███████║██╔██╗██║██║██╔████╔██║███████║░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
--██╔══██║██║╚████║██║██║╚██╔╝██║██╔══██║░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
--██║░░██║██║░╚███║██║██║░╚═╝░██║██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
--╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

SceneDicts = { --Animation dicts for scenes.
  Cocaine = {
    [1] = 'anim@amb@business@coc@coc_unpack_cut_left@',
    [2] = 'anim@amb@business@coc@coc_packing_hi@',
  },
  Meth = {
    [1] = 'anim@amb@business@meth@meth_monitoring_cooking@cooking@',
    [2] = 'anim@amb@business@meth@meth_smash_weight_check@',
  },
  Weed = {
    [1] = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
    [2] = 'anim@amb@business@weed@weed_sorting_seated@',
  }, 
  Money = {
    [1] = 'anim@amb@business@cfm@cfm_counting_notes@',
    [2] = 'anim@amb@business@cfm@cfm_cut_sheets@',
    [3] = 'anim@amb@business@cfm@cfm_drying_notes@',
  }
}

PlayerAnims = { --Animation for player within scenes.
  Cocaine = {
    [1] = 'coke_cut_v5_coccutter',
    [2] = 'full_cycle_v3_pressoperator'
  },
  Meth = {
    [1] = 'chemical_pour_short_cooker',
    [2] = 'break_weigh_v3_char01',
  },
  Weed = {
    [1] = 'weed_spraybottle_crouch_spraying_02_inspector',
    [2] = "sorter_right_sort_v3_sorter02",
  }, 
  Money = {
    [1] = 'note_counting_v2_counter',
    [2] = 'extended_load_tune_cut_billcutter',
    [3] = 'loading_v3_worker',
  }
}

SceneAnims = { --Animation for entities within scenes.
  Cocaine = {
    [1] = {
      bakingsoda  = 'coke_cut_v5_bakingsoda',
      creditcard1 = 'coke_cut_v5_creditcard',
      creditcard2 = 'coke_cut_v5_creditcard^1',     
    },
    [2] = {
      scoop     = 'full_cycle_v3_scoop',
      box1      = 'full_cycle_v3_FoldedBox',
      dollmold  = 'full_cycle_v3_dollmould',
      dollcast1 = 'full_cycle_v3_dollcast',
      dollcast2 = 'full_cycle_v3_dollCast^1',
      dollcast3 = 'full_cycle_v3_dollCast^2',
      dollcast4 = 'full_cycle_v3_dollCast^3',
      press     = 'full_cycle_v3_cokePress',
      doll      = 'full_cycle_v3_cocdoll',
      bowl      = 'full_cycle_v3_cocbowl',
      boxed     = 'full_cycle_v3_boxedDoll',
    },
  },
  Meth = {
    [1] = {
      ammonia   = 'chemical_pour_short_ammonia',
      clipboard = 'chemical_pour_short_clipboard',
      pencil    = 'chemical_pour_short_pencil',
      sacid     = 'chemical_pour_short_sacid',
    },
    [2] = {
      box1      = 'break_weigh_v3_box01',
      box2      = 'break_weigh_v3_box01^1',
      clipboard = 'break_weigh_v3_clipboard',
      methbag1  = 'break_weigh_v3_methbag01',
      methbag2  = 'break_weigh_v3_methbag01^1',
      methbag3  = 'break_weigh_v3_methbag01^2',
      methbag4  = 'break_weigh_v3_methbag01^3',
      methbag5  = 'break_weigh_v3_methbag01^4',
      methbag6  = 'break_weigh_v3_methbag01^5',
      methbag7  = 'break_weigh_v3_methbag01^6',
      pen       = 'break_weigh_v3_pen',
      scale     = 'break_weigh_v3_scale',
      scoop     = 'break_weigh_v3_scoop',     
    },
  },
  Weed = {
    [1] = {},
    [2] = {
      weeddry1  = 'sorter_right_sort_v3_weeddry01a',
      weeddry2  = 'sorter_right_sort_v3_weeddry01a^1',
      weedleaf1 = 'sorter_right_sort_v3_weedleaf01a',
      weedleaf2 = 'sorter_right_sort_v3_weedleaf01a^1',
      weedbag   = 'sorter_right_sort_v3_weedbag01a',
      weedbud1a = 'sorter_right_sort_v3_weedbud02b',
      weedbud2a = 'sorter_right_sort_v3_weedbud02b^1',
      weedbud3a = 'sorter_right_sort_v3_weedbud02b^2',
      weedbud4a = 'sorter_right_sort_v3_weedbud02b^3',
      weedbud5a = 'sorter_right_sort_v3_weedbud02b^4',
      weedbud6a = 'sorter_right_sort_v3_weedbud02b^5',
      weedbud1b = 'sorter_right_sort_v3_weedbud02a',
      weedbud2b = 'sorter_right_sort_v3_weedbud02a^1',
      weedbud3b = 'sorter_right_sort_v3_weedbud02a^2',
      bagpile   = 'sorter_right_sort_v3_weedbagpile01a',
      weedbuck  = 'sorter_right_sort_v3_bucket01a',
      weedbuck  = 'sorter_right_sort_v3_bucket01a^1',
    },
  },
  Money = {
    [1] = {
      binmoney  = 'note_counting_v2_binmoney',
      moneybin  = 'note_counting_v2_moneybin',
      money1    = 'note_counting_v2_moneyunsorted',
      money2    = 'note_counting_v2_moneyunsorted^1',
      wrap1     = 'note_counting_v2_moneywrap',
      wrap2     = 'note_counting_v2_moneywrap^1',
    },
    [2] = {
      cutter    = 'extended_load_tune_cut_papercutter',
      singlep1  = 'extended_load_tune_cut_singlemoneypage',
      singlep2  = 'extended_load_tune_cut_singlemoneypage^1',
      singlep3  = 'extended_load_tune_cut_singlemoneypage^2',
      table     = 'extended_load_tune_cut_table',
      stack     = 'extended_load_tune_cut_moneystack',
      strip1    = 'extended_load_tune_cut_singlemoneystrip',
      strip2    = 'extended_load_tune_cut_singlemoneystrip^1',
      strip3    = 'extended_load_tune_cut_singlemoneystrip^2',
      strip4    = 'extended_load_tune_cut_singlemoneystrip^3',
      strip5    = 'extended_load_tune_cut_singlemoneystrip^4',
      sinstack  = 'extended_load_tune_cut_singlestack',
    },
    [3] = {
      bucket    = 'loading_v3_bucket',
      money1    = 'loading_v3_money01',
      money2    = 'loading_v3_money01^1',
    }
  },
}

SceneItems = { --Objects for entities within scenes.
  Cocaine = {
    [1] = {
      bakingsoda  = 'bkr_prop_coke_bakingsoda_o',
      creditcard1 = 'prop_cs_credit_card',
      creditcard2 = 'prop_cs_credit_card',
    },
    [2] = {
      scoop     = 'bkr_prop_coke_fullscoop_01a',
      doll      = 'bkr_prop_coke_doll',
      boxed     = 'bkr_prop_coke_boxedDoll',
      dollcast1 = 'bkr_prop_coke_dollCast',
      dollcast2 = 'bkr_prop_coke_dollCast',
      dollcast3 = 'bkr_prop_coke_dollCast',
      dollcast4 = 'bkr_prop_coke_dollCast',
      dollmold  = 'bkr_prop_coke_dollmould',
      bowl      = 'bkr_prop_coke_fullmetalbowl_02',
      press     = 'bkr_prop_coke_press_01b',      
      box1      = 'bkr_prop_coke_dollboxfolded',
    },
  },
  Meth = {
    [1] = {
      ammonia   = 'bkr_prop_meth_ammonia',
      clipboard = 'bkr_prop_fakeid_clipboard_01a',
      pencil    = 'bkr_prop_fakeid_penclipboard',
      sacid     = 'bkr_prop_meth_sacid',
    },
    [2] = {
      box1      = 'bkr_prop_meth_bigbag_04a',
      box2      = 'bkr_prop_meth_bigbag_03a',
      clipboard = 'bkr_prop_fakeid_clipboard_01a',
      methbag1  = 'bkr_prop_meth_openbag_02',
      methbag2  = 'bkr_prop_meth_openbag_02',
      methbag3  = 'bkr_prop_meth_openbag_02',
      methbag4  = 'bkr_prop_meth_openbag_02',
      methbag5  = 'bkr_prop_meth_openbag_02',
      methbag6  = 'bkr_prop_meth_openbag_02',
      methbag7  = 'bkr_prop_meth_openbag_02',
      pen       = 'bkr_prop_fakeid_penclipboard',
      scale     = 'bkr_prop_coke_scale_01',
      scoop     = 'bkr_prop_meth_scoop_01a',     
    },
  },
  Weed = {
    [1] = {},
    [2] = {
      weeddry1  = 'bkr_prop_weed_dry_01a',
      weeddry2  = 'bkr_prop_weed_dry_01a',
      weedleaf1 = 'bkr_prop_weed_leaf_01a',
      weedleaf2 = 'bkr_prop_weed_leaf_01a',
      weedbag   = 'bkr_prop_weed_bag_01a',
      weedbud1a = 'bkr_prop_weed_bud_02b',
      weedbud2a = 'bkr_prop_weed_bud_02b',
      weedbud3a = 'bkr_prop_weed_bud_02b',
      weedbud4a = 'bkr_prop_weed_bud_02b',
      weedbud5a = 'bkr_prop_weed_bud_02b',
      weedbud6a = 'bkr_prop_weed_bud_02b',
      weedbud1b = 'bkr_prop_weed_bud_02a',
      weedbud2b = 'bkr_prop_weed_bud_02a',
      weedbud3b = 'bkr_prop_weed_bud_02a',
      bagpile   = 'bkr_prop_weed_bag_pile_01a',
      weedbuck  = 'bkr_prop_weed_bucket_open_01a',
      weedbuck  = 'bkr_prop_weed_bucket_open_01a',
    },
  },
  Money = {
    [1] = {
      binmoney  = 'bkr_prop_coke_tin_01',
      moneybin  = 'bkr_prop_tin_cash_01a',
      money1    = 'bkr_prop_money_unsorted_01',
      money2    = 'bkr_prop_money_unsorted_01',
      wrap1     = 'bkr_prop_money_wrapped_01',
      wrap2     = 'bkr_prop_money_wrapped_01',
    },
    [2] = {
      cutter    = 'bkr_prop_fakeid_papercutter',
      singlep1  = 'bkr_prop_cutter_moneypage',
      singlep2  = 'bkr_prop_cutter_moneypage',
      singlep3  = 'bkr_prop_cutter_moneypage',
      table     = 'bkr_prop_fakeid_table',
      stack     = 'bkr_prop_cutter_moneystack_01a',
      strip1    = 'bkr_prop_cutter_moneystrip',
      strip2    = 'bkr_prop_cutter_moneystrip',
      strip3    = 'bkr_prop_cutter_moneystrip',
      strip4    = 'bkr_prop_cutter_moneystrip',
      strip5    = 'bkr_prop_cutter_moneystrip',
      sinstack  = 'bkr_prop_cutter_singlestack_01a',
    },
    [3] = {
      bucket    = 'bkr_prop_money_pokerbucket',
      money1    = 'bkr_prop_money_unsorted_01',
      money2    = 'bkr_prop_money_unsorted_01',
    }
  },
}

allIpls = {
	--METH LAB
	{
		names = {"bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo"},
		interiorsProps = {
			
			"meth_lab_security_high",
			"meth_lab_setup",
			"meth_lab_upgrade",
			
		},
		coords={{1009.5, -3196.6, -38.99682}}
	},
	--WEED LAB
	{
		interiorsProps = {
			"weed_drying",
			"weed_production",
			"weed_upgrade_equip",
			"weed_growtha_stage3",
			"weed_growthc_stage1",
			"weed_growthd_stage1",
			"weed_growthe_stage2",
			"weed_growthf_stage2",
			"weed_growthg_stage1",
			"weed_growthh_stage3",
			"weed_growthi_stage2",
			"weed_hosea",
			"weed_hoseb",
			"weed_hosec",
			"weed_hosed",
			"weed_hosee",
			"weed_hosef",
			"weed_hoseg",
			"weed_hoseh",
			"weed_hosei",
			"light_growtha_stage23_upgrade",
			"light_growthb_stage23_upgrade",
			"light_growthc_stage23_upgrade",
			"light_growthc_stage23_upgrade",
			"light_growthd_stage23_upgrade",
			"light_growthe_stage23_upgrade",
			"light_growthf_stage23_upgrade",
			"light_growthg_stage23_upgrade",
			"light_growthh_stage23_upgrade",
			"light_growthi_stage23_upgrade",
			"weed_security_upgrade",
			"weed_chairs"
		},
		coords={{1051.491, -3196.536, -39.14842}}
	},
	--Cocaine LAB
	{
		interiorsProps = {
			
			"security_low",
			"security_high",
			"equipment_basic",
			"equipment_upgrade",
			"set_up",
			"production_basic",
			"production_upgrade",
			"table_equipment",
			"table_equipment_upgrade",
			"coke_press_upgrade",
			"coke_cut_01",
			"coke_cut_02",
			"coke_cut_03",
			"coke_cut_04",
			"coke_cut_05"
		},
		coords={{1093.6, -3196.6, -38.99841}}
	},
}