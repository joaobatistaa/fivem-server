-- 
-- ██████╗░███████╗░█████╗░░█████╗░██╗██╗░░░░░
-- ██╔══██╗██╔════╝██╔══██╗██╔══██╗██║██║░░░░░
-- ██████╔╝█████╗░░██║░░╚═╝██║░░██║██║██║░░░░░
-- ██╔══██╗██╔══╝░░██║░░██╗██║░░██║██║██║░░░░░
-- ██║░░██║███████╗╚█████╔╝╚█████╔╝██║███████╗
-- ╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═╝╚══════╝

Config.DisableHeadshot = false       ---@param Set true it will remove heatshots (Requiere server restart)
Config.RemovePistolWhipping = true   ---@param Remove weapon whipping (Requiere server restart)
Config.UseCustomWeaponDamages = true ---@param Custom weapon damages true = Yes | false = no. (Requiere server restart)

Config.UseRecoil = false ---@param Enable custom recoil
Config.RightLeftRecoil = false ---@param true = Right Recoil | false = Left Recoil.
Config.RightLeftRecoilRandomiser = false ---@param If this is set to true then the recoil inside a vehicle will not trigger all the time. The value below will set the chance if true.
Config.RightLeftRecoilRandomiserChance = 50 ---@param This is a percentage out of 100. The higher it is, the higher the chance of recoil kicking inside a vehicle.

Config.UseVehicleRecoil = false ---@param Enable/Disable recoil inside vehicles.
Config.UseScreenExplosions = false ---@param Adds a small screen explosion, it is affected by how big recoil is.

Config.GripMultiplier =  true
Config.SuppressorMultiplier = true

Config.LoweredFirstPersonRecoil = false -- Turn on/off lowered recoil while being in first person mode..
Config.LoweredFirstPersonRecoilValue = 0.7 -- Value for lowered recoil. It is actually the recoil * the value. So the lower the value is here the lowered it will be in first person.

