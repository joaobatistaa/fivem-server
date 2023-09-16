------------ BLIPS  -------------
local Config = {}

Config.Map = {
  --{name="Votar para o Presidente",color=83, id=409, x = -266.36416625977, y = -2035.6640625, z = 29.145593643188},
  --{name="Tomada de Posse",color=83, id=280, x = 198.55, y = 1165.35, z = 229.145593643188},
  --{name="Apanha Erva",color=69, id=140, x= 2205.38, y= 5579.44, z= 53.85},
 -- {name="Processamento Erva",color=69, id=140, x= 1904.33,  y= 4922.7,  z= 52.25},
--	{name="Venda Erva",color=69, id=140, x= 2329.55, y= 2571.95, z= 45.68},
--  {name="Tequilla",color=83, id=93, x= -559.18, y= 290.37, z= 82.98},
	{name="Bahamas",color=48, id=93, x= -1394.30, y= -602.260, z= 29.32},
	{name="Vanilla",color=27, id=121, x = 129.246, y = -1299.363, z = 29.501},
	{name="Remax",color=1, id=94, x = -117.81, y = -607.35, z = 36.28},
--  {name="Galaxy",color=3, id=93, x= 344.09, y= 288.68, z= 95.32},
--  {name="Taxi",color=60, id=198, x= 906.89, y= -175.99, z= 74.11},
 -- {name="Uber",color=3, id=198, x= -314.63, y= -1094.89, z= 23.03},
	--{name="IKEA",color=5, id=569, x= 2749.63, y= 3472.08, z= 54.68},
--  {name="Loja Erva",color=69, id=140, x = -1172.55, y = -1572.55, z = 42.73},
--	{name="Plantação Erva",color=69, id=140, x= 2218.56,  y= 5578.03,  z= 53.78},
	{name="Igreja",color=0, id=305, x= -1682.5,  y= -291.62,  z= 52.5},
	{name="Tribunal",color=0, id=409, x= -529.08,  y= -175.69,  z= 38.22},
    --{name="Casino",color=38, id=89, x= 924.25,  y= 46.74,  z= 81.11},
	--{name="Vodafone",color=1, id=59, x= -657.37,  y= -856.65,  z= 24.5},
	{name="Kartódromo",color=2, id=315, x= -119.84,  y= -2117.93,  z= 16.71},
	{name="Redline",color=2, id=446, x= -374.962,  y= -118.168,  z= 38.697},
	--{name="Carrinhos de Choque",color=1, id=380, x= -1733.99,  y= -1172.34,  z= 12.38},
--  {name="Prime Motorcycles",color=7, id=226, x= -906.18,  y= -228.86,  z= 39.95},
	--{name="Pista de Arranques",color=1, id=380, x= 1387.82,  y= 3164.56,  z= 40.41},
   -- {name="Loja de Caça",color=5, id=141, x = -675.55, y = 5836.1, z = 17.34},
--	{name="Stand Importados",color=49, id=225, x= -794.08,  y= -227.11,  z= 37.15},
	--{name="Loja de Pesca",color=29, id=317, x= -1599.38,  y= 5201.66,  z= 4.4},
	--{name="Loja de Pesca - Cayo Perico",color=29, id=317, x = 4818.71, y = -4309.48, z = 5.23},
	{name="Lago",color=18, id=410, x= 1104.14,  y= -562.08,  z= 58.48},
--	{name="Quartel dos Bombeiros",color=1, id=436, x= 1200.53,  y= -1473.16,  z= 34.86},
	{name="Centro de Treinamentos da Policia",color=2, id=110, x= -921.66,  y= -2915.22,  z= 13.95},
--	{name="Esquadra do DPR Centro",color=29, id=60, x= 1855.8,  y= 3682.53,  z= 34.26},
--	{name="Câmara Municipal",color=3, id=498, x= 237.35,  y= -406.75,  z= 34.26},
	--{name="Local de Caça",color=75, id=442, x= -769.63,  y= 5592.75,  z= 33.48},
	--{name="Norauto",color=5, id=446, x= 827.06, y = -897.3, z = 29.89},
	--{name="WorldCostumers",color=10, id=226, x= -197.98, y = -1384.61, z = 31.26},
	--{name="Reboques",color=10, id=68, x= -429.38,  y= -1727.94,  z= 18.78},
	--{name="Quartel dos Bombeiros",color=1, id=436, x= -364.18,  y= 6117.74,  z= 34.86},
	{name="Esquadra da PSP",color=29, id=60, x= 439.33, y = -982.3, z = 30.71},
	--{name="Esquadra da PSP",color=29, id=60, x= 377.15, y = -1595.22, z = 30.04},
	{name="Esquadra da PSP",color=29, id=60, x= -444.33, y = 6010.15, z = 32.29},
	--{name="BurguerShot",color=49, id=106, x = -1196.45, y = -892.64, z = 13.50},
}

------------ FIM BLIPS ----------

Citizen.CreateThread(function()
	
	for i=1, #Config.Map, 1 do
		
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
	end

end)