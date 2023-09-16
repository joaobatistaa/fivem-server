Config.CacadorInfo = {

	-- [GENERAL]:
	EnableFootprints     = false,
	PNearAnimalToEscape  = 40,      -- if the distance between a player and the animal is less than this value, it will run away (not for native animals)

	-- [HARVESTING]:
	HeadshotForPerfect = true,      -- In order to receve the perfect item, you will need to get perfect in Config.WeaponDamages and also kill the animal with an headshot 
	TimeToHarvest      = 15000,     -- number of milliseconds to complete harvesting
	CameraMovement     = true,      -- if true camera animation when harvesting animals
	MinLeather         = 1,         -- the minimum number of leather you can drop
	MaxLeather         = 1,         -- the maximum number of leather you can drop 
	CanDropMeat        = true,      -- false if you don't want that animals can drop meat
	MeatItem           = "meat",    -- item name for meat
	MinMeat            = 2,         -- the minimum number of leather you can drop
	MaxMeat            = 3,         -- the maximum number of leather you can drop
	CanDropSpecial     = true,      -- false if you don't want that animals can drop special items (see Config.Animals)
	SpecialProb        = 96,        -- probability, example: the script generates a random number from 1 to 100, if the random number is higher (>) than this one it will drop (so 10% probability)

	-- [BAIT]:
	EnableBait           = true,
	BlipOnBaitAnimal     = true,
	BaitPlacingTime      = 15000,     -- milliseconds
	BaitItemName         = "animal_bait",
	BaitAnimals          = {"a_c_deer", "a_c_boar", "a_c_mtlion", "a_c_coyote"},  -- animal that can spawn when placing a bait (need to be also in Config.Animals)
	TimeForAnimalToLeave = 10000,     -- animal once reached bait will wait this time before walking away milliseconds
	BaitSpawnRadious     = 30,        -- when you place a bait, the animal will spawn in this radious (I raccomend 200) 
	TimeBetween          = 120,       -- IN SECONDS, time you need to wait before placing another bait


	-- [ANIMALS / WEAPONS]:
		-- MODEL: the model of animal you want to spawn / hunt 
		-- BAD/GOOD/PERFECT: the item dropped when harvesting that animal
		-- DIMENSION: size of the animal, you need this with Config.WeaponDamages

	Animals = {
		{dimension = "big", model = "a_c_deer", bad = "leather_deer_bad", badCost = 100, good = "leather_deer_good", goodCost = 420, perfect = "leather_deer_perfect", perfectCost = 890, hash = -664053099, specialItem = "deer_horn", specialItemCost = 630, isIllegal = false},
		{dimension = "medBig", model = "a_c_boar", bad = "leather_boar_bad", badCost = 100, good = "leather_boar_good", goodCost = 420, perfect = "leather_boar_perfect", perfectCost = 890, hash = -832573324, specialItem = "", specialItemCost = 0, isIllegal = false},
		{dimension = "medBig", model = "a_c_mtlion", bad = "leather_mlion_bad", badCost = 100, good = "leather_mlion_good", goodCost = 420, perfect = "leather_mlion_perfect", perfectCost = 890, hash = 307287994, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430},
		{dimension = "medium", model = "a_c_coyote", bad = "leather_coyote_bad", badCost = 100, good = "leather_coyote_good", goodCost = 420, perfect = "leather_coyote_perfect", perfectCost = 890, hash = 1682622302, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430},
		{dimension = "small", model = "a_c_rabbit_01", bad = "leather_rabbit_bad", badCost = 100, good = "leather_rabbit_good", goodCost = 420, perfect = "leather_rabbit_perfect", perfectCost = 890, hash = -541762431, specialItem = "", specialItemCost = 0, isIllegal = false},
		{dimension = "medium", model = "a_c_cormorant", bad = "leather_cormorant_bad", badCost = 100, good = "leather_cormorant_good", goodCost = 420, perfect = "leather_cormorant_perfect", perfectCost = 890, hash = 1457690978, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430},
		--{dimension = "small", model = "a_c_chickenhawk", bad = "leather_chickenhawk_bad", badCost = 100, good = "leather_chickenhawk_good", goodCost = 420, perfect = "leather_chickenhawk_perfect", perfectCost = 890, hash = -1430839454, specialItem = "", specialItemCost = 0, isIllegal = true, illegalBadCost = 50, illegalGoodCost = 190, illegalPerfectCost = 430}
	},   
	-- IMPORTANT: dimension name must be one of these "small" / "medium" / "medBig" / "big"
    -- IMPORTANT: you don't have to change hash numbers
    -- IMPORTANT: you need to have bad / good / perfect items in your items database
	
	CourosIlegais = {
        ['leather_cormorant_bad']  = {300, 500},
		['leather_cormorant_good']   = {300, 500},
        ['leather_cormorant_perfect']  = {300, 500},
        ['leather_coyote_bad']    = {300, 500},
        ['leather_coyote_good'] = {300, 500},
        ['leather_coyote_perfect'] = {300, 500},
        ['leather_mlion_bad'] = {300, 500},
        ['leather_mlion_good'] = {300, 500},
        ['leather_mlion_perfect'] = {300, 500},
	},
	
	CarnePrices = {
		['meat']  = {500, 700},
	},
	
	ChifreVeadoPrices = {
		['deer_horn'] = {1500, 3000},
	},
	
	CouroPrices = { 
        ['leather_deer_bad']  = {300, 400},
		['leather_deer_good']   = {300, 400},
        ['leather_deer_perfect']  = {300, 400},
        ['leather_boar_bad']    = {300, 400},
        ['leather_boar_good'] = {300, 400},
        ['leather_boar_perfect'] = {300, 400},
        ['leather_rabbit_bad'] = {300, 400},
        ['leather_rabbit_good'] = {300, 450},
        ['leather_rabbit_perfect'] = {300, 400},
	},
	
	WeaponDamages = {
		-- According to the type of weapon (category) used to kill the animal, it will drop a certain type of skin based on his size (Config.Animals dimension)
		-- EXAMPLE: if i kill with a sniper a big animal in this case it will give me perfect item
		{category = "unarmed", small = "bad", medium = "bad", medBig = "bad", big = "bad"},
		{category = "melee", small = "bad", medium = "bad", medBig = "bad", big = "bad"},
		{category = "pistol", small = "good", medium = "good", medBig = "bad", big = "bad"},
		{category = "subgun", small = "bad", medium = "bad", medBig = "good", big = "bad"},
		{category = "shootgun", small = "bad", medium = "bad", medBig = "good", big = "bad"},
		{category = "rifle", small = "bad", medium = "bad", medBig = "bad", big = "bad"},
		{category = "snip", small = "bad", medium = "good", medBig = "perfect", big = "perfect"}
	},   -- IMPORTANT: you don't have to change category names

	NativeAnimal      = false,   -- false if you want to spawn your animals (modify AnimalModels) and not use native ones
	SpawnAnimalNumber = 10,     -- number of animal to spawn if you aren't using native animals
	KnifesForHarvest  = {'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_DAGGER'},  -- you can harvest an animal only with these knifes


	-- [HUNTING ZONES]:
	huntAllMap  = false,   -- true if you want to enable hunting in all the map
	huntPoint   = {
		{x = -1133.44, y = 4605.55, z = 144.96},
		--{x = 1996.02, y = 4982.71, z = 40.63}
	},   -- if Config.huntAllMap false you have to decide a point in the map and the radious where you can hunt
	huntRadious = 400,


	-- [CAMPFIRE]:
	EnableCampfire       = false,
	CampfireCommand      = "campfire", -- don't put the slash before
	CampfireProp         = "prop_beach_fire", -- name for the prop to spawn
	CampfireNameItem1    = "coal",     -- name for item1 in crafting
	CampfireCountItem1   = 2,          -- number of pieces you need for item1
	CampfireNameItem2    = "wood",     -- name for item2 in crafting
	CampfireCountItem2   = 4,          -- number of pieces you need for item2
	CampPlacingTime      = 15000,      -- milliseconds
	KeyCampfireMenu      = "E",        -- ["E"]
	MeatName             = "meat",     
	CookingTime          = 20000,      -- milliseconds
	CookedMeatName       = "cookedMeat",
	KeyDestroyCampfire   = "G",        -- ["G"]
	noCampfireZoneRadious = 1000,
	noCampfireZone       = {
		{x = -259.24, y = -1900.51, z = 27.76}
	},   --you can add multiple of them (remember ",")


	-- [SELLING ITEMS]:
	MeatCost = 20,
	-- see also Config.Animals for prices


	-- [BLIPS]:
	BlipOnEntity = true,  -- if not using native animals 
	Blips = {
		--{coords = vector3(-121.93, 6204.93, 31.38), name = "Caça - Venda de Itens", sprite = 442, colour = 5, scale = 0.7},
		--{coords = vector3(582.38, -2723.17, 7.19), name = "Caça - Venda de Itens Ilegal", sprite = 442, colour = 27, scale = 0.7},
		{coords = vector3(-1133.44, 4605.55, 144.96), name = "Zona de Caça", sprite = 161, colour = 27, scale = 1.1},
		{coords = vector3(-1133.44, 4605.55, 144.96), name = "Caça", sprite = 442, colour = 27, scale = 1.1}
	},
	
	SellHunting = {
		[1] = {
			pos = {-121.93, 6204.93, 31.38},
			blip = {enable = true, str = 'Caça - Venda de Itens', sprite = 515, display = 4, color = 5, scale = 1.1},
			marker = {enable = true, drawDist = 12.0, type = 27, color = {r = 240, g = 52, b = 52, a = 100}, scale = {x = 1.25, y = 1.25, z = 1.25}},
			drawText = '~r~[E]~s~ Vender Itens de Caça',
			keybind = 38,
			ilegal = false
		},
--[[		[2] = {
			pos = {1996.02, 4982.71, 41.63, 219.41},
			blip = {enable = true, str = 'Caça - Venda de Itens Ilegal', sprite = 515, display = 4, color = 5, scale = 1.1},
			marker = {enable = true, drawDist = 12.0, type = 27, color = {r = 240, g = 52, b = 52, a = 100}, scale = {x = 1.25, y = 1.25, z = 1.25}},
			drawText = '~r~[E]~s~ Vender Itens de Caça Ilegais',
			keybind = 38,
			ilegal = true
		},--]]
	},


	-- [LANGUAGE]:
	Text = {
		['before_harvest']   = 'Pressiona [~g~E~w~] para retirar o Couro',
		['harvesting']       = 'A retirar o Couro...',
		['need_knife']       = 'Precisas de ter uma faca na mão',
		['receved_leather']  = 'Recebeste Couro',
		['ruined_leather']   = 'O couro estava muito estragado',
		['receved_meat']     = 'Recebeste Carne',
		['special_item']     = 'Recebeste algo especial',
		----
		['campfire']         = 'Pressiona [~g~E~w~] para cozinhar, [~g~G~w~] para remover',
		['cooking']          = 'A cozinhar carne',
		['placing_campfire'] = 'A montar acampamento...',
		['cant_place_camp']  = "Não podes montar o teu acampamento aqui",
		----
		['cant_place_bait']  = "Não podes colocar a armadilha aqui",
		['placing_bait']     = 'A colocar armadilha...',
		['between_bait']     = 'Precisas de esperar antes de utilizar novamente',
		['no_effects_bait']  = 'A tua armadilha não teve efeito',
		----
		['sell_items']       = 'Pressiona [~b~E~w~] para interagir',
		['sold']             = 'Vendeste com sucesso',
		----
		['no_material']      = "Não tens material suficiente",
		['you_didnt_kill_it'] = "Não mataste o animal"
	},
}