JAM.VehicleShop = {}
local JVS = JAM.VehicleShop
JVS.ESX = JAM.ESX

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
JVS.PlateLetters  = 3
JVS.PlateNumbers  = 3
JVS.PlateUseSpace = true


JVS.DrawTextDist = 5.0
JVS.MenuUseDist = 2.0
JVS.SpawnVehDist = 50.0
JVS.VehRetDist = 5.0

JVS.CarDealerJobLabel = "cardealer"
JVS.DealerMarkerPos = vector3(-48.12, -1099.36, 27.27)

-- Why vector4's, you ask?
-- X, Y, Z, Heading.

JVS.PurchasedCarPos = vector4(-28.1890, -1082.72, 27.041, 69.758270263672)
JVS.TestCarPos = vector4(-1970.66, 2837.4, 31.81, 60.0)
JVS.PurchasedUtilPos = vector4(-23.5425, -1116.51, 26.910, 154.97103881836)

JVS.SmallSpawnVeh = 'vsci'
JVS.SmallSpawnPos = vector4(-44.7412, -1096.65, 26.422, 152.09365844727)

JVS.LargeSpawnVeh = 'rubble'
JVS.LargeSpawnPos = vector4(-18.57, -1103.14, 26.67, 159.95)

JVS.DisplayPositions = {
	--[1] = vector4(-50.1, -1083.75, 27.302, 103.63626861572),
	--[2] = vector4(-54.6848, -1097.10, 27.302, 200.53131103516),
	--[3] = vector4(-42.1619, -1101.39, 27.302, 200.16741943359),
	--[4] = vector4(-36.8314, -1093.12, 27.302, 26.372177124023),
	
	--[3] = vector4(-54.6848, -1097.10, 27.302, 200.53131103516),
}

JVS.Blips = {
	CityShop = {
		Zone = "Concessionária",
		Sprite = 225,
		Scale = 0.8,
		Display = 4,
		Color = 4,
		Pos = { x = -54.02, y = -1110.43, z = 28.00 },
	},
}
