Config = {}
-- For more info check https://codem.gitbook.io/codem-documentation/

Config.Theme = 'blvck' --  sky, blvck, cherry, kush, mango, proxima
Config.Logo = 'default' -- Default or URL link
Config.BackgroundImage = 'background.png' -- default or custom image/video
-- Backgrounds can be found in html/assets/background/
-- Config.BackgroundImage = 'background.png'
Config.PlayMusicByDefault = true -- if true plays the music when loading screen is active

--html\assets\music
Config.Musics = {
    "music.mp3",
    "music-1.mp3",
}

-- To display on left menu (must be an image)
-- Supports max 2 images
Config.AlbumsThumbnail = {
    {
        source = 'https://i.imgur.com/5v9y4AD.png', -- Must be a link
    },
    {
        source = 'https://i.imgur.com/5v9y4AD.png', -- Must be a link
    }
}

Config.Albums = {
    {
        source = 'https://i.imgur.com/5v9y4AD.png', -- Must be a link
    },
    {
        source = 'EjaorVlUcn0'  -- Must be a link
    }
}


Config.EnableHintMessages = true
Config.HintMessages = {
	{
		text= 'Podes socializar-te em locais específicos da cidade. As chances de encontrar jogadores são maiores em lugares como o Motel, Stand, Hospital, etc.',
		time= 8000,
	},
	{
		text= 'Todos os jogadores que entram no servidor têm que ler as regras no discord!',
		time= 3000,
	},
	{
		text= 'É obrigatório ter gravações de vídeo em tickets abertos para reembolso de danos.',
		time= 1000,
	}
}


Config.ButtonLinks = {
    -- ["twitter"] = 'https://twitter.com',
    ["instagram"] = 'https://www.instagram.com/worldtugarp',
    -- ["reddit"] = 'https://www.reddit.com/',
    ["discord"] = 'https://discord.gg/APHUfj5u8p',
}

Config.ServerName = 'WORLDTUGA RP'

Config.Language = {
    ["WELCOME"] = 'BEM VINDO AO',
	["INSIDE_CITY"] = 'Imagens do Servidor',
	["FOOTAGES"] = 'Últimas imagens do servidor',
	["PATCH_NOTES"] = 'Notas da Atualização',
	["PATCH_NOTES_VERSION"] = 'Notas da Atualização V1.0',
	["LATEST_UPDATES"] = 'Últimas atualizações...',
	["FOLLOW_CITY"] = 'Siga-nos nas redes sociais.',


    ["CITY_LOADING"] = 'Por favor, aguarda, o servidor está a carregar...',
	["SETTINGS"] = 'Definições',
	["ENABLE_MUSIC"] = 'Ligar/Desligar música',
	["SHOW_MENU"] = 'Mostrar Menu',
	["SHOW_HINT"] = 'Mostrar Dica',
	["SHOW_ALL"] = 'Mostrar toda a Interface',

	["KEYBINDS_INFO"] = 'Clique numa tecla para ver a sua função',
	["KEYBINDS_INFO_2"] = 'Algumas teclas podem ser alteradas nas configurações do jogo,',
	["GO_TO"] = 'Para alterar, clica em',
	["FIVEM_SETTINGS"] = 'ESC>Configurações>Teclas de Atalho>FiveM',
	["PRESS"] = 'Clique',
	["DOUBLE_PRESS"] = 'Clique Duplo',
	["COMBINATIONS"] = 'Combinações',
	["KEYBINDS_INFO_3"] = 'Clica numa tecla para ver a sua atribuição.',
	["KEYBINDS_INFO_4"] = 'Lembra-te de que essas teclas são atalhos para comandos. Existem muitos comandos que não possuem uma tecla no jogo.',

	["COMMANDS"] = 'Comandos',
	["SHOW_ALL"] = 'Mostrar todos os comandos',
	["SELECT_COMMAND"] = 'Por favor, seleciona um comando',
	["DISPLAY_BINDING"] = 'Mostrar tecla',
	["COMMANDS_INFO"] = 'Clica num comando para ver a sua função',
	["HINT"] = 'Dica',
}

