local PlayerData       = {}
local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local Car = { 133987706, -1553120962 }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  TriggerServerEvent("esx:playerconnected")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

------------- LOGS DE ENTRADA EM CARROS DE EMERGENCIA ----------------
--[[

local isIncarPolice = false
local enviado = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
		local User = GetPlayerPed(-1)
		local playerName = GetPlayerName(PlayerId())
		local vehid = GetVehiclePedIsIn(User, false)
		local jogadorid = GetPlayerServerId(PlayerId())
		if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(vehid, -1) == User then
			if(PlayerData.job.name ~= "ambulance" and not isIncarPolice and PlayerData.job.name ~= "police" and PlayerData.job.name ~= "sheriff") then
				isIncarPolice = true
				enviado = enviado + 1
				if enviado == 1 then
					TriggerServerEvent('DiscordBot:ToDiscord', 'carrosemergencia', SystemName, "O jogador ( [" .. jogadorid .. "] " .. playerName .. " ) entrou num carro policial (PSP OU GNR), possivelmente estará a roubar o mesmo!!", 'system', source, false, false)
				end
			end
		else
			isIncarPolice = false
			enviado = 0
		end

	end
end)  --]]

------------- LOGS DE ENTRADA EM CARROS DE EMERGENCIA ----------------

------------- LOGS DE ENTRADA EM CARROS WHITELISTED ----------------
--[[
local isIncar = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)


		if(IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then

				if(Config.LogEnterPoliceVehicle == true and not isIncar) then

					for i=1, #blacklistedModels, 1 do

						if(blacklistedModels[i] == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))then
							TriggerServerEvent('DiscordBot:ToDiscord', 'carroblacklist', SystemName, "O jogador ( [ID: " .. jogadorid .. "] " .. playerName .. " ) entrou num carro blacklist (Modelo do Carro:" .. GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))) .. ") !!", 'system', source, false, false)
							isIncar = true
						end
					end
				end
		else
			isIncar = false
		end

	end
end) --]]

------------- LOGS DE ENTRADA EM CARROS WHITELISTED ----------------

