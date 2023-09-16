Config = {}

Config["image_source"] = "nui://qs-inventory/html/images/"  -- From where it should take images?

Config.CloseInventoryHudTrigger = "esx_inventoryhud:closeInventory" -- Change with your event, or put item in esx_inventoryhud config.

Config["chance"] = {
	[1] = { name = "Comum", rate = 50 }, -- Chance
	[2] = { name = "Raro", rate = 40 },
	[3] = { name = "Muito Raro", rate = 13.5 },
	[4] = { name = "Épico", rate = 5} ,
	[5] = { name = "Lendário", rate = 1.5 },
}

Config["broadcast"] = true  -- Enable/disable announcements

Config["broadcast_tier"] = {
	[1] = false,	-- Upon receiving the award in Type "1" will be announced.
	[2] = true, 	-- Upon receiving the award in Type "2" will be announced.
	[3] = true,		-- Upon receiving the award in Type "3" will be announced.
	[4] = true,  	-- Upon receiving the award in Type "4" will be announced.
	[5] = true,  	-- Upon receiving the award in Type "5" will be announced.
}

Config["lootbox"] = {
	["lootbox1"] = { -- Item name in database
		name = "Lootbox #1", -- Display name
		list = {
			{ weapon = "weapon_knife", tier = 3 },
			{ vehicle = "twizy", tier = 5 },
			{ money = 30000, tier = 2 },
			{ black_money = 80000 , tier = 5 },
			{ item = "contract", amount=5, tier = 4 },
			{ item = "bread", amount=20, tier = 1 },
			{ vehicle = "dominator", tier = 5 },
			{ item = "armor", amount=5, tier = 3 },
		}
	},
	["lootbox2"] = {
		name = "Lootbox #2",
		list = {
			{ weapon = "WEAPON_PISTOL", tier = 4 },
			{ vehicle = "z1000a1", tier = 5 },
			{ money = 100000, tier = 4 },
			{ black_money = 150000, tier = 5 },
			{ item = "fakeid", amount=1, tier = 2 },
			{ item = "armor", amount=12, tier = 3 },
			{ vehicle = "pcs20", tier = 4 },
			{ item = "fixtool", amount=30, tier = 1 },
			{ weapon = "WEAPON_PISTOL50", tier = 5 },
		}
	},

}