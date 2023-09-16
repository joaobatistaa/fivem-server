
Config = {}
Locales = Locales or {}

--[[ 
    Welcome to the qs-smartphone configuration!
    To start configuring your new asset, please read carefully
    each step in the documentation that we will attach at the end of this message.

    Each important part of the configuration will be highlighted with a box.
    like this one you are reading now, where I will explain step by step each
    configuration available within this file.

    This is not all, most of the settings, you are free to modify it
    as you wish and adapt it to your framework in the most comfortable way possible.
    The configurable files you will find all inside client/custom/*
    or inside server/custom/*.

    Direct link to the resource documentation, read it before you start:
    https://docs.quasar-store.com/information/welcome
]]




--░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
--██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
--██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
--██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
--╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
--░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

Config.Language = "en" -- Set your lang in locales folder
Config.Framework = "esx" -- 'esx' or 'qb'

--[[                                    
    'old' (Esx 1.1).
    'new' (Esx 1.2, v1 final, legacy or extendedmode).
]]

Config.esxVersion = 'new' 
Config.UseQBCorechecks = true -- Use QBCore events to optimise phone checks
Config.UseESXchecks = false -- Only for specific inventory
Config.ox_inventory = false -- Use true only if you have ox_inventory

-- Leave it as default if you dont know what you are doing
Config.ScreenshotBasic = 'screenshot-basic' 
Config.RepeatTimeout = 2000 -- Don't touch here
Config.CallRepeats = 999999 -- Don't touch here
Config.WhatsappMaxMessages = 50 -- Recommended 50, More than 50 poor performance 
Config.DeleteStoriesAndNotifies = true -- Do you want the notifications and stories to be deleted after a certain time?
Config.MaxApp = 40 -- Dont touch.
Config.RequiredPhone = true -- Do you need the item to be able to use your smartphone
Config.DisableMovement = false -- Block all the movement while you are using the smartphone

Config.okokTextUI = {
    enable = false, -- If you use false, by default there will be DrawText3D
    colour = 'darkgreen', -- Change the color of your TextUI here
    position = 'left', -- Change the position of the TextUI here
}

-- Choose the default ringtones for your players!
Config.setVolumeMax = 0.2 -- Volume

Config.Ringtones = {
    defaultRingtone = 'https://www.youtube.com/watch?v=HRtC2sDiKqM',
    ringtones = {
        { url = 'https://www.youtube.com/watch?v=AoWVtJQBgYs', name = 'Cradles'},
        { url = 'https://www.youtube.com/watch?v=iLBBRuVDOo4', name = 'Astronomia'},
        { url = 'https://www.youtube.com/watch?v=t6-cCh9bTG4', name = 'Oh no'},
        { url = 'https://www.youtube.com/watch?v=Z6dqIYKIBSU', name = 'Funkytown'},
        { url = 'https://www.youtube.com/watch?v=cR2XilcGYOo', name = 'Bangarang'},
        { url = 'https://www.youtube.com/watch?v=OT216Rrg0jY', name = 'Life Goes On'},
    }
}

--[[ 
    Be careful editing this because every phone need to have a frame, prop and wallpaper sets to work properly.
    Name of the items with the frame.
]]

Config.Phones = {                          
    ['classic_phone'] = 'classic_frame.png', -- Never remove or delete this from the first position.
    ['black_phone'] = 'black_frame.png',
    ['blue_phone'] = 'blue_frame.png',
    ['gold_phone'] = 'gold_frame.png',
    ['red_phone'] = 'red_frame.png',
    ['green_phone'] = 'green_frame.png',
    ['greenlight_phone'] = 'greenlight_frame.png',
    ['pink_phone'] = 'pink_frame.png',
    ['white_phone'] = 'white_frame.png',
    ['phone'] = 'classic_frame.png',
}

-- Name of the item with the prop
Config.PhonesProps = {
    ['classic_phone'] = `prop_phone_mega_1`, -- Never remove or delete this from the first position.
    ['black_phone'] = `prop_phone_mega_2`,
    ['blue_phone'] = `prop_phone_mega_3`,
    ['gold_phone'] = `prop_phone_mega_4`,
    ['red_phone'] = `prop_phone_mega_5`,
    ['green_phone'] = `prop_phone_mega_6`,
    ['greenlight_phone'] = `prop_phone_mega_7`,
    ['pink_phone'] = `prop_phone_mega_8`,
    ['white_phone'] = `prop_phone_mega_9`,
    ['phone'] = `prop_phone_mega_10`,
}

-- Name of the item with the default wallpaper.
Config.PhonesCustomWallpaper = { 
    ['classic_frame.png'] = 'b5', -- Never remove or delete this from the first position.
    ['black_frame.png'] = 'b4',
    ['blue_frame.png'] = 'b4',
    ['gold_frame.png'] = 'b1',
    ['red_frame.png'] = 'b3',
    ['green_frame.png'] = 'b1',
    ['greenlight_frame.png'] = 'b1',
    ['pink_frame.png'] = 'b2',
    ['white_frame.png'] = 'b1',
}



-- ██╗███╗░░░███╗██████╗░░█████╗░██████╗░████████╗░█████╗░███╗░░██╗████████╗
-- ██║████╗░████║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗░██║╚══██╔══╝ 
-- ██║██╔████╔██║██████╔╝██║░░██║██████╔╝░░░██║░░░███████║██╔██╗██║░░░██║░░░ 
-- ██║██║╚██╔╝██║██╔═══╝░██║░░██║██╔══██╗░░░██║░░░██╔══██║██║╚████║░░░██║░░░
-- ██║██║░╚═╝░██║██║░░░░░╚█████╔╝██║░░██║░░░██║░░░██║░░██║██║░╚███║░░░██║░░░
-- ╚═╝╚═╝░░░░░╚═╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░ 

--[[

    BEFORE YOU CONTINUE READ THIS

    If you are going to make any changes in these apps.
    How to translate them, change the order, delete them.

    It is very important that you USE the /deletallapps command in your server console and then restart the server.

    IF YOU DO NOT DO this the apps will continue as before

]]

-- ██████╗░███████╗███████╗░█████╗░██╗░░░██╗██╗░░░░░████████╗   ░█████╗░██████╗░██████╗░░██████╗
-- ██╔══██╗██╔════╝██╔════╝██╔══██╗██║░░░██║██║░░░░░╚══██╔══╝   ██╔══██╗██╔══██╗██╔══██╗██╔════╝
-- ██║░░██║█████╗░░█████╗░░███████║██║░░░██║██║░░░░░░░░██║░░░   ███████║██████╔╝██████╔╝╚█████╗░
-- ██║░░██║██╔══╝░░██╔══╝░░██╔══██║██║░░░██║██║░░░░░░░░██║░░░   ██╔══██║██╔═══╝░██╔═══╝░░╚═══██╗
-- ██████╔╝███████╗██║░░░░░██║░░██║╚██████╔╝███████╗░░░██║░░░   ██║░░██║██║░░░░░██║░░░░░██████╔╝
-- ╚═════╝░╚══════╝╚═╝░░░░░╚═╝░░╚═╝░╚═════╝░╚══════╝░░░╚═╝░░░   ╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░╚═════╝░
 
--[[   
    -- Pre-installed applications (If you modify them, remember to empty the "apps" column of your sql "users").
    -- Example app DONT UNCOMMENT
    
    [1] = {                             -- Slot id, 'It is important that you follow the order of the numbers [1], [2], [3]....'
        custom = false,                 -- Is a custom app?
        app = "phone",                  -- name of app (dont touch if it is not custom).
        color = "img/apps/phone.png",   -- App visual image.
        tooltipText = "Phone",          -- Name on smartphone (Traslate if you want).
        tooltipPos = "top",             -- Ignore.
        job = false,                    -- Ignore.
        blockedjobs = {},               -- Ignore.
        slot = 1,                       -- Slot where the app will appear.
        Alerts = 0,                     -- Alerts that will appear in the app as soon as you use the phone.
        bottom = true                   -- Ignore.
    }, 
]]

Config.PhoneApplications = {
    [1] = { --- @param -- Slot id, 'It is important that you follow the order of the numbers [1], [2], [3]....'
        custom = false, -- 
        app = "phone", -- App label.
        color = "img/apps/phone.png", -- App visual image.
        tooltipText = "Telemóvel", -- Ignore.
        tooltipPos = "top", -- Ignore.
        job = false, -- Ignore.
        blockedjobs = {}, -- Ignore.
        slot = 1, -- Slot where the app will appear.
        Alerts = 0, -- Alerts that will appear in the app as soon as you use the phone.
        bottom = true -- Ignore.
    },
    [2] = {
        custom = false,
        app = "photos",
        color = "img/apps/gallery.png",
        tooltipText = "Galeria",
        job = false,
        slot = 2,
        blockedjobs = {},
        Alerts = 0,
        bottom = true
    },
    [3] = {
        custom = false,
        app = "messages",
        color = "img/apps/messages.png",
        tooltipText = "Mensagens",
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
        bottom = true
    },
    [4] = {
        custom = false,
        app = "safari",
        color = "img/apps/safari.png",
        tooltipText = "Safari",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
        bottom = true
    },
    [5] = {
        custom = false,
        app = "mail",
        color = "img/apps/mail.png",
        tooltipText = "Email",
        job = false,
        slot = 5,
        blockedjobs = {},
        Alerts = 0
    },
    [6] = {
        custom = false,
        app = "calendar",
        color = "img/apps/calendar.png",
        tooltipText = "Calendário",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0
    },
    [7] = {
        custom = false,
        app = "camera",
        color = "img/apps/camera.png",
        tooltipText = "Câmara",
        job = false,
        slot = 7,
        blockedjobs = {},
        Alerts = 0
    },
    [8] = {
        custom = false,
        app = "store",
        color = "img/apps/appstore.png",
        tooltipText = "App Store",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0
    },
    [9] = {
        custom = false,
        app = "clock",
        color = "img/apps/clock.png",
        tooltipText = "Relógio",
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0
    },
    [10] = {
        custom = false,
        app = "ping",
        color = "img/apps/ping.png",
        tooltipText = "Ping",
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0
    },
    [11] = {
        custom = false,
        app = "tips",
        color = "img/apps/tips.png",
        tooltipText = "Dicas",
        job = false,
        slot = 11,
        blockedjobs = {},
        Alerts = 1
    },
    [12] = {
        custom = false,
        app = "calculator",
        color = "img/apps/calculator.png",
        tooltipText = "Calculadora",
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0
    },
    [13] = {
        custom = false,
        app = "bank",
        color = "img/apps/bank.png",
        tooltipText = "Banco",
        job = false,
        blockedjobs = {},
        slot = 13,
        Alerts = 0
    },
    [14] = {
        custom = false,
        app = "weather",
        color = "img/apps/weather.png",
        tooltipText = "Tempo",
        job = false,
        slot = 14,
        blockedjobs = {},
        Alerts = 0
    },
    [15] = {
        custom = false,
        app = "notes",
        color = "img/apps/notes.png",
        tooltipText = "Notas",
        job = false,
        slot = 15,
        blockedjobs = {},
        Alerts = 0
    },
    [16] = {
        custom = false,
        app = "settings",
        color = "img/apps/settings.png",
        tooltipText = "Definições",
        job = false,
        blockedjobs = {},
        slot = 16,
        Alerts = 0
    },
    [17] = {
        custom = false,
        app = "business",
        color = "img/apps/business.png",
        tooltipText = "Serviços",
        job = false,
        slot = 17,
        blockedjobs = {},
        Alerts = 0
    },

    -- Temple for custom app!
    -- Check in docuementation for more info.
    --[[ [18] = {
        custom = true,
        app = "example",     
        color = "img/apps/example.png",
        tooltipText = "Example",
        job = false,
        slot = 18,
        blockedjobs = {},
        Alerts = 0
    }, ]]
}




--░█████╗░██████╗░██████╗░  ░██████╗████████╗░█████╗░██████╗░███████╗
--██╔══██╗██╔══██╗██╔══██╗  ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝
--███████║██████╔╝██████╔╝  ╚█████╗░░░░██║░░░██║░░██║██████╔╝█████╗░░
--██╔══██║██╔═══╝░██╔═══╝░  ░╚═══██╗░░░██║░░░██║░░██║██╔══██╗██╔══╝░░
--██║░░██║██║░░░░░██║░░░░░  ██████╔╝░░░██║░░░╚█████╔╝██║░░██║███████╗
--╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░  ╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝

Config.StoreAppToday = {
	{
        header = 'TIKTOK',
        head = 'Descubra, assista e experimente!',
        image = 'https://i.imgur.com/nHoGMo4.jpeg',
        footer = 'TikTok é uma comunidade global de vídeos curtos.',
        textcolor = 'white'
    },
    {
        header = 'NOVA VERSÃO!',
        head = 'Aproveite o iQS 2.0 e o seu belo design',
        image = 'https://i.imgur.com/uPLQMVZ.png',
        footer = 'O seu smartphone tem agora o iQS 2.0!',
        textcolor = 'white'
    },
}

Config.StoreApps = {
    -- Apps from the App Store.
    ["instagram"] = {
        custom = false, -- Is custom app?
        app = "instagram", -- App label.
        color = "img/apps/instagram.png", -- App visual image.
        tooltipText = "Instagram", -- Visual app name.
        tooltipPos = "top", -- Ignore.
        job = false, -- If you want this app to work only with jobs, put them inside ' '.
        blockedjobs = {}, -- If you want this app to crash with jobs, put them inside {}.
        slot = 18, -- Slot where the app will be installed.
        Alerts = 0, -- Ignore.
        creator = "Instagram, Inc.​",
        password = false,
        isGame = false,
        description = "Gratuito - Oferece compras na aplicação.",
        score = "4.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "22.5M Avaliações",
        age = "16+",
        extraDescription = {
            {
                header = "INSTAGRAM",
                head = "Divirta-se com os seus amigos!",
                image = "https://i.imgur.com/nhyfbJs.png",
                footer = "Aproximamos-te das pessoas e das coisas que mais adora. - Instagram do Facebook",
                textcolor = 'white'
            }
        }
    },
    ["garage"] = {
        custom = false,
        app = "garage",
        color = "img/apps/garages.png",
        tooltipText = "Meus Veículos",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 19,
        creator = "Raffaele Di Marzo.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Faz a gestão dos teus veículos com mais facilidade",
        score = "3.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "48 Avaliações",
        age = "18+",
        extraDescription = {
            {
                header = "MEUS VEÍCULOS",
                head = "Gere os teus veículos aqui",
                image = "https://i.imgur.com/Pv9W8iP.png",
                footer = "Os Meus Veículos é a aplicação que atende todos os donos de carros, motos ou outros veículos.",
                textcolor = 'white'
            }
        }
    },
    ["whatsapp"] = {
        custom = false,
        app = "whatsapp",
        color = "img/apps/whatsapp.png",
        tooltipText = "WhatsApp",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 20,
        creator = "WhatsApp Inc.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Simples. Confiável. Privado.",
        score = "4", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "9.6M Avaliações",
        age = "16+",
        extraDescription = {
            {
                header = "WHATSAPP",
                head = "#3 em Redes Sociais",
                image = "https://www.cronista.com/files/image/336/336154/60cb8a40b2548.jpg",
                footer = "O WhatsApp do Facebook é uma aplicação GRÁTIS de mensagens e videochamadas.",
                textcolor = 'white'
            }
        }
    },
    ["twitter"] = {
        custom = false,
        app = "twitter",
        color = "img/apps/twitter.png",
        tooltipText = "Twitter",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 21,
        creator = "Twitter, Inc.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Contém anúncios·Oferece compras na aplicação",
        score = "3.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "19.3M Avaliações",
        age = "17+",
        extraDescription = {
            {
                header = "TWITTER",
                head = "Estás preparado para tweetar?",
                image = "https://d500.epimg.net/cincodias/imagenes/2022/01/07/gadgets/1641568079_017034_1641569592_noticia_normal.jpg",
                footer = "Expande a tua rede social e fica atualizado sobre o que é a tendência agora.",
                textcolor = 'white'
            }
        }
    },
    ["advert"] = {
        custom = false,
        app = "advert",
        color = "img/apps/yellow_pages.png",
        tooltipText = "Páginas Amarelas",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 22,
        creator = "YELLOWPAGES.COM LLC.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Encontra empresas locais perto de ti..",
        score = "4", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "36.1K Avaliações",
        age = "4+",
        extraDescription = {
            {
                header = "YELLOW PAGES",
                head = "Anuncia os teus artigos aqui..",
                image = "https://thumbs.dreamstime.com/b/portsmouth-hampshire-uk-mobile-phone-cell-being-held-hand-yellow-pages-app-open-screen-209900632.jpg",
                footer = "Mais de 30.000 pessoas publicam os seus artigos aqui!",
                textcolor = 'white'
            }
        }
    },
    ["tinder"] = {
        custom = false,
        app = "tinder",
        color = "img/apps/tinder.png",
        tooltipText = "Tinder",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 23,
        creator = "Tinder Inc.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Converse e conheça novas pessoas!",
        score = "4.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "10.5M Avaliações",
        age = "16+",
        extraDescription = {
            {
                header = "TINDER",
                head = "Com 30 bilhões de encontros até ao momento!",
                image = "https://d500.epimg.net/cincodias/imagenes/2020/01/23/lifestyle/1579788462_071828_1579788504_noticia_normal.jpg",
                footer = "Tinder é a aplicação mais popular do mundo para conhecer novas pessoas.",
                textcolor = 'white'
            }
        }
    },
    ["youtube"] = {
        custom = false,
        app = "youtube",
        color = "img/apps/youtube.png",
        tooltipText = "YouTube",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 24,
        creator = "Google LLC.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Videos, Música e Live Streams",
        score = "3.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "24.3M Avaliações",
        age = "17+",
        extraDescription = {
            {
                header = "YOUTUBE",
                head = "Os teus vídeos e criadores de conteúdo favoritos.",
                image = "https://f.hellowork.com/blogdumoderateur/2021/05/youtube-mobile-pc.jpg",
                footer = "Descubra um grande número de vídeos e criadores de conteúdo!",
                textcolor = 'white'
            }
        }
    },
    ["uber"] = {
        custom = false,
        app = "uber",
        color = "img/apps/uber.png",
        tooltipText = "Uber Eats",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 25,
        creator = "Uber Technologies, Inc.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Entregamos qualquer pedido onde quer que estejas!",
        score = "3.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "4.9M Avaliações",
        age = "12+",
        extraDescription = {
            {
                header = "UBER EATS",
                head = "Encontra uma entrega de comida dentro do teu orçamento.",
                image = "https://s03.s3c.es/imag/_v0/770x420/e/5/f/uber-eats.jpg",
                footer = "Começa a trabalhar agora, com um simples clique!",
                textcolor = 'white'
            }
        }
    },
    ["state"] = {
        custom = false,
        app = "state",
        color = "img/apps/workspace.png",
        tooltipText = "Emergência",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 26,
        creator = "Los Santos Inc.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Entre em contato com os funcionários de Los Santos",
        score = "4.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = " 12M Avaliações",
        age = "4+",
        extraDescription = {
            {
                header = "EMERGÊNCIA",
                head = "Polícia, ambulâncias e muito mais aqui",
                image = "https://cdn.oldskull.net/wp-content/uploads/2014/12/los-santos-ciudad-de-gta.jpg",
                footer = "Entre em contato diretamente com eles agora.",
                textcolor = 'white'
            }
        }
    },
    ["meos"] = {
        custom = false,
        app = "meos",
        color = "img/apps/police.png",
        tooltipText = "Polícia",
        tooltipPos = "top",
        job = {"police"},
        blockedjobs = {},
        slot = 27,
        creator = "LS Department.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "MDT exclusivo para policias.",
        score = "5", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = " 12 Avaliações",
        age = "18+",
        extraDescription = {
            {
                header = "MDT",
                head = "Base de dados para a polícia!",
                image = "https://i.imgur.com/xIn2bWQ.png",
                footer = "Os civis estão seguros graças ao teu trabalho",
                textcolor = 'white'
            }
        }
    },
    ["jump"] = {
        custom = false,
        app = "jump",
        color = "img/apps/jump.png",
        tooltipText = "Doodle Jump",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 28,
        creator = "Hydra Dev.​",
        Alerts = 0,
        password = false,
        isGame = true,
        description = "Insanamente viciante!",
        score = "4.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = " 660 Avaliações",
        age = "4+",
        extraDescription = {
            {
                header = "DOODLE JUMP",
                head = "ESTÁ AVISADO: Insanamente viciante!",
                image = "https://thumbs.gfycat.com/ContentEnragedIridescentshark-size_restricted.gif",
                footer = "Jogo do salto muito divertido!",
                textcolor = 'white'
            }
        }
    },
    ["spotify"] = {
        custom = false,
        app = "spotify",
        color = "img/apps/spotify.png",
        tooltipText = "Spotify",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 29,
        creator = "Spotify AB.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Ouve música em qualquer lado!",
        score = "4.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "25M Avaliações",
        age = "12+",
        extraDescription = {
            {
                header = "SPOTIFY",
                head = "Ouve já as tuas músicas favoritas",
                image = "https://indiehoy.com/wp-content/uploads/2021/04/spotify-logo.jpg",
                footer = "Um mundo infinito de música!",
                textcolor = 'white'
            }
        }
    },
    ["flappy"] = {
        custom = false,
        app = "flappy",
        color = "img/apps/flappy.png",
        tooltipText = "Flappy Bird",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 30,
        creator = "Essendon Studios.​",
        Alerts = 0,
        password = false,
        isGame = true,
        description = "Salta com o teu pássaro ao redor do mundo!",
        score = "4.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "2M Avaliações",
        age = "12+",
        extraDescription = {
            {
                header = "FLAPPY BIRD",
                head = "Salta com o teu pássaro ao redor do mundo!",
                image = "https://deblogsyjuegos.files.wordpress.com/2015/10/flappygif.gif",
                footer = "Divirta-se com o novo Flappy Bird!",
                textcolor = 'white'
            }
        }
    },
    ["kong"] = {
        custom = false,
        app = "kong",
        color = "img/apps/kong.png",
        tooltipText = "Donkey Kong",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 31,
        creator = "Nintendo Inc.​",
        Alerts = 0,
        password = false,
        isGame = true,
        description = "Salve a princesa!",
        score = "2.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "3M Avaliações",
        age = "4+",
        extraDescription = {
            {
                header = "DONKEY KONG",
                head = "Salve a princesa!",
                image = "https://i.gifer.com/1INx.gif",
                footer = "Joga com o Mário para salvar a Princesa Peach das garras de Donkey Kong!",
                textcolor = 'white'
            }
        }
    },
    ["pacman"] = {
        custom = false,
        app = "pacman",
        color = "img/apps/pacman.png",
        tooltipText = "PAC-MAN",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 32,
        creator = "BANDAI NAMCO Inc.​",
        Alerts = 0,
        password = false,
        isGame = true,
        description = "PAC-MAN apresenta o modo história!",
        score = "4", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "1M Avaliações",
        age = "18+",
        extraDescription = {
            {
                header = "PAC-MAN",
                head = "PAC-MAN apresenta o modo história!",
                image = "https://cl.buscafs.com/www.sandiegored.com/public/uploads/images/112453.gif",
                footer = "Faz uma jornada emocionante, experimenta vários layouts de labirinto com obstáculos",
                textcolor = 'white'
            }
        }
    },
    ["uberDriver"] = {
        custom = false,
        app = "uberDriver",
        color = "img/apps/uberDriver.png",
        tooltipText = "Uber",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 33,
        creator = "Uber Technologies, Inc.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Nunca foi tão fácil viajar para onde quiseres!",
        score = "4", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "12M Avaliações",
        age = "16+",
        extraDescription = {
            {
                header = "Uber",
                head = "Solicita uma viagem onde e quando quiser",
                image = "https://www.autofacil.es/wp-content/uploads/2021/05/coche_uber.jpg",
                footer = "Na Uber comprometemo-nos com a sua segurança.",
                textcolor = 'white'
            }
        }
    },
    ["weazel"] = {
        custom = false,
        app = "weazel",
        color = "img/apps/weazel.png",
        tooltipText = "Notícias",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 34,
        creator = "iOS Basics",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Descubra todas as novidades fresquinhas",
        score = "4.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "18M Avaliações",
        age = "9+",
        extraDescription = {
            {
                header = "NOTÍCIAS",
                head = "Jornalistas da cidade Los Santos!",
                image = "https://cdn.neow.in/news/images/uploaded/2020/02/1580744740_og__divs9jfd19aq.jpg",
                footer = "Descubra todas as novidades fresquinhas.",
                textcolor = 'white'
            }
        }
    },
    ["tiktok"] = {
        custom = false,
        app = "tiktok",
        color = "img/apps/tiktok.png",
        tooltipText = "Tiktok",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 35,
        creator = "TikTok Pte. Ltd.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "TikTok é uma comunidade global de vídeos curtos.",
        score = "5", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "900M Avaliações",
        age = "9+",
        extraDescription = {
            {
                header = "TikTok",
                head = "TikTok é uma comunidade global de vídeos curtos.",
                image = "https://images.squarespace-cdn.com/content/v1/5bdb42a389c17245c5eb0aea/1606778098553-58GZBC84IKL7Z38WV0KC/TikTok-Case-Study-Header.gif?format=2500w",
                footer = "Com esta app podes descobrir, criar e editar vídeos incríveis",
                textcolor = 'white'
            }
        }
    },
    ["tower"] = {
        custom = false,
        app = "tower",
        color = "img/apps/tower.png",
        tooltipText = "City Building",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 36,
        creator = "Cool Happy",
        Alerts = 0,
        password = false,
        isGame = true,
        description = "Jogo de Construção da Casa Torre Feliz",
        score = "3.75", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "20K Avaliações",
        age = "9+",
        extraDescription = {
            {
                header = "City Building",
                head = "Casa de diversão feliz",
                image = "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/dd/09/0d/dd090df4-bf4c-788f-62e0-ca006227886d/source/512x512bb.jpg",
                footer = "Jogo de construção da casa torre feliz",
                textcolor = 'white'
            }
        }
    },
    ["labyrinth"] = {
        custom = false,
        app = "labyrinth",
        color = "img/apps/labyrinth.png",
        tooltipText = "Maze Puzzle Game",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 37,
        creator = "iOS Basics",
        Alerts = 0,
        password = false,
        isGame = true,
        description = "Clássico jogo do labirinto onde tu controlas a bola",
        score = "4", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "100K Avaliações",
        age = "9+",
        extraDescription = {
            {
                header = "Maze Puzzle Game",
                head = "Clássico jogo do labirinto onde tu controlas a bola",
                image = "https://i.ytimg.com/vi/JRXC2A9Hgl0/maxresdefault.jpg",
                footer = "Joga o melhor jogo de labirinto do teu Telemovel",
                textcolor = 'white'
            }
        }
    },
	--[[
    ["radio"] = {
        custom = false,
        app = "radio",
        color = "img/apps/radio.png",
        tooltipText = "Radio",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 42,
        creator = "LS Radio Inc.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Trabalho de rádio para todos os usuários.",
        score = "3.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = " 332 Avaliações",
        age = "16+",
        extraDescription = {
            {
                header = "RADIO",
                head = "Um rádio para se conectar a muitas frequências!",
                image = "https://i.imgur.com/ENBVOUI.png",
                footer = "Comunique-se com rapidez e segurança.",
                textcolor = 'black'
            }
        }
    },
	--]]
    -- Temple for custom app!
    -- Check in docuementation for more info.
    --[[ ['example'] = {
        custom = true,
        app = "example",
        color = "./img/apps/example.png",
        background = "#FFFFFF",
        tooltipText = "Example",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 44,
        creator = "Lucceti's Pizza, Inc.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Solicitar entregas de pizza',
        score = '4', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '12M Avaliações',
        age = '3+',
        extraDescription = {
            {
                header = 'Uber',
                head = 'Solicitar entregas de pizza',
                image = 'https://www.autofacil.es/wp-content/uploads/2021/05/coche_uber.jpg',
                footer = 'Na Uber comprometemo-nos com a sua segurança.',
                textcolor = 'white'
            }
        }
    }, ]]
    ['rentel'] = { -- Rental DLC.
        custom = false,
        app = "rentel",
        color = "img/apps/rentel.png",
        tooltipText = "Nextbike",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 38,
        creator = "nextbike.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Começa a andar de bicicleta!',
        score = '3.50', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '333 Avaliações',
        age = '4+',
        extraDescription = {
            {
                header = 'NEXTBIKE',
                head = 'A melhor aplicação de aluguer de bicicletas!',
                image = 'https://i.imgur.com/WPzp1PV.png',
                footer = 'Encontra áreas de aluguer de bicicletas ou faz até mesmo amigos!',
                textcolor = 'white'
            }
        }
    },
    ['racing'] = { -- Racing DLC.
        custom = false,
        app = "racing",
        color = "img/apps/racing.png",
        tooltipText = "Corridas Ilegais",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {'police'},
        slot = 39,
        creator = "Los Santos Customs.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Aplicação de corrida ilegal de Los Santos.',
        score = '4.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '5M Avaliações',
        age = '16+',
        extraDescription = {
            {
                header = 'CORRIDAS',
                head = 'Corridas ilegais em Los Santos!',
                image = 'https://i.imgur.com/OJ4Zxtn.png',
                footer = 'Aplicação criada pela LS Customs, para proporcionar adrenalina aos condutores.',
                textcolor = 'white'
            }
        }
    },
	
	['houses'] = { -- qs-housing
        app = "houses",
        color = "img/apps/home.png",
        icon = "fas fa-house",
        tooltipText = "Meus Imóveis",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 40,
        creator = "Remax Lda.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Aplicação para gerires as tuas casas.',
        score = '4.50', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '1M Recomendações',
        age = '18+',
        extraDescription = {
            {
                header = 'MINHAS CASAS',
                head = 'Melhor aplicação para gerires os teus imóveis!',
                image = 'https://i.imgur.com/OJ4Zxtn.png',
                footer = 'Aplicação criada pela Remax, para facilitar na gestão das tuas casas.'
            }
        }
    },
	
	['business'] = {
        app = "business",
        color = "img/apps/business.png",
        icon = "fas fa-warehouse",
        tooltipText = "Empresas e Negócios",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 41,
        creator = "Los Santos Inc.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Contacta as empresas de Los Santos!',
        score = '5', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '12M Recomendações',
        age = '14+',
        extraDescription = {
            {
                header = 'EMPRESAS E NEGÓCIOS',
                head = 'Contacta as empresas de Los Santos!',
                image = 'https://diariolibre.blob.core.windows.net.optimalcdn.com/images/binrepository/doordashdriver_15714255_20210205162935-focus-0-0-375-240.jpg',
                footer = 'Encomenda comida ou contacta a polícia rapidamente!'
            }
        }
    },

    ['society'] = {
        app = "society",
        color = "img/apps/society.png",
        icon = "fas fa-warehouse",
        tooltipText = "Minha Empresa",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 42,
        creator = "Los Santos Inc.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Gestão da tua empresa',
        score = '4', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '666 Recomendações',
        age = '18+',
        extraDescription = {
            {
                header = 'EMPRESA',
                head = 'Extensão para a aplicação de negócios!',
                image = 'https://zenkit.com/wp-content/uploads/2017/12/business-meeting.jpg',
                footer = 'Gestão fácil e dinâmica.'
            }
        }
    },

    --[[ ["sellix"] = { -- Sellix DLC.
        custom = false,
        app = "sellix",
        color = "img/apps/sellix.png",
        tooltipText = "Sellix",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 47,
        creator = "Sellix Inc.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Painel de comércio eletrônico",
        score = "2.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = " 199 Avaliações",
        age = "18+",
        extraDescription = {
            {
                header = "SELLIX",
                head = "Painel de comércio eletrônico",
                image = "https://i.ytimg.com/vi/yjEKxwnHLEc/maxresdefault.jpg",
                footer = "Gerencie seus produtos e vendas",
                textcolor = 'black'
            }
        }
    }, ]]

    --[[ ["crypto"] = {
        custom = false,
        app = "crypto",
        color = "img/apps/crypto.png",
        tooltipText = "Binance",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 41,
        creator = "Binance LTD",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "Uma troca de criptografia para todos aqueles diamantes",
        score = "4.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "316K Avaliações",
        age = "18+",
        extraDescription = {
            {
                header = "BINANCE",
                head = "Troca de criptomoedas",
                image = "https://v2.cimg.co/news/75173/174150/adobestock-iryna-budanova-1-1.jpg",
                footer = "Binance: Compre Bitcoin!",
                textcolor = 'white'
            }
        }
    }, ]]
}




--████████╗███████╗░█████╗░██╗░░██╗███╗░░██╗██╗░█████╗░██╗░█████╗░███╗░░██╗
--╚══██╔══╝██╔════╝██╔══██╗██║░░██║████╗░██║██║██╔══██╗██║██╔══██╗████╗░██║
--░░░██║░░░█████╗░░██║░░╚═╝███████║██╔██╗██║██║██║░░╚═╝██║███████║██╔██╗██║
--░░░██║░░░██╔══╝░░██║░░██╗██╔══██║██║╚████║██║██║░░██╗██║██╔══██║██║╚████║
--░░░██║░░░███████╗╚█████╔╝██║░░██║██║░╚███║██║╚█████╔╝██║██║░░██║██║░╚███║
--░░░╚═╝░░░╚══════╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░╚════╝░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝

Config.ResetPassword = {
    spawnNPC = true, -- Spawn a NPC?
    coords = vec3(-1524.32, -409.3, 35.6),
    money = 500,
    text = "[E] - Técnico de Telemóveis",
    ped = {
        coords = vec3(-1524.32, -409.3, 35.6),
        h = 230.65,
        model = `hc_hacker`
    },
    blip = {
        coords = vec3(-1524.32, -409.3, 35.6),
        name = 'Técnico de Telemóveis',
        sprite = 89,
        color = 1,
        scale = 0.7
    },
}




--██╗░░░██╗░█████╗░██╗░█████╗░███████╗
--██║░░░██║██╔══██╗██║██╔══██╗██╔════╝
--╚██╗░██╔╝██║░░██║██║██║░░╚═╝█████╗░░
--░╚████╔╝░██║░░██║██║██║░░██╗██╔══╝░░
--░░╚██╔╝░░╚█████╔╝██║╚█████╔╝███████╗
--░░░╚═╝░░░░╚════╝░╚═╝░╚════╝░╚══════╝

--[[             
    It is very important that you choose the name of your script and what voice script you use on your server.
    If your voice system does not appear here, you can configure in config_calls_client and config_calls_server

    'pma'     Most Recommended script `https://github.com/AvarianKnight/pma-voice`
    'mumble'  Deprecated script `https://github.com/FrazzIe/mumble-voip-fivem`
    'toko'   `https://tokovoip.vip/`
    'salty'  `https://github.com/v10networkscom/saltychat-fivem` `https://gaming.v10networks.com/SaltyChat`
]]

Config.Voice = 'mumble'

-- That is only to verify that your script is started, it is necessary that you put the name of the folder of your script
Config.VoiceScriptName = 'mumble-voip' 




--██████╗░░█████╗░███╗░░██╗██╗░░██╗██╗███╗░░██╗░██████╗░
--██╔══██╗██╔══██╗████╗░██║██║░██╔╝██║████╗░██║██╔════╝░
--██████╦╝███████║██╔██╗██║█████═╝░██║██╔██╗██║██║░░██╗░
--██╔══██╗██╔══██║██║╚████║██╔═██╗░██║██║╚████║██║░░╚██╗
--██████╦╝██║░░██║██║░╚███║██║░╚██╗██║██║░╚███║╚██████╔╝
--╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░

--[[ 
    YOU CAN ONLY CHOOSE ONE

    If you set true to this the bank app will use an IBAN, false to use the ID of the player.
    If you use are not using Iban and the player its disconnect you will not be able to send him money.
]]

Config.IbanBank = true         

-- With the option above set in true and okokBankingIban in true you will be able to use the okokBanking Alias.
Config.okokBankingIban = true  




--░██████╗░░█████╗░██████╗░░█████╗░░██████╗░███████╗░██████╗
--██╔════╝░██╔══██╗██╔══██╗██╔══██╗██╔════╝░██╔════╝██╔════╝
--██║░░██╗░███████║██████╔╝███████║██║░░██╗░█████╗░░╚█████╗░
--██║░░╚██╗██╔══██║██╔══██╗██╔══██║██║░░╚██╗██╔══╝░░░╚═══██╗
--╚██████╔╝██║░░██║██║░░██║██║░░██║╚██████╔╝███████╗██████╔╝
--░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚═════╝░

---@param Enable or disable the Valet button from here
Config.AvailableValet = false 

---@param If it is true, an NPC comes and leaves it next to you. If it is false it appears near you without NPC
Config.ValetNPC = true

---@param Does he give you the keys when you call the car, or when the car is delivered to you? (Recommended to leave it true)
Config.ValetKeysBefore = false

---@param Price to bring your vehicle to you
Config.ValetPrice = 1000 -- 

---@param This option is for impound system
            -- 'default'
            -- 'cd_garage'
            -- 'loaf_garage'
            -- 'qb-garages'
            -- 'esx_garages'
            -- 'okokGarage'
            -- 'jg-advanced-garages'
            -- 'rcore_garages'
Config.GarageScript = 'cd_garage'

-- This is for when the Valet/Garage App takes the car to you, you need to trigger your key system
function VehicleKeys(vehicle, hash, plate, model)
    ---@param vehicle Give the ID of local vehicle
    ---@param hash Give the HASH of vehicle
    ---@param plate Return the plate of vehicle
    ---@param model Give the model IsNamedRendertargetLinked

    ---@param If you is 'qs-vehiclekeys' uncomment this :
    --TriggerServerEvent('vehiclekeys:server:givekey', plate, model) -- qs-vehiclekeys default export, first start qs-smartphone in server.cfg
    exports['qs-vehiclekeys']:GiveKeysAuto()
    ---@param If you is 'qb-vehiclekeys' uncomment this :
    --TriggerEvent("vehiclekeys:client:SetOwner", plate)  -- qb-vehiclekeys default export.

    --print('^4[QS Smartphone] ^3[Debug]^0: If you have any vehiclekeys remember to add your vehiclekeys event in config.lua line 233...') -- You can remove this.
end




--░██╗░░░░░░░██╗███████╗████████╗  ██████╗░██╗░░██╗░█████╗░███╗░░██╗███████╗
--░██║░░██╗░░██║██╔════╝╚══██╔══╝  ██╔══██╗██║░░██║██╔══██╗████╗░██║██╔════╝
--░╚██╗████╗██╔╝█████╗░░░░░██║░░░  ██████╔╝███████║██║░░██║██╔██╗██║█████╗░░
--░░████╔═████║░██╔══╝░░░░░██║░░░  ██╔═══╝░██╔══██║██║░░██║██║╚████║██╔══╝░░
--░░╚██╔╝░╚██╔╝░███████╗░░░██║░░░  ██║░░░░░██║░░██║╚█████╔╝██║░╚███║███████╗
--░░░╚═╝░░░╚═╝░░╚══════╝░░░╚═╝░░░  ╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝
                                                
Config.WetPhone = false -- Being in the water, the phone will break and will give you the same item but with the prefix "wet_".
Config.RepairWetPhone = 'phone_module' -- With said item, we can repair the wet phone.
Config.RepairWetPhoneNpc = false -- Be able to repair your phone with the NPC Telephone Technician.
Config.RepairWetPhoneNpcPrice = 100 -- Price to repair a wet phone in the Technician.
Config.RepairWetPhoneNpcAccount = 'bank' -- Choose here the account to pay the technician for repairing the wet phone.




--░░░░░██╗░█████╗░██████╗░░██████╗  ░█████╗░██████╗░██████╗░░██████╗
--░░░░░██║██╔══██╗██╔══██╗██╔════╝  ██╔══██╗██╔══██╗██╔══██╗██╔════╝
--░░░░░██║██║░░██║██████╦╝╚█████╗░  ███████║██████╔╝██████╔╝╚█████╗░
--██╗░░██║██║░░██║██╔══██╗░╚═══██╗  ██╔══██║██╔═══╝░██╔═══╝░░╚═══██╗
--╚█████╔╝╚█████╔╝██████╦╝██████╔╝  ██║░░██║██║░░░░░██║░░░░░██████╔╝
--░╚════╝░░╚════╝░╚═════╝░╚═════╝░  ╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░╚═════╝░

-- These works will have permission to publish in the News app.
Config.WeazelJob = { 
    'jornalista',
    'police',
    'mechanic',
    'ambulance',
    'remax',
}

-- Jobs available to receive Police App alerts.
Config.PoliceAppJobs = {
    [1] = 'police',
    -- [2] = 'sheriff',
} 

--[[ 
    Default contacts

    job  'Name of job who will receive the message'
    name 'Visible label'
    img  'Image of contact'

    If you use a custom dispatch you can configure it in line 130 of config_client
]]

Config.Jobs = {
    { job = 'police', name = 'PSP' , img = './img/apps/police.png'},
    { job = 'ambulance', name = 'INEM', img = './img/apps/ambulance.png'},
    { job = 'mechanic', name = 'MECANICOS', img = './img/apps/mechanic.png'},
    { job = 'taxi', name = 'TÁXI', img = './img/apps/taxi.png'},
}

--[[ 
    IMPORTANT these are commands to receive or not receive messages NO MESSAGE IS SENT WITH THESE.
    to put it another way it is to enter and exit of duty.

    ]]
Config.jobCommands = { -- Just enter a number here, this is the number that will appear when you call.
    ["police"] = "113",
    ["ambulance"] = "112",
    ["mechanic"] = "114",
}




--██████╗░██╗░░░░░░█████╗░░█████╗░██╗░░██╗███╗░░░███╗░█████╗░██████╗░██╗░░██╗███████╗████████╗
--██╔══██╗██║░░░░░██╔══██╗██╔══██╗██║░██╔╝████╗░████║██╔══██╗██╔══██╗██║░██╔╝██╔════╝╚══██╔══╝
--██████╦╝██║░░░░░███████║██║░░╚═╝█████═╝░██╔████╔██║███████║██████╔╝█████═╝░█████╗░░░░░██║░░░
--██╔══██╗██║░░░░░██╔══██║██║░░██╗██╔═██╗░██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗░██╔══╝░░░░░██║░░░
--██████╦╝███████╗██║░░██║╚█████╔╝██║░╚██╗██║░╚═╝░██║██║░░██║██║░░██║██║░╚██╗███████╗░░░██║░░░
--╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░

Config.WeaponsItems = true -- This will work for Onion Browser, weapons are items?
Config.BlackMarketAccount = 'bank' -- Account with which you want to pay in Onion Browser.

--[[ 
    Onion browser items!
    It is important that you follow the order of the numbers [1], [2], [3]...

    item     'Item name'
    label    'label that will show in the app'
    isItem   false 'Is a weapons' true 'is a item'
    price    'Price of the product'
]]

Config.Darkweb = { 
    List = {    
        [1] = { item = 'WEAPON_PISTOL',     label = 'Pistola',       isItem = true, price = 90000},
        --[2] = { item = 'WEAPON_PISTOL50',   label = 'Pistola 50',    isItem = true, price = 9000},
       -- [3] = { item = 'WEAPON_PISTOL_MK2', label = 'Pistola MK2',   isItem = true, price = 10000},
        --[4] = { item = 'WEAPON_KNUCKLE',    label = 'Punho de Ferro',       isItem = true, price = 5000},
        --[5] = { item = 'WEAPON_GRENADE',    label = 'Granada',       isItem = true, price = 20000},
        --[6] = { item = 'WEAPON_CARBINERIFLE_MK2', label = 'Carbine Rifle MK2', isItem = true, price = 35000},
        --[7] = { item = 'WEAPON_BULLPUPRIFLE_MK2', label = 'Bullpup Rifle MK2', isItem = true, price = 40000},
        --[8] = { item = 'WEAPON_SNIPERRIFLE',      label = 'Sniper Rifle',      isItem = true, price = 800000},
        -- [9] = { item = 'laptop', label = 'Hacker Laptop', isItem = true, price = 700}, -- If you use `Config.WeaponsItems = false` then you can choose if it's an item with `isItem = true`.
    },
}




--██████╗░░█████╗░░█████╗░████████╗██╗░░██╗  ░██████╗██╗░░░██╗░██████╗████████╗███████╗███╗░░░███╗
--██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║░░██║  ██╔════╝╚██╗░██╔╝██╔════╝╚══██╔══╝██╔════╝████╗░████║
--██████╦╝██║░░██║██║░░██║░░░██║░░░███████║  ╚█████╗░░╚████╔╝░╚█████╗░░░░██║░░░█████╗░░██╔████╔██║
--██╔══██╗██║░░██║██║░░██║░░░██║░░░██╔══██║  ░╚═══██╗░░╚██╔╝░░░╚═══██╗░░░██║░░░██╔══╝░░██║╚██╔╝██║
--██████╦╝╚█████╔╝╚█████╔╝░░░██║░░░██║░░██║  ██████╔╝░░░██║░░░██████╔╝░░░██║░░░███████╗██║░╚═╝░██║
--╚═════╝░░╚════╝░░╚════╝░░░░╚═╝░░░╚═╝░░╚═╝  ╚═════╝░░░░╚═╝░░░╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝
                 
Config.EnableBooth = true -- Do you want to enable the phone booths?

-- Configure here the props that will be phone booths.
Config.Booth = { 
    [1158960338] = true, -- Hash of booths
    [1511539537] = true,
    [1281992692] = true,
    [-429560270] = true,
    [-1559354806] = true,
    [-78626473] = true,
    [295857659] = true,
    [-2103798695] = true,
    -- You can add more!
}




--██████╗░░█████╗░████████╗████████╗███████╗██████╗░██╗░░░██╗
--██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗╚██╗░██╔╝
--██████╦╝███████║░░░██║░░░░░░██║░░░█████╗░░██████╔╝░╚████╔╝░
--██╔══██╗██╔══██║░░░██║░░░░░░██║░░░██╔══╝░░██╔══██╗░░╚██╔╝░░
--██████╦╝██║░░██║░░░██║░░░░░░██║░░░███████╗██║░░██║░░░██║░░░
--╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░

Config.EnableBattery = true -- Do you want to enable the battery?
Config.HousingCharge = true -- Phone charger inside the houses?

-- Only load battery information when a player enters the server: playerLoaded, !! Don't restart the live resource because it will break. !!
Config.BatteryPersistData = true -- Persist data on battery.json
Config.TimeSavePersistData = 20000 -- x 20 sec - less than this number is not recommended

Config.PowerBank = 'powerbank' -- Item name?
Config.RemoveItemPowerBank = true -- Do you want the powerbank to be removed once used?

-- Usage /adminbattery id ammount
Config.AdminCommand = true -- Recharge the batery for admins?
Config.AdminCommandName = 'bateriaadmin'
Config.AdminCommandDescription = 'Recarrega a bateria de um telemóvel'
Config.AdminPermissions = 'admin'

--Customize your own marker or disable it. 
-- Remember that here is the charger marker inside your house too.
Config.ChargerMarker = { 
    enable = true,
    type = 2, 
    scale = {x = 0.2, y = 0.2, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 120},
    movement = 0 --Use 0 to disable movement.
}

Config.Battery = {
    debug = false, -- If you use true, you will be able to see the log in F8 of your battery going down.
    default = 0.01, -- This is the rate at which the battery drains by default.
    apps = { -- The following applications will make your battery go down faster.
        ['phone'] = 0.02,
        ['photos'] = 0.02,
        ['messages'] = 0.02,
        ['settings'] = 0.02,
        ['clock'] = 0.02,
        ['camera'] = 0.02,
        ['mail'] = 0.02,
        ['bank'] = 0.02,
        ['calendar'] = 0.02,
        ['notes'] = 0.02,
        ['calculator'] = 0.02,
        ['store'] = 0.02,
        ['music'] = 0.02,
        ['ping'] = 0.02,
        ['instagram'] = 0.02,
        ['garage'] = 0.02,
        ['whatsapp'] = 0.02,
        ['twitter'] = 0.02,
        ['advert'] = 0.02,
        ['tinder'] = 0.02,
        ['cs-stories'] = 0.02,
        ['youtube'] = 0.02,
        ['uber'] = 0.02,
        ['darkweb'] = 0.02,
        ['state'] = 0.02,
        ['meos'] = 0.02,
        ['jump'] = 0.02,
        ['business'] = 0.02,
        ['society'] = 0.02,
        ['spotify'] = 0.02,
        ['flappy'] = 0.02,
        ['kong'] = 0.02,
        ['pacman'] = 0.02,
        ['group-chats'] = 0.02,
        ['uberDriver'] = 0.02,
        ['rentel'] = 0.02,
        ['racing'] = 0.02,
        ['labyrinth'] = 0.02,
        ['tower'] = 0.02,
        ['tiktok'] = 0.02,
        -- ['example'] = 0.02,
    }
}

-- Here you can add plugs to charge your phone wherever you want.
Config.HouseChargeCoords = {
    {
        coords = vec3(1431.4039306641, -2009.6640625, 61.349201202393),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge.
    },
}

Config.DefaultChargeCoords = #Config.HouseChargeCoords -- Don't touch this please.
Config.PowerbankSpeed = 1.0 -- Charging speed of the item `powerbank`.




--██████╗░██╗░░░██╗░██████╗██╗███╗░░██╗███████╗░██████╗░██████╗
--██╔══██╗██║░░░██║██╔════╝██║████╗░██║██╔════╝██╔════╝██╔════╝
--██████╦╝██║░░░██║╚█████╗░██║██╔██╗██║█████╗░░╚█████╗░╚█████╗░
--██╔══██╗██║░░░██║░╚═══██╗██║██║╚████║██╔══╝░░░╚═══██╗░╚═══██╗
--██████╦╝╚██████╔╝██████╔╝██║██║░╚███║███████╗██████╔╝██████╔╝
--╚═════╝░░╚═════╝░╚═════╝░╚═╝╚═╝░░╚══╝╚══════╝╚═════╝░╚═════╝░

Config.JobsInPhone = {
    ["police"] = {
        order = 1,
        name = 'police',
        label = "PSP",
        info = 'A Polícia de Segurança Pública sempre ao seu dispor',
        score = '4',
        duty = false,
    },
    ["ambulance"] = {
        order = 2,
        name = 'ambulance',
        label = "INEM",
        info = 'Resolvemos todos os seus problemas de saúde',
        score = '4',
        duty = false,
    },
	["mechanic"] = {
        order = 3,
        name = 'mechanic',
        label = "Norauto",
        info = 'Faça a manutenção e modifica o teu veículo ao melhor preço com a Norauto',
        score = '4',
        duty = false,
    },
	["taxi"] = {
        order = 4,
        name = 'taxi',
        label = "Táxi",
        info = 'Chama um táxista para te levar para qualquer lado',
        score = '4',
        duty = false,
    },
	--[[
    ["tabac"] = {
        order = 3,
        name = 'tabac',
        label = "Tabac",
        info = 'Food and party tables provided',
        score = '3',
        duty = false,
    },
    ["burgershot"] = {
        order = 4,
        name = 'burgershot',
        label = "Burgershot",
        info = '100% vegan burgers, I\'m kidding...',
        score = '2',
        duty = false,
    },
    ["noodle"] = {
        order = 5,
        name = 'noodle',
        label = "Noodle",
        info = 'The best fried noodles in Los Santos',
        score = '4',
        duty = false,
    },
    ["unicorn"] = {
        order = 6,
        name = 'unicorn',
        label = "Unicorn",
        info = 'Come move your body to the best nightclub',
        score = '5',
        duty = false,
    },
    ["paradise"] = {
        order = 7,
        name = 'paradise',
        label = "Paradise Club",
        info = 'We do not sell alcohol to minors',
        score = '2',
        duty = false,
    },
    ["recycle"] = {
        order = 9,
        name = 'recycle',
        label = "Recyclage",
        info = 'Protect the environment and take care of the streets',
        score = '1',
        duty = false,
    },
    ["catcafe"] = {
        order = 10,
        name = 'catcafe',
        label = "Cat Cafe",
        info = 'Lots of coffee, but above all, lots of kittens',
        score = '5',
        duty = false,
    },
	-]]
}




--░█████╗░░█████╗░███╗░░██╗███╗░░██╗███████╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
--██╔══██╗██╔══██╗████╗░██║████╗░██║██╔════╝██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
--██║░░╚═╝██║░░██║██╔██╗██║██╔██╗██║█████╗░░██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║
--██║░░██╗██║░░██║██║╚████║██║╚████║██╔══╝░░██║░░██╗░░░██║░░░██║██║░░██║██║╚████║
--╚█████╔╝╚█████╔╝██║░╚███║██║░╚███║███████╗╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║
--░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

Config.Signal = true -- If you want to enable this system, use true.
Config.visibleZone = false -- Leave this false whenever you are going to use the server, it is only for zone testing.

--[[ 
    Mountains and zones blocked for low signal, here is the complete PolyZone.
    Within this PolyZone, you will not be able to use certain apps or receive calls.
]]

Config.Mountains = {
    {
        coords = {
            vector2(-331.82, 5704.55),
            vector2(1383.33, 6353.03),
            vector2(2492.42, 5231.82),
            vector2(1486.36, 5159.09),
            vector2(1413.64, 4516.67),
            vector2(771.21, 4262.12),
            vector2(-210.61, 4219.70),
            vector2(-240.91, 3759.09),
            vector2(19.70, 3334.85),
            vector2(-1331.82, 2807.58),
            vector2(-1665.15, 3365.15),
            vector2(-2307.58, 3607.58),
            vector2(-1998.48, 4334.85),
        },
        minz = 0,
        maxz = 800

    },
    {
        coords = {
            vector2(1868.18, 1656.06),
            vector2(1631.82, 831.82),
            vector2(1280.30, 425.76),
            vector2(1346.97, 25.76),
            vector2(1516.67, -901.52),
            vector2(2056.06, -453.03),
            vector2(2456.06, 365.15),
            vector2(2274.24, 1062.12)
        },
        minz = 0,
        maxz = 800
    },
    {
        coords = {
            vector2(4177.27, 50.00),
            vector2(3068.18, 1819.70),
            vector2(2734.85, 171.21),
            vector2(1322.73, -1228.79),
            vector2(1789.39, -2883.33),
            vector2(2486.36, -2780.30),
            vector2(3425.76, -2513.64),
            vector2(4165.15, -1816.67)
        },
        minz = 0,
        maxz = 800
    },

}




--██╗░░░██╗██████╗░███████╗██████╗░  ██████╗░██████╗░██╗██╗░░░██╗███████╗██████╗░
--██║░░░██║██╔══██╗██╔════╝██╔══██╗  ██╔══██╗██╔══██╗██║██║░░░██║██╔════╝██╔══██╗
--██║░░░██║██████╦╝█████╗░░██████╔╝  ██║░░██║██████╔╝██║╚██╗░██╔╝█████╗░░██████╔╝
--██║░░░██║██╔══██╗██╔══╝░░██╔══██╗  ██║░░██║██╔══██╗██║░╚████╔╝░██╔══╝░░██╔══██╗
--╚██████╔╝██████╦╝███████╗██║░░██║  ██████╔╝██║░░██║██║░░╚██╔╝░░███████╗██║░░██║
--░╚═════╝░╚═════╝░╚══════╝╚═╝░░╚═╝  ╚═════╝░╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝

Config.Decimals = false -- Use decimal numbers?
Config.UberMinimumMoney = 1000 -- Minimum money to enter service or to request a vehicle.
Config.UberMaximumMoney = 10000 -- Maximum price per trip, you can not earn more than this for each trip.
Config.UberDriverAccount = 'bank' -- Remember that if you use QBCore, the account 'money' does not exist, it is 'cash'.

Config.Classes = { -- You can ignore this setting, it will be executed in future updates.
	[0] = 'COMPACT', -- Compacts
	[1] = 'SEDAN', -- Sedans
	[2] = 'SUV', -- SUVs
	[3] = 'COUPE', -- Coupes
	[4] = 'MUSCLE', -- Muscle
	[5] = 'SPORT CLASSIC', -- Sports Classics
	[6] = 'SPORT', -- Sports
	[7] = 'SUPER', -- Super
	[8] = 'MOTOR', -- Motorcycles
	[9] = 'OFFROAD', -- Off-road
}




--██╗░░░██╗██████╗░███████╗██████╗░  ███████╗░█████╗░████████╗░██████╗
--██║░░░██║██╔══██╗██╔════╝██╔══██╗  ██╔════╝██╔══██╗╚══██╔══╝██╔════╝
--██║░░░██║██████╦╝█████╗░░██████╔╝  █████╗░░███████║░░░██║░░░╚█████╗░
--██║░░░██║██╔══██╗██╔══╝░░██╔══██╗  ██╔══╝░░██╔══██║░░░██║░░░░╚═══██╗
--╚██████╔╝██████╦╝███████╗██║░░██║  ███████╗██║░░██║░░░██║░░░██████╔╝
--░╚═════╝░╚═════╝░╚══════╝╚═╝░░╚═╝  ╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░

Config.uberPriceMultiplier = 1.5 
Config.uberTipMin = 30 
Config.uberTipMax = 50 

Config.uberDelivery = {
    [1] = {["x"] = 8.69, ["y"] = -243.09, ["z"] = 47.66},
    [2] = {["x"] = 113.74, ["y"] = -277.95, ["z"] = 54.51},
    [3] = {["x"] = 201.56, ["y"] = -148.76, ["z"] = 61.47},
    [4] = {["x"] = -206.84, ["y"] = 159.49, ["z"] = 74.08},
    [5] = {["x"] = 38.83, ["y"] = -71.64, ["z"] = 63.83},
    [6] = {["x"] = 47.84, ["y"] = -29.16, ["z"] = 73.71},
    [7] = {["x"] = -264.41, ["y"] = 98.82, ["z"] = 69.27},
    [8] = {["x"] = -419.34, ["y"] = 221.12, ["z"] = 83.6},
    [9] = {["x"] = -998.43, ["y"] = 158.42, ["z"] = 62.31},
    [10] = {["x"] = -1026.57, ["y"] = 360.64, ["z"] = 71.36},
    [11] = {["x"] = -967.06, ["y"] = 510.76, ["z"] = 82.07},
    [12] = {["x"] = -1009.64, ["y"] = 478.93, ["z"] = 79.41},
    [13] = {["x"] = -1308.05, ["y"] = 448.59, ["z"] = 100.86},
    [14] = {["x"] = 557.39, ["y"] = -1759.57, ["z"] = 29.31},
    [15] = {["x"] = 325.1, ["y"] = -229.59, ["z"] = 54.22},
    [16] = {["x"] = 414.82, ["y"] = -217.57, ["z"] = 59.91},
    [17] = {["x"] = 430.85, ["y"] = -941.91, ["z"] = 29.19},
    [18] = {["x"] = -587.79, ["y"] = -783.53, ["z"] = 25.4},
    [19] = {["x"] = -741.54, ["y"] = -982.28, ["z"] = 17.44},
    [20] = {["x"] = -668.23, ["y"] = -971.58, ["z"] = 22.34},
    [21] = {["x"] = -664.21, ["y"] = -1218.25, ["z"] = 11.81},
    [22] = {["x"] = 249.99, ["y"] = -1730.79, ["z"] = 29.67},
    [23] = {["x"] = 405.77, ["y"] = -1751.18, ["z"] = 29.71 },
    [24] = {["x"] = 454.96, ["y"] = -1580.25, ["z"] = 32.82},
    [25] = {["x"] = 278.81, ["y"] = -1117.96, ["z"] = 29.42},
    [26] = {["x"] = 101.82, ["y"] = -819.49, ["z"] = 31.31},
    [27] = {["x"] = -416.72, ["y"] = -186.79, ["z"] = 37.45},
}

Config.uberItems = {
	[1] = {["item"] = "bread", ["name"] = "Pão", ["price"] = 500},
	[2] = {["item"] = "sandwich", ["name"] = "Sandes", ["price"] = 500},
	[3] = {["item"] = "cocacola", ["name"] = "Coca-Cola", ["price"] = 500},
	[4] = {["item"] = "beer", ["name"] = "Cerveja", ["price"] = 500},
	[5] = {["item"] = "hamburguer", ["name"] = "Hambúrguer", ["price"] = 500},
	[6] = {["item"] = "bandage", ["name"] = "Ligadura", ["price"] = 4000},
	[7] = {["item"] = "binoculars", ["name"] = "Binóculos", ["price"] = 500},
	[8] = {["item"] = "chocolate", ["name"] = "Chocolate", ["price"] = 500},
	[9] = {["item"] = "icetea", ["name"] = "Ice-Tea", ["price"] = 500},
	[10] = {["item"] = "fixtool", ["name"] = "Kit de Reparação", ["price"] = 15000},
	[11] = {["item"] = "tyrekit", ["name"] = "Kit de Pneus", ["price"] = 10000},
	[12] = {["item"] = "classic_phone", ["name"] = "Iphone 13 Cinzento", ["price"] = 4000},
}




--██████╗░██╗██╗░░░░░██╗░░░░░██╗███╗░░██╗░██████╗░
--██╔══██╗██║██║░░░░░██║░░░░░██║████╗░██║██╔════╝░
--██████╦╝██║██║░░░░░██║░░░░░██║██╔██╗██║██║░░██╗░
--██╔══██╗██║██║░░░░░██║░░░░░██║██║╚████║██║░░╚██╗
--██████╦╝██║███████╗███████╗██║██║░╚███║╚██████╔╝
--╚═════╝░╚═╝╚══════╝╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░

--[[ 
    default          Works with default QBCore and ESX system
    okokBilling      Works on ESX (QBCore compatible but dont have code) https://okok.tebex.io/package/5246431
    rcore_billing    Old resource (Discontinued)
    jim-payments     Free QBCore billing (https://github.com/jimathy/jim-payments)
    billing_ui       Works on ESX and QBCore (https://jaksam1074-fivem-scripts.tebex.io/package/5369991)
    false            if you are not using one
]]
Config.billingSystem = 'okokBilling'

--[[ 
    ESX                     = 'esx_billing:payBill' 
    okokBilling             = 'okokBilling:PayInvoice'
    rcoreBilling            = 'rcore_billing'
    qbcore or jim-payments  = 'nothing'
    billing_ui              = 'billing_ui:payInvoice'
    False if you are not using one
]]

Config.billingpayBillEvent = 'okokBilling:PayInvoice'

Config.Debug = false -- Debug mode, only for development.




-- ██████╗ ██╗███████╗██████╗  █████╗ ████████╗ ██████╗██╗  ██╗
-- ██╔══██╗██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║  ██║
-- ██║  ██║██║███████╗██████╔╝███████║   ██║   ██║     ███████║
-- ██║  ██║██║╚════██║██╔═══╝ ██╔══██║   ██║   ██║     ██╔══██║
-- ██████╔╝██║███████║██║     ██║  ██║   ██║   ╚██████╗██║  ██║
-- ╚═════╝ ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝
                                                            
Config.CustomDispatch = false -- Use a custom dispatch script? (Jobs message only) 

--[[ 
    'client' excute on client side go to (qs-smartphone/client/custom/misc/dispatch.lua 'qs-smartphone:client:CustomClientDispatch')
    'server' excute on server side go to (qs-smartphone/server/custom/misc/dispatch.lua 'qs-smartphone:sever:CustomServerDispatch')
]]

Config.CustomDispatchSide = 'client' 