--[[ 
    Welcome to the interior system, here you can add more yourself or 
    ask the creator to send you this file with its previously placed interiors. 
    You can also see how to do it manually from the documentation.
]]

Config.IplData = {
	{ 
    -- Apartment
    export = function () 
        return exports['bob74_ipl']:GetExecApartment1Object() 
    end,
	defaultTheme = 'seductive',
    themes = {
			{label = 'Moderno', value = 'modern', price = 30000},
			{label = 'Melancólico', value = 'moody', price = 30000},
			{label = 'Vibrante', value = 'vibrant', price = 30000},
			{label = 'Nítido', value = 'sharp', price = 30000},
			{label = 'Monocromático', value = 'monochrome', price = 30000},
			{label = 'Sedutor', value = 'seductive', price = 30000},
			{label = 'Real', value = 'regal', price = 30000},
			{label = 'Água', value = 'aqua', price = 30000}
		},
        exitCoords = vec3(-787.44, 315.81, 217.64),
		iplCoords = vec3(-787.78050000, 334.92320000, 215.83840000),
		inventory = { weight = 300000, slots = 50 },
	},
    {
    -- Office
		export = function ()
			return exports['bob74_ipl']:GetFinanceOffice1Object()
		end,
		defaultTheme = 'warm',
		themes = {
			{label = 'Quente', value = 'warm', price = 30000},
			{label = 'Clássico', value = 'classical', price = 30000},
			{label = 'Vintage', value = 'vintage', price = 30000},
			{label = 'Contraste', value = 'contrast', price = 30000},
			{label = 'Rico', value = 'rich', price = 30000},
			{label = 'Fresco', value = 'cool', price = 30000},
			{label = 'Gelo', value = 'ice', price = 30000},
			{label = 'Conservador', value = 'conservative', price = 30000},
			{label = 'Polido', value = 'polished', price = 30000}
		},
		exitCoords = vec3(-1579.756, -565.0661, 108.523),
		iplCoords = vec3(-1576.127441, -575.050537, 108.507690),
		inventory = { weight = 300000, slots = 50 },
	},
    {
    -- Night Club
		exitCoords = vec3(-1569.402222, -3017.604492, -74.413940),
		iplCoords = vec3(-1604.664, -3012.583, -78.000),
		inventory = { weight = 500000, slots = 50 },
	},
    {
    -- Clubhouse 1
		exitCoords = vec3(1121.037354, -3152.782471, -37.074707),
		iplCoords = vec3(1107.04, -3157.399, -37.51859),
		inventory = { weight = 500000, slots = 50 },
	},
    {
    -- Clubhouse 2
		exitCoords = vec3(997.028564, -3158.136230, -38.911377),
		iplCoords = vec3(998.4809, -3164.711, -38.90733),
		inventory = { weight = 500000, slots = 50 },
	},
	{
    -- Document Forgery
		exitCoords = vec3(1173.7, -3196.73, -39.01),
		iplCoords = vec3(1165, -3196.6, -39.01306),
		inventory = { weight = 500000, slots = 50 },
	},

	{
	-- NightClub Warehouse
		exitCoords = vec3(-1520.88, -2978.54, -80.45),
		iplCoords = vec3(-1505.783, -3012.587, -80.000),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- 2 Car
		exitCoords = vec3(179.15, -1000.15, -99.0),
		iplCoords = vec3(173.2903, -1003.6, -99.65707),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- 6 Car
		exitCoords = vec3(212.4, -998.97, -99.0),
		iplCoords = vec3(197.8153, -1002.293, -99.65749),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- 10 Car
		exitCoords = vec3(240.67, -1004.69, -99.0),
		iplCoords = vec3(229.9559, -981.7928, -99.66071),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Casino NightClub
		exitCoords = vec3(1545.57, 254.22, -46.01),
		iplCoords = vec3(1550.0, 250.0, -48.0),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Warehouse Medium
		exitCoords = vec3(1048.12, -3097.28, -39.0),
		iplCoords = vec3(1056.486, -3105.724, -39.00439),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Warehouse Large
		exitCoords = vec3(992.38, -3098.08, -39.0),
		iplCoords = vec3(1006.967, -3102.079, -39.0035),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Vehicle Warehouse
		exitCoords = vec3(956.12, -2987.24, -39.65),
		iplCoords = vec3(994.5925, -3002.594, -39.64699),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Old Bunker Interior
		exitCoords = vec3(899.5518,-3246.038, -98.04907),
		iplCoords = vec3(899.5518,-3246.038, -98.04907),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Arcadius Garage 1
		exitCoords = vec3(-198.666, -580.515, 136.00),
		iplCoords = vec3(-191.0133, -579.1428, 135.0000),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Arcadius Garage 2
		exitCoords = vec3(-124.532, -571.478, 136.00),
		iplCoords = vec3(-117.4989, -568.1132, 135.0000),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Arcadius Garage 3
		exitCoords = vec3(-135.412, -622.440, 136.00),
		iplCoords = vec3(-136.0780, -630.1852, 135.0000),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- Arcadius Mod Shop
		exitCoords = vec3(-139.388, -587.917, 167.00),
		iplCoords = vec3(-146.6166, -596.6301, 166.0000),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- 2133 Mad Wayne Thunder
		exitCoords = vec3(-1289.89, 449.83, 97.9),
		iplCoords = vec3(-1288, 440.748, 97.69459),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- 2868 Hillcrest Avenue
		exitCoords = vec3(-753.04, 618.82, 144.14),
		iplCoords = vec3(-763.107, 615.906, 144.1401),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- EclipseTowers, Apt 3	
		exitCoords = vec3(-785.12, 323.75, 212.0),
		iplCoords = vec3(-773.407, 341.766, 211.397),
		inventory = { weight = 500000, slots = 50 },
	},
	{
	-- 	Dell Perro Heights, Apt 7
		exitCoords = vec3(-1453.86, -517.64, 56.93),
		iplCoords = vec3(-1477.14, -538.7499, 55.5264),
		inventory = { weight = 500000, slots = 50 },
	}
}