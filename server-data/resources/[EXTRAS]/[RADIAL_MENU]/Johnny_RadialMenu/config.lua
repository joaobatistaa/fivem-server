ESX = nil

local playergroup = nil

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
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local sleep = 5000

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(sleep)
        if ESX ~= nil then
			if playergroup == nil then
				ESX.TriggerServerCallback('johnny:server:getGrupo', function(group)
					playergroup = group
				end)
			else
				sleep = 10000
			end
		else
			sleep = 1000
        end
    end
end)

 
local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}

rootMenuConfig =  {
    {
        id = "general",
        displayName = "Animações",
        icon = "#icon-animacoes",
        enableMenu = function()
            return true
        end,
        subMenus = {"animacoes:carregar",  "animacoes:cruzarbracos", "animacoes:rastejar", "animacoes:desmaiar", "animacoes:baleado", "animacoes:refem", "animacoes:render", "general:emotes"}
    },
	{
        id = "policemenu",
        displayName = "Polícia",
        icon = "#icon-policia",
        enableMenu = function()
			if PlayerData.job.name == 'police' then	
				return true
			else
				return false
			end
		end,
        subMenus = {"policia:localizadormatriculas", "policia:radarveiculo"}
    },
	{
        id = "gestao",
        displayName = "Gestão",
        icon = "#carro-gestao",
        enableMenu = function()
            return true
        end,
        subMenus = {"gestao:servicos", "gestao:hud", "gestao:radio", "gestao:telemovel", "gestao:menuassalto"} --"gestao:cartoes", 
    },
	{
        id = "admin",
        displayName = "Admin",
        icon = "#menu-admin",
        enableMenu = function()
			if playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' then
				return true
			end
        end,
        subMenus = {"admin:menuadmin", "admin:toggleadmin", "admin:playercontrol", "admin:spectate"}
    },
    {
        id = "animations",
        displayName = "Estilos Andar",
        icon = "#walking",
        enableMenu = function()
            return true
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
    {
        id = "expressions",
        displayName = "Expressões",
        icon = "#expressions",
        enableMenu = function()
            return true
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    }
}

newSubMenus = {

    ['gestao:cartoes'] = {
        title = "Cartões",
        icon = "#gestao-cartoes",
        functionName = "gestao:cartoes"
    },
	
	['gestao:servicos'] = {
        title = "Serviços",
        icon = "#gestao-servicos",
        functionName = "gestao:servicos"
    }, 
	
	['gestao:chavesmotel'] = {
        title = "Chaves Motel",
        icon = "#gestao-chavesmotel",
        functionName = "james_motels:menuchaves"
    },
	
	['gestao:hud'] = {
        title = "Alterar HUD",
        icon = "#gestao-hud",
        functionName = "gestao:hud"
    },	
	
	['gestao:radio'] = {
        title = "Rádio",
        icon = "#gestao-radio",
        functionName = "ls-radio:usarClient"
    },
	
	['gestao:telemovel'] = {
        title = "Telemóvel",
        icon = "#gestao-telemovel",
        functionName = "johnny_core:abrir_telemovel"
    },
	
	['gestao:menuassalto'] = {
        title = "Menu Assalto",
        icon = "#gestao-menuassalto",
        functionName = "cuffs:OpenMenu"
    },
	
	
	['policia:localizadormatriculas'] = {
        title = "Localizador Matrícula",
        icon = "#police-vehicle-radar",
        functionName = "mark-b_police-tracker:openUI"
    },
	
	['policia:radarveiculo'] = {
        title = "Radar Veículo",
        icon = "#police-plate-loc",
        functionName = "Johnny_RadarPolicia:OpenUI"
    },
	
	
	
	------------ ANIMAÇÕES HABITUAIS ----------
	
    ['animacoes:carregar'] = {
        title = "Carregar",
        icon = "#carregar",
        functionName = "animacoes:carregar"
    },
    ['animacoes:cruzarbracos'] = {
        title = "Cruzar Braços",
        icon = "#cruzarbracos",
        functionName = "animacoes:cruzarbracos"
    },
    ['animacoes:rastejar'] = {
        title = "Rastejar",
        icon = "#rastejar",
        functionName = "animacoes:rastejar"
    },
	['animacoes:desmaiar'] = {
        title = "Desmaiar",
        icon = "#desmaiar",
        functionName = "animacoes:desmaiar"
    },
	['animacoes:baleado'] = {
        title = "Baleado",
        icon = "#baleado",
        functionName = "animacoes:baleado"
    },	
	['animacoes:refem'] = {
        title = "Refém",
        icon = "#refem",
        functionName = "animacoes:refem"
    },
	['animacoes:render'] = {
        title = "Render",
        icon = "#render",
        functionName = "KneelHU"
    },
	
	------------- MENU CARRO ---------------
	
    ['carro:trancar'] = {
        title = "Chave",
        icon = "#gestao-chavesmotel",
        functionName = "carro:chavedocarro"
    },
    ['carro:gestao'] = {
        title = "Menu",
        icon = "#carro-gestao",
        functionName = "carremote:toggleUI"
    }, 
    ['carro:neon'] = {
        title = "Néon",
        icon = "#carro-neon",
        functionName = "carro:neon"
    }, 	
	
	--------- MENU ROUPAS --------------
	
	['roupas:casaco'] = {
        title = "Casaco",
        icon = "#menu-roupas",
        functionName = "roupas:casaco"
    },
	['roupas:calcas'] = {
        title = "Calças",
        icon = "#menu-roupas",
        functionName = "roupas:calcas"
    },
	['roupas:sapatos'] = {
        title = "Sapatos",
        icon = "#menu-roupas",
        functionName = "roupas:sapatos"
    },
	['roupas:oculos'] = {
        title = "Óculos",
        icon = "#menu-roupas",
        functionName = "roupas:oculos"
    },
	['roupas:mascara'] = {
        title = "Máscara",
        icon = "#menu-roupas",
        functionName = "roupas:mascara"
    },
	['roupas:chapeu'] = {
        title = "Chapéu",
        icon = "#menu-roupas",
        functionName = "roupas:chapeu"
    },
	['roupas:orelha'] = {
        title = "Acess. Orelha",
        icon = "#menu-roupas",
        functionName = "roupas:orelha"
    },
	
	---------------- ANIMAÇÕES ---------------
	
    ['animations:brave'] = {
        title = "Corajoso",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Apressado",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Negócios",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Bêbado",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Magoado",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Forte",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Atrevido",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Triste",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Elegante",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Indiferente",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Vagabundo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Rico",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Estiloso",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Suspeito",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Gay",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "Gay 2",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Normal",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
	
	------------- MENU ADMIN -------------
	
	['admin:menuadmin'] = {
        title = "Menu Admin",
        icon = "#menu-admin",
        functionName = "gestao:admin"
    },
	
	['admin:toggleadmin'] = {
        title = "Entrar/Sair Admin",
        icon = "#menu-admin",
        functionName = "modoadmin:toggleadmin"
    },
	
	['admin:playercontrol'] = {
        title = "Gerir Jogadores",
        icon = "#menu-admin",
        functionName = "es_admin2:abrirmenu"
    },
	
	['admin:spectate'] = {
        title = "Spectate",
        icon = "#menu-admin",
        functionName = "esx_spectate:spectate"
    },
	
	------------- EXPRESSÕES --------------
	
    ["expressions:angry"] = {
        title="Nervoso",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Bêbado",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Burro",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Eletrocutado",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Mal Humorado",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Feliz",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Magoado",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Alegre",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Espantado",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="Fechar Olho",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Chocado",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Com Sono",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Convencido",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Especulativo",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Estressado",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Amuado",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Estranho",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Estranho 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    }
	
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 500 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

------------ MENU F5 ANTIGO ---------------
 
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
Config								= {}

--------------------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------------------
-- GENERAL
Config.general = {
	manettes = false,
}
-- GPS RAPIDE
Config.poleemploi = {
	x = -259.08557128906,
	y = -974.677734375,
	z = 31.220008850098,
}
Config.comico = {
	x = 430.91763305664,
	y = -980.24694824218,
	z = 31.710563659668,
}
Config.hopital = {
	x = 292.29,
	y = -583.66,
	z = 43.19,
}
Config.concessionnaire = {
	x = -44.385055541992,
	y = -1109.7479248047,
	z = 26.437595367432,
}
-- Ouvrir le menu perso
Config.menuperso = {
	clavier = Keys["F5"],
}
-- Ouvrir le menu job
Config.menujob = {
}
-- TP sur le Marker
Config.TPMarker = {
	clavier = Keys["DELETE"],
}
-- Lever les mains
Config.handsUP = {
}
-- Pointer du doight
Config.pointing = {
}
-- S'acroupir
Config.crouch = {
}

------------ MENU F5 ANTIGO ---------------
