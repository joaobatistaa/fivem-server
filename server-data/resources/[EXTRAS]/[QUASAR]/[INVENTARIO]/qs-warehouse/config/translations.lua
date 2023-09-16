--████████╗██████╗░░█████╗░███╗░░██╗░██████╗██╗░░░░░░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
--╚══██╔══╝██╔══██╗██╔══██╗████╗░██║██╔════╝██║░░░░░██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
--░░░██║░░░██████╔╝███████║██╔██╗██║╚█████╗░██║░░░░░███████║░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
--░░░██║░░░██╔══██╗██╔══██║██║╚████║░╚═══██╗██║░░░░░██╔══██║░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
--░░░██║░░░██║░░██║██║░░██║██║░╚███║██████╔╝███████╗██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
--░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

Config.Language = "en" --You can choose between 'en', 'es' or create your own language.

Config.Languages = { --You can copy one of these translations and create your own with another language.
    ['en'] = {
        ["WAREHOUSE_DRAWTEXT_OPEN_WAREHOUSE"] = "[E] - Entrar no Armazém",
        ["WAREHOUSE_DRAWTEXT_LOCKPICK_WAREHOUSE"] = "[G] - Arrombar Armazém",

        ["WAREHOUSE_NOTIFICATION_INCORRECT_PASSWORD"] = "A password está incorreta!",
        ["WAREHOUSE_NOTIFICATION_LOCKPICK_SUCCESS"] = "Conseguiste arrombar a porta!",
        ["WAREHOUSE_NOTIFICATION_BROKEN_LOCKPICK"] = "A lockpick partiu-se e o alarme foi disparado, a polícia está a caminho!",
        ["WAREHOUSE_NOTIFICATION_TITLE"] = "Assalto ao armazém privado",
        ["WAREHOUSE_NOTIFICATION_POLICE_DISPATCH"] = "Foi iniciado um assalto a um armazém privado em:",
    },

    ['es'] = {
        ["WAREHOUSE_DRAWTEXT_OPEN_WAREHOUSE"] = "[E] - Abrir almacen",
        ["WAREHOUSE_DRAWTEXT_LOCKPICK_WAREHOUSE"] = "[G] - Forzar cerradura",

        ["WAREHOUSE_NOTIFICATION_INCORRECT_PASSWORD"] = "La contraseña es incorrecta",
        ["WAREHOUSE_NOTIFICATION_LOCKPICK_SUCCESS"] = "La cerradura parece haberse abierto!",
        ["WAREHOUSE_NOTIFICATION_BROKEN_LOCKPICK"] = "Se rompio el lockpick, la policia esta en camino!",
        ["WAREHOUSE_NOTIFICATION_TITLE"] = "Robo a warehouse privada",
        ["WAREHOUSE_NOTIFICATION_POLICE_DISPATCH"] = "Se inicio un robo a warehouse privada en:",
    },
}