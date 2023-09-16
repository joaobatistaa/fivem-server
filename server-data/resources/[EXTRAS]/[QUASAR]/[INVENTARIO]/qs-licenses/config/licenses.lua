Config = Config or {}

Config.Shops = {
    [1] = {
        name = 'id_card',
        text =  "[E] - Licencia de Identidad",
        label = 'DNI',
        type = "Documento",
        progbar = "Comprando licencia...",
        price = 150,
        isjob = false, --job name or false.
        timer = 2500,
        location = vec3(-545.08, -204.13, 38.22),
        blip = {
            enable = true,
            name = 'Licencia de Identidad',
            sprite = 409,
            color = 0,
            scale = 0.7
        },
    },

    [2] = {
        name = 'id_card',
        isjob = false, --job name or false.
        text =  "[E] - Licencia de Armas",
        label = 'Licencia',
        type = "Licencia de Armas",
        price = 10,
        progbar = "Comprando licencia...",
        timer = 2500,
        location = vec3(14.01, -1106.11, 29.8),
        blip = {
            enable = false,
            name = 'Licencia de Armas',
            sprite = 89,
            color = 1,
            scale = 0.5
        },
    },

    [3] = {
        name = 'id_card',
        isjob = false, --job name or false.
        text =  "[E] - Licencia de Conducir",
        label = 'Licencia de Conducir',
        type = "Licencia",
        price = 10,
        progbar = "Comprando licencia...",
        timer = 2500,
        location = vec3(239.78, -1380.27, 33.74),
        blip = {
            enable = true,
            name = 'Licencia de Conducir',
            sprite = 67,
            color = 3,
            scale = 0.6
        },
    },
}