Config = {

--I recommend not touching this.
    Weapon = 'WEAPON_APPISTOL',

--Here you choose if the weapon is eliminated at the end of the Match.
    RemoveWeapon = true,

--Minimum players needed to start a game.
    RequiredPlayers = 2,

--This is the area where the entrance to Counter Strike is located.
    JoinCircle = vector3(324.0188, 4323.245, 48.20),

--Queue time before entering the game (in minutes).
    QueueTime = 0.3,

--Time that the game will last (in minutes).
    MatchLength = 5,

--The time that shows the winner and the data at the end of the game (in seconds)
    DisplayWinner = 10,

--Choose true to force the first person.
    ForceFirstPerson = true,

--These are the players' Spawn points on the Counter Strike map.
    SpawnPoints = {
        vector3(451.3637, 5608.543, 2146.188),
        vector3(447.6503, 5570.633, 2146.184),
        vector3(450.9994, 5530.453, 2147.578),
        vector3(410.4653, 5592.792, 2145.935),
        vector3(487.068, 5586.829, 2147.035),
        vector3(452.8733, 5643.275, 2147.435),
        vector3(389.9046, 5623.262, 2147.135),
        vector3(410.4666, 5593.027, 2146.335),
        vector3(419.7946, 5559.776, 2146.235),
        vector3(422.1427, 5523.408, 2147.335),
    },

--Position and details of the winner.
    WinnerPosition = vector3(-144.4975, -593.673, 210.7751),
    WinnerHeading = 193.6,
    WinnerCam = vector3(-144.5389, -597.1759, 211.775),
    Reward = '20000',

--Price to enter the game.
    Price = 10000,

--Here you can configure the translations, be careful, the system is somewhat fragile.
    Translations = {
        ['join_paintball'] = '~g~E~w~ -Entrar na fila para ~r~De_Dust~w~',
        ['leave_paintball'] = '~g~E~w~ - Sair da Fila\n%s',  
        ['left_paintball'] = 'Afastaste do local da fila e foste removido da mesma',
        ['match_in_progress'] = '~r~%s\n~w~Ainda tens ~g~%s~w~ segundos restantes até o jogo terminar..',
        ['gun_removed'] = 'A tua arma foi removida porque já não estás em jogo',
        ['match_ends'] = 'O jogo acaba em: ~g~%s ~w~segundos\nKills: ~g~%s ~w~\nMortes: ~r~%s',
        ['seconds_starts'] = ' O jogo vai começar em ',
        ['match_progress'] = 'Já existe um jogo a decorrer..',
        ['in_queue'] = ' jogadores...\n',
        ['you_killed'] = 'Mataste ',
        ['you_got_killed'] = 'Foste morto por ',
        ['killed_by'] = ' foi morto por ',
        ['no_money'] = 'Não tens dinheiro suficiente para participar no deathmatch (10.000€).',
        ['won'] = '~g~%s ~w~ganhou o jogo: %s kills e %s mortes.\n~w~Acabaste com: %s kills e %s mortes.',
        ['you_won'] = '\nGanhaste o jogo com %s kills e %s mortes.',
        ['reward_notify'] = 'Ganhaste o deathmatch e recebeste 20.000€'   
    },
}

--Customize as you like the Marker of this resource 
--[https://docs.fivem.net/docs/game-references/markers/]
Config.MarkerSettings = { 
    type = 1, 
    scale = {x = 12.5, y = 12.5, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 120},
    x = 188.45,
    y = -913.63,
    z = 29.71
}

--Choose the Blip that you want from this website.
--https://docs.fivem.net/docs/game-references/blips/
Blip = {
	blip = {
		name = 'WTRP - Deathmatch',
		sprite = 310,
		color = 3,
		scale = 0.8,
	},
}	

--You can change mythic_notify for your notification system.
function SendTextMessage(msg)
	--SetNotificationTextEntry('STRING')
	--AddTextComponentString(msg)
	--DrawNotification(0,1)
    
	exports['mythic_notify']:DoHudText('inform', msg)
end