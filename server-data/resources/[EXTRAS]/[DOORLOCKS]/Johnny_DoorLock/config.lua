Config = {}

Config.AutoCloseDoors = false
Config.ForceAutoCloseDoors = false -- If the door should insta close
Config.DurationBeforeClosing = 2500 -- Milliseconds

Config.Doors = {
	
	-- PRISÃO
	
	{
		objHash = GetHashKey('prop_gate_prison_01'),
		objCoords = vector3(1844.9984130859375, 2604.810546875, 44.636260986328125),
		textCoords = vector3(1844.98, 2608.28, 47.10),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 15,
		size = 2
	},
	{
		objHash = 539686410,
		objCoords = vector3(1837.911865234375, 2590.256103515625, 46.19788360595703),
		textCoords = vector3(1837.911865234375, 2590.256103515625, 46.19788360595703),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 1,
		size = 2
	},
	{
		objHash = -684929024,
		objCoords = vector3(1837.743408203125, 2592.1630859375, 46.03961181640625),
		textCoords = vector3(1837.743408203125, 2592.1630859375, 46.03961181640625),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 1,
		size = 2
	},
	{
		objHash = -684929024,
		objCoords = vector3(1831.3414306640625, 2594.993408203125, 46.03794860839844),
		textCoords = vector3(1831.3414306640625, 2594.993408203125, 46.03794860839844),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 1,
		size = 2
	},
	{
		objHash = GetHashKey('prop_pris_door_03'),
		objCoords = vector3(1819.0743408203125, 2594.87451171875, 46.08699035644531),
		textCoords = vector3(1819.0743408203125, 2594.87451171875, 46.08699035644531),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	{
		objHash = 2074175368,
		objCoords = vector3(1772.8133544921875, 2570.29638671875, 45.74467468261719),
		textCoords = vector3(1772.8133544921875, 2570.29638671875, 45.74467468261719),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	{
		objHash = GetHashKey('prop_gate_prison_01'),
		objCoords = vector3(1799.6083984375, 2616.975341796875, 44.603248596191406),
		textCoords = vector3(1799.6083984375, 2616.975341796875, 44.603248596191406),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 4,
		size = 2
	},
	{
		objHash = GetHashKey('prop_gate_prison_01r'),
		objCoords = vector3(1818.5428466796875, 2604.810546875, 44.61042404174805),
		textCoords = vector3(1818.5428466796875, 2604.810546875, 44.61042404174805),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 4,
		size = 2
	},
	{
		objHash = GetHashKey('prop_gate_prison_01r'),
		objCoords = vector3(1844.9984130859375, 2604.8125, 44.63977813720703),
		textCoords = vector3(1844.9984130859375, 2604.8125, 44.63977813720703),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 4,
		size = 2
	},
	
	
	-- DEPARTAMENTO PSP LOS SANTOS
	
	{
		objHash = 2130672747,
		objCoords = vector3(431.41192626953125, -1000.78271484375, 26.74387550354004),
		textCoords = vector3(431.41192626953125, -1000.78271484375, 26.74387550354004),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff'},
		locked = true,
		maxDistance = 7,
		size = 2
	},
	-- Peaky
	
	{
		textCoords = vector3(-1890.22, 2052.23, 141.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1077118233, objCoords  = vector3(-1890.22509765625, 2052.23583984375, 141.3125)},
			{objHash = 1077118233, objCoords  = vector3(-1887.903076171875, 2051.386962890625, 141.3115234375)}
		}
	},
	{
		textCoords = vector3(-1886.22, 2050.83, 141.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1077118233, objCoords  = vector3(-1887.5340576171875, 2051.23388671875, 141.3125)},
			{objHash = 1077118233, objCoords  = vector3(-1885.2110595703125, 2050.3798828125, 141.30850219726562)}
		}
	},
	-------------------------------------------------------------------------------
	{
		textCoords = vector3(-1861.22, 2054.83, 141.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1077118233, objCoords  = vector3(-1861.68896484375, 2054.115966796875, 141.3535919189453)},
			{objHash = 1077118233, objCoords  = vector3(-1859.2139892578125, 2054.117919921875, 141.35350036621094)}
		}
	},
	-------------------------------------------------------------------------------
	{
		textCoords = vector3(-1874.22, 2069.83, 141.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1077118233, objCoords  = vector3(-1873.2939453125, 2069.2197265625, 141.30850219726562)},
			{objHash = 1077118233, objCoords  = vector3(-1875.614013671875, 2070.06787109375, 141.3125)}
		}
	},
	{
		textCoords = vector3(-1884.22, 2073.83, 141.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1077118233, objCoords  = vector3(-1884.9210205078125, 2073.4619140625, 141.30850219726562)},
			{objHash = 1077118233, objCoords  = vector3(-1887.2430419921875, 2074.307861328125, 141.3125)}
		}
	},
	{
		textCoords = vector3(-1892.22, 2074.83, 141.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1077118233, objCoords  = vector3(-1892.8330078125, 2074.380859375, 141.30850219726562)},
			{objHash = 1077118233, objCoords  = vector3(-1894.72998046875, 2075.967041015625, 141.3125)}
		}
	},
	-------------------------------------------------------------------------------
	{
		textCoords = vector3(-1898.22, 2082.83, 140.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1843224684, objCoords  = vector3(-1898.5140380859375, 2082.85205078125, 140.91525268554688)},
			{objHash = 1843224684, objCoords  = vector3(-1900.406005859375, 2084.44677734375, 140.9145965576172)}
		}
	},

	{
		textCoords = vector3(-1900.22, 2084.83, 140.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1843224684, objCoords  = vector3(-1900.993896484375, 2084.947265625, 140.91883850097656)},
			{objHash = 1843224684, objCoords  = vector3(-1902.882080078125, 2086.544921875, 140.9167938232422)}
		}
	},
	{
		textCoords = vector3(-1905.22, 2085.83, 140.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1843224684, objCoords  = vector3(-1905.9940185546875, 2085.626953125, 140.9114990234375)},
			{objHash = 1843224684, objCoords  = vector3(-1907.5960693359375, 2083.743896484375, 140.9114990234375)}
		}
	},
	{
		textCoords = vector3(-1910.22, 2080.83, 140.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1843224684, objCoords  = vector3(-1910.2020263671875, 2080.678955078125, 140.9114990234375)},
			{objHash = 1843224684, objCoords  = vector3(-1911.81005859375, 2078.794921875, 140.9114990234375)}
		}
	},
	{
		textCoords = vector3(-1912.22, 2075.83, 140.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1843224684, objCoords  = vector3(-1912.10107421875, 2075.56005859375, 140.91490173339844)},
			{objHash = 1843224684, objCoords  = vector3(-1910.208984375, 2073.968994140625, 140.91310119628906)}
		}
	},
	{
		textCoords = vector3(-1909.22, 2073.83, 140.3125),
		authorizedJobs = {'peakyblinders'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 1843224684, objCoords  = vector3(-1909.6240234375, 2073.471923828125, 140.91519165039062)},
			{objHash = 1843224684, objCoords  = vector3(-1907.7320556640625, 2071.8779296875, 140.91310119628906)}
		}
	},
	
	-- Tribunal
	
	{
		objHash = 918828907,
		objCoords = vector3(-560.5423583984375, -234.61032104492188, 34.47710418701172),
		textCoords = vector3(-560.5423583984375, -234.61032104492188, 34.47710418701172),
		authorizedJobs = {'offpolice', 'offsheriff','police','juiz'},
		locked = true,
		maxDistance = 2,
		size = 2
	},
	{
		objHash = 918828907,
		objCoords = vector3(-557.944091796875, -233.11065673828125, 34.47710418701172),
		textCoords = vector3(-557.944091796875, -233.11065673828125, 34.47710418701172),
		authorizedJobs = {'offpolice', 'offsheriff','police','juiz'},
		locked = true,
		maxDistance = 2,
		size = 2
	},
	{
		textCoords = vector3(-567.97, -236.86, 34.42),
		authorizedJobs = {'offpolice', 'offsheriff','police','juiz'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 297112647, objCoords  = vector3(-567.4882202148438, -236.2653350830078, 34.35750198364258)},
			{objHash = 830788581, objCoords  = vector3(-568.5510864257812, -234.4238739013672, 34.35750198364258)}
		}
	},
	

	-- Ballas
	
	{
		objHash = 23523831,
		objCoords = vector3(115.03984832763672, -1961.363037109375, 21.422700881958008),
		textCoords = vector3(115.03984832763672, -1961.363037109375, 21.422700881958008),
		authorizedJobs = {'ballas'},
		locked = true,
		maxDistance = 2,
		size = 2
	},
	{

		objHash = -1912632538,
		objCoords = vector3(113.9327392578125, -1973.5006103515625, 21.423776626586914),
		textCoords = vector3(113.9327392578125, -1973.5006103515625, 21.423776626586914),
		authorizedJobs = {'ballas'},
		locked = true,
		maxDistance = 2,
		size = 2
	},
	{
		textCoords = vector3(118.67, -1973.96, 21.42),
		authorizedJobs = {'ballas'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 989957872, objCoords  = vector3(117.09940338134766, -1974.3480224609375, 21.41925621032715)},
			{objHash = 830788581, objCoords  = vector3(119.16741943359375, -1973.637939453125, 21.41925621032715)}
		}
	},
	{

		objHash = -1118363016,
		objCoords = vector3(102.73886108398438, -1960.2596435546875, 21.006330490112305),
		textCoords = vector3(102.73886108398438, -1960.2596435546875, 21.006330490112305),
		authorizedJobs = {'ballas'},
		locked = true,
		maxDistance = 4,
		size = 2
	},
	
	-- CARTEL
	
	{
		objHash = GetHashKey('v_ilev_fh_frontdoor'),
		objCoords = vector3(-3217.282958984375, 816.3267822265625, 9.077104568481445),
		textCoords = vector3(-3217.282958984375, 816.3267822265625, 9.077104568481445),
		authorizedJobs = {'cartel'},
		locked = true,
		maxDistance = 2,
		size = 2
	},
	{

		objHash = GetHashKey('prop_facgate_07b'),
		objCoords = vector3(-3137.5849609375, 798.952392578125, 16.35331916809082),
		textCoords = vector3(-3137.5849609375, 798.952392578125, 16.35331916809082),
		authorizedJobs = {'cartel'},
		locked = true,
		maxDistance = 7,
		size = 2
	},

	-- Grove
	
	{
		objHash = 1381046002,
		objCoords = vector3(-152.02444458007812, -1622.647705078125, 33.8377571105957),
		textCoords = vector3(-152.02444458007812, -1622.647705078125, 33.8377571105957),
		authorizedJobs = {'grove'},
		locked = true,
		maxDistance = 2,
		size = 2
	},

	-- Vagos
	
	{
		objHash = 2118614536,
		objCoords = vector3(336.7447814941406, -1991.843505859375, 24.362913131713867),
		textCoords = vector3(336.7447814941406, -1991.843505859375, 24.362913131713867),
		authorizedJobs = {'vagos'},
		locked = true,
		maxDistance = 2,
		size = 2
	},

	{
		objHash = 2118614536,
		objCoords = vector3(324.7153015136719, -1991.085693359375, 24.362913131713867),
		textCoords = vector3(324.7153015136719, -1991.085693359375, 24.362913131713867),
		authorizedJobs = {'vagos'},
		locked = true,
		maxDistance = 2,
		size = 2
	},

	-- Vanilla
	
	{
		objHash = GetHashKey('prop_strip_door_01'),
		objCoords = vector3(127.95006561279297, -1298.506591796875, 29.41962242126465),
		textCoords = vector3(127.95006561279297, -1298.506591796875, 29.41962242126465),
		authorizedJobs = {'vanilla'},
		locked = true,
		maxDistance = 2,
		size = 2
	},

	{
		objHash = 1695461688,
		objCoords = vector3(96.09197235107422, -1284.853759765625, 29.438783645629883),
		textCoords = vector3(96.09197235107422, -1284.853759765625, 29.438783645629883),
		authorizedJobs = {'vanilla'},
		locked = true,
		maxDistance = 2,
		size = 2
	},

	-- Bahamas
	
	{
		textCoords = vector3(-1387.035888671875, -586.6932983398438, 30.44564437866211),
		authorizedJobs = {'bahamas'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = -224738884, objCoords  = vector3(-1387.035888671875, -586.6932983398438, 30.44564437866211)},
			{objHash = 666905606, objCoords  = vector3(-1389.1368408203125, -588.0576782226562, 30.44564437866211)}
		}
	},

	{
		textCoords = vector3(-1390.44873046875, -594.80322265625, 30.445646286010742),
		authorizedJobs = {'bahamas'},
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = 134859901, objCoords  = vector3(-1390.44873046875, -594.80322265625, 30.445646286010742)},
			{objHash = 134859901, objCoords  = vector3(-1391.869140625, -592.6160278320312, 30.445646286010742)}
		}
	},

	-- MAFIA
	
	{
		objHash = GetHashKey('prop_lrggate_02_ld'),
		objCoords = vector3(-1474.2281494140625, 68.37447357177734, 52.52275085449219),
		textCoords = vector3(-1474.12890625, 68.38936614990234, 52.5270881652832),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 10
	},
	
	{
		objHash = 1033441082,
		objCoords = vector3(-1535.9849853515625, 130.47039794921875, 57.750526428222656),
		textCoords = vector3(-1535.9849853515625, 130.47039794921875, 57.750526428222656),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 5
	},
	
	{
		objHash = -1859471240,
		objCoords = vector3(-1462.425048828125, 65.71588134765625, 53.38676071166992),
		textCoords = vector3(-1462.425048828125, 65.71588134765625, 53.38676071166992),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 5
	},
	
	{
		objHash = -1859471240,
		objCoords = vector3(-1441.7266845703125, 171.9103546142578, 56.064937591552734),
		textCoords = vector3(-1441.7266845703125, 171.9103546142578, 56.064937591552734),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 5
	},
	
		{
		objHash = -1859471240,
		objCoords = vector3(-1578.3712158203125, 153.20703125, 58.96854782104492),
		textCoords = vector3(-1578.3712158203125, 153.20703125, 58.96854782104492),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 5
	},
	
		{
		objHash = -1859471240,
		objCoords = vector3(-1434.00634765625, 235.0129852294922, 60.37110137939453),
		textCoords = vector3(-1434.00634765625, 235.0129852294922, 60.37110137939453),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 5
	},
	
	{
		objHash = GetHashKey('prop_lrggate_02_ld'),
		objCoords = vector3(-1616.23193359375, 79.7791976928711, 60.77870178222656),
		textCoords = vector3(-1616.23193359375, 79.7791976928711, 60.77870178222656),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 12
	},
	
	{
		objHash = GetHashKey('v_ilev_mm_door'),
		objCoords = vector3(-1523.06201171875, 143.65328979492188, 55.80904769897461),
		textCoords = vector3(-1523.06201171875, 143.65328979492188, 55.80904769897461),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 5
	},
	
	{
		objHash = GetHashKey('v_ilev_mm_door'),
		objCoords = vector3(-1500.4010009765625, 104.14398956298828, 55.80867004394531),
		textCoords = vector3(-1500.4010009765625, 104.14398956298828, 55.80867004394531),
		authorizedJobs = {'mafia'},
		locked = true,
		maxDistance = 5
	},
	
	
	-- ESQUADRA GABZ CIDADE
	
	{
		objHash = -53345114,
		objCoords = vector3(484.1764221191406, -1007.734375, 26.48005485534668),
		textCoords = vector3(485.14, -1007.70, 26.27),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},

	{
		objHash = -53345114,
		objCoords = vector3(486.9131164550781, -1012.1886596679688, 26.48005485534668),
		textCoords = vector3(485.95, -1011.87, 26.27),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	
	{
		objHash = -53345114,
		objCoords = vector3(482.9127197265625, -1011.1886596679688, 26.48005485534668),
		textCoords = vector3(482.95, -1012.87, 26.27),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	{
		objHash = 1830360419,
		objCoords = vector3(464.15655517578125, -997.50927734375, 26.370704650878906),
		textCoords = vector3(464.95, -997.87, 26.370),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	{
		objHash = 1830360419,
		objCoords = vector3(464.1590576171875, -974.6655883789062, 26.370704650878906),
		textCoords = vector3(464.1590576171875, -974.6655883789062, 26.370704650878906),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	{
		objHash = -1406685646,
		objCoords = vector3(440.52008056640625, -977.60107421875, 30.823192596435547),
		textCoords = vector3(440.52008056640625, -977.60107421875, 30.823192596435547),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	{
		objHash = -96679321,
		objCoords = vector3(440.52008056640625, -986.2334594726562, 30.823192596435547),
		textCoords = vector3(440.52008056640625, -986.2334594726562, 30.823192596435547),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	
	{
		objHash = -53345114,
		objCoords = vector3(479.9128112792969, -1012.9286596679688, 26.48005485534668),
		textCoords = vector3(482.95, -1012.87, 26.27),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	
	{
		objHash = -53345114,
		objCoords = vector3(476.91259765625, -1012.1886596679688, 26.48005485534668),
		textCoords = vector3(482.95, -1012.87, 26.27),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 3,
		size = 2
	},
	
	--------------------exterior---------------------
	
	{
		objHash = -1635161509,
		objCoords = vector3(410.0257873535156, -1024.219970703125, 29.220199584960938),
		textCoords = vector3(410.26, -1028.27, 29.4),
		authorizedJobs = {'police', 'sheriff','offpolice', 'offsheriff'},
		locked = true,
		maxDistance = 7,
		size = 2
	},
	
	{
		objHash = -1868050792,
		objCoords = vector3(410.0257873535156, -1024.2259521484375, 29.2202205657959),
		textCoords = vector3(409.98, -1021.07, 29.37),
		authorizedJobs = {'police', 'sheriff','offpolice', 'offsheriff'},
		locked = true,
		maxDistance = 7,
		size = 2
	},
	
	{
		objHash = 2130672747,
		objCoords = vector3(431.41192626953125, -1000.7716674804688, 26.696609497070312),
		textCoords = vector3(431.74, -1001.07, 25.75),
		authorizedJobs = {'police', 'sheriff','offpolice', 'offsheriff'},
		locked = true,
		maxDistance = 4,
		size = 2
	},
	
	{
		objHash = 2130672747,
		objCoords = vector3(452.3005065917969, -1000.7716674804688, 26.696609497070312),
		textCoords = vector3(452.12, -1000.86, 25.73),
		authorizedJobs = {'police', 'sheriff','offpolice', 'offsheriff'},
		locked = true,
		maxDistance = 4,
		size = 2
	},
	{
		textCoords = vector3(442.0, -998.64, 30.73),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff' },
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = -1547307588, objCoords = vector3(440.73919677734375, -998.7462158203125, 30.815303802490234)},
			{objHash = -1547307588, objCoords = vector3(443.061767578125, -998.7462158203125, 30.815303802490234)}
		}
	},
	{
		textCoords = vector3(434.46, -982.0, 30.71),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff' },
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = -1547307588, objCoords = vector3(434.74444580078125, -980.7555541992188, 30.815303802490234)},
			{objHash = -1547307588, objCoords = vector3(434.74444580078125, -983.078125, 30.815303802490234)}
		}
	},
	{
		textCoords = vector3(457.15, -971.17, 30.71),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff' },
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = -1547307588, objCoords = vector3(458.208740234375, -972.2542724609375, 30.8153076171875)},
			{objHash = -1547307588, objCoords = vector3(455.88616943359375, -972.2542724609375, 30.8153076171875)}
		}
	},
	{
		objHash = GetHashKey('hei_prop_station_gate'),
		objCoords = vector3(488.8948059082031, -1017.2119750976562, 27.149349212646484),
		textCoords = vector3(488.74, -1020.52, 28.21),
		authorizedJobs = {'police', 'sheriff','offpolice', 'offsheriff'},
		locked = true,
		maxDistance = 4,
		size = 2
	},
	{
		textCoords = vector3(468.32, -1014.50, 26.39),
		authorizedJobs = {'offpolice', 'offsheriff','police','sheriff' },
		locked = true,
		maxDistance = 3,
		doors = {
			{objHash = -692649124, objCoords = vector3(467.3686218261719, -1014.406005859375, 26.483816146850586)},
			{objHash = -692649124, objCoords = vector3(469.7742614746094, -1014.406005859375, 26.483816146850586)}
		}
	},
	
	-- Yakuza
	
	{
		objHash = -1007367639,
		objCoords = vector3(829.2184448242188, -2333.972900390625, 31.811111450195312),
		textCoords = vector3(829.2184448242188, -2333.972900390625, 31.811111450195312),
		authorizedJobs = {'yakuza'},
		locked = true,
		maxDistance = 7
	},
	
	{
		objHash = -733653166,
		objCoords = vector3(818.79345703125, -2349.521484375, 30.53359031677246),
		textCoords = vector3(818.79345703125, -2349.521484375, 30.53359031677246),
		authorizedJobs = {'yakuza'},
		locked = true,
		maxDistance = 3
	},
	
	{
		objHash = -1046695423,
		objCoords = vector3(822.1651000976562, -2338.251953125, 30.770160675048828),
		textCoords = vector3(822.1651000976562, -2338.251953125, 30.770160675048828),
		authorizedJobs = {'yakuza'},
		locked = true,
		maxDistance = 3
	},

	-- NORAUTO
	
	{
		objHash = -983965772,
		objCoords = vector3(945.9384765625, -985.6380004882812, 41.713260650634766),
		textCoords = vector3(945.9384765625, -985.6380004882812, 41.713260650634766),
		authorizedJobs = {'mechanic'},
		locked = true,
		maxDistance = 8
	},
	
	-- Lavagem
	
	{
		objHash = GetHashKey('v_ilev_fib_door1'),
		objCoords = vector3(127.84889221191406, -760.454833984375, 45.9011116027832),
		textCoords = vector3(127.84889221191406, -760.454833984375, 45.9011116027832),
		authorizedJobs = {'bahamas', 'vanilla'},
		locked = true,
		maxDistance = 2
	},

	-- REDLINE/OFIVINA ILEGAL
	
	{
		objHash = GetHashKey('prop_gar_door_04'),
		objCoords = vector3(950.7745971679688, -1698.22705078125, 31.44470977783203),
		textCoords = vector3(950.7745971679688, -1698.22705078125, 31.44470977783203),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 5,
		size = 5
	},
	
	-- OFICINA LOS SANTOS CUSTOMS
	
	{
		objHash = 718507040,
		objCoords = vector3(-355.8181457519531, -134.8740692138672, 40.05652618408203),
		textCoords = vector3(-355.8181457519531, -134.8740692138672, 40.05652618408203),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 8,
		size = 5
	},
	
	
	{
		objHash = 718507040,
		objCoords = vector3(-349.4925231933594, -117.55015563964844, 40.01057434082031),
		textCoords = vector3(-349.4925231933594, -117.55015563964844, 40.01057434082031),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 8,
		size = 5
	},
	
	{
		textCoords = vector3(-323.437, -105.740, 39.009),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 7,
		doors = {
			{objHash = 2134335554, objCoords  = vector3(-325.67071533203125, -103.57537078857422, 38.012054443359375)},
			{objHash = 758463511, objCoords  = vector3(-320.50592041015625, -105.45514678955078, 38.01206970214844)}
		}
	},
	
	{
		objHash = 1546389727,
		objCoords = vector3(-356.7233581542969, -93.97313690185547, 39.062259674072266),
		textCoords = vector3(-356.7233581542969, -93.97313690185547, 39.062259674072266),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 2,
		size = 5
	},
	
	{
		objHash = 1278022473,
		objCoords = vector3(-356.19232177734375, -92.51394653320312, 39.062259674072266),
		textCoords = vector3(-356.19232177734375, -92.51394653320312, 39.062259674072266),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 2,
		size = 5
	},
	
	{
		objHash = 4256823717,
		objCoords = vector3(-343.4473571777344, -123.6837387084961, 38.603736877441406),
		textCoords = vector3(-343.4473571777344, -123.6837387084961, 38.603736877441406),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 2,
		size = 5
	},
	
	{
		objHash = 4256823717,
		objCoords = vector3(-347.1109313964844, -133.7510986328125, 38.603736877441406),
		textCoords = vector3(-347.1109313964844, -133.7510986328125, 38.603736877441406),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 2,
		size = 5
	},
	
	{
		objHash = 3426294393,
		objCoords = vector3(-369.032470703125, -100.56044006347656,39.700660705566406),
		textCoords = vector3(-369.032470703125, -100.56044006347656, 39.700660705566406),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 2,
		size = 5
	},
	
	{
		objHash = 2568635511,
		objCoords = vector3(-366.1983337402344, -92.62431335449219, 39.68939208984375),
		textCoords = vector3(-366.1983337402344, -92.62431335449219, 39.68939208984375),
		authorizedJobs = {'redline'},
		locked = true,
		maxDistance = 2,
		size = 5
	},
	
}
