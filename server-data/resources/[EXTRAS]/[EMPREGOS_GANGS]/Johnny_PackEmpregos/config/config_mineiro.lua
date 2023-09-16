Config.ItemWeightSystem		= true						-- Set this to true if you are using weight instead of limit.
Config.ProgressBars			= true						-- set to false to disable my progressBars and add your own in the script.

Config.MineiroUniforms = {
	cloakroom = {
		male = {
			['tshirt_1'] = 112,  ['tshirt_2'] = 0,
			['torso_1'] = 350,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 73,
			['pants_1'] = 170,   ['pants_2'] = 1,
			['shoes_1'] = 112,   ['shoes_2'] = 1,
			['helmet_1'] = 97,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 318,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 69,
			['pants_1'] = 162,   ['pants_2'] = 0,
			['shoes_1'] = 88,   ['shoes_2'] = 0,
			['helmet_1'] = 155,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 5
		}
	}
}

Config.MineiroVestiario = {
	[1] = {
		pos = {2831.662, 2799.804, 57.523},
		blip = {enable = true, str = 'Vestiário', sprite = 365, display = 4, color = 5, scale = 1.1},
		marker = {enable = true, drawDist = 100.0, type = 2, color = {r = 71, g = 181, b = 255, a = 120}, scale = {x = 0.4, y = 0.4, z = 0.2}},
		drawText = '~b~[E]~s~ Trocar de Roupa',
		keybind = 38,
	},
}

Config.MineiroVeiculo = {
	[1] = {
		pos = {2828.049, 2797.435, 57.641},
		blip = {enable = true, str = 'Garagem Mineiro', sprite = 365, display = 4, color = 5, scale = 1.1},
		marker = {enable = true, drawDist = 100.0, type = 2, color = {r = 71, g = 181, b = 255, a = 120}, scale = {x = 0.4, y = 0.4, z = 0.2}},
		drawText = '~b~[E]~s~ Retirar Veículo',
		keybind = 38,
	},
}

-- Mining Spots:
Config.Mining = {
	[1] = {
		pos = {2972.12, 2841.38, 46.02, 284.1},
		inUse = false,
		blip = {enable = true, str = 'Pedreira', sprite = 85, display = 4, color = 5, scale = 1.1},
		marker = {enable = true, drawDist = 15, type = 2, color = {r = 30, g = 139, b = 195, a = 170}, scale = {x = 0.5, y = 0.5, z = 0.3}},
		drawText = '~b~[E]~s~ Minerar',
		keybind = 38,
	},
	[2] = {
		pos = {2973.16, 2837.92, 45.69, 284.1},
		inUse = false,
		blip = {enable = false, str = 'Pedreira', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 15, type = 2, color = {r = 30, g = 139, b = 195, a = 170}, scale = {x = 0.5, y = 0.5, z = 0.3}},
		drawText = '~b~[E]~s~ Minerar',
		keybind = 38,
	},
	[3] = {
		pos = {2974.26, 2834.10, 45.74, 284.1},
		inUse = false,
		blip = {enable = false, str = 'Pedreira', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 15, type = 2, color = {r = 30, g = 139, b = 195, a = 170}, scale = {x = 0.5, y = 0.5, z = 0.3}},
		drawText = '~b~[E]~s~ Minerar',
		keybind = 38,
	},
	[4] = {
		pos = {2958.47, 2851.04, 47.44, 284.1},
		inUse = false,
		blip = {enable = false, str = 'Pedreira', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 15, type = 2, color = {r = 30, g = 139, b = 195, a = 170}, scale = {x = 0.5, y = 0.5, z = 0.3}},
		drawText = '~b~[E]~s~ Minerar',
		keybind = 38,
	},
	[5] = {
		pos = {2977.588, 2831.150, 46.228, 300.63873291016},
		inUse = false,
		blip = {enable = false, str = 'Pedreira', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 15, type = 2, color = {r = 30, g = 139, b = 195, a = 170}, scale = {x = 0.5, y = 0.5, z = 0.3}},
		drawText = '~b~[E]~s~ Minerar',
		keybind = 38,
	},
	[6] = {
		pos = {2979.696, 2825.716, 45.727, 299.29556274414},
		inUse = false,
		blip = {enable = false, str = 'Pedreira', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 15, type = 2, color = {r = 30, g = 139, b = 195, a = 170}, scale = {x = 0.5, y = 0.5, z = 0.3}},
		drawText = '~b~[E]~s~ Minerar',
		keybind = 38,
	}
}

-- Mining Reward Settings:
Config.MiningReward = {min = 1, max = 1}