Config.Components = {
    [`WEAPON_PISTOL`] = { suppressor = `component_at_pi_supp_02`, grip = nil},
    [`WEAPON_PISTOL50`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = nil},
    [`WEAPON_COMBATPISTOL`] = { suppressor = `COMPONENT_AT_PI_SUPP`, grip = nil},
    [`WEAPON_APPISTOL`] = { suppressor = `COMPONENT_AT_PI_SUPP`, grip = nil},
    [`WEAPON_HEAVYPISTOL`] = { suppressor = `COMPONENT_AT_PI_SUPP`, grip = nil},
    [`WEAPON_VINTAGEPISTOL`] = { suppressor = `COMPONENT_AT_PI_SUPP`, grip = nil},
    [`WEAPON_SMG`] = { suppressor = `COMPONENT_AT_PI_SUPP`, grip = nil},
    [`WEAPON_MICROSMG`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = nil},
    [`WEAPON_ASSAULTSMG`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = nil},
    [`WEAPON_ASSAULTRIFLE`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_CARBINERIFLE`] = { suppressor = `COMPONENT_AT_AR_SUPP`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_ADVANCEDRIFLE`] = { suppressor = `COMPONENT_AT_AR_SUPP`, grip = nil},
    [`WEAPON_SPECIALCARBINE`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_BULLPUPRIFLE`] = { suppressor = `COMPONENT_AT_AR_SUPP`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_ASSAULTSHOTGUN`] = { suppressor = `COMPONENT_AT_AR_SUPP`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_HEAVYSHOTGUN`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_BULLPUPSHOTGUN`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_PUMPSHOTGUN`] = { suppressor = `COMPONENT_AT_SR_SUPP`, grip = nil},
    [`WEAPON_MARKSMANRIFLE`] = { suppressor = `COMPONENT_AT_AR_SUPP`, grip = `COMPONENT_AT_AR_AFGRIP`},
    [`WEAPON_SNIPERRIFLE`] = { suppressor = `COMPONENT_AT_AR_SUPP_02`, grip = nil},
    [`WEAPON_COMBATPDW`] = { suppressor = nil, grip = `COMPONENT_AT_AR_AFGRIP`}
}

Config.Weapons = {

    --You can change the values down here, feel free to also comment any weapons you don't want and add any weapons you do want. Only throwables are missing from this list.
    --Here's a link for you to find all weapons in GTA V: https://forge.plebmasters.de/weapons

    --Pistol--
    [1] = { hash = `WEAPON_PISTOL`, recoil = 0.90, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.30, damageMultiplier = 0.20},
    [2] = { hash = `WEAPON_PISTOL_MK2`, recoil = 1.55, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [3] = { hash = `WEAPON_COMBATPISTOL`, recoil = 1.50, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [4] = { hash = `WEAPON_APPISTOL`, recoil = 1.50, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [5] = { hash = `WEAPON_STUNGUN`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [6] = { hash = `WEAPON_PISTOL50`, recoil = 4.50, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [7] = { hash = `WEAPON_SNSPISTOL`, recoil = 1.30, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [8] = { hash = `WEAPON_SNSPISTOL_MK2`, recoil = 1.30, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [9] = { hash = `WEAPON_HEAVYPISTOL`, recoil = 2.50, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [10] = { hash = `WEAPON_VINTAGEPISTOL`, recoil = 1.30, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [11] = { hash = `WEAPON_FLAREGUN`, recoil = 3.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [12] = { hash = `WEAPON_MARKSMANPISTOL`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [13] = { hash = `WEAPON_REVOLVER`, recoil = 6.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [14] = { hash = `WEAPON_REVOLVER_MK2`, recoil = 6.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [15] = { hash = `WEAPON_DOUBLEACTION`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [16] = { hash = `WEAPON_RAYPISTOL`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [17] = { hash = `WEAPON_CERAMICPISTOL`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [18] = { hash = `WEAPON_NAVYREVOLVER`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [19] = { hash = `WEAPON_GADGETPISTOL`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    --Pistol--


    --Submachine Guns--
    [20] = { hash = `WEAPON_MICROSMG`, recoil = 2.20, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [21] = { hash = `WEAPON_SMG`, recoil = 1.90, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [22] = { hash = `WEAPON_SMG_MK2`, recoil = 1.90, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [23] = { hash = `WEAPON_ASSAULTMG`, recoil = 2.50, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [24] = { hash = `WEAPON_COMBATPDW`, recoil = 2.20, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [25] = { hash = `WEAPON_MACHINEPISTOL`, recoil = 2.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [26] = { hash = `WEAPON_MINISMG`, recoil = 1.70, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [27] = { hash = `WEAPON_RAYCARBINE`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    --Submachine Guns--


    --Shotguns--
    [28] = { hash = `WEAPON_PUMPSHOTGUN`, recoil = 3.50, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 0.00},
    [29] = { hash = `WEAPON_PUMPSHOTGUN_MK2`, recoil = 3.50, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [30] = { hash = `WEAPON_SAWNOFFSHOTGUN`, recoil = 4.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [31] = { hash = `WEAPON_ASSAULTSHOTGUN`, recoil = 6.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [32] = { hash = `WEAPON_BULLPUPSHOTGUN`, recoil = 4.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [33] = { hash = `WEAPON_MUSKET`, recoil = 6.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [34] = { hash = `WEAPON_HEAVYSHOTGUN`, recoil = 6.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [35] = { hash = `WEAPON_DBSHOTGUN`, recoil = 5.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [36] = { hash = `WEAPON_AUTOSHOTGUN`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [37] = { hash = `WEAPON_COMBATSHOTGUN`, recoil = 4.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    --Shotguns--

    --Assault Rifles--
    [38] = { hash = `WEAPON_ASSAULTRIFLE`, recoil = 1.97, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [39] = { hash = `WEAPON_ASSAULTRIFLE_MK2`, recoil = 2.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [40] = { hash = `WEAPON_CARBINERIFLE`, recoil = 1.90, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [41] = { hash = `WEAPON_CARBINERIFLE_MK2`, recoil = 2.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [42] = { hash = `WEAPON_ADVANCEDRIFLE`, recoil = 1.93, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [43] = { hash = `WEAPON_SPECIALCARBINE`, recoil = 1.95, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [44] = { hash = `WEAPON_SPECIALCARBINE_MK2`, recoil = 2.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [45] = { hash = `WEAPON_BULLPUPRIFLE`, recoil = 1.90, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [46] = { hash = `WEAPON_BULLPUPRIFLE_MK2`, recoil = 1.95, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [47] = { hash = `WEAPON_COMPACTRIFLE`, recoil = 2.12, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [48] = { hash = `WEAPON_MILITARYRIFLE`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    --Assault Rifles--   

    --Light Machine Guns--
    [49] = { hash = `WEAPON_MG`, recoil = 1.80, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [50] = { hash = `WEAPON_COMBATMG`, recoil = 1.70, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [51] = { hash = `WEAPON_COMBATMG_MK2`, recoil = 1.70, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [52] = { hash = `WEAPON_GUSENBERG`, recoil = 1.80, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    --Light Machine Guns--

    --Sniper Rifles--
    [53] = { hash = `WEAPON_SNIPERRIFLE`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [54] = { hash = `WEAPON_HEAVYSNIPER`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [55] = { hash = `WEAPON_HEAVYSNIPER_MK2`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [56] = { hash = `WEAPON_MARKSMANRIFLE`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [57] = { hash = `WEAPON_MARKSMANRIFLE_MK2`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    --Sniper Rifles--   

    --Heavy Weapons--
    [58] = { hash = `WEAPON_RPG`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [59] = { hash = `WEAPON_GRENADELAUNCHER`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [60] = { hash = `WEAPON_GRENADELAUNCHER_SMOKE`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [61] = { hash = `WEAPON_MINIGUN`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [62] = { hash = `WEAPON_FIREWORK`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [63] = { hash = `WEAPON_RAILGUN`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [64] = { hash = `WEAPON_HOMINGLAUNCHER`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [65] = { hash = `WEAPON_COMPACTLAUNCHER`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    [66] = { hash = `WEAPON_RAYMINIGUN`, recoil = 1.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
    --Heavy Weapons--      

    --Melee--
    [70] = { hash = `WEAPON_UNARMED`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [71] = { hash = `WEAPON_DAGGER`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [72] = { hash = `WEAPON_BAT`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [73] = { hash = `WEAPON_BOTTLE`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [74] = { hash = `WEAPON_CROWBAR`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [75] = { hash = `WEAPON_FLASHLIGHT`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [76] = { hash = `WEAPON_GOLFCLUB`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [77] = { hash = `WEAPON_HAMMER`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [78] = { hash = `WEAPON_HATCHET`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [79] = { hash = `WEAPON_KNUCKLE`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [80] = { hash = `WEAPON_KNIFE`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [81] = { hash = `WEAPON_MACHETE`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [82] = { hash = `WEAPON_SWITCHBLADE`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [83] = { hash = `WEAPON_NIGHTSTICK`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [84] = { hash = `WEAPON_WRENCH`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [85] = { hash = `WEAPON_BATTLEAXE`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [86] = { hash = `WEAPON_POOLCUE`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    [87] = { hash = `WEAPON_STONE_HATCHET`, recoil = 0.00, vehicleRecoil = 0.00, gripMultiplier = 0.00, suppressorMultiplier = 0.00, damageMultiplier = 0.25},
    --Melee--

    [88] = { hash = `WEAPON_ASSAULTSMG`, recoil = 2.00, rightLeftRecoil = 1.00, vehicleRecoil = 1.10, vehicleRightLeftRecoil = 2.00, gripMultiplier = 0.80, suppressorMultiplier = 0.72, damageMultiplier = 1.00},
}