Config.PatchNotes = {
	"Empregos legais melhorados, com mais animações...",
	"Novo Sistema de Casas reais com +300 decorações interior/exterior + Remax.",
	"Smartphone (Iphone 14 Pro Max) realístico com várias aplicações e definições que podes personalizar a teu gosto.",
	"Inventário totalmente personalizável a teu gosto, com sistema de controlo de roupas, attachments das armas, Craft, Lojas, Cofres (All in One)...",
	"Novo menu de faturas com muitas mais opções.",
	"Sistema de Banco real com cartão de crédito, PIN e muito mais...",
	"Novo sistema de garagem e novo stand.",
	"Novos assaltos multiplayer, com várias animações.",
	"Cartões únicos com item no inventário (Cartão de Cidadão, Carta de Condução, Licenças de Barco e Avião, Porte de Arma, Licença de Caça).",
	"Novos Carros com handlings melhoradas, Novos mapas e novas Roupas...",
	"Novo design dos menus.",
	"Novo sistema policial com muitas mais interações/informações para a PSP.",
	"Novo design dos menus.",
	"Hud redesenhado, com menu de definições.",
	"Sistema de drogas melhorado.",
	"Novo menu de controlo de portas/luzes/motor do veículo.",
	"Hangar de Aviões adicionado (Agora é possível ter uma aeronave/helicóptero), mas apenas com licença de aviação.",
	"Missão de rapto adicionada.",
	"Menu Néon para Vip's (várias animações e controlo de néons personalizado).",
	"Novo menu de Tunagem.",
	"Seguradora para veículos.",
	"Sistema real de veículos com contagem de quilómetros, revisão e manutenção.",
	"Sistema de rebocamento com corda.",
	"Novos itens adicionados às lojas.",
	"Ilha Cayo Perico e Barcos.",
	"Isto tudo e muito mais, explora o servidor e diverte-te!"
}