-- Washing Spots:
Config.Washing = {
	[1] = {
		pos = {1966.86, 536.98, 159.92},
		blip = {enable = true, str = 'Lavagem da Pedra', sprite = 365, display = 4, color = 5, scale = 1.1},
		marker = {enable = true, drawDist = 100.0, type = 1, color = {r = 0, g = 200, b = 150, a = 170}, scale = {x = 5.0, y = 5.0, z = 2.0}},
		drawText = '~b~[E]~s~ Lavagem de Pedra',
		keybind = 38,
	},
	[2] = {
		pos = {1994.04, 562.95, 160.38},
		blip = {enable = false, str = 'Lavagem da Pedra', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 100.0, type = 1, color = {r = 0, g = 200, b = 150, a = 170}, scale = {x = 5.0, y = 5.0, z = 2.0}},
		drawText = '~b~[E]~s~ Lavagem de Pedra',
		keybind = 38,
	},
	[3] = {
		pos = {1976.528, 524.8822, 160.56},
		blip = {enable = false, str = 'Lavagem da Pedra', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 100.0, type = 1, color = {r = 0, g = 200, b = 150, a = 170}, scale = {x = 5.0, y = 5.0, z = 2.0}},
		drawText = '~b~[E]~s~ Lavagem de Pedra',
		keybind = 38,
	},
	[4] = {
		pos = {1962.670, 482.8681, 159.78},
		blip = {enable = false, str = 'Lavagem da Pedra', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 100.0, type = 1, color = {r = 0, g = 200, b = 150, a = 170}, scale = {x = 5.0, y = 5.0, z = 2.0}},
		drawText = '~b~[E]~s~ Lavagem de Pedra',
		keybind = 38,
	}
}

-- Wash Settings & Rewards
Config.WashSettings = {
	input = 10,				-- required stone to wash
	output = {
		min = 7,			-- minimum output of washed stone
		max = 10			-- maximum output of washed stone
	}
}

-- Smelting Spots:
Config.Smelting = {
	[1] = {
		pos = {1088.08, -2001.52, 30.87, 139.3},
		blip = {enable = true, str = 'Fundição', sprite = 436, display = 4, color = 5, scale = 1.1},
		marker = {enable = true, drawDist = 12.0, type = 27, color = {r = 240, g = 52, b = 52, a = 100}, scale = {x = 1.25, y = 1.25, z = 1.25}},
		drawText = '~r~[E]~s~ Fundição',
		keybind = 38,
	},
	[2] = {
		pos = {1088.51, -2005.12, 31.15, 60.69},
		blip = {enable = false, str = 'Fundição', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 12.0, type = 27, color = {r = 240, g = 52, b = 52, a = 100}, scale = {x = 1.25, y = 1.25, z = 1.25}},
		drawText = '~r~[E]~s~ Fundição',
		keybind = 38,
	},
	[3] = {
		pos = {1084.61, -2001.91, 239.11},
		blip = {enable = false, str = 'Fundição', sprite = 365, display = 4, color = 5, scale = 0.65},
		marker = {enable = true, drawDist = 12.0, type = 27, color = {r = 240, g = 52, b = 52, a = 100}, scale = {x = 1.25, y = 1.25, z = 1.25}},
		drawText = '~r~[E]~s~ Fundição',
		keybind = 38,
	}
}

-- Smelting Settings & Reward:
Config.SmeltingSettings = {
	input = 5,
	reward = {
		[1] = {item = 'diamond', chance = 10, amount = {min = 1, max = 2}},
		[2] = {item = 'gold', chance = 20, amount = {min = 1, max = 2}},
		[3] = {item = 'iron', chance = 50, amount = {min = 1, max = 3}},
		[4] = {item = 'copper', chance = 80, amount = {min = 2, max = 4}},
		[5] = {item = 'steel', chance = 80, amount = {min = 2, max = 4}},
	}
}

-- Smelting Spots:
Config.SellMineiro = {
	[1] = {
		pos = {-195.972, 6265.392, 31.489, 219.7},
		blip = {enable = true, str = 'Venda de Itens de Mineração', sprite = 515, display = 4, color = 5, scale = 1.1},
		marker = {enable = true, drawDist = 12.0, type = 27, color = {r = 240, g = 52, b = 52, a = 100}, scale = {x = 1.25, y = 1.25, z = 1.25}},
		drawText = '~r~[E]~s~ Vender Itens de Mineração',
		keybind = 38,
	},
}

Config.PricesMineiro = {
        -- ['item'] = {min, max} --
        ['copper']  = {50, 250}, -- MINERIOS PREÇOS
		['steel']   = {250, 400},
        ['iron']    = {400, 600},
        ['gold']    = {700, 1000},
        ['diamond'] = {1300, 1900}
}

-- Config Database ITems:
Config.DatabaseItemsMineiro = {
	['pickaxe'] = 'picareta',
	['stone'] = 'stone',
	['washed_stone'] = 'washed_stone',
	['uncut_diamond'] = 'uncut_diamond',
	['uncut_rubbies'] = 'uncut_rubbies',
	['gold'] = 'gold',
	['silver'] = 'silver',
	['copper'] = 'copper',
	['iron_ore'] = 'iron_ore'
}
