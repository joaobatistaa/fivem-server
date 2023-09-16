Config = {}

Config.webhook = "https://discord.com/api/webhooks/1079106355983564850/mMoZzBxYybfQpoyUaVDUv3nnFLj9r0QKnQzeUo2hZCvJhIZM6KBCiOkN3YxmkJbTf8Co"						-- Webhook to send logs for discord
Config.lang = "br"								-- Set the file language [en/br]

Config.ESX = {									-- ESX settings, if you are using vRP, ignore
	['ESXSHAREDOBJECT'] = "esx:getSharedObject",-- Change your getshared object event here if you are using anti-cheat
}

Config.format = {
	['currency'] = 'EUR',						-- This is the currency format, so your currency symbol appears correctly [Examples: BRL, USD]
	['location'] = 'pt-PT'						-- This is your country location, to format the decimal places according to your pattern [Examples: pt-BR, en-US]
}

Config.command = "menutunning"						-- Command to open the menu (Event to open the menu if you want to trigger it from somewhere: TriggerEvent ('advanced_vehicles: showStatusUI'))
Config.Jobs = {'mechanic', 'police', 'redline'}			-- Jobs to perform actions in menu (set to false to disable permission)
Config.UseT1gerMechanic = false                  -- If set to true Vehicles will use the CarJack (toolbox) and Lift (mechanic_toolbox) from the t1ger_mechanic script. Look at the Readme for using this

Config.allVehicles = false						-- true: only cars will be available / false: all vehicles will be available
Config.itemToInspect = "scanner"				-- Item required to inspect vehicles

Config.NitroAmount = 250						-- Amount of nitro for each charge
Config.NitroRechargeTime = 20					-- Nitro recharge time
Config.NitroRechargeAmount = 10					-- Quantity of loads
-- You can set 2 keys for nitro
Config.NitroKey1 = 19 	-- ALT
Config.NitroKey2 = 210 	-- CTRL

Config.oil = "oil"								-- Oil index configured in Config.maintenance
-- Config for car services
Config.maintenance = {
	['default'] = { -- default means if you don't have a setting for the specific vehicle, it will default to
		['oil'] = {								-- Index
			['lifespan'] = 1500,				-- Number of KMs until the car needs service
			['damage'] = {
				['type'] = 'engine',			-- Damage type: engine: this will damage the vehicle's engine
				['amount_per_km'] = 0.0001,		-- This is the base value (in percentage) that the car will suffer damage for every km it runs [maximum engine health is 1000, so 0.0001 of 1000 is 0.1 | The maximum value for handling is obtained from the vehicle's handling.meta file]
				['km_threshold'] = 100,			-- This is the limit to increase the multiplier, so the multiplier will increase each time the player passes this km [Set this value to 99999 if you don't want the multiplier to work]
				['multiplier'] = 1.2,			-- This is the damage multiplier, this value will cause the car to take even more damage after the player has used the car longer [This value cannot be less than 1.0 | Set this value to 1.0 if you don't want the multiplier to work]
				['min'] = 0,					-- This is the minimum value that the piece's health can reach when taking damage.
				['destroy_engine'] = false		-- Will cause the car to stop running if the engine reaches the minimum value [applicable only when type = engine]
			},
			['repair_item'] = {
				['name'] = 'oil',				-- Item to do the car service
				['amount'] = 2,					-- Quantity of items
				['time'] = 10					-- repair time
			},
			['interface'] = {
				['name'] = 'Óleo do Motor',					-- Interface name
				['icon_color'] = '#ffffff00',				-- Background color in interface
				['icon'] = 'images/maintenance/oil.png',	-- Image
				['description'] = 'É necessário manter o óleo novo e limpo para teres o teu motor saudável',	-- Description
				['index'] = 0								-- This index means that items are ordered in the interface, 0 will be first, 1...
			}
		},
		['tires'] = {
			['lifespan'] = 5000,
			['damage'] = {
				['type'] = 'CHandlingData',			-- This will damage the physics of the vehicle (handling.meta)
				['handId'] = 'fTractionCurveMax',	-- Index on handling.meta
				['amount_per_km'] = 0.0001,			-- By setting 0.0001 (in quantity_per_km), 100 (in km limit) and 1.2 (in multiplier), the car will run approximately 1,300 km before reaching the minimum value
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.5
			},
			['repair_item'] = {
				['name'] = 'tires',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pneus',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/tires.png',
				['description'] = 'Os pneus são usados para manter o teu veículo equilibrado, pneus gastos farão com que o teu veículo derrape mais facilmente',
				['index'] = 1
			}
		},
		['brake_pads'] = {
			['lifespan'] = 4000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'brake_pads',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pastilhas dos Travões',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/brake_pads.png',
				['description'] = 'As pastilhas do travão são fundamentais para fazer o teu carro parar durante uma travagem.',
				['index'] = 2
			}
		},
		['transmission_oil'] = {
			['lifespan'] = 30000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveMaxFlatVel',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 100.0
			},
			['repair_item'] = {
				['name'] = 'transmission_oil',
				['amount'] = 2,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Óleo para Transmissão',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/transmission_oil.png',
				['description'] = 'É fundamental manter o óleo limpo para que a transmissão funcione corretamente.',
				['index'] = 3
			}
		},
		['shock_absorber'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'shock_absorber',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Amortecedores',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/shocks.png',
				['description'] = 'A tua suspensão depende de um bom amortecedor.',
				['index'] = 4
			}
		},
		['clutch'] = {
			['lifespan'] = 35000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'clutch',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Embreagem',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/clutch.png',
				['description'] = 'Velocidade da embreagem ao aumentar/reduzir as mudanças.',
				['index'] = 5
			}
		},
		['air_filter'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.00005,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = false
			},
			['repair_item'] = {
				['name'] = 'air_filter',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Filtro de Ar',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/air_filter.png',
				['description'] = 'O teu motor precisa respirar através de um bom filtro de ar.',
				['index'] = 6
			}
		},
		['fuel_filter'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.00005,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = false
			},
			['repair_item'] = {
				['name'] = 'fuel_filter',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Filtro de Combustível',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/fuel_filter.png',
				['description'] = 'O nome fala por si para a função: evitar a passagem de lixo do tanque de combustível do veículo para o motor',
				['index'] = 7
			}
		},
		['spark_plugs'] = {
			['lifespan'] = 15000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'spark_plugs',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Velas de Ignição',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/spark_plugs.png',
				['description'] = 'As velas de ignição são necessárias para gerar a energia necessária para o motor funcionar corretamente',
				['index'] = 8
			}
		},
		['serpentine_belt'] = {
			['lifespan'] = 20000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = true
			},
			['repair_item'] = {
				['name'] = 'serpentine_belt',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Correia de Distribuição',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/serpentine_belt.png',
				['description'] = 'A correia de distribuição coordena a abertura e o fechamento das válvulas do motor, bem como o movimento dos pistões no cilindro e virabrequim',
				['index'] = 9
			}
		},
	},
	--[[['panto'] = {	-- If you enable this, the panto car will have these settings
		['example'] = {
			['lifespan'] = 999,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'example',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Example',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/example.png',
				['description'] = 'Example',
				['index'] = 9
			}
		},
	}]]
}