------------- LOGS DE KILLS ----------------
--[[
Citizen.CreateThread(function()
    local alreadyDead = false

    while true do
        Citizen.Wait(1)
        local playerPed = GetPlayerPed(-1)
        if IsEntityDead(playerPed) and not alreadyDead then
            local playerName = GetPlayerName(PlayerId())
			
            killer = GetPedKiller(playerPed)
            killername = false
			
			local vitimaid = GetPlayerServerId(PlayerId())
			
            for id = 0, 355 do
                if killer == GetPlayerPed(id) then
					killerid = GetPlayerServerId(id)
                    killername = GetPlayerName(id)
                end
            end

            local death = GetPedCauseOfDeath(playerPed)

            if checkArray(Melee, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " foi morto à porrada por [" .. killerid .. "] " .. killername, 'system', source, false, false)
            elseif checkArray(Bullet, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " foi baleado por [" .. killerid .. "] " .. killername, 'system', source, false, false)
            elseif checkArray(Knife, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " foi esfaqueado por [" .. killerid .. "] " .. killername, 'system', source, false, false)
            elseif checkArray(Car, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " foi atropelado por [" .. killerid .. "] " .. killername, 'system', source, false, false)
            elseif checkArray(Animal, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " foi morto por um animal", 'system', source, false, false)
            elseif checkArray(FallDamage, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " morreu de queda", 'system', source, false, false)
            elseif checkArray(Explosion, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " morreu numa explosão", 'system', source, false, false)
            elseif checkArray(Gas, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " morreu intoxicado", 'system', source, false, false)
            elseif checkArray(Burn, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " morreu queimado", 'system', source, false, false)
            elseif checkArray(Drown, death) then
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " morreu afogado", 'system', source, false, false)
            else
                TriggerServerEvent('DiscordBot:ToDiscord', 'kill', SystemName, "[" .. vitimaid .. "] " .. playerName .. " morreu por causas desconhecidas", 'system', source, false, false)
            end	

            alreadyDead = true
        end

        if not IsEntityDead(playerPed) then
            alreadyDead = false
        end
    end
end) 
--]]
--[[
local weapons = {
	[-1569615261] = 'Morto à Porrada',
	[-1716189206] = 'Morto à facada',
	[1737195953] = 'Morto por cacetete',
	[1317494643] = 'Morto por martelo',
	[-1786099057] = 'Morto por um taco de baseball',
	[-2067956739] = 'Morto por um pé de cabra',
	[1141786504] = 'Morto por um taco de golf',
	[-102323637] = 'Morto por uma garrafa',
	[-1834847097] = 'Morto por um punhal',
	[-102973651] = 'Morto por um machado',
	[-656458692] = 'Morto por um KnuckleDuster',
	[-581044007] = 'Morto por uma Machete',
	[-1951375401] = 'Morto por uma lanterna',
	[-538741184] = 'Morto por um canivete',
	[-1810795771] = 'Morto por um Poolcue',
	[419712736] = 'Morto por um Wrench',
	[-853065399] = 'Morto por um Battleaxe',
	[453432689] = 'Baleado por uma Pistola',
	[3219281620] = 'Baleado por uma PistolMk2',
	[1593441988] = 'Baleado por uma Glock',
	[-1716589765] = 'Baleado por uma Deagle',
	[-1076751822] = 'Baleado por uma Pistola SNS',
	[-771403250] = 'Baleado por uma Pistola Pesada',
	[137902532] = 'Baleado por uma FN Model 1910',
	[-598887786] = 'Baleado por uma T/C G2 Contender',
	[-1045183535] = 'Baleado por uma Revólver',
	[584646201] = 'Baleado por uma Tec-9',
	[911657153] = 'Eletrocutado por um Tazer',
	[1198879012] = 'Morto por uma Pistola Sinalizadora',
	[324215364] = 'Baleado por uma MicroSMG',
	[-619010992] = 'Baleado por uma MachinePistol',
	[736523883] = 'Baleado por uma SMG',
	[2024373456] = 'Baleado por uma SMGMk2',
	[-270015777] = 'Baleado por uma Famas',
	[171789620] = 'Baleado por uma AR15 PDW',
	[-1660422300] = 'Baleado por uma MG',
	[2144741730] = 'Baleado por uma CombatMG',
	[3686625920] = 'Baleado por uma CombatMGMk2',
	[1627465347] = 'Baleado por uma TommyGun',
	[-1121678507] = 'Baleado por uma MAC-10',
	[-1074790547] = 'Baleado por uma AK-47',
	[961495388] = 'Baleado por uma AssaultRifleMk2',
	[-2084633992] = 'Baleado por uma M4A4',
	[4208062921] = 'Baleado por uma CarbineRifleMk2',
	[-1357824103] = 'Baleado por uma AUG',
	[-1063057011] = 'Baleado por uma SpecialCarbine',
	[2132975508] = 'Baleado por uma BullpupRifle',
	[1649403952] = 'Baleado por uma Mini Draco',
	[100416529] = 'Baleado por uma SniperRifle',
	[205991906] = 'Baleado por uma HeavySniper',
	[177293209] = 'Baleado por uma HeavySniperMk2',
	[-952879014] = 'Baleado por uma MarksmanRifle',
	[487013001] = 'Baleado por uma Shotgun XM1014',
	[2017895192] = 'Baleado por uma Sawed-Off',
	[-1654528753] = 'Baleado por uma BullpupShotgun',
	[-494615257] = 'Baleado por uma AssaultShotgun',
	[-1466123874] = 'Baleado por uma Musket',
	[984333226] = 'Baleado por uma HeavyShotgun',
	[-275439685] = 'Baleado por uma DoubleBarrelShotgun',
	[317205821] = 'Baleado por uma Autoshotgun',
	[-1568386805] = 'Explodido por uma GrenadeLauncher',
	[-1312131151] = 'Explodido por um RPG',
	[1119849093] = 'Baleado por uma Minigun',
	[2138347493] = 'Explodido por uma Firework',
	[1834241177] = 'Baleado por uma Railgun',
	[1672152130] = 'Explodido por uma HomingLauncher',
	[1305664598] = 'Intoxicado por uma GrenadeLauncherSmoke',
	[125959754] = 'Explodido por uma CompactLauncher',
	[-1813897027] = 'Explodido por uma Granada',
	[741814745] = 'Explodido por uma StickyBomb',
	[-1420407917] = 'Explodido por uma ProximityMine',
	[-1600701090] = 'Intoxicado por uma BZGas',
	[615608432] = 'Queimado por uma Molotov',
	[101631238] = 'Morto por um Extintor',
	[883325847] = 'Queimado por uma PetrolCan',
	[1233104067] = 'Morto por uma Flare',
	[600439132] = 'Morto por uma Bola',
	[126349499] = 'Morto por uma Bola de Neve',
	[-37975472] = 'Intoxicado por uma SmokeGrenade',
	[-1169823560] = 'Baleado por uma Pipebomb',
	[-72657034] = 'Morto por um Paraquedas'
}

Citizen.CreateThread(function()
    -- main loop thing
	alreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and not alreadyDead then
			killer = GetPedKiller(playerPed)
			killername = false
			for id = 0, 255 do
				if killer == GetPlayerPed(id) then
					killername = GetPlayerName(id)
				end
			end
			if killer == playerPed then
				TriggerServerEvent('DiscordBot:killerlog',0,0,nil)
			elseif killername then
				TriggerServerEvent('DiscordBot:killerlog',killername,1,hashToWeapon(GetPedCauseOfDeath(playerPed)))
			else
				TriggerServerEvent('DiscordBot:killerlog',0,2,nil)
			end
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
	end
end)

--]]
function hashToWeapon(hash)
	return weapons[hash]
