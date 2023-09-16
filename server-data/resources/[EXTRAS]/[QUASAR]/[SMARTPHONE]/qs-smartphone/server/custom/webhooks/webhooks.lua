
--░██╗░░░░░░░██╗███████╗██████╗░██╗░░██╗░█████╗░░█████╗░██╗░░██╗░██████╗
--░██║░░██╗░░██║██╔════╝██╔══██╗██║░░██║██╔══██╗██╔══██╗██║░██╔╝██╔════╝
--░╚██╗████╗██╔╝█████╗░░██████╦╝███████║██║░░██║██║░░██║█████═╝░╚█████╗░
--░░████╔═████║░██╔══╝░░██╔══██╗██╔══██║██║░░██║██║░░██║██╔═██╗░░╚═══██╗
--░░╚██╔╝░╚██╔╝░███████╗██████╦╝██║░░██║╚█████╔╝╚█████╔╝██║░╚██╗██████╔╝
--░░░╚═╝░░░╚═╝░░╚══════╝╚═════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░░╚═╝╚═════╝░

--- @param Important, add a webhook here, otherwise the images won't work.
Config.Webhook = 'https://discord.com/api/webhooks/1077760147310518303/KxSYxOxbfjUsjk-bvEETusm6ktb4dYjb8fr0fRpTJ5gCzxwPTqRueGU6SPaGIBbJgiK8'             --- @param Set your own discord Webhook here.
Config.TwitterWebhook = 'https://discord.com/api/webhooks/1077759902056984626/yVca_fJcFxo3t9nGiSyTMCGBqmjQtjB_yFClFqNtco_nH_ntHQ0CBsad4K1Lj8MgWEFq'      --- @param Set your own discord Webhook here.
Config.InstagramWebhook = 'https://discord.com/api/webhooks/1077759769068191755/GYwaiTlvVsY2ht3y9KMRqp9__X38iNnYLBW36xxTX5MY2K78epTfNERH_TQrrp6UL40F'    --- @param Set your own discord Webhook here.
Config.YellowPagesWebhook = 'https://discord.com/api/webhooks/1077759978443640862/5vZQABXbDvNDDLBiJipU8zzP9GEyJB9E75gBIQn6iLpfFJR3iaymx3ilgIMhPQq0mlzk'  --- @param Set your own discord Webhook here.
Config.NewsWebhook = 'https://discord.com/api/webhooks/1077760047532224593/66bJ6KRIH2_1R6maANheUDUy0wZol_rfP1jTBQ_x_-XwNdqAZXgOSK_TdDByiHL8Whn9'         --- @param Set your own discord Webhook here.

-- Webhooks for social media posts, all of these can be public for your players to see the webhooks on your discord server!
Config.PublicWebhookFooter = 'Johnny Logs'
Config.WebhookImage = 'https://i.ibb.co/CvkTJjN/worldtuga.gif'

Config.Webhooks = { -- Enable or disable webhooks.
    twitter = true,
    instagram = true,
    yellowpages = true,
    news = true,
}

Config.WebhooksTranslations = { -- All webhook translations.
    ['twitter'] = {
        name = 'Twitter',
        title = 'Novo Tweet!',
        username = '**Nome de Utilizador**: @',
        description = '\n**Descrição**: ',
        image = 'https://media.discordapp.net/attachments/926274292373655562/999492805770608710/twitter.png'
    },

    ['instagram'] = {
        name = 'Instagram',
        title = 'Novo Post!',
        username = '**Nome de Utilizador**: @',
        description = '\n**Descrição**: ',
        image = 'https://media.discordapp.net/attachments/926274292373655562/999504825450500157/instagram.png'
    },

    ['yellowpages'] = {
        name = 'Páginas Amarelas',
        title = 'Novo Post!',
        username = '**Nome de Utilizador**: ',
        description = '\n**Descrição**: ',
        number = '\n**Number**: ',
        image = 'https://media.discordapp.net/attachments/926274292373655562/999508700907700234/yellow_pages.png'
    },

    ['news'] = {
        name = 'Notícias',
        title = 'Nova Notícia!',
        storie = '**Título**: ',
        description = '\n**Descrição**: ',
        date = '\n**Número**: ',
        image = 'https://media.discordapp.net/attachments/989917195972788234/1002266182994362379/weazel.png'
    },
}