-- Upgrades availables
Config.upgrades = {
	['default'] = {
		['susp'] = {	-- Index
			['improvements'] = {
				['type'] = 'CHandlingData',			-- CHandlingData: will affect vehicle physics
				['handId'] = 'fSuspensionRaise',	-- The index in handling.meta
				['value'] = -0.2,					-- Changing value
				['fixed_value'] = false				-- This means whether the value will be relative or absolute (fixed)
			},
			['item'] = {
				['name'] = 'susp',					-- Item required to update
				['amount'] = 1,						-- Quantity of items
				['time'] = 10						-- Time
			},
			['interface'] = {
				['name'] = 'Suspensão Muito Baixa',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp.png',
				['description'] = 'Troque a suspensão por um conjunto extremamente reduzido. Adequado apenas para pickups e veículos altos.',
				['index'] = 0
			},
			['class'] = 'suspension'
		},
		['susp1'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp1',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspensão Baixa',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp1.png',
				['description'] = 'Instala um conjunto de molas curtas para abaixar o veículo ao extremo. Pode tornar o teu veículo instável. Não é adequado para veículos baixos.',
				['index'] = 1
			},
			['class'] = 'suspension'
		},
		['susp2'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.05,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp2',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspensão Desportiva',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp2.png',
				['description'] = 'Instala uma mola desportiva para reduzir a altura do veículo. Não é adequado para veículos que já estão baixos.',
				['index'] = 2
			},
			['class'] = 'suspension'
		},
		['susp3'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp3',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspensão Confortável',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp3.png',
				['description'] = 'Aumenta ligeiramente a altura da suspensão para dar mais conforto e segurança aos passageiros.',
				['index'] = 3
			},
			['class'] = 'suspension'
		},
		['susp4'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp4',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Suspensão Alta',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp4.png',
				['description'] = 'Aumenta drasticamente a altura da suspensão para veículos que desejam uma aventura off-road.',
				['index'] = 4
			},
			['class'] = 'suspension'
		},

		['garett'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.04,
				['turbo'] = true,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'garett',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Turbo Garett GTW',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/turbo.png',
				['description'] = 'Instala uma turbina maior para gerar mais pressão e admitir mais ar frio na entrada do motor, gerando mais potência.',
				['index'] = 5
			},
			['class'] = 'turbo'
		},
		['nitrous'] = {
			['improvements'] = {
				['type'] = 'nitrous'	-- Nitro
			},
			['item'] = {
				['name'] = 'nitrous',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Nitro',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/nitrous.png',
				['description'] = 'O Nitro aumenta a quantidade de oxigénio que entra nos cilindros do motor. É como se, por alguns segundos, ele expandisse o volume do motor para gerar energia.',
				['index'] = 6
			},
			['class'] = 'nitro'
		},
		['AWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 0.5,
				['powered_wheels'] = {0,1,2,3},	-- If the update changes fDriveBiasFront, the wheels that will receive power from the vehicle must also be changed
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'awd',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Conversão para AWD',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/awd.png',
				['description'] = 'Uma transmissão AWD significa que o motor gira todas as 4 rodas do teu veículo.',
				['index'] = 7
			},
			['class'] = 'differential'
		},
		['RWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 0.0,
				['powered_wheels'] = {2,3},
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'rwd',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Conversão para RWD',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/rwd.png',
				['description'] = 'Uma transmissão RWD significa que o motor gira as 2 rodas traseiras do teu veículo.',
				['index'] = 8
			},
			['class'] = 'differential'
		},
		['FWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 1.0,
				['powered_wheels'] = {0,1},
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'fwd',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Conversão para FWD',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/fwd.png',
				['description'] = 'Uma transmissão FWD significa que o motor gira as 2 rodas da frente do teu veículo.',
				['index'] = 9
			},
			['class'] = 'differential'
		},

		['semislick'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.4,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'semislick',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pneus Semi Slick',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/semislick.png',
				['description'] = 'O pneu semi-slick é um pneu de rua homologado usado para explorar totalmente o desempenho dos veículos.',
				['index'] = 10
			},
			['class'] = 'tires'
		},
		['slick'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.8,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'slick',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Pneus Slick',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/slick.png',
				['description'] = 'Os pneus slick, por serem lisos, possuem maior área de contato com o solo, garantindo assim um melhor desempenho.',
				['index'] = 11
			},
			['class'] = 'tires'
		},

		['race_brakes'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 2.0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'race_brakes',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Travões de Corrida',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/race_brakes.png',
				['description'] = 'Os travões de corrida têm um poder de travagem muito maior e não sobreaquecem como os travõs normais.',
				['index'] = 12
			},
			['class'] = 'brakes'
		},
	}
}

