
### INSTALL ###

1) Drag and drop `dz-drone` into your server resources
2) Ensure `dz-drone` in your server.cfg
3) Add drone items into your `qb-core/shared/items.lua` for QBCore
4) Add drone items into your `database` if you use ESX sql based items
5) Copy the items images from `images` folder into your `inventory` folder
6) Restart your server

### QBCore Item under qb-core/shared/items.lua ###
	['drone'] 					    = {['name'] = 'drone', 		     			   	['label'] = 'Drone', 						['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'drone.png', 						['unique'] = true,    	['useable'] = true, 	['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'Regular Drone with regular options.'},	
	['drone_lspd'] 		 		    = {['name'] = 'drone_lspd', 					['label'] = 'LSPD Drone', 					['weight'] = 1500, 	    ['type'] = 'item', 		['image'] = 'drone_lspd.png', 					['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'Advanced LSPD Drone with and advanced options.'},


### ESX sql Items ###
	INSERT INTO `items` (name, label, `limit`) VALUES
		('drone', 'Drone', 1),
		('drone_lspd', 'LSPD Drone', 1),
	;

### SUPPORT ###
https://discord.gg/8nFqCR4xVC