Config.Keybinds = {
    ["ESC"] = false,
    ["F1"] = {
        ["pressInfo"] = 'Radial Menu com Funções Essenciais',
        ["doublePressInfo"] = false,
    },
    ["F2"] = {
        ["pressInfo"] = 'Inventário',
    },
    ["F3"] = {
        ["pressInfo"] = 'Telemóvel',
    },
    ["F4"] = false,
    ["F5"] = false,
    ["F6"] = {
        ["pressInfo"] = 'Menu Emprego',
    },
    ["F7"] = {
        ["pressInfo"] = 'Menu Faturas',
    },
    ["F8"] = false,
    ["F9"] = false,
    ["F10"] = false,
    ["F11"] = false,
    ["F12"] = false,
    ["“"] = false,
    ["1"] = {
        ["pressInfo"] = 'Usar Item da Slot 1 do Inventário',
    },
    ["2"] = {
        ["pressInfo"] = 'Usar Item da Slot 2 do Inventário',

    },
    ["3"] = {
        ["pressInfo"] = 'Usar Item da Slot 3 do Inventário',

    },
    ["4"] = {
        ["pressInfo"] = 'Usar Item da Slot 4 do Inventário',

    },
    ["5"] = {
        ["pressInfo"] = 'Usar Item da Slot 5 do Inventário',

    },
    ["6"] = false,
    ["7"] = false,
    ["8"] = false,
    ["9"] = false,
    ["0"] = false,
    ["-"] = false,
    ["+"] = false,
    ["BACKSPACE"] = {
        ["pressInfo"] = 'Sair de alguns Menus',
    },
    ["TAB"] = {
        ["pressInfo"] = 'Ver Itens das Slots 1-5 do Inventário',
    },
    ["Q"] = false,
    ["W"] = false,
    ["E"] = {
        ["pressInfo"] = 'Interação com Blips',
	},
    ["R"] = {
        ["pressInfo"] = 'Recarregar Arma',
	},
    ["T"] = {
        ["pressInfo"] = 'Chat',
    },
    ["Y"] = {
        ["pressInfo"] = 'Cruise Control',
	},
    ["U"] = {
        ["pressInfo"] = 'Menu de Controlo do Veículo',
    },
    ["I"] = false,
    ["O"] = false,
    ["P"] = {
        ["pressInfo"] = 'Menu de Pausa',
	},
    ["["] = false,
    ["]"] = false,
    ["ENTER"] = {
        ["pressInfo"] = 'Confirmar Opção nos Menus',
    },
    ["CAPS"] = {
        ["pressInfo"] = 'Falar na Rádio',
	},
    ["A"] = false,
    ["S"] = false,
    ["D"] = false,
    ["F"] = false,
    ["G"] = false,
    ["H"] = {
        ["pressInfo"] = 'Ligar/Desligar Luzes do Veículo',
	},
    ["J"] = {
        ["pressInfo"] = 'Abrir Menu de Definições do Hud',
	},
    ["K"] = false,
    ["L"] = {
        ["pressInfo"] = 'Alterar Tom de Voz (Proximidade do Microfone)',
	},
    [";"] =  false,
    ["@"] =  false,
    ["LSHIFT"] =  {
        ["pressInfo"] = 'Correr',
        ["doublePressInfo"] = false,
        ["combinations"] = {
			{
                ["key"] = 'LEFTARROW',
                ["info"] = 'Código 1 PSP (Apenas Polícia)',
            },
			{
                ["key"] = 'DOWNARROW',
                ["info"] = 'Código 2 PSP (Apenas Polícia)',
            },
			{
                ["key"] = 'RIGHTARROW',
                ["info"] = 'Código 3 PSP (Apenas Polícia)',
            },
            {
                ["key"] = 'UPARROW',
                ["info"] = 'Código 99 PSP (Apenas Polícia)',
            },
        },
    },
    ["Z"] =  {
        ["pressInfo"] = 'Menu de Animações',
	},
    ["X"] =  {
        ["pressInfo"] = 'Levantar os Braços',
	},
    ["C"] =  {
        ["pressInfo"] = 'Olhar para trás',
	},
    ["V"] =  {
        ["pressInfo"] = 'Alterar Proximidade da Personagem',
	},
    ["B"] =  {
        ["pressInfo"] = 'Apontar',
	},
    ["N"] =  false,
    ["M"] =  {
        ["pressInfo"] = 'Animação Favorita (Podes alterar no menu de animações no "Z")',
	},
    ["<"] =  false,
    [">"] =  false,
    ["?"] =  false,
    ["RSHIFT"] =  false,
    ["LCTRL"] =  {
        ["pressInfo"] = 'Agachar',
	},
    ["ALT"] =  false,
    ["SPACE"] = {
        ["pressInfo"] = 'Saltar',
	},
    ["ALTGR"] = false,
    ["RCTRL"] = false,
	--[[
	["HOME"] = {
        ["pressInfo"] = 'Ver Estado de Assaltos',
	},
	["INS"] = {
        ["pressInfo"] = 'Ver todos os códigos enviados pela PSP e ir para o marcador no mapa (Apenas Polícia)',
	},
	--]]
}
-- add only 2 commands here
Config.PreviewCommands = {
    ["hud"] = 'Mostrar/Esconder Hud do Topo.',
    ["telemovel"] = 'Abrir telemovel (Tens que ter o telemóvel no inventário).',
}

Config.Commands = {
    ["hud"] = 'Mostrar/Esconder Hud do Topo.',
    ["telemovel"] = 'Abrir telemovel (Tens que ter o telemóvel no inventário).',
    ["e (nome da animação)"] = 'Executar uma animação.',
    ["definicoeshud"] = 'Definições da Hud',
    ["report"] = 'Fazer Report',
    ["inventoryfix"]= 'Corrigir bugs que possam ocorrer na Interface do inventário.',
    ["infotaxi"]= 'Ver ajuda para taxista.',
    ["tempojogado"]= 'Ver o teu tempo jogado no servidor.',
    ["toptempojogado"]= 'Ver o TOP de tempo jogado no servidor.',
    ["animal"]= 'Menu de Gestão do teu Animal.',
    ["radio"]= 'Ver comandos secundários da rádio.',
    ["rastejar"]= 'Rastejar no chão.',
    ["emotes"]= 'Abrir menu de animações.',
    ["clear"]= 'Limpar o chat.',
    ["closemenu"]= 'Desbugar Menu Radial do F1',
    ["cartoessim"]= 'Ver os teus cartões SIM do telemóvel',
    ["refem"]= 'Fazer alguém de refém.',
    ["rebocar"]= 'Rebocar um veículo (Apenas para quem trabalha nos reboques ou na norauto).',
    ["carregar"]= 'Levar um jogador às costas.',
    ["cruzarbracos"]= 'Cruzar os braços.',
}