-- Repair config
Config.repair = {
	['engine'] = {			-- Part index (do not change)
		['items'] = {		-- Items needed to repair the part
			['piston'] = 4,
			['rod'] = 4,
			['oil'] = 3
		},
		['time'] = 10,		-- time to repair
		['repair'] = {		-- The handling.meta indices that will return to default
			"engine",		-- engine: will fix engine health
			"fInitialDriveForce",
		}
	},
	['transmission'] = {
		['items'] = {
			['gear'] = 5,
			['transmission_oil'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"fClutchChangeRateScaleUpShift"
		}
	},
	['chassis'] = {
		['items'] = {
			['iron'] = 10,
			['aluminium'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"body"		-- body: will fix the chassis health
		}
	},
	['brakes'] = {
		['items'] = {
			['brake_discs'] = 4,
			['brake_pads'] = 4,
			['brake_caliper'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"fBrakeForce"
		}
	},
	['suspension'] = {
		['items'] = {
			['shock_absorber'] = 4,
			['springs'] = 4
		},
		['time'] = 10,
		['repair'] = {
			"fTractionCurveMax",
			"fSuspensionForce"
		}
	}
}

Config.infoTextsPage = {
	[1] = {
		['icon'] = "images/info.png",
		['title'] = "Informação Básica",
		['text'] = "Este é o painel de manutenção do veículo. É fundamental cuidar do teu veículo para mantê-lo em boas condições de uso. Existem vários itens de manutenção a serem feitos a cada X KM, por exemplo, o óleo do motor precisa ser trocado a cada 1500 Kms ou o teu motor irá danificar. Outras revisões precisam ser feitas num KM superior, leva o veículo a um mecânico para que ele lhe informe a vida útil das peças do teu veículo."
	},
	[2] = {
		['icon'] = "images/services.png",
		['title'] = "Como realizar inspeções?",
		['text'] = "É necessário fazer a manutenção preventiva no horário correto, para isso basta levar o veículo a um mecânico de confiança. Ele poderá analisar as peças do seu carro e após passar no scanner terá as informações atualizadas de cada peça que precisa ser substituída."
	},
	[3] = {
		['icon'] = "images/repair.png",
		['title'] = "Reparações",
		['text'] = "O separador de reparações é usado quando alguma parte do seu veículo está perdendo desempenho, isso acontece quando a manutenção não é realizada na data prevista. Os reparos são caros e precisam ser feitos, pois as peças danificadas prejudicam seriamente o desempenho do seu veículo, portanto, certifique-se de fazer qualquer manutenção."
	},
	[4] = {
		['icon'] = "images/performance.png",
		['title'] = "Atualizações",
		['text'] = "Se você quiser apimentar a experiência com o teu veículo, podes instalar algumas peças de desempenho nele, mas <b>CUIDADO!!</b> As peças de desempenho são extremamente poderosas e afetam diretamente a física do teu veículo, então tens que escolher sabiamente qual peça instalar ou o teu veículo pode ficar instável ou até capotar. O mecânico não é responsável por atualizações inadequadas."
	}
}

Config.createTable = false