end

------------- LOGS DE KILLS ----------------

function checkArray (array, val)
    for name, value in ipairs(array) do
        if value == val then
            return true
        end
    end
    return false
end

function GetPlayerByEntityID(id)
	for _, player in ipairs(GetActivePlayers()) do
		if(NetworkIsPlayerActive(player) and GetPlayerPed(player) == id) then return player end
	end
	return nil
end

--------------------------------------------------------------------------------- NOVO SISTEMA DE LOGS DE MORTES -----------------------------------------------------------------------------------------------------

WeaponNames = {
	[tostring(GetHashKey('WEAPON_UNARMED'))] = 'Porrada',
	[tostring(GetHashKey('GADGET_PARACHUTE'))] = 'Parachute',
	[tostring(GetHashKey('WEAPON_KNIFE'))] = 'Faca',
	[tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Nightstick',
	[tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hammer',
	[tostring(GetHashKey('WEAPON_BAT'))] = 'Baseball Bat',
	[tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
	[tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
	[tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Bottle',
	[tostring(GetHashKey('WEAPON_DAGGER'))] = 'Antique Cavalry Dagger',
	[tostring(GetHashKey('WEAPON_HATCHET'))] = 'Hatchet',
	[tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Knuckle Duster',
	[tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
	[tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Flashlight',
	[tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switchblade',
	[tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Battleaxe',
	[tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Poolcue',
	[tostring(GetHashKey('WEAPON_PIPEWRENCH'))] = 'Wrench',
	[tostring(GetHashKey('WEAPON_STONE_HATCHET'))] = 'Stone Hatchet',

	[tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
	[tostring(GetHashKey('WEAPON_PISTOL_MK2'))] = 'Pistol Mk2',
	[tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
	[tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50	',
	[tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistol',
	[tostring(GetHashKey('WEAPON_SNSPISTOL_MK2'))] = 'SNS Pistol Mk2',
	[tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
	[tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistol',
	[tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
	[tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Heavy Revolver',
	[tostring(GetHashKey('WEAPON_REVOLVER_MK2'))] = 'Heavy Revolver Mk2',
	[tostring(GetHashKey('WEAPON_DOUBLEACTION'))] = 'Double-Action Revolver',
	[tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
	[tostring(GetHashKey('WEAPON_STUNGUN'))] = 'Stun Gun',
	[tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
	[tostring(GetHashKey('WEAPON_RAYPISTOL'))] = 'Up-n-Atomizer',

	[tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
	[tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machine Pistol',
	[tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
	[tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
	[tostring(GetHashKey('WEAPON_SMG_MK2'))] = 'SMG Mk2	',
	[tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
	[tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
	[tostring(GetHashKey('WEAPON_MG'))] = 'MG',
	[tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG	',
	[tostring(GetHashKey('WEAPON_COMBATMG_MK2'))] = 'Combat MG Mk2',
	[tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg Sweeper',
	[tostring(GetHashKey('WEAPON_RAYCARBINE'))] = 'Unholy Deathbringer',

	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE_MK2'))] = 'Assault Rifle Mk2',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE_MK2'))] = 'Carbine Rifle Mk2',
	[tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE_MK2'))] = 'Special Carbine Mk2',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE_MK2'))] = 'Bullpup Rifle Mk2',
	[tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',

	[tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER_MK2'))] = 'Heavy Sniper Mk2',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE_MK2'))] = 'Marksman Rifle Mk2',

	[tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
	[tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
	[tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
	[tostring(GetHashKey('WAPAON_PIPEBOMB'))] = 'Pipe Bomb',
	[tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
	[tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
	[tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
	[tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
	[tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
	[tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
	[tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
	[tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',

	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
	[tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
	[tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
	[tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
	[tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
	[tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RAYMINIGUN'))] = 'Widowmaker',

	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN_MK2'))] = 'Pump Shotgun Mk2',
	[tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-off Shotgun',
	[tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
	[tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
	[tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
	[tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
	[tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
	[tostring(GetHashKey('WEAPON_SWEEPERSHOTGUN'))] = 'Sweeper Shotgun',

	[tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
	[tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
	[tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
	[tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [Vehicle]',
	[tostring(GetHashKey('OBJECT'))] = 'Object',
	[tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank Cannon',
	[tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Rockets',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
	[tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
	[tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
	[tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
	[tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Heli Crash',
	[tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
	[tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
	[tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exhaustion',
	[tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosion',
	[tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Electric Fence',
	[tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bleeding',
	[tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
	[tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
	[tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
	[tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
	[tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
	[tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Air Defence Gun',
	[tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
	[tostring(GetHashKey('WEAPON_COUGAR'))] = 'Cougar'
}


Citizen.CreateThread(function()
	local DeathReason, Killer, DeathCauseHash, Weapon

	while true do
		Citizen.Wait(0)
		if IsEntityDead(GetPlayerPed(PlayerId())) then
			Citizen.Wait(0)
			local PedKiller = GetPedSourceOfDeath(GetPlayerPed(PlayerId()))
			local killername = GetPlayerName(PedKiller)
			DeathCauseHash = GetPedCauseOfDeath(GetPlayerPed(PlayerId()))
			Weapon = WeaponNames[tostring(DeathCauseHash)]
			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
			end

			if (Killer == PlayerId()) then
				DeathReason = 'committed suicide'
			elseif (Killer == nil) then
				DeathReason = 'died'
			else
				if IsMelee(DeathCauseHash) then
					DeathReason = 'morto por bastão'
				elseif Porrada(DeathCauseHash) then
					DeathReason = 'morto à porrada'
				elseif IsTorch(DeathCauseHash) then
					DeathReason = 'queimado'
				elseif IsKnife(DeathCauseHash) then
					DeathReason = 'esfaqueado'
				elseif IsPistol(DeathCauseHash) then
					DeathReason = 'morto por pistola'
				elseif IsSub(DeathCauseHash) then
					DeathReason = 'morto por smg'
				elseif IsRifle(DeathCauseHash) then
					DeathReason = 'morto por rifle'
				elseif IsLight(DeathCauseHash) then
					DeathReason = 'morto por machine gun'
				elseif IsShotgun(DeathCauseHash) then
					DeathReason = 'morto por shotgun'
				elseif IsSniper(DeathCauseHash) then
					DeathReason = 'morto por sniper'
				elseif IsHeavy(DeathCauseHash) then
					DeathReason = 'morto por uma arma explosiva'
				elseif IsMinigun(DeathCauseHash) then
					DeathReason = 'morto por minigun'
				elseif IsBomb(DeathCauseHash) then
					DeathReason = 'bombardeado'
				elseif IsVeh(DeathCauseHash) then
					DeathReason = 'atropelado'
				elseif IsVK(DeathCauseHash) then
					DeathReason = 'atropelado'
				else
					DeathReason = 'morto'
				end
			end

			if DeathReason == 'committed suicide' or DeathReason == 'died' then
				TriggerServerEvent('DiscordBot:killerlog', 1, GetPlayerServerId(PlayerId()), 0, DeathReason, Weapon)
			else
				TriggerServerEvent('DiscordBot:killerlog', 2, GetPlayerServerId(PlayerId()), GetPlayerServerId(Killer), DeathReason, Weapon)
			end
			Killer = nil
			DeathReason = nil
			DeathCauseHash = nil
			Weapon = nil
		end
		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(0)
		end
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		local id = PlayerId()
		local playerped = GetPlayerPed(id)
		local playerName = GetPlayerName(id)
		local idjogador = GetPlayerServerId(id)
		local jogadorDisparando = IsPedShooting(playerped)
		
		if jogadorDisparando then
			TriggerServerEvent('DiscordBot:tirosdisparados', idjogador, playerName, WeaponNames[tostring(GetSelectedPedWeapon(playerped))])
			Citizen.Wait(5000)
		end
	end

end)


function hashToWeapon(hash)
	return weapons[hash]
end

function Porrada(Weapon)
	local Weapons = {'WEAPON_UNARMED'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsMelee(Weapon)
	local Weapons = {'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsTorch(Weapon)
	local Weapons = {'WEAPON_MOLOTOV'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsKnife(Weapon)
	local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsPistol(Weapon)
	local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSub(Weapon)
	local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRifle(Weapon)
	local Weapons = {'WEAPON_CARBINERIFLE', 'WEAPON_CARBINERIFLE_MK2', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_ASSAULTRIFLE_MK2', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsLight(Weapon)
	local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsShotgun(Weapon)
	local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSniper(Weapon)
	local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_SNIPERRIFLE_MK2', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsHeavy(Weapon)
	local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsMinigun(Weapon)
	local Weapons = {'WEAPON_MINIGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsBomb(Weapon)
	local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVeh(Weapon)
	local Weapons = {'VEHICLE_WEAPON_ROTORS'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVK(Weapon)
	local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end


--Debug shizzels :D
function ShowDebug(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName("~b~JD_logs Debug:~s~\n"..text)
	DrawNotification(true, true)
end
