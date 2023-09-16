--[[  
    Vehicle configuration system!
    Add your custom vehicles, and in BackEngineVehicles, you 
    can configure the vehicles that bring the stash in front of it.
]]

Config.UseItemInVehicle = true -- Disables the use of items in vehicles

Config.VehicleClass = { --You can check the type of vehicle here or in its META files https://wiki.rage.mp/index.php?title=Vehicles#Compacts.
    [0] =   { MaxWeight = 200000,    slots = 50 }, -- Compacts
    [1] =   { MaxWeight = 300000,    slots = 50 }, --Sedans
    [2] =   { MaxWeight = 800000,    slots = 50 }, --SUVs
    [3] =   { MaxWeight = 200000,    slots = 50 }, --Coupes
    [4] =   { MaxWeight = 200000,    slots = 50 }, --Muscle
    [5] =   { MaxWeight = 200000,    slots = 50 }, -- Sports Classics
    [6] =   { MaxWeight = 250000,    slots = 50 }, --Sports
    [7] =   { MaxWeight = 200000,    slots = 50 }, --Super
    [8] =   { MaxWeight = 50000,    slots = 50 }, --Motorcycles
    [9] =   { MaxWeight = 1000000,    slots = 50 }, --Off-road
    [10] =  { MaxWeight = 1800000,    slots = 50 }, --Industrial
    [11] =  { MaxWeight = 1800000,    slots = 50 }, --Utility
    [12] =  { MaxWeight = 1800000,    slots = 50 }, --van
    [13] =  { MaxWeight = 0,    slots = 50 }, --Cycles
    [14] =  { MaxWeight = 150000,    slots = 50 }, --boats
    [15] =  { MaxWeight = 150000,    slots = 50 }, --Helicopters
    [16] =  { MaxWeight = 400000,    slots = 50 }, --Planes
    [17] =  { MaxWeight = 1800000,    slots = 50 }, -- Service
    [18] =  { MaxWeight = 1800000,    slots = 50 }, --Emergency
    [19] =  { MaxWeight = 1800000,    slots = 50 }, --Military
    [20] =  { MaxWeight = 1800000,    slots = 50 }, -- Commerical
    [21] =  { MaxWeight = 1800000,    slots = 50 }  --Trains
}

Config.CustomTrunk = {
    [joaat('flatbed')] = {
        slots = 50,
        maxweight = 1000000
    },
	[joaat('sandking')] = {
        slots = 50,
        maxweight = 7500000
    },
	[joaat('sandking2')] = {
        slots = 50,
        maxweight = 7500000
    },
	[joaat('rebel')] = {
        slots = 50,
        maxweight = 4000000
    },
	[joaat('rebel2')] = {
        slots = 50,
        maxweight = 4000000
    },
	[joaat('yosemite')] = {
        slots = 50,
        maxweight = 4000000
    },
	[joaat('yosemite3')] = {
        slots = 50,
        maxweight = 4000000
    },
	[joaat('slamvan')] = {
        slots = 50,
        maxweight = 4000000
    },
	[joaat('slamvan2')] = {
        slots = 50,
        maxweight = 4000000
    },
	[joaat('slamvan3')] = {
        slots = 50,
        maxweight = 4000000
    },
	[joaat('caracara')] = {
        slots = 50,
        maxweight = 7500000
    },
	[joaat('caracara2')] = {
        slots = 50,
        maxweight = 7500000
    },
	[joaat('everon')] = {
        slots = 50,
        maxweight = 6000000
    },
	[joaat('bodhi2')] = {
        slots = 50,
        maxweight = 6000000
    },
	[joaat('f150')] = {
        slots = 50,
        maxweight = 7000000
    },
	[joaat('riata')] = {
        slots = 50,
        maxweight = 6000000
    },
	[joaat('dubsta3')] = {
        slots = 50,
        maxweight = 6000000
    },
	[joaat('kamacho')] = {
        slots = 50,
        maxweight = 6000000
    },
	[joaat('rr14')] = {
        slots = 50,
        maxweight = 6000000
    },
	[joaat('22g63')] = {
        slots = 50,
        maxweight = 6000000
    },
	[joaat('bagger')] = {
        slots = 50,
        maxweight = 3500000
    },
	[joaat('brioso2')] = {
        slots = 50,
        maxweight = 5000000
    },
	[joaat('sultanrs')] = {
        slots = 50,
        maxweight = 3000000
    },
	[joaat('sultan')] = {
        slots = 50,
        maxweight = 3000000
    },
	[joaat('rubble')] = {
        slots = 50,
        maxweight = 3000000
    },
	[joaat('guardian')] = {
        slots = 50,
        maxweight = 3000000
    },
	[joaat('g65')] = {
        slots = 50,
        maxweight = 1000000
    },
	[joaat('x6mf16')] = {
        slots = 50,
        maxweight = 1000000
    },
	[joaat('rmodx6')] = {
        slots = 50,
        maxweight = 1000000
    },
	[joaat('master2019')] = {
        slots = 50,
        maxweight = 1000000
    },
}

Config.CustomGlovebox = {
    [joaat('adder')] = {
        slots = 5,
        maxweight = 1000000
    },
}

Config.BackEngineVehicles = {
    [`ninef`] = true,
    [`adder`] = true,
    [`vagner`] = true,
    [`t20`] = true,
    [`infernus`] = true,
    [`zentorno`] = true,
    [`reaper`] = true,
    [`comet2`] = true,
    [`comet3`] = true,
    [`jester`] = true,
    [`jester2`] = true,
    [`cheetah`] = true,
    [`cheetah2`] = true,
    [`prototipo`] = true,
    [`turismor`] = true,
    [`pfister811`] = true,
    [`ardent`] = true,
    [`nero`] = true,
    [`nero2`] = true,
    [`tempesta`] = true,
    [`vacca`] = true,
    [`bullet`] = true,
    [`osiris`] = true,
    [`entityxf`] = true,
    [`turismo2`] = true,
    [`fmj`] = true,
    [`re7b`] = true,
    [`tyrus`] = true,
    [`italigtb`] = true,
    [`penetrator`] = true,
    [`monroe`] = true,
    [`ninef2`] = true,
    [`stingergt`] = true,
    [`surfer`] = true,
    [`surfer2`] = true,
    [`gp1`] = true,
    [`autarch`] = true,
    [`tyrant`] = true,
    [`18performante`] = true,
}
